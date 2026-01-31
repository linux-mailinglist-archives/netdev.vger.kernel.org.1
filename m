Return-Path: <netdev+bounces-255434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EIh5OfISfmlLVQIAu9opvQ
	(envelope-from <netdev+bounces-255434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:34:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79970C2776
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C99903031AE7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5168536682C;
	Sat, 31 Jan 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FlayTHJs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0C4359F88;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=hf/7Eojp+sO5kNF1UFOYGCbOsAStSGT971b3ZmzN1OjmhJ/NahJbEoU0aj5VEqX9JCgOM0/kCHVcnpMI4NufIUwcBZBc8Yh/oo7fLVJgH4oOmTqavNCnXWO9HUXAZfiffyiN2Nqe4C0Z6mML6g82iEzETLCXaYhmFHPLBKE7K04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=c78VBSuB3zJR1YCeHGb5UJcGA9b8DZwRfytxgWk/nVQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=paJnUAMntG6yxEOje+bkag+xHAkbE2eqlBetkzhDylg4xkle54EhJlvFxhdWax4h7vyISFVfrcvf7rSjKviYeCetyjkMiYXsiAf/Khxc8BRxhkCyt6+hNJpryjXEQk1F0N+i9G+PEIAmkK+plGtoJXJ4IMo1TayR6oN82ahUuiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FlayTHJs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6D96C4AF1B;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=c78VBSuB3zJR1YCeHGb5UJcGA9b8DZwRfytxgWk/nVQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FlayTHJs2JUrQOYizmq+bu9LbW2w66UJVg9tbVq+HjdhRH0wnlriOKQ+ObL4grHnZ
	 +r98L9a4ebz0IGwaVufND7ECK2QORhXbBvQVK5a+kMDa7qGwng3sDR4o0E+xDmh6Op
	 VlmGodLkSbAOyoXmJxvDaIwuRmHzyOtGFbDIInKiTpzGbIK10Z0gzL/C6WkfT6FQTL
	 Ppij1jr5RxAiEHQouiIYV7XVqh0HDtQumuNQ46hazfxSkW5WVTVX3lu2dcaOXH1KrM
	 y3vvDQo+EnhPO+Mu8nbkXFfGeeANwYzVECJbdDObW/IbfycnsGRe0ICaCffV0Ut1G7
	 58BrPSt6HvYoA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBua-0000000AVlf-0TIM;
	Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Kees Cook <kees@kernel.org>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v4 29/41] docs: xforms_lists.py: use CFuntion to handle all function macros
Date: Sat, 31 Jan 2026 15:25:03 +0100
Message-ID: <4ad68fce80ea7f994665ce2d72b39f0098df2476.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255434-lists,netdev=lfdr.de,huawei];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,huawei];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79970C2776
X-Rspamd-Action: no action

The new CFunction class handles better macros, as it works the same
way C compilers do, handling delimiters tha right way.

This allows removing complex regular expressions, placing instead
just a simple one with the name(s) of the functions to be replaced.

Doing a before/after check using "kernel-doc -man ." shows only
cosmetic changes (whitespaces, mostly).

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/xforms_lists.py | 71 ++++++++++++---------------
 1 file changed, 31 insertions(+), 40 deletions(-)

