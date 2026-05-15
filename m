Return-Path: <netdev+bounces-288276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4P95KIz0Bmo4pgIAu9opvQ
	(envelope-from <netdev+bounces-288276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:25:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF3154D4A3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 12:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC3613150826
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914D5466B5E;
	Fri, 15 May 2026 09:56:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 774D343E4AE;
	Fri, 15 May 2026 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778838972; cv=none; b=Nq3sK0VgM2bpXQMME63JTOdwg1CMWD4Pz3gkRI0P/glQyriSK6qKINDtqVDlAfkn8Xg8N6+Krg8wgDEn/dTywr0FOe9ZQcm26xQkFsKwvo8EepNjgYiLbo1UQ7sr4VPtRX8kUq9UjCQvr4+k1NZuTJNoemEVQXak5C2wEZHb208=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778838972; c=relaxed/simple;
	bh=UGCagGDoyi3bkk5Q504DGiKrb4e0/4S3z32wD3DgJug=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T4Vj/2uIRGJyfs0CMQBIww3Xk8trorqngZ6ED4g91hKgoYasXVwfXDQuNjwYRPztbM/EjUUol01V7YLVtS8X1q8qWcFkEB5a2n1FpSfN7lAJ+O5kY67W4plWFGxkUC7FtPotjD1DN3EY1dqdOX8pvYzr3ownDWK3jURWrloOMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EB2BC2BCB0;
	Fri, 15 May 2026 09:56:11 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Alexandra Winter <wintera@linux.ibm.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] [net-next] dibs: Improve DIBS prompts and help texts
Date: Fri, 15 May 2026 11:56:02 +0200
Message-ID: <9093259c43e5d1996965d1522562444419196a19.1778838921.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BF3154D4A3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288276-lists,netdev=lfdr.de,renesas];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-0.984];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

The Kconfig prompts for the DIBS options read:

    DIBS support (DIBS) [N/m/y/?]
      intra-OS shortcut with dibs loopback (DIBS_LO) [N/y/?]

Clarify the DIBS prompt by expanding the acronym.
Capitalize the first character of the DIBS_LO prompt.
While at it, join the first two lines of the DIBS help text into a real
sentence.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2:
  - Drop changing dibs to all caps, which was completely wrong for the
    module name,
  - Target "net-next" instead of "net".
---
 drivers/dibs/Kconfig | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dibs/Kconfig b/drivers/dibs/Kconfig
index 5dc347b9b2350667..8f41e562210044df 100644
--- a/drivers/dibs/Kconfig
+++ b/drivers/dibs/Kconfig
@@ -1,18 +1,18 @@
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
 	  dibs devices and dibs clients like the SMC protocol.
 	  The module name is dibs.
 
 config DIBS_LO
-	bool "intra-OS shortcut with dibs loopback"
+	bool "Intra-OS shortcut with dibs loopback"
 	depends on DIBS
 	default n
 	help
-- 
2.43.0


