Return-Path: <netdev+bounces-245604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 721F1CD35D6
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 20:01:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B5863008F8D
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 19:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96BC7191F98;
	Sat, 20 Dec 2025 19:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="MaOoE8Qp"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78A23770B
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 19:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766257307; cv=none; b=TVAxla1dhIjiJDq1E0Qb/NDMgR4FHz3IRAWDbjYCuag+qbVC1xsZFEfiyVa3Rd1nEbPBa9PdrxG0iNeBqA0QwSJLNUA6c3788eFFlOxtxRaSisWQNuQsjSEjDGSzCBPgLCy2UsrI/Oy3rjP6QZXr6xXy3NckwXxTszI9NRD3BS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766257307; c=relaxed/simple;
	bh=vnD1GyI4VGLWY/sGBoexe1ZQUge+RVFNghpiT/MhYNQ=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Cxgd4RFGnF1qwT1cArjW4/fDFNM5Me1HDk1Fgq7A11ICNSvYG+nBG6zjKqFvVeBUg36bIBA8qy0nW8nDyN2O+EEYPr/mHwPVwQDFoMluiD1smQOqWnrAEhZiXbm1rr/QKZul6Bi6bdWBVslmmUsszT1cMZLJpaXrsJ0jMxguWo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=MaOoE8Qp; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766257301;
	bh=KU3pyGnQR+h5GWvS/5+kDMS0LeFUEa6bI5Dcar/8lsg=;
	h=From:To:Cc:Subject:Date;
	b=MaOoE8QpDwJv/BRiP9bDVD0VwX57I11Ed7sB5wgvBrWqcVF2D2+X0sbPj9EUWxoet
	 ejFf6QF9uatifaMBmjznCdjLROzuKAS/MbhRwJK9dFLHRrby/JBkMHWoV/SOppFxCG
	 83kL/U3+R3i+akHzHCtzjmWVEJ0Zt3IR+cLZGkDg=
Received: from 7erry.customer.ask4.lan ([31.205.230.119])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 6233094; Sun, 21 Dec 2025 03:01:34 +0800
X-QQ-mid: xmsmtpt1766257294tauss7hip
Message-ID: <tencent_7C21405938B40C8251F2CFE0308CD7093908@qq.com>
X-QQ-XMAILINFO: MOnsIKIZIC7LoayIyF0P3pZgXt1xd5mgCLh/IhgSnGFd0/ZRK+8TBWS4lQH9y0
	 Wno75ERkKfWaHdXrHzy/AjM7V5Uedd+s7t6HgubQWNvTk/e5feAzSSQw1iRz6Mi46Panuxoki574
	 kDEmZ067SSNy8pzGwtMS8IS6Chn7jpOAgdM8tvQBMKFLBxYppvREXb8PV6rKC3FjqD3/GoGW8VTg
	 hg1bbpvuTIOA0AprpbuDH3Mu4CVLO7XyA0ZrDCNJQI0CBLXvzCmpXnBLQc1FkCE+4njYXWyNU5fz
	 TW7EXgVnM+CyCHOG4ZWQ83k6qU6aTSQvLyettnqP7StWzFVF+K6hCAD1JruUXXN/Uq2bJ4xOOgsp
	 i3YN1PYMaHjKzw4T0UoQ0TKH8MxNDSWErImGUYoJatFW4OEM4xIK2A3HAh9CPOYmq7HODHDONRkF
	 dI0QRHsZ+e1n56ZBdJM/LPZfdCBTCk8STkP+/k2lpJd6pV8jNXfbCwMfMuQPGwWjJsEij1G+5Fjy
	 HznN0gl3HpnvFnNWlTIEOgJNWzwjYXOwiNPespfBhghhz7wNAIVRbKM+qzHRbx6Xq/G2Cv2orz1R
	 W1uFT5AcktTrPmbSA853ynHA/OJbe0KF+Ct7SBKb9qdYyaGhXmN4rqNOq7Qh0MRqw519GsQjj0PF
	 vCHllJsnvUrjD9vs8OzJe/3K/4rlqK3U5RvgWnlX9D8HYkTprEAGJ12NZ6HpsQ48goBpB+sRvNfP
	 oCn8Nh7DB8l1hrSteKTLPBPA8jE3BPfi/8KVqOdTde+DbOKwkKI1FwTbXEs8iPsqBrLLrv4QzzAa
	 RuVcR9UzOgQzrus4dYRZ5U8m9WFzqRN34486b0A0zCo6Hu4qVet/1P97cVZTuKdUakxadSDeTtdW
	 9vmnli7T9gvUV2m95qBBVqU3tM6I579IP4oN8YRbIC3j7SywdtjUP1jZOdR64Gk2AmA8AgrdGWsq
	 EooIaiIkuz0q0f6g/i5rrR5LRdZXXq1GarGzPmLu3QvmklMwL6vNINQG2zJlmAIVPjTKCErHhG6X
	 EkruYY9tfICULWiVDVY1fWuDlSIpvVtfzjsqJ1QyoBU1QE0D+8YdWd5/QL+fnIFg6K9voVrJA0bD
	 M8DxeDVr5OHdAp6TOZQDmMCBXpNjyT4COcjpPdg5O4GzXU+RirsI8oEWNQzOv/3Fr7cdcqEmis+M
	 Ot8qA=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: Jerry Wu <w.7erry@foxmail.com>
