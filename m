Return-Path: <netdev+bounces-256612-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KrpIooEg2njggMAu9opvQ
	(envelope-from <netdev+bounces-256612-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:34:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B7380E3311
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 09:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 58A69300D250
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 08:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15B393DFB;
	Wed,  4 Feb 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjeCp9yo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B75393DC1;
	Wed,  4 Feb 2026 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770194042; cv=none; b=IezMpSmAK43jOY2RFv0Y6lZmfFCLoFUhts6n7+wDDt7XIm8r85eE/NhDW17EACvPiLdDtKEGsPsq1ccxUTMwhpDvhyClo8QBEoK3wqer7eGfrlWQfUXVkyo8wSe6VqhxnN6mlPHNl9eInypXfDwzK6Nm3fEC9zMLqYNseMXMvtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770194042; c=relaxed/simple;
	bh=ecFO7/L4A/li5bJRaLWDUbJSeXCf5l9ebmA68aTXv14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To; b=KabNKcmRmLJ5bpntd+WWDfFvcxjQyzMvvh31EPl0V/UrfXswg6m7XgFPuCqN76dUtaSXhOWk0wKr09reEHLvBFsjsxXHW+8dvDfFv/zt0Q0nLG9tTmTUCc93oyaMzULInSahSDb0Y+aNG+7UCbq8IrDAfuJqY+2FnozRNSLjwfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjeCp9yo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE382C2BC86;
	Wed,  4 Feb 2026 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770194041;
	bh=ecFO7/L4A/li5bJRaLWDUbJSeXCf5l9ebmA68aTXv14=;
	h=From:Date:Subject:To:Reply-To:From;
	b=bjeCp9yoOZIJ1rG4tKLWnUZFCfCKxOs/HSwipcWnNMRzab9rRyxHqBevyvH1FAhJ2
	 +w6kuhAJyaJii5Jky7qWNm17i42uN3o8sl6mRSxY1YfP/T/fr16DaSvx+kpb2fCSek
	 vfOfQEAdkPrsxhqJF/9sQxyXDLYqKw9jYOdxpKsAWxbl7EeNwKDZr1P3L4KFW3rk4x
	 wLq21+QNsjvB5FwCg4UTBf5bugWB8BY9U0zyNatyL8l2OzMiQDm1MnUld83B+zip/s
	 XTzXEqlAYfYBFSkajaqQEHj+Ghah60NSs4YHbAT4Dy7U9W967VyKOQrO8jt5zoXXtf
	 KvhpE+e9ep+zQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B6E83EF5;
	Wed,  4 Feb 2026 08:34:01 +0000 (UTC)
From: Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Date: Wed, 04 Feb 2026 16:33:51 +0800
Subject: [PATCH] nfc: nxp-nci: remove interrupt trigger type
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260204-fc-nxp-nci-remove-interrupt-trigger-type-v1-1-3bde91593173@amd.com>
X-B4-Tracking: v=1; b=H4sIAG4Eg2kC/x2NQQqDMBAAvyJ7diEmpUq/UjxoXOMeXMMmiiL+v
 aHHgWHmhkTKlOBT3aB0cOJNCjR1BX4ZJBDyVBissW9jzQtnj3JGFM+otG5HESST6h4zZuUQSDF
 fkXBq285ZN7qxa6DkotLM53/17Z/nB0Gg9zl6AAAA
X-Change-ID: 20260204-fc-nxp-nci-remove-interrupt-trigger-type-d778323b3b81
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, carl.lee@amd.com, 
 peter.shen@amd.com, colin.huang2@amd.com
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770194040; l=1133;
 i=carl.lee@amd.com; s=20260203; h=from:subject:message-id;
 bh=S4f9MfSDtarUqVAH0McJX6bzbyZME7KFSQONWKA1FKQ=;
 b=kpvwuOZRaUjemIlIPFCMTW7vpbW0JUD/LrDbcg514SQKKMI40tTfdyIdYQKgh0Z56NMQvofGs
 co6KmX6FiEWBOEfien2vOMEhBLCiZNVJ/A2p6Bo35geoLGMTa/E5Iwn
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_FROM(0.00)[bounces-256612-lists,netdev=lfdr.de,carl.lee.amd.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	HAS_REPLYTO(0.00)[carl.lee@amd.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,amd.com:replyto,amd.com:email,amd.com:mid]
X-Rspamd-Queue-Id: B7380E3311
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



