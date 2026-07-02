Return-Path: <netdev+bounces-304043-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PWzOGh0sRmpELAsAu9opvQ
	(envelope-from <netdev+bounces-304043-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:15:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D02646F5213
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:15:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=ZQw8V2xN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304043-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304043-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DBC430C656F
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E13E1232;
	Thu,  2 Jul 2026 09:07:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDA646AF04
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 09:07:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983261; cv=none; b=CRSDx/ATiwVdHrOmjGgkshl+nVjsa0v3PP1eq2AAOM3jNd1DLpA3c9KS6QJ9f4dsIQPElX+tRIwFLTUNgGX8IDXU/qnv6aDzRdgXxeBEJWDyOx2Kur3uTqR7ivW7i0/5svDyt57f51lhDxu8ly80Lpp+4j0ztpd7ueluryDYLUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983261; c=relaxed/simple;
	bh=2ICHkoIZExT5+DfhgH3R3nAeUnI9QwO+AxV3uVd/HyQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwC8W0ReEPZWFDSHrDm0S74DBfGn+ccNT6oUmz7w5Iex7aWU0kHkI78np+YcsWRXRK5XBk54MkFI7H1+acGtgnm4jdS+6kI2N+oz4xIASGLRZxRfXyGj4tUP/mmaDrjjFe+k3RP5KAU9mIur8C7FBE8iVwtokzpA31wqv/Ja+MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZQw8V2xN; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 34AE61A0DD5;
	Thu,  2 Jul 2026 09:07:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 0554D5FF03;
	Thu,  2 Jul 2026 09:07:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 588E0104C9625;
	Thu,  2 Jul 2026 11:07:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782983257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=YCaaC8VkSZj6CdeXIhHw9RxFfHRZQBodVxt7Thd9TzI=;
	b=ZQw8V2xN2+dTueRlq/58GAkGMjhbrPsEGtcAxe1qu6RKPqdmVUSx2B3u0jrsvSA4aK/cNU
	6sNWr3p8UasMvIod6pAViZhllUB2nV9cWu5Z7sU9pnvc3UJc+y7Ulja+sslrZIPRh/wfGE
	kCOU7MXuPTyPTs9vHOY6JOBa5eAHdKWufFFvwujPV0LRM4L5j2GBzOjx1YMGrmRb3sFqBp
	Qa6y3sxwHOEq+m/QE3lpbCDrApWsdGd+76b8ERToPe3AUMdQUZJfK2r/oYNRpbgLTCIIEU
	BMYpYQEkPRNSSm93T/20NVFZ8fCJDv/kSs9L/2mprJZxqOXf2EJn1lnU+yC32g==
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Date: Thu, 02 Jul 2026 11:07:23 +0200
Subject: [PATCH net-next 01/10] net: dsa: microchip: split
 ksz8_change_mtu()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260702-clean-ksz-4th-v1-1-93441e695fa4@bootlin.com>
References: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
In-Reply-To: <20260702-clean-ksz-4th-v1-0-93441e695fa4@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>, 
 Vladimir Oltean <vladimir.oltean@nxp.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk];
	FORGED_RECIPIENTS(0.00)[m:woojung.huh@microchip.com,m:UNGLinuxDriver@microchip.com,m:andrew@lunn.ch,m:olteanv@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:pascal.eberhard@se.com,m:miquel.raynal@bootlin.com,m:thomas.petazzoni@bootlin.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bastien.curutchet@bootlin.com,m:vladimir.oltean@nxp.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-304043-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid,bootlin.com:from_mime,nxp.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D02646F5213

From: Vladimir Oltean <vladimir.oltean@nxp.com>

Even among the ksz8 family, there are big differences in the MTU change
procedure between KSZ87xx and KSZ88xx (KSZ8463 is like KSZ88xx here).

Since we have 3 separate dsa_switch_ops for what constitutes "KSZ8", we
can split those procedures into separate functions.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 49 ++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 30 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index 586916570a84..c351179f6a60 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -158,10 +158,17 @@ static int ksz8_reset_switch(struct ksz_device *dev)
 	return 0;
 }
 
