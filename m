Return-Path: <netdev+bounces-300525-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jy0LAfhCNGr/TAYAu9opvQ
	(envelope-from <netdev+bounces-300525-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:11:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 506CA6A24E1
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 21:11:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=tipi-net.de header.s=dkim header.b=jw327lAb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300525-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300525-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24B9C301BCE3
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 19:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D61F33E358;
	Thu, 18 Jun 2026 19:11:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AD532C302;
	Thu, 18 Jun 2026 19:11:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781809900; cv=none; b=AggMIZ2ODmfeVeTDeyT3x09jQtnYqFKAP4V7D+ECK32Ky9R0XoA7PtP2OHmXBII+ogsAsYu+h5ouLxGeNN6HhKhOa9hZWJvOeu3bbUb0DAsJXY/M9El6yJPDc/77D9seE+s7tbCQVWrxn3tyG1/RyvC4jh3wcCNK7TOksCFGW/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781809900; c=relaxed/simple;
	bh=BHtCh0b8TOuswa7hGrMfjuNY27YzqJTCUlO9bZ66Tag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OZb6Kd2gsV49QTvyt6VdNd6/DYqUbeUKRMFY+0YidHWWWqTRh94MQ+5KmKtnY9XKI/WTjD9UbMcVnfOre8LRJAmAiN+Tjf6zRx5cXMbXpdPTqBOQGnBDOVkwgcakpfrpCQ2e9JEeXhrDaP4XiRYRRKWEYpYa6FXGfP1wl+Cn3Mo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=jw327lAb; arc=none smtp.client-ip=194.13.80.246
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D7B6A3ED1;
	Thu, 18 Jun 2026 21:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781809896; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=BZmMdIyN4y3YvhjhU/ik4zjvZCEifGsK+dfHTV2z28A=;
	b=jw327lAbeWqcEMZ4AagUMj0vGnOu39EEZ8EQBVRpwxNX99FOen0mNPwS6E1FmlanK/Yhuq
	8YkhEE9td7BZXikHmtlvqq14GAUDtwk4A78SORr3YFGL7QcO3Bsgj0TLG6yF9ReJAxtbPc
	WfsLLfFq8NfJhQTRGlLVqVkPE3NByZPAqRdt88Zxv+5v/769ekpKl6QklVGm3zLfSGfBc9
	BUdKBomIXCTfe1e6E2ywQp/lDeOPq2fY++xF6Ehu1nud2Rl6wecOtbg8Ofz6EyFbrUkP52
	XQb3t1J2szPMBOOOlC+uUoVvZPQirdhjxdqXLpFtGE+hO4/iq7cB3P48daCyWw==
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
Subject: [PATCH net] net: usb: lan78xx: restore VLAN filter table after device reset
Date: Thu, 18 Jun 2026 21:11:08 +0200
Message-ID: <20260618191109.4086598-1-nb@tipi-net.de>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:Thangaraj.S@microchip.com,m:Rengarajan.S@microchip.com,m:UNGLinuxDriver@microchip.com,m:Woojung.Huh@microchip.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:schuchmann@schleissheimer.de,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:nb@tipi-net.de,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	DMARC_NA(0.00)[tipi-net.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300525-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 506CA6A24E1

Configured VLANs stop receiving traffic after a USB autosuspend/resume
cycle, e.g. when a cable is unplugged long enough for the device to
suspend and then plugged back in. VLAN filtering stays enabled but all
VLAN-tagged frames are dropped until a VLAN is added or removed again.

The reset on resume clears the hardware VLAN filter table, but unlike
the multicast and address filters it is never reprogrammed from the
driver's shadow copy, so it stays empty.

Restore the VLAN filter table as part of the reset sequence.

Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Closes: https://lore.kernel.org/netdev/BEZP281MB224501E38B30BFDC4BD3D364D9E32@BEZP281MB2245.DEUP281.PROD.OUTLOOK.COM/T/#u
Fixes: 55d7de9de6c3 ("Microchip's LAN7800 family USB 2/3 to 10/100/1000 Ethernet device driver")
Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/usb/lan78xx.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/lan78xx.c b/drivers/net/usb/lan78xx.c
index bcf293ea1bd3..52c76de64eb9 100644
--- a/drivers/net/usb/lan78xx.c
+++ b/drivers/net/usb/lan78xx.c
@@ -3065,14 +3065,20 @@ static int lan78xx_set_features(struct net_device *netdev,
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
@@ -3353,6 +3359,15 @@ static int lan78xx_reset(struct lan78xx_net *dev)
 
 	lan78xx_set_multicast(dev->net);
 
+	/* The chip reset above also clears the VLAN filter table held in the
+	 * shared VLAN/DA hash RAM. The network stack does not re-add VLANs
+	 * after a silent device reset (e.g. on reset_resume after USB
+	 * autosuspend), so restore the table from our shadow copy here.
+	 */
+	ret = lan78xx_write_vlan_table(dev);
+	if (ret < 0)
+		return ret;
+
 	/* reset PHY */
 	ret = lan78xx_read_reg(dev, PMT_CTL, &buf);
 	if (ret < 0)

base-commit: 7d8297e26b4e20b5d1c3c3fe51fe81a1c7fbc823
-- 
2.53.0


