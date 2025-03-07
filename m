Return-Path: <netdev+bounces-172697-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4421BA55B95
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:13:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 577F1189B37D
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4D46426;
	Fri,  7 Mar 2025 00:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuT/Rran"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F77944E;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741306372; cv=none; b=LFR2uhgYx5eflScj8uhvds3UgBmkNYGb8MxE5cAEkMYlzzt1yNO/guJ2HMe5Fs2cym2o5KBcZLlGdmZUEmjYWYIh8pOA5u14pczsoGXeJCrXvAFP8bH9bYSzhgX0Y/2wjMkUl71Tcgz6lFNJlg13VEhfyQPAiOEWglcy0fNnFPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741306372; c=relaxed/simple;
	bh=XNb5Sx3xQlIxmfxdW3R3wrJR+hhgDU6+wt7JwOVQXM0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KPzCZRFrC/PLeVYwKsn2Y7lnWBfihRrQNmBmb3mZXiuLYNPD7kQNpY5PNgkpA8ZOgBlB1jnFWD/z+xLH/oFqfA3/0EcJG/LE0AuL900pO8TXcP25BOjoOhCCCzfXjqAFf3PWz9VcyVXaNG1gzDzHvS+TX7xqDFIYmdZu10bb6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuT/Rran; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8ECA7C4CEEE;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741306371;
	bh=XNb5Sx3xQlIxmfxdW3R3wrJR+hhgDU6+wt7JwOVQXM0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=AuT/RranIR5ew310WuioaKNKnilWP3f35WfLkf1SrnmNno3MjtDzJmfLTSZSHNj1X
	 GYXAogQ2WIZpZ0rsgobKo4sVpXXAEHikWrvkEps61iZOTNZtU/gb11k42ocHYdfuCV
	 uOTM3/BiYQsU9cawkMWZGrFTo1I8qo/BvWQGNoSnZcUNHqM8bo5QC7N+15YsyUVvz2
	 q/ETnpyGFEqeO448oCsm87Kf6fKs8JLXYtZwaXBCb7zk2J1BqbT88T2Ly0tdvFyJOr
	 3+ZBJQvGt9DbKrpun2B+clH6e6Nhux66N2oZOdNdKMNRLWNAkLq6L55Xo0Hs8CtE4v
	 mrIdHTfj22euQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D59C282EC;
	Fri,  7 Mar 2025 00:12:51 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 06 Mar 2025 19:15:26 -0500
Subject: [PATCH net-next v3 5/8] enic: remove unused function
 cq_enet_wq_desc_dec
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-enic_cleanup_and_ext_cq-v3-5-92bc165344cf@cisco.com>
References: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
In-Reply-To: <20250306-enic_cleanup_and_ext_cq-v3-0-92bc165344cf@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1741306525; l=1103;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=+dPGv5N9MWqWyMEvqnn1fc2Fu6Bu+7Wi7gCqqsYQK6M=;
 b=j6/jt0lKahwVpCBoY7RLYkY1cq7pz214EQ4cKIT7uuT8CnWTFzgdgd/J5bBNy/5MT+IAOZh7l
 WTPwxjdXtrCCleeEN3bfGkDxCDCsx/HgfvSu0/mTzzVylKNQBLocYUJ
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Removes cq_enet_wq_desc_dec, not needed anymore.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/cq_enet_desc.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
index 809a3f30b87f78285414990a2a42c9a30a8662c6..50787cff29db0cc9041093521385781cf557e4cc 100644
--- a/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
+++ b/drivers/net/ethernet/cisco/enic/cq_enet_desc.h
@@ -17,13 +17,6 @@ struct cq_enet_wq_desc {
 	u8 type_color;
 };
 
-static inline void cq_enet_wq_desc_dec(struct cq_enet_wq_desc *desc,
-	u8 *type, u8 *color, u16 *q_number, u16 *completed_index)
-{
-	cq_desc_dec((struct cq_desc *)desc, type,
-		color, q_number, completed_index);
-}
-
 /*
  * Defines and Capabilities for CMD_CQ_ENTRY_SIZE_SET
  */

-- 
2.48.1



