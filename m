Return-Path: <netdev+bounces-271218-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKzzMe7TwmllmgQAu9opvQ
	(envelope-from <netdev+bounces-271218-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:11:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CC731A8C1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:11:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 58B8230D642D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:08:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA6F3A0E80;
	Tue, 24 Mar 2026 18:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wJiTqLa2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F7E386C03;
	Tue, 24 Mar 2026 18:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774375725; cv=none; b=Bt5TZsOEWeu1UPTLpshB0T+DAFftldonv33athRl6Xrhj9ArM9c7urmX8P71GxkItNpd8yzQ4VLZrB549vS+LlBPb9PDjIw5AzClcljgcAgTtRoor+aN8JsbXKBM6cIyf+k24EX4gC0e7Oe5KtDms838uXgCv8wHak274ZGEo9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774375725; c=relaxed/simple;
	bh=NsCuh0kMJwd7g1iWiZQoKs0jSLMe/s4s+1AN3yqGpZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SSvyvnKfsP0mZNoMT9Y8gB1GJSriUB0+NbkxUuV6NN/nTLkkia6Q/P19g1L17X4XxnnEn/rzpY7PPhXyTvseBj2y7m2H0AGuAOksZZ/lKJorif8cARYnMLigbLYr/aOC3NXq1VmKpM6UQzYgply3ebV3TH5mWQzVVoZp66myJ6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wJiTqLa2; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 5D5794E427DB;
	Tue, 24 Mar 2026 18:08:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2C1B6601A0;
	Tue, 24 Mar 2026 18:08:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0622F1045059C;
	Tue, 24 Mar 2026 19:08:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774375721; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=ctnkA2Z/QP+/ow0ArbPhwunjtlwws5koYT6RP/2y1wg=;
	b=wJiTqLa2Wl3YDxWbhRzjZpgeFNne1nnD6V2rIqQliVaarc2JCrBT/5VdIkdAaBOoRDjD5b
	9jp/EOYTYY0a0j8UAAuRLX53krFotAiV3HdEw2kTjgsIBzw+yukZySnh4MfEqRN6/Px3zh
	PXBWKu0/QhIktNW7D5FXLAc21ZcJiKsA1snm00Gh1z7vnj7khTVlZPDXBpQICvIiCqRpcZ
	tllkGoD4P2d7bjNeHsFWDtKSeQzv6bihK8OEAuZI1NS5csusyOOeTbXJXJy5IGUrjxOCXw
	ABeD2cZrMBcCIx/wbbXK+CbQs+uGhjHGhU0OQYizxl+l4HWDDXxR0gN4OCQIVA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	UNGLinuxDriver@microchip.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/2] net: dsa: microchip: drop an outdated comment about SGMII support
Date: Tue, 24 Mar 2026 19:08:25 +0100
Message-ID: <20260324180826.524327-3-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
References: <20260324180826.524327-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-271218-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,kernel.org,davemloft.net,google.com,redhat.com,microchip.com,gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Queue-Id: 36CC731A8C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SGMII support has been added to ksz9477, we can drop the comment saying
that it'll be added later.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/dsa/microchip/ksz9477.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/microchip/ksz9477.c b/drivers/net/dsa/microchip/ksz9477.c
index 30d8c0146bbb..d3c23dcaea8c 100644
--- a/drivers/net/dsa/microchip/ksz9477.c
+++ b/drivers/net/dsa/microchip/ksz9477.c
@@ -525,7 +525,7 @@ int ksz9477_r_phy(struct ksz_device *dev, u16 addr, u16 reg, u16 *data)
 	 * A fixed PHY can be setup in the device tree, but this function is
 	 * still called for that port during initialization.
 	 * For RGMII PHY there is no way to access it so the fixed PHY should
-	 * be used.  For SGMII PHY the supporting code will be added later.
+	 * be used.
 	 */
 	if (!dev->info->internal_phy[addr]) {
 		struct ksz_port *p = &dev->ports[addr];
-- 
2.49.0


