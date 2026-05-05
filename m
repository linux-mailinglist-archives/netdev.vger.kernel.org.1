Return-Path: <netdev+bounces-284435-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qN+nNOj9+WkqFwMAu9opvQ
	(envelope-from <netdev+bounces-284435-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:25:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBA94CF5A1
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 16:25:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 62A713053D07
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 14:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64844480330;
	Tue,  5 May 2026 14:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="WTbP0FR2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D57447ECDE;
	Tue,  5 May 2026 14:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777991120; cv=none; b=Z5MOhTTIdflt20laP3Mm4A8ylcZ3tXB552h52us2sOpKm5D2KroxPbGLL68jg7aw+Dv9Z0EJ4CCXHWxoAWpjk+miCOTILWTPqnJLLfUYU28SAaaZpI80zltuqVmhaXIkS7cYxqkgva1iUFQqEd1qNl90eheMstXeZbDgngsnafY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777991120; c=relaxed/simple;
	bh=m8Xjk2wnvb3rPWg6sC0qhQ6vP4aFS/BHZiCUCMq054E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KwyKYT9lfleNXANVcZX0KPc8JA4QZLDK/twdRnODx2CPRnQu5gqmp5aeTu+w25+5clUv9MZnVnfa+y8guyIU2F0A5qmyqYbCGwFV1w0+48XQbVDsASiGomSGr73pXW9pAeild41Oc++pDOAwEW1o8uBEpkk29f0r+8nYzJApMTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=WTbP0FR2; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 237B31A3523;
	Tue,  5 May 2026 14:25:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id EC1456053C;
	Tue,  5 May 2026 14:25:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3BC1111AD0236;
	Tue,  5 May 2026 16:25:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1777991116; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=piUJ7mUfFNpyWzUKFFwhxU1MDxqdpzh6kw35XoGmveg=;
	b=WTbP0FR2YcaBwzRsOz0mJME6vN6sd20a39zUQGFLdPTnhz3Sg+I8HXaRDuO9hcQPUf0LLb
	/SGf9SQTA+oVBvWrpbNMq6Rwo6bVkF6R7V8E3yx6Km6J9JkB4OwF8NQqUC7eMuX/+WR77V
	upWZkZos6qZPpIGSzI1jplPZOelnNtE8EQ8Ts8SVW9XBFgy59voHKoGNJ0alqVObrqU20k
	LRxdDCnXfMGLyHOoGTOSjsf6VvDBkcifAZOW7h+6xdINaPbKL/Tf3c+guxU+GL8Dvpet/M
	SUkcnbMrZcnMsDQoTTyDZyTvwvq+iRZ7uACWo7R5z1vqVUdky51vi2lRsRS7Dg==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Tue, 05 May 2026 16:25:01 +0200
Subject: [PATCH net-next 1/9] net: dsa: microchip: Remove unused
 ksz8_all_queues_split()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260505-clean-ksz-driver-v1-1-05d70fa42461@bootlin.com>
References: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
In-Reply-To: <20260505-clean-ksz-driver-v1-0-05d70fa42461@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.3
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 6FBA94CF5A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284435-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bootlin.com,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:dkim,bootlin.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

ksz8_all_queues_split() isn't used anywhere.

Remove it.

Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz8.c | 15 ---------------
 drivers/net/dsa/microchip/ksz8.h |  1 -
 2 files changed, 16 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
index c354abdafc1b5..dc29b028f8409 100644
--- a/drivers/net/dsa/microchip/ksz8.c
+++ b/drivers/net/dsa/microchip/ksz8.c
@@ -267,21 +267,6 @@ static int ksz8_port_queue_split(struct ksz_device *dev, int port, int queues)
 	return ksz_prmw8(dev, port, reg_2q, mask_2q, data_2q);
 }
 
-int ksz8_all_queues_split(struct ksz_device *dev, int queues)
-{
-	struct dsa_switch *ds = dev->ds;
-	const struct dsa_port *dp;
-
-	dsa_switch_for_each_port(dp, ds) {
-		int ret = ksz8_port_queue_split(dev, dp->index, queues);
-
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
 void ksz8_r_mib_cnt(struct ksz_device *dev, int port, u16 addr, u64 *cnt)
 {
 	const u32 *masks;
diff --git a/drivers/net/dsa/microchip/ksz8.h b/drivers/net/dsa/microchip/ksz8.h
index 0f2cd1474b44f..52b7d944d9d97 100644
--- a/drivers/net/dsa/microchip/ksz8.h
+++ b/drivers/net/dsa/microchip/ksz8.h
@@ -61,7 +61,6 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
 			      struct phy_device *phydev, unsigned int mode,
 			      phy_interface_t interface, int speed, int duplex,
 			      bool tx_pause, bool rx_pause);
-int ksz8_all_queues_split(struct ksz_device *dev, int queues);
 
 u32 ksz8463_get_port_addr(int port, int offset);
 int ksz8463_r_phy(struct ksz_device *dev, u16 phy, u16 reg, u16 *val);

-- 
2.53.0


