Return-Path: <netdev+bounces-255424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL/IFpwRfmkbVQIAu9opvQ
	(envelope-from <netdev+bounces-255424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:28:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0433FC266E
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:28:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7024302247A
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0513C366546;
	Sat, 31 Jan 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jhqi27Bi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BC61358D1A;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=g7SmVFHz/nUiOdzuliDM8d6OFBvuw34KC+4OlG43OmTjG3tRmg08kS4QWDDpuEfv1X7K1mWrqRVHXIHA6+hy5+got6vf2es2Em22s4pa7cTpHYfi100TYuleWu8DrFQp8tEvVABZcXrzZN3EpLcmeWeMVFC6z2I5KNtSzhXkBKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=exVw90yVLaIyCuiKNYXLsf4VR9OXQdWgf2cZhrnzV2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ar+jO2XD+JGxXUyZ/07D7YDEjlzF23EDwZnodyms0bi7pUK7m3kK/ouDZrdswXrBUN6GMegYmyEEEsw2uHeCNEY88mshTJNLYz5nCPrW/GXU5rWerZIyZtw6rBbqVNBI3IZSsaRZQ6uk0yfUiNqm8D+mnYmnTKH5vS4mrt6cJhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jhqi27Bi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9414FC2BCF6;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=exVw90yVLaIyCuiKNYXLsf4VR9OXQdWgf2cZhrnzV2Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jhqi27BiIT4Cy//A3hEMRtGYKj50D5duVDfRfGkKdNgh6LD77COjmfBm64oC/rxgq
	 Chi6eJlVjvFKzFZuicwjfCRd11XLJCUS4y/RL0kbRwZ93UpgHzfdcmU7UGDcOZrvVc
	 b0AQNa8jXCKYwbGEB4m4iBCrAiRwlde4FiB95ffOYcdlvFbEW50gZvUNn9bI+RzTgA
	 YvT9Fp7wKQG7suV9128aCSi0eZxhIBzXVaHZA1C7ebawmkE7z0rtN5py4KusvhVf45
	 Mf4siTxDUozZqHAqMAb3GDntztQCBlHnv0NkDutJpfgao47cERvK1EirAQQ6kCAmTq
	 M7HeP0nAPIEaA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVl2-3bSB;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 20/41] docs: kdoc_re: add support on NestedMatch for argument replacement
Date: Sat, 31 Jan 2026 15:24:54 +0100
Message-ID: <ff9a001e213558d419b3e149710db4c5ba8a53e3.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255424-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0433FC266E
X-Rspamd-Action: no action

Currently, NestedMatch has very limited support for aguments
replacement: it is all or nothing.

Add support to allow replacing individual arguments as well.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 84 ++++++++++++++++++++++----------
 1 file changed, 59 insertions(+), 25 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index e34d55c25680..858cc688a58f 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -177,29 +177,6 @@ class NestedMatch:
     will ignore the search string.
     """
 
-    # TODO: make NestedMatch handle multiple match groups
-    #
-    # Right now, regular expressions to match it are defined only up to
-    #       the start delimiter, e.g.:
-    #
-    #       \bSTRUCT_GROUP\(
-    #
-    # is similar to: STRUCT_GROUP\((.*)\)
-    # except that the content inside the match group is delimiter-aligned.
-    #
-    # The content inside parentheses is converted into a single replace
-    # group (e.g. r`\1').
-    #
-    # It would be nice to change such definition to support multiple
-    # match groups, allowing a regex equivalent to:
-    #
-    #   FOO\((.*), (.*), (.*)\)
-    #
-    # it is probably easier to define it not as a regular expression, but
-    # with some lexical definition like:
-    #
-    #   FOO(arg1, arg2, arg3)
-
     def __init__(self, regex):
         self.regex = KernRe(regex)
 
@@ -285,6 +262,59 @@ class NestedMatch:
 
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
@@ -310,9 +340,13 @@ class NestedMatch:
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


