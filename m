Return-Path: <netdev+bounces-254366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEBPJl1Demmr4wEAu9opvQ
	(envelope-from <netdev+bounces-254366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:11:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF1BA697A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CB60B30871EF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACBC377561;
	Wed, 28 Jan 2026 16:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uB7rv6MG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACEF376BF1;
	Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619037; cv=none; b=OQVPXSIv3jPSEcUu3UtenJRbONY/gfC2d82skeyUOq5TAKYuKwm1+5Jc3HTPcvbzcWFxoN36HqgaiQKknvDK8Wboc4c3Ckl0PAfwIfhSwNQbpQvwP7YEX4RcxU7coCFyvodkajtxt9sMUgj3yNIwKdfKIDy9NTOg8NJsLGszzGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619037; c=relaxed/simple;
	bh=9hX1oywg1Y3txaPPZEQtrG+JM7sUb7c+w2+8n+ph75o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cNt4yARo5qVQEPZgrvKm+rglaiSyBgoBcha754z8rSOFploXVDLf1gmtCLJTyPQxHCdq8KbkrMjZ1AG68ig1A15NItQRYyyzXqrxyRvXkRTJ1kjjhjO++dCXDFvH2YC5Ghca0BlDHHMVpuTmV3dERv88okvaJHc71DZggErJkIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uB7rv6MG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05F3C4CEF1;
	Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619036;
	bh=9hX1oywg1Y3txaPPZEQtrG+JM7sUb7c+w2+8n+ph75o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uB7rv6MG0D8lfxVU3F+negR4Dm2Cv7s/5bWYbEWoSFTAka2Sl2Wq/ECE31sw+DYPB
	 ee2wLL7tLY7FFA1iEGUECqTj1olYIenIb/Og65iFul1SPvl325JKB2zZNGTZYuSpQd
	 hLtg8Tc4WMm+oUHsQ8RpX7ZgHo2U624Ugs0tmlT3cLdAUOo/CYz2iprYsfRnxHvX7H
	 6cdtgTrjDX9HmzofaxUpdgM2B13upvvGgL2YvV4nt7luPssD+JiPhm6EHHeY1L6eMA
	 1LuF3TK2yuWDfuS5tWsWNixNVPmkTV8FoGv8RuV9DRVlswMpl3vfysYdykBMpLEVNl
	 S0JaMjyDQPlbg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kU-0000000DB7Q-2nh2;
	Wed, 28 Jan 2026 17:50:34 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 20/25] tools: kdoc_re: add support on NestedMatch for argument replacement
Date: Wed, 28 Jan 2026 17:50:18 +0100
Message-ID: <efb77b71a3aba57d85f52968e9a64aee378cdeda.1769617841.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769617841.git.mchehab+huawei@kernel.org>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254366-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EF1BA697A
X-Rspamd-Action: no action

Currently, NestedMatch has very limited support for aguments
replacement: it is all or nothing.

Add support to allow replacing individual arguments as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_re.py | 61 ++++++++++++++++++++++++++++++--
 1 file changed, 59 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index aabfd6c4fd71..f49a568b9155 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -267,6 +267,59 @@ class NestedMatch:
 
             yield line[t[0]:t[2]]
 
+    @staticmethod
+    def _split_args(all_args, delim=","):
+        """
+        Helper method to split comma-separated function arguments
+        or struct elements, if delim is set to ";".
+
+        It returns a list of arguments that can be used later on by
+        the sub() method.
+        """
+        args = [all_args]
+        stack = []
+        arg_start = 0
+        string_char = None
+        escape = False
+
+        for idx, d in enumerate(all_args):
+            if escape:
+                escape = False
+                continue
+
+            if string_char:
+                if d == '\\':
+                    escape = True
+                elif d == string_char:
+                    string_char = None
+
+                continue
+
+            if d in ('"', "'"):
+                string_char = d
+                continue
+
+            if d in DELIMITER_PAIRS:
+                end = DELIMITER_PAIRS[d]
+
+                stack.append(end)
+                continue
+
+            if stack and d == stack[-1]:
+                stack.pop()
+                continue
+
+            if d == delim and not stack:
+                args.append(all_args[arg_start:idx].strip())
+                arg_start = idx + 1
+
+        # Add the last argument (if any)
+        last = all_args[arg_start:].strip()
+        if last:
+            args.append(last)
+
+        return args
+
     def sub(self, sub, line, count=0):
         """
         This is similar to re.sub:
@@ -292,9 +345,13 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \0 at the sub string, if \0 is used there
+            # replace arguments
             new_sub = sub
-            new_sub = new_sub.replace(r'\0', value)
+            if "\\" in sub:
+                args = self._split_args(value)
+
+                new_sub = re.sub(r'\\(\d+)',
+                                 lambda m: args[int(m.group(1))], new_sub)
 
             out += new_sub
 
-- 
2.52.0


