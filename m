Return-Path: <netdev+bounces-278496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJs2OTtc3mlfCQAAu9opvQ
	(envelope-from <netdev+bounces-278496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:24:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE773FBBF6
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 17:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B52273053297
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 15:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFF9D3E959D;
	Tue, 14 Apr 2026 15:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Y0oFLH8x"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AC83E715C;
	Tue, 14 Apr 2026 15:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776179621; cv=none; b=knrVaBzpaj1+sNzT4t0jmzL+oCwr2PL6qg+kfPKHj33+lqTOQkPe1Xk/yHcYs42aGHWrJKhr5RI+VT/iNN3uT0ic+UKXXwIcVBNRJJCAqn+DRN8h8cwd50uLzAwMkDFrT0l5i6rus3W1Gqc2n0YR9PJWklcMPyLAGNxfIordrms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776179621; c=relaxed/simple;
	bh=Vz9rKL54iiHymEiW3uv51q84eEtAHKuWK73E/syCT54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MMoGT+0rLSIotuAbCZ6mgKGWMgF/MQ6ql2GumWhQ83+VHDCD6locI4s8+SeyQVRNKFm8L0SuSNA0aXuD9ZGyl6TwdH/jw0dwEnHYvz4uf8MAMEPzon4JXPtpYfjVjcvUqjUssUjxdWRdcI2BKWdwv+3LAkxt0u903OEdIk6F/dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Y0oFLH8x; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id B027A4E42990;
	Tue, 14 Apr 2026 15:13:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 746DE60410;
	Tue, 14 Apr 2026 15:13:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC0621045127E;
	Tue, 14 Apr 2026 17:13:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1776179617; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding; bh=SC94qSGZ3uavMZ8B7XaCT46R2BgoL8muSdeO4dwNkx4=;
	b=Y0oFLH8xQRI0z0LMnsor1c1F3XqxDT3IrcWjWVM5XuuopyWo1lc4Eb6VCaiLY9op8iXwYp
	t1kQod75Z3wn9Xiismg87nV45obwNL1gG+W0zN/HTF3jS7EXc1paN7t7txWybW13Zk4R1I
	4569/CN2+prsug6UH1nZ9xx3krDCHxAJVd0eC7uQtsiHBaZW8iWJfPxmZcANwmIsPjl36z
	lykkcZTJ3jFsu9tReQxFcSpkobj/J7pUo6vWCVKLC7ic4KBLJJ2BJuWAdmydKWETzZOTSX
	lIrmNaZ0JyaxsmPZtETezo/pzoJmXwV1IHSLSE8UKu1cGhDowUglsZmGkoylOg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: "Kory Maincent (Dent Project)" <kory.maincent@bootlin.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Carlo Szelinsky <github@szelinsky.de>,
	thomas.petazzoni@bootlin.com,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net] net: pse-pd: fix out-of-bounds bitmap access in pse_isr() on 32-bit
Date: Tue, 14 Apr 2026 17:13:30 +0200
Message-ID: <20260414151331.745552-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278496-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:email,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 8CE773FBBF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In pse_isr(), notifs_mask was declared as a single unsigned long on the
stack (32 bits on 32-bit architectures). For PSE controllers with more
than 32 ports, this causes two problems:

- map_event callbacks could wrote bit positions >= 32 via
  *notifs_mask |= BIT(i), which is undefined behaviour on a 32-bit
  unsigned long and corrupts adjacent stack memory.

- for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) treats
  &notifs_mask as a multi-word bitmap and reads beyond the single
  unsigned long when nr_lines > BITS_PER_LONG.

Fix this by moving notifs_mask out of the stack and into struct pse_irq
as a dynamically allocated bitmap. It is sized with
BITS_TO_LONGS(pcdev->nr_lines) words in devm_pse_irq_helper(), so it
is always wide enough regardless of the host word size.

Fixes: fc0e6db30941a ("net: pse-pd: Add support for reporting events")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
 drivers/net/pse-pd/pse_core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index 3beaaaeec9e1f..2ced837f375d2 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -1170,6 +1170,7 @@ struct pse_irq {
 	struct pse_controller_dev *pcdev;
 	struct pse_irq_desc desc;
 	unsigned long *notifs;
+	unsigned long *notifs_mask;
 };
 
 /**
@@ -1247,7 +1248,6 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
 static irqreturn_t pse_isr(int irq, void *data)
 {
 	struct pse_controller_dev *pcdev;
-	unsigned long notifs_mask = 0;
 	struct pse_irq_desc *desc;
 	struct pse_irq *h = data;
 	int ret, i;
@@ -1257,14 +1257,15 @@ static irqreturn_t pse_isr(int irq, void *data)
 
 	/* Clear notifs mask */
 	memset(h->notifs, 0, pcdev->nr_lines * sizeof(*h->notifs));
+	bitmap_zero(h->notifs_mask, pcdev->nr_lines);
 	mutex_lock(&pcdev->lock);
-	ret = desc->map_event(irq, pcdev, h->notifs, &notifs_mask);
-	if (ret || !notifs_mask) {
+	ret = desc->map_event(irq, pcdev, h->notifs, h->notifs_mask);
+	if (ret || bitmap_empty(h->notifs_mask, pcdev->nr_lines)) {
 		mutex_unlock(&pcdev->lock);
 		return IRQ_NONE;
 	}
 
-	for_each_set_bit(i, &notifs_mask, pcdev->nr_lines) {
+	for_each_set_bit(i, h->notifs_mask, pcdev->nr_lines) {
 		unsigned long notifs, rnotifs;
 		struct pse_ntf ntf = {};
 
@@ -1340,6 +1341,11 @@ int devm_pse_irq_helper(struct pse_controller_dev *pcdev, int irq,
 	if (!h->notifs)
 		return -ENOMEM;
 
+	h->notifs_mask = devm_kcalloc(dev, BITS_TO_LONGS(pcdev->nr_lines),
+				      sizeof(*h->notifs_mask), GFP_KERNEL);
+	if (!h->notifs_mask)
+		return -ENOMEM;
+
 	ret = devm_request_threaded_irq(dev, irq, NULL, pse_isr,
 					IRQF_ONESHOT | irq_flags,
 					irq_name, h);
-- 
2.43.0


