Return-Path: <netdev+bounces-290465-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OD4ZEXoVD2otFAYAu9opvQ
	(envelope-from <netdev+bounces-290465-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:23:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4E0B5A72A8
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 16:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D1EE3055C19
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725AA3EC2EB;
	Thu, 21 May 2026 13:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TBadRIHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08CE33EAC82;
	Thu, 21 May 2026 13:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779371375; cv=none; b=YosMPg9F4yufI9P4/Tj6uUgFLdaooTgRg4b5fw2xRNuC0RthoLySgkResIS7cjJzWkGn0Q82O3ZwFTbzEtILUm8N2nSXUv5bFHA8hrWvZP/Fq9sl/fJ74lra2aIU+yyIIyxJdkUza+LhALxHe4E7KMG7NvxyrALwdFiDWwRsqfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779371375; c=relaxed/simple;
	bh=oUyNorKwD6muPpSTEXB/+Rh2KSawrmbgwEt4VK6rICE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ma0oB2yTGlvme5avEuriNihIE3/COPcJBkSEPqF+9NUHA01xALo4/L9r1ktQ2J8FD3A+Ils0ThbDw/0ii6E1czjpBvFY+DAaCnHjM8xSGk3Z4O2VHwWo4zkk3k68ZI4ipNGQ98cvNbGcV1y2xuumQ47OH4mGd2Ix28hnDi9w8FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TBadRIHl; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C90FB1F00A3B;
	Thu, 21 May 2026 13:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779371373;
	bh=mQr0j8EZIQuMcSactjBInbE4E33i7QBCPj/yJUOyrRA=;
	h=From:Date:Subject:To:Cc;
	b=TBadRIHlcnT6SDIY3P1DcPa3By3BeBCJ8spsWcVsvLjgOMpfcElVqySZiYwOOeOex
	 2bDQ51OMoU0o5WqwWnffieYhiv2nBhonljcED4909A64GtBygGtqLMdvfDs5fe7oo0
	 Lv1/cRDwz0YbbZC7bcyZFgSG5vb2/kmSmZUL71u1RKKo5tUXsf3p5dNiK/c3FL4BQh
	 F2MauMUTRSMDCIhxTHrCYDHfJal2q7si4Zee+ulRAWTgNLMunAiUAbS/sCv5BgRr6H
	 SY2ZhdwvJO3tLSrCE1s8ucXON0y5fB3ASWUU93M0ZTd1rSP6lAJFw+IHBE7ayD0ylW
	 Mzj1ITYnsdh1A==
From: Michael Grzeschik <mgr@kernel.org>
Date: Thu, 21 May 2026 15:49:29 +0200
Subject: [PATCH RESEND] MAINTAINERS: Update address for Michael Grzeschik
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-maintainer-v1-1-29b5e106682d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAGgND2oC/22NMQvCMBSE/0p5s5EkDa04OdjVQUfpUJqX9qEm8
 lKCUvLfDZ0dbvjuuLsVIjJhhGO1AmOiSMEXULsKxnnwEwqyhUFL3UijG/EayC9FyAJxtNI0oxk
 OLZTCm9HRZxu7w7W7dZcz9MWfKS6Bv9tHUlv6by4poYRtjdXO1KZ27emB7PG5DzxBn3P+ARE4I
 zmtAAAA
X-Change-ID: 20260426-maintainer-eecd046c4a87
To: Jakub Kicinski <kuba@kernel.org>, 
 Markus Schneider-Pargmann <mail@markussp.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Cc: Michael Grzeschik <mgr@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1632; i=mgr@kernel.org;
 h=from:subject:message-id; bh=oUyNorKwD6muPpSTEXB/+Rh2KSawrmbgwEt4VK6rICE=;
 b=owEBbQKS/ZANAwAKAb9pWET5cfSrAcsmYgBqDw1sQbmtySfJMKGqNQAyZ/9rhpZIbDFDca2m6
 yysw3AafMaJAjMEAAEKAB0WIQQV2+2Fpbqd6fvv0Gi/aVhE+XH0qwUCag8NbAAKCRC/aVhE+XH0
 qy75D/4qYsRyHsGKtNYpsOLF4jmN9NpumViAgsCb5qiN63kI3KGUsUCWalS35ntBfSeOgxueH29
 1ZbO56lWK82dFl8+ALVx13N6DBV3q02wEeq4pQSSzT27fXky6q0yaVb2/K7BvBLWZLn8XNLkZE7
 GZUjm3QqGKW/JhfwTZ6t+gOoUOOOCpCu9tNsedQ+VB0m/H6Uu16pF87bL7diIytTVPnn+o2tjUj
 k4HXolMS/ZiGU26nay8gF8cgFektU+Uq+X3ubqjYayzHt64qPZBUGudXzrwmdNVBcbb4DNLl6Wa
 8YP2J5dk+sZ02QCtRhZI/O5wPFQLpMvXVoQgVk4sZF5H97CDKwNE9UUB6ySpEPdojfbfzqZsH+r
 bmhIZ2g/DJT5A6nw8ybY9udSlJ+xAvysWFnrtqCcAxNVSDLW8Ep5DJvZyMd8om+iIU+yG10wfxR
 EjZRMj8tOnB0sz7VsHgeYGuPGeC1ri2fLYES/2hny+FnnlM+uP2GDrDZYGJRytFPCBrB6JFhbVS
 HS2C4BSFuco6fDr1FKl5a+boC124sy1TdsMO2WAz/POwX8l1bOifzQaccdFq02KFIFb/UD/Tw7q
 EWeBgRqixRrqkC07h6jNUf2wmKvostVVAsEvv/q49+KlaRpCC974lgmRrVGHti2Y0u4WwvNDtRv
 puw0PNXviqIxRfg==
X-Developer-Key: i=mgr@kernel.org; a=openpgp;
 fpr=957BC452CE953D7EA60CF4FC0BE9E3157A1E2C64
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-290465-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mgr@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B4E0B5A72A8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Since I am moving from Pengutronix update my email address for the
ARCNET subsystems to point to my kernel.org address.

Also update .mailmap.

Signed-off-by: Michael Grzeschik <mgr@kernel.org>
Acked-by: Jakub Kicinski <kuba@kernel.org>
Acked-by: Markus Schneider-Pargmann <mail@markussp.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index bd6a72f29d9cc..99dba08041fa1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -584,6 +584,8 @@ Mayuresh Janorkar <mayur@ti.com>
 Md Sadre Alam <quic_mdalam@quicinc.com> <mdalam@codeaurora.org>
 Miaoqing Pan <quic_miaoqing@quicinc.com> <miaoqing@codeaurora.org>
 Michael Buesch <m@bues.ch>
+Michal Grzeschik <mgr@kernel.org> <m.grzeschik@pengutronix.de>
+Michal Grzeschik <mgr@kernel.org> <mgr@pengutronix.de>
 Michael Riesch <michael.riesch@collabora.com> <michael.riesch@wolfvision.net>
 Michal Simek <michal.simek@amd.com> <michal.simek@xilinx.com>
 Michel Dänzer <michel@tungstengraphics.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index 10e8253181d32..0f22ec0b3bf81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2064,7 +2064,7 @@ F:	Documentation/devicetree/bindings/display/snps,arcpgu.txt
 F:	drivers/gpu/drm/tiny/arcpgu.c
 
 ARCNET NETWORK LAYER
-M:	Michael Grzeschik <m.grzeschik@pengutronix.de>
+M:	Michael Grzeschik <mgr@kernel.org>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/arcnet/

---
base-commit: 8bc67e4db64aa72732c474b44ea8622062c903f0
change-id: 20260426-maintainer-eecd046c4a87

Best regards,
-- 
Michael Grzeschik <mgr@kernel.org>


