Return-Path: <netdev+bounces-255439-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ODVwIk8Tfml6VQIAu9opvQ
	(envelope-from <netdev+bounces-255439-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:35:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0790AC2798
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7C82304A2EA
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E314336C0A5;
	Sat, 31 Jan 2026 14:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qf3OnObv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C6ED35B621;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=soTbzcFIx62ZMwb8l3XVMll3YmtF0fzutk6IOLdncSBkN+fTn19p45TB3JT7Vu7gh8Ck6BQsBjd4RS/qJStHC+TVf9SsDxahJ0v23nFWGGyhchwjIkwipZUg8dFTuOdlI+GXB7RZuIvqPe4iVuM8uZLp4/IIl78G0/BWcHpSLpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=FQwon0lGCEEl3a0ZrhHyVTozHezlG7Q5rbiRVSPsdCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L06FUzwDcJV3TgmoBjK1nAKtCSQDD3XLfptkkO57n+t1AnwaUHY6J5O4+lI9POeb5TsFP40kCgiELr0p8ZL3c68Xtk9VhcWyFNt3+dRck/c2P2wuSDcwAceCEzsjoV9V2BgAUozahJ6NuTwvPD0tQ2CdssS84OL/IF26lsa1qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qf3OnObv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C555FC2BCC4;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869522;
	bh=FQwon0lGCEEl3a0ZrhHyVTozHezlG7Q5rbiRVSPsdCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qf3OnObvsEFFPnhT3+O8KOqp/K+XwsoKEtc+YF8lt9UkxJbB7PxET8ThukOfyEvSn
	 6jnEo6D3ildurzqP6tQ2kB8Ql1hpleDK99D47s3d3C48XUE9uRnoBCx3CyRzFX5anu
	 36GgeiDO3s2+t7FuVw5eMiSa8tEvAGikz4l3EWF46NmIC38pVSYJiHLqFZJf098R0J
	 CKwGMiUPe8SuV5l5RxaSYY4xggo178IO4MllCs5UXux/4dRkqyt38paYfvxxc4UeG/
	 XjIsIVdEksIoo9HyOj5lSUxdv7QnpBbSkVyMSv8L4D+Y+u2jsVEN/n4+awZDOdtUxw
	 FwpLYxzQTErWA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVlT-07B5;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Kees Cook <kees@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH v4 26/41] docs: kdoc_parser: move transform lists to a separate file
Date: Sat, 31 Jan 2026 15:25:00 +0100
Message-ID: <543bc5c380a64a85d1bd656e0e7045626398206c.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255439-lists,netdev=lfdr.de,huawei];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 0790AC2798
X-Rspamd-Action: no action

Over the time, most of the changes at kernel-doc are related
to maintaining a list of transforms to convert macros into pure
C code.

Place such transforms on a separate module, to cleanup the
parser module.

While here, drop the now obsolete comment about the two-steps
logic to handle struct_group macros.

There is an advantage on that: QEMU also uses our own kernel-doc,
but the xforms list there is different. By placing it on a
separate module, we can minimize the differences and make it
easier to keep QEMU in sync with Kernel upstream.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 Documentation/tools/kdoc_parser.rst   |   8 ++
 tools/lib/python/kdoc/kdoc_files.py   |   3 +-
 tools/lib/python/kdoc/kdoc_parser.py  | 147 ++------------------------
 tools/lib/python/kdoc/xforms_lists.py | 117 ++++++++++++++++++++
 4 files changed, 133 insertions(+), 142 deletions(-)
 create mode 100644 tools/lib/python/kdoc/xforms_lists.py

diff --git a/Documentation/tools/kdoc_parser.rst b/Documentation/tools/kdoc_parser.rst
index 03ee54a1b1cc..55b202173195 100644
--- a/Documentation/tools/kdoc_parser.rst
+++ b/Documentation/tools/kdoc_parser.rst
@@ -4,6 +4,14 @@
 Kernel-doc parser stage
 =======================
 
+C replacement rules used by the parser
+======================================
+
+.. automodule:: lib.python.kdoc.xforms_lists
+   :members:
+   :show-inheritance:
+   :undoc-members:
+
 File handler classes
 ====================
 
diff --git a/tools/lib/python/kdoc/kdoc_files.py b/tools/lib/python/kdoc/kdoc_files.py
index 022487ea2cc6..7357c97a4b01 100644
--- a/tools/lib/python/kdoc/kdoc_files.py
+++ b/tools/lib/python/kdoc/kdoc_files.py
@@ -15,6 +15,7 @@ import os
 import re
 
 from kdoc.kdoc_parser import KernelDoc
+from kdoc.xforms_lists import CTransforms
 from kdoc.kdoc_output import OutputFormat
 
 
@@ -117,7 +118,7 @@ class KernelFiles():
         if fname in self.files:
             return
 
-        doc = KernelDoc(self.config, fname)
+        doc = KernelDoc(self.config, fname, CTransforms)
         export_table, entries = doc.parse_kdoc()
 
         self.export_table[fname] = export_table
diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 1e8e156e2a9e..a280fe581937 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -75,142 +75,6 @@ doc_begin_func = KernRe(str(doc_com) +			# initial " * '
 #
 struct_args_pattern = r'([^,)]+)'
 
-struct_xforms = [
-    # Strip attributes
-    (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
-    (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-    (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
-    (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
-    (KernRe(r'\s*__packed\s*', re.S), ' '),
-    (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
-    (KernRe(r'\s*__private', re.S), ' '),
-    (KernRe(r'\s*__rcu', re.S), ' '),
-    (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
-    (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-    (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
-    #
-    # Unwrap struct_group macros based on this definition:
-    # __struct_group(TAG, NAME, ATTRS, MEMBERS...)
-    # which has variants like: struct_group(NAME, MEMBERS...)
-    # Only MEMBERS arguments require documentation.
-    #
-    # Parsing them happens on two steps:
-    #
-    # 1. drop struct group arguments that aren't at MEMBERS,
-    #    storing them as STRUCT_GROUP(MEMBERS)
-    #
-    # 2. remove STRUCT_GROUP() ancillary macro.
-    #
-    # The original logic used to remove STRUCT_GROUP() using an
-    # advanced regex:
-    #
-    #   \bSTRUCT_GROUP(\(((?:(?>[^)(]+)|(?1))*)\))[^;]*;
-    #
-    # with two patterns that are incompatible with
-    # Python re module, as it has:
-    #
-    #   - a recursive pattern: (?1)
-    #   - an atomic grouping: (?>...)
-    #
-    # I tried a simpler version: but it didn't work either:
-    #   \bSTRUCT_GROUP\(([^\)]+)\)[^;]*;
-    #
-    # As it doesn't properly match the end parenthesis on some cases.
-    #
-    # So, a better solution was crafted: there's now a CFunction
-    # class that ensures that delimiters after a search are properly
-    # matched. So, the implementation to drop STRUCT_GROUP() will be
-    # handled in separate.
-    #
-    (CFunction('struct_group'), r'\2'),
-    (CFunction('struct_group_attr'), r'\3'),
-    (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
-    (CFunction('__struct_group'), r'\4'),
-
-    #
-    # Replace macros
-    #
-    # TODO: use CFunction on all FOO($1, $2, ...) matches
-    #
-    # it is better to also move those to the CFunction logic,
-    # to ensure that parentheses will be properly matched.
-    #
-    (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
-     r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-    (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
-     r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-    (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-            re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-    (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-            re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-    (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
-            r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-    (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
-            struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-    (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
-            struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
-    (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-    (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
-    (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
-]
-
-#
-# Transforms for function prototypes
-#
-function_xforms = [
-    (KernRe(r"^static +"), ""),
-    (KernRe(r"^extern +"), ""),
-    (KernRe(r"^asmlinkage +"), ""),
-    (KernRe(r"^inline +"), ""),
-    (KernRe(r"^__inline__ +"), ""),
-    (KernRe(r"^__inline +"), ""),
-    (KernRe(r"^__always_inline +"), ""),
-    (KernRe(r"^noinline +"), ""),
-    (KernRe(r"^__FORTIFY_INLINE +"), ""),
-    (KernRe(r"__init +"), ""),
-    (KernRe(r"__init_or_module +"), ""),
-    (KernRe(r"__deprecated +"), ""),
-    (KernRe(r"__flatten +"), ""),
-    (KernRe(r"__meminit +"), ""),
-    (KernRe(r"__must_check +"), ""),
-    (KernRe(r"__weak +"), ""),
-    (KernRe(r"__sched +"), ""),
-    (KernRe(r"_noprof"), ""),
-    (KernRe(r"__always_unused *"), ""),
-    (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-    (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-    (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-    (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
-    (KernRe(r"__no_context_analysis\s*"), ""),
-    (KernRe(r"__attribute_const__ +"), ""),
-    (CFunction("__cond_acquires"), ""),
-    (CFunction("__cond_releases"), ""),
-    (CFunction("__acquires"), ""),
-    (CFunction("__releases"), ""),
-    (CFunction("__must_hold"), ""),
-    (CFunction("__must_not_hold"), ""),
-    (CFunction("__must_hold_shared"), ""),
-    (CFunction("__cond_acquires_shared"), ""),
-    (CFunction("__acquires_shared"), ""),
-    (CFunction("__releases_shared"), ""),
-    (CFunction("__attribute__"), ""),
-]
-
-#
-# Transforms for variable prototypes
-#
-var_xforms = [
-    (KernRe(r"__read_mostly"), ""),
-    (KernRe(r"__ro_after_init"), ""),
-    (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
-    (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
-    (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
-    (KernRe(r"(?://.*)$"), ""),
-    (KernRe(r"(?:/\*.*\*/)"), ""),
-    (KernRe(r";$"), ""),
-]
 
 #
 # Ancillary functions
@@ -394,11 +258,12 @@ class KernelDoc:
     #: String to write when a parameter is not described.
     undescribed = "-- undescribed --"
 
-    def __init__(self, config, fname):
+    def __init__(self, config, fname, xforms):
         """Initialize internal variables"""
 
         self.fname = fname
         self.config = config
+        self.xforms = xforms
 
         # Initial state for the state machines
         self.state = state.NORMAL
@@ -889,7 +754,7 @@ class KernelDoc:
         # Go through the list of members applying all of our transformations.
         #
         members = trim_private_members(members)
-        members = self.apply_transforms(struct_xforms, members)
+        members = self.apply_transforms(self.xforms.struct_xforms, members)
 
         #
         # Deal with embedded struct and union members, and drop enums entirely.
@@ -1011,8 +876,7 @@ class KernelDoc:
         # Drop comments and macros to have a pure C prototype
         #
         if not declaration_name:
-            for r, sub in var_xforms:
-                proto = r.sub(sub, proto)
+            proto = self.apply_transforms(self.xforms.var_xforms, proto)
 
         proto = proto.rstrip()
 
@@ -1104,7 +968,8 @@ class KernelDoc:
             #
             # Apply the initial transformations.
             #
-            prototype = self.apply_transforms(function_xforms, prototype)
+            prototype = self.apply_transforms(self.xforms.function_xforms,
+                                              prototype)
 
         # Yes, this truly is vile.  We are looking for:
         # 1. Return type (may be nothing if we're looking at a macro)
diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
new file mode 100644
index 000000000000..88968bafdb78
--- /dev/null
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -0,0 +1,117 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+# Copyright(c) 2026: Mauro Carvalho Chehab <mchehab@kernel.org>.
+
+import re
+
+from kdoc.kdoc_re import CFunction, KernRe
+
+struct_args_pattern = r'([^,)]+)'
+
+class CTransforms:
+    """
+    Data class containing a long set of transformations to turn
+    structure member prefixes, and macro invocations and variables
+    into something we can parse and generate kdoc for.
+    """
+
+    #: Transforms for structs and unions
+    struct_xforms = [
+        # Strip attributes
+        (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
+        (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
+        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
+        (KernRe(r'\s*__packed\s*', re.S), ' '),
+        (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
+        (KernRe(r'\s*__private', re.S), ' '),
+        (KernRe(r'\s*__rcu', re.S), ' '),
+        (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
+        (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
+        (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
+
+        (CFunction('struct_group'), r'\2'),
+        (CFunction('struct_group_attr'), r'\3'),
+        (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
+        (CFunction('__struct_group'), r'\4'),
+
+        #
+        # Replace macros
+        #
+        # TODO: use CFunction on all FOO($1, $2, ...) matches
+        #
+        # it is better to also move those to the CFunction logic,
+        # to ensure that parentheses will be properly matched.
+        #
+        (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
+        r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+        (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
+        r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+        (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+                re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+        (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
+                re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
+        (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
+                r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+        (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
+                struct_args_pattern + r'\)', re.S), r'\2 *\1'),
+        (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
+                struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
+        (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
+        (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
+        (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
+    ]
+
+    #: Transforms for function prototypes
+    function_xforms = [
+        (KernRe(r"^static +"), ""),
+        (KernRe(r"^extern +"), ""),
+        (KernRe(r"^asmlinkage +"), ""),
+        (KernRe(r"^inline +"), ""),
+        (KernRe(r"^__inline__ +"), ""),
+        (KernRe(r"^__inline +"), ""),
+        (KernRe(r"^__always_inline +"), ""),
+        (KernRe(r"^noinline +"), ""),
+        (KernRe(r"^__FORTIFY_INLINE +"), ""),
+        (KernRe(r"__init +"), ""),
+        (KernRe(r"__init_or_module +"), ""),
+        (KernRe(r"__deprecated +"), ""),
+        (KernRe(r"__flatten +"), ""),
+        (KernRe(r"__meminit +"), ""),
+        (KernRe(r"__must_check +"), ""),
+        (KernRe(r"__weak +"), ""),
+        (KernRe(r"__sched +"), ""),
+        (KernRe(r"_noprof"), ""),
+        (KernRe(r"__always_unused *"), ""),
+        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
+        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
+        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
+        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+        (KernRe(r"__no_context_analysis\s*"), ""),
+        (KernRe(r"__attribute_const__ +"), ""),
+        (CFunction("__cond_acquires"), ""),
+        (CFunction("__cond_releases"), ""),
+        (CFunction("__acquires"), ""),
+        (CFunction("__releases"), ""),
+        (CFunction("__must_hold"), ""),
+        (CFunction("__must_not_hold"), ""),
+        (CFunction("__must_hold_shared"), ""),
+        (CFunction("__cond_acquires_shared"), ""),
+        (CFunction("__acquires_shared"), ""),
+        (CFunction("__releases_shared"), ""),
+        (CFunction("__attribute__"), ""),
+    ]
+
+    #: Transforms for variables
+    var_xforms = [
+        (KernRe(r"__read_mostly"), ""),
+        (KernRe(r"__ro_after_init"), ""),
+        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
+        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
+        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+        (KernRe(r"(?://.*)$"), ""),
+        (KernRe(r"(?:/\*.*\*/)"), ""),
+        (KernRe(r";$"), ""),
+    ]
-- 
2.52.0


