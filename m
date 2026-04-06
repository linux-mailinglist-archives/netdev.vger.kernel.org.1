Return-Path: <netdev+bounces-275715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fI3LJDgM1Gm5qQcAu9opvQ
	(envelope-from <netdev+bounces-275715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:40:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0183A6B24
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 21:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BC3F3021E9E
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 19:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63674396560;
	Mon,  6 Apr 2026 19:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="POIf5Y0v"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFB2C1595;
	Mon,  6 Apr 2026 19:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775504429; cv=none; b=paQQhmXotPdS6kK5xfLWJgY6X5ElOgctSZaQSvOfcE2i3qtEcDVFZme4tZ+1RV5au2cU6WLz1Z+8+m8ud+wgE1Vm4k1R/oYnbnCpCnMAOB7+RgV3ZcI0PoT0RaPjXZ627rh9UpyKTcN1547fmfAnphh7veA1699sWuJWvn2pHGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775504429; c=relaxed/simple;
	bh=o6SVX02Cy49xwJaMaA0hSMfOCJpY7mCYLWuYVTyLwpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mw1KZIo/yrGnOJjbrPD0quDtbEw4U4S2U1G4qtpKm+G6N0s/JAMixOWOrbNlNg3FbWa+c6whvkqtAE4qFIb5HNmASmIoBBxMITVBaUvT7anyV951G5dcwS3tUhsJv9T3npU54tXGTHWgPoQnTAQloIoNg8nNpvRiW5RHW3t+MP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=POIf5Y0v; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D056A589E;
	Mon,  6 Apr 2026 21:40:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775504424; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding; bh=vZusVusnCFkImcX+sjCySol13wfuarQezH6fJsCm24w=;
	b=POIf5Y0v4k5qQbORPFTqDr3jo0Pdahsu+7wqouakIIX3ZW8VxmBkGXRUegDz7xK+sAuEE1
	DyfrrkQ8A9d4sdyKGcC7XqqUuJmhaFCeM9X5NfRvASOePhfKa9v8hv6uuiO4XU0ONxQ8Gf
	wkCeHxNMk5jPtE/7RiCODRHer0BFY/fNVee7ptxI85SYJKD+i+ui6uN8TkMNKZlPpvaA2w
	gcmz0XJRIJ0wr8CNlil2Zvz63gCOcIZXQR0fte6VoP+uBdUmro69HN4FNt/W3UVdTQ3VN/
	kBLsqeOln97N7Ln5bFqerB1E3D4ipcjZ1GMN2nj4NZ0cAjHNLWVsnPbDImsFDA==
From: Nicolai Buchwitz <nb@tipi-net.de>
Date: Mon, 06 Apr 2026 21:40:00 +0200
Subject: [PATCH net-next] docs: netdev: document AI-assisted review tooling
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260406-nb-docs-ai-review-v1-1-b58943762ca9@tipi-net.de>
X-B4-Tracking: v=1; b=H4sIAA8M1GkC/x2MwQ5AMBAFf0X2bJNqEPEr4kC9spclrSAR/64cJ
 5mZmyKCIFKb3RRwSJRVExR5Rm4ZdAbLlJissbUpTc068rS6yIPw5+Nk24yl97ZwvgKlbgvwcv3
 PjhQ7K66d+ud5AWo64+NtAAAA
X-Change-ID: 20260406-nb-docs-ai-review-28b4ff21cf5e
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>
Cc: netdev@vger.kernel.org, workflows@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275715-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: AD0183A6B24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a section about Sashiko, the Linux Foundation's open-source
AI review system for kernel patches. Contributors can check review
feedback on the Sashiko website and address findings proactively,
reducing the need for maintainers to relay the same questions.

Also point to the local review tooling at netdev-ai.bots.linux.dev
for contributors who want to run AI reviews before submitting.

Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
---
Sashiko [1] reviews are already being used on the list (e.g. [2])
but there's no mention of them in the netdev docs. Add a section
so contributors know they can check and respond to AI review
feedback directly.

Based on Jakub's reviewer guidance patch [3].

[1] https://sashiko.dev/
[2] https://lore.kernel.org/all/20260324024235.929875-1-kuba@kernel.org/
[3] https://lore.kernel.org/all/20260406175334.3153451-1-kuba@kernel.org/
---
 Documentation/process/maintainer-netdev.rst | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index bda93b459a0533fa1adfd11b756a4f47d1dbaa22..27296afb05d3828a350b4ed5c16907672db9785d 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -559,6 +559,19 @@ Reviewers are highly encouraged to do more in-depth review of submissions
 and not focus exclusively on process issues, trivial or subjective
 matters like code formatting, tags etc.
 
+AI-assisted review
+~~~~~~~~~~~~~~~~~~
+
+Patches posted to netdev are automatically reviewed by the Sashiko
+AI review system (https://sashiko.dev/). Results are posted publicly
+on the website. Check for findings on your submissions and address
+valid ones before a maintainer has to relay the same questions.
+
+You can also run AI reviews locally before submitting. Instructions
+and tooling are available at:
+
+  https://netdev-ai.bots.linux.dev/ai-local.html
+
 Testimonials / feedback
 -----------------------
 

---
base-commit: d00749db443cf420a882c020ce0e6bb5c43009de
change-id: 20260406-nb-docs-ai-review-28b4ff21cf5e

Best regards,
-- 
Nicolai Buchwitz <nb@tipi-net.de>


