Return-Path: <netdev+bounces-287614-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMIsEb+CBGrVKwIAu9opvQ
	(envelope-from <netdev+bounces-287614-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:55:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C13E534748
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 15:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 59534307697B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 13:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D61D2D593E;
	Wed, 13 May 2026 13:29:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0453428C009;
	Wed, 13 May 2026 13:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778678952; cv=none; b=iK3sVVBjiMfiRs+cpwZFCvpMwOPJahqcrkg2PEHXtwSuO9mZv2V5H56KzdRflZfqeep0qOwM9m5qXQgyPXnwu74Y2w+c4xPFYbfPxa/m2DFRamWkC/P4OTYZUV9a9CM2DxcaK5qQtDl16c8/BdA8N9AagknJgDTX+eGmEPxpXJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778678952; c=relaxed/simple;
	bh=4zSEe7Ommd+yxNM4HOMR2HBXF1enjKOZNs8YC5obsxY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qqCIX+3bJsSc3VK5kJQYx6HYW0kIHMPqVZx2jd+kDRviUn5vkA4jhR6EOuFCpw7TPpXCFlzLHuH6l7Ft3Ets+ZLPrCNe3Pnj6KB786QaEFXONqTGnGEikpBRS2VRvbZekP6Gpdne9b63mzDhoPXQqnzX1cZAJ15b+20Jp5JR94I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C226CC2BCB7;
	Wed, 13 May 2026 13:29:10 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] [net] dibs: Improve DIBS prompts and help texts
Date: Wed, 13 May 2026 15:29:07 +0200
Message-ID: <1afbbbc74669f053414dcbabd909e52e7eae66e0.1778678915.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3C13E534748
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-287614-lists,netdev=lfdr.de,renesas];
	DMARC_NA(0.00)[glider.be];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

The Kconfig prompts for the DIBS options read:

    DIBS support (DIBS) [N/m/y/?]
      intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]

Clarify the DIBS prompt by expanding the acronym.
Capitalize the first character of the DIBS_LO prompt, and always write
DIBS in full caps.
While at it, join the first two lines of the DIBS help text into a real
sentence.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/dibs/Kconfig | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index 5dc347b9b2350667..f2dd4c3e7c5f6d72 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -1,23 +1,23 @@
 # SPDX-License-Identifier: GPL-2.0
 config DIBS
-	tristate "DIBS support"
+	tristate "Direct Internal Buffer Sharing support"
 	default n
 	help
-	  Direct Internal Buffer Sharing (DIBS)
-	  A communication method that uses common physical (internal) memory
-	  for synchronous direct access into a remote buffer.
+	  Direct Internal Buffer Sharing (DIBS) is a communication method that
+	  uses common physical (internal) memory for synchronous direct access
+	  into a remote buffer.
 
 	  Select this option to provide the abstraction layer between
-	  dibs devices and dibs clients like the SMC protocol.
-	  The module name is dibs.
+	  DIBS devices and DIBS clients like the SMC protocol.
+	  The module name is DIBS.
 
 config DIBS_LO
-	bool "intra-OS shortcut with dibs loopback"
+	bool "Intra-OS shortcut with DIBS loopback"
 	depends on DIBS
 	default n
 	help
-	  DIBS_LO enables the creation of an software-emulated dibs device
+	  DIBS_LO enables the creation of an software-emulated DIBS device
 	  named lo which can be used for transferring data when communication
 	  occurs within the same OS. This helps in convenient testing of
-	  dibs clients, since dibs loopback is independent of architecture or
+	  DIBS clients, since DIBS loopback is independent of architecture or
 	  hardware.
-- 
2.43.0