-static int ksz8863_change_mtu(struct ksz_device *dev, int frame_size)
+static int ksz88xx_change_mtu(struct dsa_switch *ds, int port, int mtu)
 {
+	struct ksz_device *dev = ds->priv;
+	int frame_size;
 	u8 ctrl2 = 0;
 
+	if (!dsa_is_cpu_port(dev->ds, port))
+		return 0;
+
+	frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+
 	if (frame_size <= KSZ8_LEGAL_PACKET_SIZE)
 		ctrl2 |= KSZ8863_LEGAL_PACKET_ENABLE;
 	else if (frame_size > KSZ8863_NORMAL_PACKET_SIZE)
@@ -171,11 +178,18 @@ static int ksz8863_change_mtu(struct ksz_device *dev, int frame_size)
 			KSZ8863_HUGE_PACKET_ENABLE, ctrl2);
 }
 
-static int ksz8795_change_mtu(struct ksz_device *dev, int frame_size)
+static int ksz87xx_change_mtu(struct dsa_switch *ds, int port, int mtu)
 {
+	struct ksz_device *dev = ds->priv;
 	u8 ctrl1 = 0, ctrl2 = 0;
+	u16 frame_size;
 	int ret;
 
+	if (!dsa_is_cpu_port(dev->ds, port))
+		return 0;
+
+	frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
+
 	if (frame_size > KSZ8_LEGAL_PACKET_SIZE)
 		ctrl2 |= SW_LEGAL_PACKET_DISABLE;
 	if (frame_size > KSZ8863_NORMAL_PACKET_SIZE)
@@ -188,31 +202,6 @@ static int ksz8795_change_mtu(struct ksz_device *dev, int frame_size)
 	return ksz_rmw8(dev, REG_SW_CTRL_2, SW_LEGAL_PACKET_DISABLE, ctrl2);
 }
 
-static int ksz8_change_mtu(struct dsa_switch *ds, int port, int mtu)
-{
-	struct ksz_device *dev = ds->priv;
-	u16 frame_size;
-
-	if (!dsa_is_cpu_port(dev->ds, port))
-		return 0;
-
-	frame_size = mtu + VLAN_ETH_HLEN + ETH_FCS_LEN;
-
-	switch (dev->chip_id) {
-	case KSZ8795_CHIP_ID:
-	case KSZ8794_CHIP_ID:
-	case KSZ8765_CHIP_ID:
-		return ksz8795_change_mtu(dev, frame_size);
-	case KSZ8463_CHIP_ID:
-	case KSZ88X3_CHIP_ID:
-	case KSZ8864_CHIP_ID:
-	case KSZ8895_CHIP_ID:
-		return ksz8863_change_mtu(dev, frame_size);
-	}
-
-	return -EOPNOTSUPP;
-}
-
 static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 {
 	u8 mask_4q, mask_2q;
@@ -2551,7 +2540,7 @@ const struct dsa_switch_ops ksz8463_switch_ops = {
 	.port_mirror_del	= ksz8_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz8_change_mtu,
+	.port_change_mtu	= ksz88xx_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
@@ -2601,7 +2590,7 @@ const struct dsa_switch_ops ksz87xx_switch_ops = {
 	.port_mirror_del	= ksz8_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz8_change_mtu,
+	.port_change_mtu	= ksz87xx_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.suspend		= ksz_suspend,
 	.resume			= ksz_resume,
@@ -2652,7 +2641,7 @@ const struct dsa_switch_ops ksz88xx_switch_ops = {
 	.port_mirror_del	= ksz8_port_mirror_del,
 	.get_stats64		= ksz_get_stats64,
 	.get_pause_stats	= ksz_get_pause_stats,
-	.port_change_mtu	= ksz8_change_mtu,
+	.port_change_mtu	= ksz88xx_change_mtu,
 	.port_max_mtu		= ksz_max_mtu,
 	.get_wol		= ksz_get_wol,
 	.set_wol		= ksz_set_wol,

-- 
2.54.0