To: vladimir.oltean@nxp.com
Cc: claudiu.manoil@nxp.com,
	alexandre.belloni@bootlin.com,
	UNGLinuxDriver@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jerry Wu <w.7erry@foxmail.com>
Subject: [PATCH net v2] net: mscc: ocelot: Fix crash when adding interface under a lag
Date: Sat, 20 Dec 2025 19:01:23 +0000
X-OQ-MSGID: <20251220190123.27710-1-w.7erry@foxmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 15faa1f67ab4 ("lan966x: Fix crash when adding interface under a lag")
fixed a similar issue in the lan966x driver caused by a NULL pointer dereference.
The ocelot_set_aggr_pgids() function in the ocelot driver has similar logic
and is susceptible to the same crash.

This issue specifically affects the ocelot_vsc7514.c frontend, which leaves
unused ports as NULL pointers. The felix_vsc9959.c frontend is unaffected as
it uses the DSA framework which registers all ports.

Fix this by checking if the port pointer is valid before accessing it.

Fixes: 528d3f190c98 ("net: mscc: ocelot: drop the use of the "lags" array")
Signed-off-by: Jerry Wu <w.7erry@foxmail.com>
---
 drivers/net/ethernet/mscc/ocelot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mscc/ocelot.c b/drivers/net/ethernet/mscc/ocelot.c
index 08bee56aea35..6f917fd7af4d 100644
--- a/drivers/net/ethernet/mscc/ocelot.c
+++ b/drivers/net/ethernet/mscc/ocelot.c
@@ -2307,14 +2307,16 @@ static void ocelot_set_aggr_pgids(struct ocelot *ocelot)
 
 	/* Now, set PGIDs for each active LAG */
 	for (lag = 0; lag < ocelot->num_phys_ports; lag++) {
-		struct net_device *bond = ocelot->ports[lag]->bond;
+		struct ocelot_port *ocelot_port = ocelot->ports[lag];
 		int num_active_ports = 0;
+		struct net_device *bond;
 		unsigned long bond_mask;
 		u8 aggr_idx[16];
 
-		if (!bond || (visited & BIT(lag)))
+		if (!ocelot_port || !ocelot_port->bond || (visited & BIT(lag)))
 			continue;
 
+		bond = ocelot_port->bond;
 		bond_mask = ocelot_get_bond_mask(ocelot, bond);
 
 		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {
-- 
2.52.0


