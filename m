Return-Path: <netdev+bounces-301029-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yJHjI58OOWpvmAcAu9opvQ
	(envelope-from <netdev+bounces-301029-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:29:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A386AEB20
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 12:29:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=ajUllmYM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301029-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301029-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8620B300C00B
	for <lists+netdev@lfdr.de>; Mon, 22 Jun 2026 10:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E4A3A59A8;
	Mon, 22 Jun 2026 10:29:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C0836607D;
	Mon, 22 Jun 2026 10:29:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782124186; cv=none; b=PgBskcKRIQMLKFmccJaYpijvuS0XgTE9x15WqqfRRPFSd1OfHj03YJC9coao1u+Cr8dGhtZILufpPUkYy2DzYFBBeNZlScXLG4lMvEyMA6m9onnGZYsmKdX4eF1rTG9PyyS/0CWtj1ZdIdZctHH5xUShK6n+HgFfpVJEdAbqIGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782124186; c=relaxed/simple;
	bh=47vcHFLPuP+Dz92uLwTGP3oycukQXMy1KngWp5abA2E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gXqebaRkVeb0J3wP8etR4YfEgQyrf3CuR3GukML3zRto5Y2A+oPIOTwsEM+7JnByENXnJHcuroiyViV2UMUddbXDn1vN8zmhRr5mRFgsLdE8oLsCdbWm+tLIrZI6eltFYnHd8LRdr+qv1me9Zwx+xanJ8F9MvdyZ4FZ1Y7usVU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=ajUllmYM; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BB90FA12E1;
	Mon, 22 Jun 2026 12:29:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1782124173; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=8cPvtgry6fEbZtg+k+Au9a9S0BXjMYqcdb90NcXocuw=;
	b=ajUllmYMIln5//RHD2CocqO8/L+SF6R1mQis5I20AnMw+CFafMUd8Nm6IQaFFvTfCIzrre
	FEo8CwVew20hPWK0BClOC8j9HOu3IHAYj13LdRfLNdCQsnDbn2Oy6CKZBSQ3hsd51b65w5
	ydnZ22XHbZqYXyOrKKPTPKwMTIfnGFgIF43NSPbpIu1HbPF6mRyD3aR1sh8v+kxDmnpcMf
	bU2/DsrANXWCL9mFMn13/pjkS6Lgf+pTNl0SfvYCPMaApehIOHPQfmHxZIql9/Gtr+St7m
	8iuuUb0wFurjKGGgz/zqi2YK5EW5WLWi+Lk3JURjn9VFF4NPjGovsVIPVBwHhA==
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Woojung.Huh@microchip.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sven Schuchmann <schuchmann@schleissheimer.de>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v2] net: usb: lan78xx: restore VLAN and hash filters after link up
Date: Mon, 22 Jun 2026 12:29:11 +0200
Message-ID: <20260622102911.484045-1-nb@tipi-net.de>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:schuchmann@schleissheimer.de,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301029-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,schleissheimer.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 31A386AEB20

Configured VLANs intermittently stop receiving traffic after a link
down/up cycle, e.g. when the network cable is unplugged and plugged back
in. VLAN filtering stays enabled but all VLAN-tagged frames are dropped
until a VLAN is added or removed again.

The LAN7801 datasheet (DS00002123E) states:

  "A portion of the MAC operates on clocks generated by the Ethernet
   PHY. During a PHY reset event, this portion of the MAC is designed to
   not be taken out of reset until the PHY clocks are operational"
  (section 8.10, MAC Reset Watchdog Timer)

  "After a reset event, the RFE will automatically initialize the
   contents of the VHF to 0h."
  (section 7.1.4, VHF Organization)

Thus a link down/up cycle stops and restarts the PHY clock, resets the
PHY-clocked portion of the MAC, and the RFE clears its VLAN/DA hash
filter (VHF) memory. The VHF holds both the VLAN filter table and the
multicast hash table, but the driver never reprograms either from its
shadow copy once the link is back, so both stay empty.

