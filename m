Return-Path: <netdev+bounces-257134-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLKFAM57hGlU3AMAu9opvQ
	(envelope-from <netdev+bounces-257134-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:15:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B8BF1BEC
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 12:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F00D3004635
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C423ACEE4;
	Thu,  5 Feb 2026 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGQbNpng"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933F320DD75;
	Thu,  5 Feb 2026 11:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770289905; cv=none; b=WF98SAWlyue0meJuHYbjAGd2y9g4nYmRZsTYwalmxihEd6jAAYqKAc452ubA7b2V8Y8mKMPKBRF1wRmseYRPIm4x6TBT483UJKwbHU4isBK7oXoslATQPiV4rhEmo4uZ/sp4WbklU2IH67QayyI8CQ+Wt33nBn6da81Nld3mQ7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770289905; c=relaxed/simple;
	bh=Q+tq36Bpv2D57ptG2Dn54YPznxdyG4qIph6n0fH15jU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Anpo7hr0U9GeIiQbwaKnfnKaC0cWuX6UAYg1mFCIiLsoKFPUQBeAbsgBegw30cF744ZipwFulMEWNbi0FaypRgBWL6Cyoek12pozR4LBw5H/LuOIZwS7nkzcfk5Obkq021Oyue5Cc3UF1CtztJwtMGAFspphBdepXTZ597CyuAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGQbNpng; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36EBBC4CEF7;
	Thu,  5 Feb 2026 11:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770289905;
	bh=Q+tq36Bpv2D57ptG2Dn54YPznxdyG4qIph6n0fH15jU=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=UGQbNpngMLXIAkNmeBoA8qOufVk6djbS1leO0K4T7U1FcpyBm6zDL2M0dHdYs20lb
	 M2xNYUPyc/J5DGpT6ErJFvrFaZYyY0LWcC/awsd6yZbBUUj/Rlpljvq9QAnvS8Mn8C
	 8o3MISiAjJOyho0VnlvU/7n5psIuXALnnbNby64JSL/N8fpEq05MbfpDsDzQDa7e9B
	 BnOMA5uwbVw50fszJW3jM14Vat0jzGl6TmKJCF/sFSq5AapSrw3s2vn6/Hs5cf0isX
	 CNvHughEb0o2CaXAe5cGV6uuCFRCxTx2y00m9RRNVPz2y+vz3NpN0ctNAhvxpU2776
	 KYuAHuZxR59Bg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25743EC1E8F;
	Thu,  5 Feb 2026 11:11:45 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Thu, 05 Feb 2026 19:11:39 +0800
Subject: [PATCH v2] nfc: nxp-nci: remove interrupt trigger type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-fc-nxp-nci-remove-interrupt-trigger-type-v2-1-79d2ed4a7e42@amd.com>
X-B4-Tracking: v=1; b=H4sIAOp6hGkC/52NQQ6CMBBFr0K6dgxtVcCV9zAsoB1gFpRmWhsI4
 e5WjuDy/fy8t4uATBjEs9gFY6JAi8ugLoUwU+dGBLKZhSrVo1TlDQYDbvXgDAHjvKR8cBGZPz5
 CZBpHZIibR7BVVWule93XUmSdZxxoPVPvNvNEIS68neUkf+sfkSRBgu4tNvLeaFnpVzfbq1lm0
 R7H8QVULrAt3gAAAA==
X-Change-ID: 20260204-fc-nxp-nci-remove-interrupt-trigger-type-d778323b3b81
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, carl.lee@amd.com, 
 peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770289904; l=1554;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=6cKyct/VkHp4Ohfqh26SnglO2MibPS/8UbUTT3sCa1U=;
 b=NnsLioUF8YJNdbbB9wQ/BjoGWcuoLJL4n+sH8aY91LxSbHLePZxwMVHiAmrMnK7jZRf6VFl3w
 VLb8qS58IQoDxY1HDePigdq/zOcncqba3ybJyyee2NOg+F+kF6n2uW6
X-Developer-Key: i=carl.lee@amd.com; a=ed25519;
 pk=pyq7QaQvoxMg806KVkRwpCbiah+7ncWr4MBpK1AEyjA=
X-Endpoint-Received: by B4 Relay for carl.lee@amd.com/20260203 with
 auth_id=623
X-Original-From: Carl Lee <carl.lee@amd.com>
Reply-To: carl.lee@amd.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257134-lists,netdev=lfdr.de,carl.lee.amd.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[carl.lee@amd.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:replyto,amd.com:email,amd.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54B8BF1BEC
X-Rspamd-Action: no action

From: Carl Lee <carl.lee@amd.com>

For NXP NCI devices (e.g. PN7150), the interrupt is level-triggered and
active high, not edge-triggered.

Using IRQF_TRIGGER_RISING in the driver can cause interrupts to fail
to trigger correctly.

Remove IRQF_TRIGGER_RISING and rely on the IRQ trigger type configured
via Device Tree.

Signed-off-by: Carl Lee <carl.lee@amd.com>
---
This v2 of the series includes Krzysztof Kozlowski in the review list
for NXP-NCI NFC.

This series removes IRQF_TRIGGER_RISING in nxp-nci driver,
relying on the IRQ trigger type specified via Device Tree.
---
Changes in v2:
- Include Krzysztof Kozlowski in the review list for NXP-NCI NFC.
- Link to v1: https://lore.kernel.org/r/20260204-fc-nxp-nci-remove-interrupt-trigger-type-v1-1-3bde91593173@amd.com
---
 drivers/nfc/nxp-nci/i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nfc/nxp-nci/i2c.c b/drivers/nfc/nxp-nci/i2c.c
index 049662ffdf97..6a5ce8ff91f0 100644
--- a/drivers/nfc/nxp-nci/i2c.c
+++ b/drivers/nfc/nxp-nci/i2c.c
@@ -305,7 +305,7 @@ static int nxp_nci_i2c_probe(struct i2c_client *client)
 
 	r = request_threaded_irq(client->irq, NULL,
 				 nxp_nci_i2c_irq_thread_fn,
-				 IRQF_TRIGGER_RISING | IRQF_ONESHOT,
+				 IRQF_ONESHOT,
 				 NXP_NCI_I2C_DRIVER_NAME, phy);
 	if (r < 0)
 		nfc_err(&client->dev, "Unable to register IRQ handler\n");

---
base-commit: 4c87cdd0328495759f6e9f9f4e1e53ef8032a76f
change-id: 20260204-fc-nxp-nci-remove-interrupt-trigger-type-d778323b3b81

Best regards,
-- 
Carl Lee <carl.lee@amd.com>



