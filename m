Return-Path: <netdev+bounces-255436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGyXK+0RfmlLVQIAu9opvQ
	(envelope-from <netdev+bounces-255436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:30:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D42DC26BC
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07191301BE01
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561B6366834;
	Sat, 31 Jan 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etJT7UQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86FF435A939;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=p6ycvzFYgw7bRVloHzXTSCiru1Q+apx101GzcXXY1a5TdXdPo2Yym/RwUdBMO3DktknvkPoov1SDUhEq9CRy0cSiYnWl8mFl/5iTYq+rHIB+WArYY1EAKcqNMKYO86E2kZ1Rm7rVk8bfc3pNeSZ6OFoyuuAmvKyle8duYLIFURs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=J9gpBcUhWSmksHEje7HfFrvd/UJKiZjrUhxoxqAfK3o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxJB30JKScPypBtBN4EDPcpC77+oqphn5qrBCPT5EiJykYRPS7a2s1YjbhDjV+Iq1xeBp3j3tkEPFA/sDJpdWsyaO0jiZb4ufsWpFcjW1qPTl7T2nzaAQO7mH35lSFHZYegGqke7ZGJlX/koIy9bLjZmBacvPpGgR5E+nYWmOd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etJT7UQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE0AC4DDE2;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=J9gpBcUhWSmksHEje7HfFrvd/UJKiZjrUhxoxqAfK3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=etJT7UQkV81clZC3G9h1rJ6n/Coqg5VDtA8GfexHi9ncJVJvmpBQn1iDvm2eAuBhd
	 Fj2wqeMsPUTEWk9IWBwYb7NqerSM4TNrTRMxWYPUk7i181CDG8Gi7dOnc3eOZ24S0X
	 h1Z4uZMcX8n+nsH0YSf0+ou5Y+ltihG+SwY/lHVlE0E/JmJyjrHO4O2jsrAHbuRtPA
	 rmuphAK/iswiSm/1w46YZxxM8R7TX0lmY6q9CKMz7x188BBO3DQlNRe0dm7aCy16zZ
	 /5ICALjF/4Z/ZMxwm6EtuGqjEOym6sXbhoG/WTbzLDMJ08JaKg/9CVMtBUVXBc3OmR
	 5GBDzj4RSnRIw==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVm7-1FNc;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 36/41] docs: sphinx-build-wrapper: better handle troff .TH markups
Date: Sat, 31 Jan 2026 15:25:10 +0100
Message-ID: <56468f3cf9ba583a0759953a931bddc361b869aa.1769867954.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255436-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D42DC26BC
X-Rspamd-Action: no action

Using a regular expression to match .TH is problematic, as it
doesn't handle well quotation marks.

Use shlex instead.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/sphinx-build-wrapper | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/docs/sphinx-build-wrapper b/tools/docs/sphinx-build-wrapper
index b7c149dff06b..e6418e22e2ff 100755
--- a/tools/docs/sphinx-build-wrapper
+++ b/tools/docs/sphinx-build-wrapper
@@ -576,7 +576,6 @@ class SphinxBuilder:
         """
 
         re_kernel_doc = re.compile(r"^\.\.\s+kernel-doc::\s*(\S+)")
-        re_man = re.compile(r'^\.TH "[^"]*" (\d+) "([^"]*)"')
 
         if docs_dir == src_dir:
             #
@@ -616,8 +615,7 @@ class SphinxBuilder:
         fp = None
         try:
             for line in result.stdout.split("\n"):
-                match = re_man.match(line)
-                if not match:
+                if not line.startswith(".TH"):
                     if fp:
                         fp.write(line + '\n')
                     continue
@@ -625,7 +623,9 @@ class SphinxBuilder:
                 if fp:
                     fp.close()
 
-                fname = f"{output_dir}/{match.group(2)}.{match.group(1)}"
+                # Use shlex here, as it handles well parameters with commas
+                args = shlex.split(line)
+                fname = f"{output_dir}/{args[3]}.{args[2]}"
 
                 if self.verbose:
                     print(f"Creating {fname}")
-- 
2.52.0