Reprogram the VLAN filter and multicast hash tables on link up.

Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Closes: https://lore.kernel.org/netdev/BEZP281MB224501E38B30BFDC4BD3D364D9E32@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM/T/#u
Tested-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
v2:
 - Reprogram in lan78xx_mac_link_up() instead of lan78xx_reset(); the
   table is lost on a plain link down/up cycle, where reset() is not
   called. This also avoids the usb_autopm_get_interface() -EACCES path
   in reset_resume() that was flagged on v1.
 - Also restore the multicast hash table: the RFE clears the whole VHF
   (VLAN + hash) memory, per the LAN7801 datasheet.

v1: https://lore.kernel.org/netdev/20260618191109.4086598-1-nb@tipi-net.de/

 drivers/net/usb/lan78xx.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bcf293ea1bd3..c4cebacabcb5 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -1452,6 +1452,15 @@ static inline u32 lan78xx_hash(char addr[ETH_ALEN])
 	return (ether_crc(ETH_ALEN, addr) >> 23) & 0x1ff;
 }
 
+static int lan78xx_write_mchash_table(struct lan78xx_net *dev)
+{
+	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
+
+	return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,
+				      DP_SEL_VHF_VLAN_LEN,
+				      DP_SEL_VHF_HASH_LEN, pdata->mchash_table);
+}
+
 static void lan78xx_deferred_multicast_write(struct work_struct *param)
 {
 	struct lan78xx_priv *pdata =
@@ -1462,9 +1471,7 @@ static void lan78xx_deferred_multicast_write(struct work_struct *param)
 	netif_dbg(dev, drv, dev->net, "deferred multicast write 0x%08x\n",
 		  pdata->rfe_ctl);
 
-	ret = lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_,
-				     DP_SEL_VHF_VLAN_LEN,
-				     DP_SEL_VHF_HASH_LEN, pdata->mchash_table);
+	ret = lan78xx_write_mchash_table(dev);
 	if (ret < 0)
 		goto multicast_write_done;
 
@@ -1557,6 +1564,7 @@ static void lan78xx_set_multicast(struct net_device *netdev)
 }
 
 static void lan78xx_rx_urb_submit_all(struct lan78xx_net *dev);
+static int lan78xx_write_vlan_table(struct lan78xx_net *dev);
 
 static int lan78xx_mac_reset(struct lan78xx_net *dev)
 {
@@ -2514,6 +2522,17 @@ static void lan78xx_mac_link_up(struct phylink_config *config,
 	if (ret < 0)
 		goto link_up_fail;
 
+	/* The RFE clears the VLAN/DA hash filter (VHF) on a link down/up
+	 * cycle, so reprogram both tables from their shadow copies.
+	 */
+	ret = lan78xx_write_vlan_table(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
+	ret = lan78xx_write_mchash_table(dev);
+	if (ret < 0)
+		goto link_up_fail;
+
 	netif_start_queue(net);
 
 	return;
@@ -3065,14 +3084,20 @@ static int lan78xx_set_features(struct net_device *netdev,
 	return lan78xx_write_reg(dev, RFE_CTL, pdata->rfe_ctl);
 }
 
+static int lan78xx_write_vlan_table(struct lan78xx_net *dev)
+{
+	struct lan78xx_priv *pdata = (struct lan78xx_priv *)(dev->data[0]);
+
+	return lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,
+				      DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);
+}
+
 static void lan78xx_deferred_vlan_write(struct work_struct *param)
 {
 	struct lan78xx_priv *pdata =
 			container_of(param, struct lan78xx_priv, set_vlan);
-	struct lan78xx_net *dev = pdata->dev;
 
-	lan78xx_dataport_write(dev, DP_SEL_RSEL_VLAN_DA_, 0,
-			       DP_SEL_VHF_VLAN_LEN, pdata->vlan_table);
+	lan78xx_write_vlan_table(pdata->dev);
 }
 
 static int lan78xx_vlan_rx_add_vid(struct net_device *netdev,

base-commit: d07d80b6a129a44538cda1549b7acf95154fb197
-- 
2.53.0


