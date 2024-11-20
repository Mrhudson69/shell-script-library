// POST /scripts
router.post("/", async (req, res) => {
    const { userId, scriptContent } = req.body;
  
    try {
      await pool.promise().query("INSERT INTO scripts (user_id, script_content) VALUES (?, ?)", [userId, scriptContent]);
      res.status(201).json({ message: "Script saved successfully" });
    } catch (err) {
      res.status(500).json({ message: "Error saving script", error: err.message });
    }
  });

  // GET /scripts
router.get("/", async (req, res) => {
    const { userId } = req.query;
  
    try {
      const [scripts] = await pool.promise().query("SELECT * FROM scripts WHERE user_id = ?", [userId]);
      res.status(200).json({ scripts });
    } catch (err) {
      res.status(500).json({ message: "Error fetching scripts", error: err.message });
    }
  });

  // PUT /scripts/:id
router.put("/:id", async (req, res) => {
    const { id } = req.params;
    const { scriptContent } = req.body;
  
    try {
      await pool.promise().query("UPDATE scripts SET script_content = ? WHERE id = ?", [scriptContent, id]);
      res.status(200).json({ message: "Script updated successfully" });
    } catch (err) {
      res.status(500).json({ message: "Error updating script", error: err.message });
    }
  });

  // DELETE /scripts/:id
router.delete("/:id", async (req, res) => {
    const { id } = req.params;
  
    try {
      await pool.promise().query("DELETE FROM scripts WHERE id = ?", [id]);
      res.status(200).json({ message: "Script deleted successfully" });
    } catch (err) {
      res.status(500).json({ message: "Error deleting script", error: err.message });
    }
  });

  