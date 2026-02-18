Return-Path: <netdev+bounces-259270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN2UCYKSlWn1SQIAu9opvQ
	(envelope-from <netdev+bounces-259270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:20:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C6F61554EE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:20:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1BC430530F0
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6319933E36B;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YMZkDkUW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A52D346AD5;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409604; cv=none; b=QTBKKi6rw+xu0xIp82s2DTzpNnB5Pmd7nwZ1IHA3HzJPJbgoxHzqMBiTPJ2k+MullReDl0dUs6rYbCHJB7cLTg56lUH4gBzAoOFPA2wYZjn1MlI1MtpAPtf/S8FB5icAFAVlb5qXxbTYJMguAHp4T3DvUWINb9lcT5IrVqH8alg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409604; c=relaxed/simple;
	bh=G52yNr/mjvH//WKN8I/I22tm0myDjYubrgazvSxDbzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Vk6HmKvZizNSJyKDJrCA4EaUnu7Y5hAcgg1kXybux56RmGetMBffgRqOuaNhEMPML3gGnPhpfiDbAQRN9HV0WhKESpOZmRC2cimu/OTsJzobekCLfTggjU6Km9tNQI612+V4L7g88pYxDTD5KV1Q7tewXzrc5JbxYliCC+GHItA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YMZkDkUW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13517C19421;
	Wed, 18 Feb 2026 10:13:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409604;
	bh=G52yNr/mjvH//WKN8I/I22tm0myDjYubrgazvSxDbzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YMZkDkUW13zBaRg7DOfUhjHz71unx7NaI6RyqKBl3SEQOD8c29gIcsjTXOy1Z9i2n
	 2Vakk440FbQguwYA+zpIKJOjV7418Okmq12espAksvQcRoemC3UF3ui4cWvKlhcwVT
	 hLstPo4SK3w54q8W/Kwf53vmWMyv2tjA/FkMviJVveDHZjYTXX8uFnEo/D0i/Zg0Ft
	 jBTtnLfbrlwy1YCNdCXx8/lF6PjLjeJWllaEaa28iJEG1PGSVnZiYTcX28bqzPeAVE
	 S1hSlv2c8X7TdkjzC/DUP5X7SVle6Yrd04Hj1SpLw5Bual6mHAl/QTkBsm+jwYApZH
	 C7nrIM/Wa/6YQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYc-00000000LeR-1Ov7;
	Wed, 18 Feb 2026 11:13:22 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH 17/38] docs: kdoc_re: don't recompile NestedMatch regex every time
Date: Wed, 18 Feb 2026 11:12:47 +0100
Message-ID: <dcc7905c09451bb40352426471070c6ca971204b.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1771408406.git.mchehab+huawei@kernel.org>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259270-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9C6F61554EE
X-Rspamd-Action: no action

Store delimiters and its regex-compiled version as const vars.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_re.py | 35 ++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 13 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index 0a7f12616f9f..00afa5bccd6d 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -99,6 +99,13 @@ class KernRe:
         self.last_match = self.regex.search(string)
         return self.last_match
 
+    def finditer(self,  string):
+        """
+        Alias to re.finditer.
+        """
+
+        return self.regex.finditer(string)
+
     def findall(self, string):
         """
         Alias to re.findall.
@@ -134,6 +141,16 @@ class KernRe:
 
         return self.last_match.groups()
 
+#: Nested delimited pairs (brackets and parenthesis)
+DELIMITER_PAIRS = {
+    '{': '}',
+    '(': ')',
+    '[': ']',
+}
+
+#: compiled delimiters
+RE_DELIM = KernRe(r'[\{\}\[\]\(\)]')
+
 
 class NestedMatch:
     """
@@ -183,14 +200,6 @@ class NestedMatch:
     #
     #   FOO(arg1, arg2, arg3)
 
-    DELIMITER_PAIRS = {
-        '{': '}',
-        '(': ')',
-        '[': ']',
-    }
-
-    RE_DELIM = re.compile(r'[\{\}\[\]\(\)]')
-
     def _search(self, regex, line):
         """
         Finds paired blocks for a regex that ends with a delimiter.
@@ -220,13 +229,13 @@ class NestedMatch:
             escape = False
 
             d = line[offset - 1]
-            if d not in self.DELIMITER_PAIRS:
+            if d not in DELIMITER_PAIRS:
                 continue
 
-            end = self.DELIMITER_PAIRS[d]
+            end = DELIMITER_PAIRS[d]
             stack.append(end)
 
-            for match in self.RE_DELIM.finditer(line[offset:]):
+            for match in RE_DELIM.finditer(line[offset:]):
                 pos = match.start() + offset
 
                 d = line[pos]
@@ -247,8 +256,8 @@ class NestedMatch:
                     string_char = d
                     continue
 
-                if d in self.DELIMITER_PAIRS:
-                    end = self.DELIMITER_PAIRS[d]
+                if d in DELIMITER_PAIRS:
+                    end = DELIMITER_PAIRS[d]
 
                     stack.append(end)
                     continue
-- 
2.52.0


