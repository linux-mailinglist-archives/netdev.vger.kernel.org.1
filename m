Return-Path: <netdev+bounces-259265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJMuOgqRlWnoSQIAu9opvQ
	(envelope-from <netdev+bounces-259265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:14:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C92A155377
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:14:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6FDEA302D9DE
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80013446D8;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxqsx67i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818DC3446BC;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771409602; cv=none; b=bBxEoODat62e4KxfVROQvhAVUwnQ/WFIXlFzcMaOdNIxYTD5WRay+dQFon/R1MR1EoLTHHnhzQWQDl2qkxb9CnedRNGN4wxfa68siZ9JcsfSkMPZNCc4MdEq9afbC2x3WzcbbEcxcmsulORyPYKhiBnJ2T8TtxojlFcw17OCquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771409602; c=relaxed/simple;
	bh=o+XwvOhwzAMJSmWQIfpQC03ux6SeS1yBhcVlaWB7ox4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nFh16VEtGeQiEFotl3ka7ldYFKt2eO5fKRssWOIjerpv0V2xGXwuARXyPR8CcCF5B28cVT94NY+/BVf1EnXVVOQsfwKJtFBDI34qNNlwKnC/zw0SRXo1pzbtAzHl8YeXMLnQVslbQngHuG9/VxMtEr3USNbAt8N+neZozHtSKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxqsx67i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ABA6C2BC9E;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771409602;
	bh=o+XwvOhwzAMJSmWQIfpQC03ux6SeS1yBhcVlaWB7ox4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxqsx67iD7IO8HPXRN3Njq0M9bTXSSPVhccyyOt+BvU+8mhOHNWJKTeRPQ3WU1wGP
	 JEvWkInGLhAmbtvLtqlXpjQ8I3rUcYOnge7rcxAhhtqkrhkfdC0+peEYKiDixyes7G
	 hmIcvO4cMhco9MCd1NM9ZCJ9gSTIwMn4Qk08HtihWVJK/L89NjhEQ/njBqIBIT2qlK
	 /mGCNZDZ0Bqezgz3ezMCmJtMNojGBY8+4nSyJIlxeYdaeQRLx0nUm3YSKZjsgpFELS
	 wvRq2xgVSAXmi/5Udqo5zEMciRQUzcqfIQmZ9r9xNQZY7cexbBcpoB07AGgpdpLMv1
	 djy3SvemE6+rg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vseYa-00000000LYT-2WjK;
	Wed, 18 Feb 2026 11:13:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 12/38] docs: kdoc_parser: ignore context analysis and lock attributes
Date: Wed, 18 Feb 2026 11:12:42 +0100
Message-ID: <744ba47877b67b369e5c255438b7fdfe7b7efa25.1771408406.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259265-lists,netdev=lfdr.de,huawei];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C92A155377
X-Rspamd-Action: no action

From: Randy Dunlap <rdunlap@infradead.org>

Drop all context analysis and lock (tracking) attributes to avoid
kernel-doc warnings.

Documentation/core-api/kref:328: ../include/linux/kref.h:72: WARNING: Invalid C declaration: Expected end of definition. [error at 96]
  int kref_put_mutex (struct kref *kref, void (*release)(struct kref *kref), struct mutex *mutex) __cond_acquires(true# mutex)
  ------------------------------------------------------------------------------------------------^
Documentation/core-api/kref:328: ../include/linux/kref.h:94: WARNING: Invalid C declaration: Expected end of definition. [error at 92]
  int kref_put_lock (struct kref *kref, void (*release)(struct kref *kref), spinlock_t *lock) __cond_acquires(true# lock)
  --------------------------------------------------------------------------------------------^

The regex is suggested by Mauro; mine was too greedy. Thanks.
Updated context analysis and lock macros list provided by PeterZ. Thanks.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/all/20260107161548.45530e1c@canb.auug.org.au/
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index f524385543a6..25d8a89f32b2 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -81,6 +81,8 @@ struct_xforms = [
     (KernRe(r'\s*__aligned\s*\([^;]*\)', re.S), ' '),
     (KernRe(r'\s*__counted_by\s*\([^;]*\)', re.S), ' '),
     (KernRe(r'\s*__counted_by_(le|be)\s*\([^;]*\)', re.S), ' '),
+    (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ' '),
+    (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ' '),
     (KernRe(r'\s*__packed\s*', re.S), ' '),
     (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
     (KernRe(r'\s*__private', re.S), ' '),
@@ -165,6 +167,16 @@ struct_nested_prefixes = [
 # the start delimiter.
 #
 function_nested_prefixes = [
+    (re.compile(r"__cond_acquires\s*\("), ""),
+    (re.compile(r"__cond_releases\s*\("), ""),
+    (re.compile(r"__acquires\s*\("), ""),
+    (re.compile(r"__releases\s*\("), ""),
+    (re.compile(r"__must_hold\s*\("), ""),
+    (re.compile(r"__must_not_hold\s*\("), ""),
+    (re.compile(r"__must_hold_shared\s*\("), ""),
+    (re.compile(r"__cond_acquires_shared\s*\("), ""),
+    (re.compile(r"__acquires_shared\s*\("), ""),
+    (re.compile(r"__releases_shared\s*\("), ""),
     (re.compile(r"__attribute__\s*\("), ""),
 ]
 
@@ -196,6 +208,7 @@ function_xforms = [
     (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+    (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
 ]
 
@@ -205,6 +218,8 @@ function_xforms = [
 var_xforms = [
     (KernRe(r"__read_mostly"), ""),
     (KernRe(r"__ro_after_init"), ""),
+    (KernRe(r'\s*__guarded_by\s*\([^\)]*\)', re.S), ""),
+    (KernRe(r'\s*__pt_guarded_by\s*\([^\)]*\)', re.S), ""),
     (KernRe(r"(?://.*)$"), ""),
     (KernRe(r"(?:/\*.*\*/)"), ""),
     (KernRe(r";$"), ""),
-- 
2.52.0


