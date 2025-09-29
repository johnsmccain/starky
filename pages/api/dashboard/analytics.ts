import { NextApiRequest, NextApiResponse } from "next";
import { v4 as uuidv4 } from "uuid";
import { setupDb } from "../../../db";
import { validateToken } from "../../../utils/validateToken";
import { saveTokenToDatabase } from "../../../utils/database";

export default async function handler(
  req: NextApiRequest,
  res: NextApiResponse
) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  await setupDb();

  try {
    const { guildId, dashboardToken } = req.body;

    if (!guildId || !dashboardToken) {
      return res.status(400).json({ error: "Missing required fields" });
    }

    // Validate the dashboard token
    const isValidToken = await validateToken(guildId, dashboardToken);

    if (!isValidToken) {
      return res.status(403).json({ error: "Invalid or expired token" });
    }

    // Generate a new analytics token
    const analyticsToken = uuidv4();

    // Store the analytics token in the database (using same table structure)
    // Note: We use a placeholder userId since this is coming from dashboard access
    await saveTokenToDatabase(guildId, "dashboard-user", analyticsToken);

    // Return the analytics URL
    const analyticsUrl = `${process.env.BASE_URL}/analytics/${guildId}/${analyticsToken}`;

    return res.status(200).json({ analyticsUrl });
  } catch (error) {
    console.error("Error generating analytics access:", error);
    return res.status(500).json({ error: "Internal server error" });
  }
}