diff --git a/tools/lib/python/kdoc/xforms_lists.py b/tools/lib/python/kdoc/xforms_lists.py
index 88968bafdb78..ea6520b38ea2 100644
--- a/tools/lib/python/kdoc/xforms_lists.py
+++ b/tools/lib/python/kdoc/xforms_lists.py
@@ -17,51 +17,38 @@ class CTransforms:
 
     #: Transforms for structs and unions
     struct_xforms = [
-        # Strip attributes
-        (KernRe(r"__attribute__\s*\(\([a-z0-9,_\*\s\(\)]*\)\)", flags=re.I | re.S, cache=False), ' '),
-        (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
+        (CFunction("__attribute__"), ' '),
+        (CFunction('__aligned'), ' '),
+        (CFunction('__counted_by'), ' '),
+        (CFunction('__counted_by_(le|be)'), ' '),
+        (CFunction('__guarded_by'), ' '),
+        (CFunction('__pt_guarded_by'), ' '),
+
         (KernRe(r'\s*__packed\s*', re.S), ' '),
         (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
         (KernRe(r'\s*__private', re.S), ' '),
         (KernRe(r'\s*__rcu', re.S), ' '),
         (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
         (KernRe(r'\s*____cacheline_aligned', re.S), ' '),
-        (KernRe(r'\s*__cacheline_group_(begin|end)\([^\)]+\);'), ''),
+
+        (CFunction('__cacheline_group_(begin|end)'), ''),
 
         (CFunction('struct_group'), r'\2'),
         (CFunction('struct_group_attr'), r'\3'),
         (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
         (CFunction('__struct_group'), r'\4'),
 
-        #
-        # Replace macros
-        #
-        # TODO: use CFunction on all FOO($1, $2, ...) matches
-        #
-        # it is better to also move those to the CFunction logic,
-        # to ensure that parentheses will be properly matched.
-        #
-        (KernRe(r'__ETHTOOL_DECLARE_LINK_MODE_MASK\s*\(([^\)]+)\)', re.S),
-        r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
-        (KernRe(r'DECLARE_PHY_INTERFACE_MASK\s*\(([^\)]+)\)', re.S),
-        r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
-        (KernRe(r'DECLARE_BITMAP\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-                re.S), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
-        (KernRe(r'DECLARE_HASHTABLE\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern + r'\)',
-                re.S), r'unsigned long \1[1 << ((\2) - 1)]'),
-        (KernRe(r'DECLARE_KFIFO\s*\(' + struct_args_pattern + r',\s*' + struct_args_pattern +
-                r',\s*' + struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-        (KernRe(r'DECLARE_KFIFO_PTR\s*\(' + struct_args_pattern + r',\s*' +
-                struct_args_pattern + r'\)', re.S), r'\2 *\1'),
-        (KernRe(r'(?:__)?DECLARE_FLEX_ARRAY\s*\(' + struct_args_pattern + r',\s*' +
-                struct_args_pattern + r'\)', re.S), r'\1 \2[]'),
-        (KernRe(r'DEFINE_DMA_UNMAP_ADDR\s*\(' + struct_args_pattern + r'\)', re.S), r'dma_addr_t \1'),
-        (KernRe(r'DEFINE_DMA_UNMAP_LEN\s*\(' + struct_args_pattern + r'\)', re.S), r'__u32 \1'),
-        (KernRe(r'VIRTIO_DECLARE_FEATURES\(([\w_]+)\)'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
+        (CFunction('__ETHTOOL_DECLARE_LINK_MODE_MASK'), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
+        (CFunction('DECLARE_PHY_INTERFACE_MASK',), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
+        (CFunction('DECLARE_BITMAP'), r'unsigned long \1[BITS_TO_LONGS(\2)]'),
+
+        (CFunction('DECLARE_HASHTABLE'), r'unsigned long \1[1 << ((\2) - 1)]'),
+        (CFunction('DECLARE_KFIFO'), r'\2 *\1'),
+        (CFunction('DECLARE_KFIFO_PTR'), r'\2 *\1'),
+        (CFunction('(?:__)?DECLARE_FLEX_ARRAY'), r'\1 \2[]'),
+        (CFunction('DEFINE_DMA_UNMAP_ADDR'), r'dma_addr_t \1'),
+        (CFunction('DEFINE_DMA_UNMAP_LEN'), r'__u32 \1'),
+        (CFunction('VIRTIO_DECLARE_FEATURES'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
     ]
 
     #: Transforms for function prototypes
@@ -85,12 +72,14 @@ class CTransforms:
         (KernRe(r"__sched +"), ""),
         (KernRe(r"_noprof"), ""),
         (KernRe(r"__always_unused *"), ""),
-        (KernRe(r"__printf\s*\(\s*\d*\s*,\s*\d*\s*\) +"), ""),
-        (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
-        (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
-        (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
         (KernRe(r"__no_context_analysis\s*"), ""),
         (KernRe(r"__attribute_const__ +"), ""),
+
+        (CFunction('__printf'), ""),
+        (CFunction('__(?:re)?alloc_size'), ""),
+        (CFunction("__diagnose_as"), ""),
+        (CFunction("DECL_BUCKET_PARAMS"), r"\1, \2"),
+
         (CFunction("__cond_acquires"), ""),
         (CFunction("__cond_releases"), ""),
         (CFunction("__acquires"), ""),
@@ -108,9 +97,11 @@ class CTransforms:
     var_xforms = [
         (KernRe(r"__read_mostly"), ""),
         (KernRe(r"__ro_after_init"), ""),
-        (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
-        (KernRe(r"LIST_HEAD\(([\w_]+)\)"), r"struct list_head \1"),
+
+        (CFunction('__guarded_by'), ""),
+        (CFunction('__pt_guarded_by'), ""),
+        (CFunction("LIST_HEAD"), r"struct list_head \1"),
+
         (KernRe(r"(?://.*)$"), ""),
         (KernRe(r"(?:/\*.*\*/)"), ""),
         (KernRe(r";$"), ""),
-- 
2.52.0


