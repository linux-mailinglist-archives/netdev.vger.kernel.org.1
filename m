Return-Path: <netdev+bounces-245603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 47930CD35C4
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 19:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE5123000913
	for <lists+netdev@lfdr.de>; Sat, 20 Dec 2025 18:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AFFF3009C3;
	Sat, 20 Dec 2025 18:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="LjrsGaop"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-57-210.mail.qq.com (out162-62-57-210.mail.qq.com [162.62.57.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BAA209F5A
	for <netdev@vger.kernel.org>; Sat, 20 Dec 2025 18:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766257032; cv=none; b=c2Pq1e+P2w4NK0Vdlop9rEEn+bkiEwhcffWXavxQn+ZSpnMrAg7KwbAuXAqAKZgAq7m5HveBAWXAjhNerscX3NN0AiFlgEWS5iXJ/q6CqjABjOLwt+FMNedtbXnuVHx8I4beiAKCXzOn6Hbo1wNcqILGw46uBjdhqHLRsh4Gg00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766257032; c=relaxed/simple;
	bh=vdirJ98rx4Lw3LOnt1dX2HKmALhZP5GwUyJA9y3V/3o=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=qWMJR482b20Bs5KHy7a6/VClOJWbTDEH49DUYlv6bJYr2HWR02ljTd9H34dcukx9Om1i+f0x8f1H0qiyyUBpJY9BxjwzQu+yI0INMmib3g/wnhdLt4sJhRfEFTZ2XWHZ4T+VT8o1ZnYgOTSt8X0aZD7Xw5bslKWdv86S7klBC80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=LjrsGaop; arc=none smtp.client-ip=162.62.57.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1766257017;
	bh=MrG3hgZbZN223ywIzuLV1B6U7mfgl3LQz4DzSdiGcFA=;
	h=From:To:Cc:Subject:Date;
	b=LjrsGaopLOuh5fWtNFLKgnT/DuSMOlv08+O4Z6A7LTly+v7PbLCjmEvl1vncK2S6q
	 7F3N04OsSJ+j9ZhbUt5hquXTOefU9iHyua3Tj9QO/VY6zo4f9syMyVqOOmfJxGS5cr
	 AEAPCjgwWfE5LFC15KXRGIdTEH0kIFzonHNdVjBg=
Received: from 7erry.customer.ask4.lan ([31.205.230.119])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id E3295CD7; Sun, 21 Dec 2025 02:56:50 +0800
X-QQ-mid: xmsmtpt1766257010tgavabu04
Message-ID: <tencent_03A0A4FC04B804E36C8245084CD6052D8406@qq.com>
X-QQ-XMAILINFO: NYXSVuwhoxRbzOK1Mb8R/+HEK5SNs2Zb5+ks/01Xa9BhMMa4WvIk3HGkd4sdZB
	 3+aIrBzQ4hB4UXxzde9OwKBptfHsnueHY1Sy/pvtKDIOBhHFJQNCHopV3ZBwOiSPj9a/Q6iKJeGe
	 klcFyQD575qPqnkK94YFTT2+JeQh3mnQCgO4XmfzhL9Nepvx/gdZs92Orno7K+aK6tUB7Ep1l/wj
	 uYhKXK04GCXLVldDPIzeJkAWB3fO8n+ht0r++3x6yLBWlU7YkfCufFcPp/keaF+x1RnvAZS7re5a
	 CCDLuJJoPcIiyBMU+s+czlRX7n4nkIzb2Q7vV4GC8cinpCqnw8tchbHo8AbTHXQibdqusfMo+HYi
	 UdFOhT9grNdG2qyjnZK0cT3MEG72NTQeGxaxx+9Gvs04n1ZlvIH/taL5v/KZq3xmVYUdsLYydtoM
	 MRswJgIFqznfgrpTUFuf7wbTSiki6hraINSvUBhv/NNCFKB1+yIkxgALb0Hx5SxsBBVQB6SyNCoT
	 RNXiSec0+joJlR0naQBMzal9C+4Ux8UEBw9IdBN3yF2QvGHXqyc/kzwKVztfzBcPZ/pPfO4EJPz6
	 nw7koN09oZGieZyNLHAvJfkr1w29sfqxDr7EQJcLaWlAVpdBgl7CNWyjLIYtkBGWUaGFivn5Nqv/
	 tgEWpys5CS+t0+IjxgkBPIVF1Z3Rrsi4iLoTUlFUqk4Q/1p7KiqVpF2cZU3Ifqd8HQPI2YAIr4q+
	 bYTi5puUUibYm5bRPo3q1G90WDLsd6K0TfLnp++NL8MaG3w1vA5tBmyPO4oJ+A+6WQM+JOr55BpO
	 7g+UtgLxzxouplqFpp3oDbtKm2j7H8W60DUAKDmv/y/YQF3ZlyiFJ2+aASvqaP9HsiqamV+LSFZ6
	 5O93lwY/5rT3Y/bJ07/8fuBvEQvyZ1p1kXCVysP463OBaNhpdCAiI9fDu3gcobpxsyzn0y+weOZ2
	 qrR11rbqZNEOVsZEMaMauIkvpE+B7+Wjdh/chyqF3TxCeWQBsRQBcfTNuPtc78XSvP9Pb3nH2Fx8
	 WN9Aca3ncBv+xI2hBXVOoAMELjcu9Jmz3oxoZNSp07D9ESjJRMK7288ocapcvt46LQfz+CWQ==
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
Date: Sat, 20 Dec 2025 18:56:34 +0000
X-OQ-MSGID: <20251220185634.25985-1-w.7erry@foxmail.com>
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
+		if (!port || !port->bond || (visited & BIT(lag)))
 			continue;
 
+		bond = port->bond;
 		bond_mask = ocelot_get_bond_mask(ocelot, bond);
 
 		for_each_set_bit(port, &bond_mask, ocelot->num_phys_ports) {
-- 
2.52.0


