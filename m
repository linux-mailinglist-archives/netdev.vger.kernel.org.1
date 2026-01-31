Return-Path: <netdev+bounces-255409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CqjA1oRfmkbVQIAu9opvQ
	(envelope-from <netdev+bounces-255409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:27:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D499C2619
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 42E8E3010751
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:26:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E73F361DDB;
	Sat, 31 Jan 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neOACnZT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055D0357711;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=CDAFB32cl24ddX+2/XegV7NB/FuOhIZpt4HW+HsS0/krwK3obieJTIpEgHdDQi9hee6+fmFlo3KqZlbCd57g+nn/W6OKKpXBFmSGHhhb0t7oV2NQLyGrV1d1XAazy7J2XCrWVWQiFwCtKkLFlLPIB3ztnVXAQaVxgaJ+qWLSQgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=uOq+nl7eJthPvVG9hgcDgM2eUmvJY3Ts+Jdl+DSpsYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TgP/iHFH72JujyJKggJ+9iJucNIFJOhVkru1B8B4oybBMUR1NwGmhjDtsiI6fUQ6Lc57Tk+0VdTwUaKFiIKhEJfaNC7IdDi+u3Z8XKg1MiEclKr9eOniCS2IugdcRtEkEk8nPBPlOsyANrlpcKVe0P6RuklxiaouOZXu+5nFj/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neOACnZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71CABC2BCAF;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=uOq+nl7eJthPvVG9hgcDgM2eUmvJY3Ts+Jdl+DSpsYI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=neOACnZTJdN4hBjqEVf5dn93zlY5Ke3dCNR50AducSB2fWBw/1/3YKlYFd8Nx66S2
	 PklvVqDS/z4xvv/8X6Wr+gQhcFgKEtYKyyuHIwRN0z8+3gQ1XEyPwlGZ8AJmwgNsmx
	 qhY2MCJQ1T4dmkDUOm3SuanelIuDfqLQkBcdufrLnbdK5dF271OT+L9iN3qtE9BWeT
	 dGsRFsDy4mXqeldzejd3nBHO1vKh4jIE+8Zd9WVsJBChrEW4E4YEMiyELWJxV+/Kwk
	 d02ZYDhtL+hqo8nm/HajufmJdYPdqDF4/oh1zcuXp3bVB1VjvOnGO5Gbewsn8T3U0W
	 NRuAPxDuPxRwA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkW-2fUw;
	Sat, 31 Jan 2026 15:25:19 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH v4 12/41] docs: kdoc_parser: ignore context analysis and lock attributes
Date: Sat, 31 Jan 2026 15:24:46 +0100
Message-ID: <e1b8c0052ea99cca8428d3aec8a4fcf10412cee8.1769867953.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-255409-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,auug.org.au:email,infradead.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2D499C2619
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
index 21cc4e19a1e8..92b550189988 100644
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
 
@@ -195,6 +207,7 @@ function_xforms = [
     (KernRe(r"__(?:re)?alloc_size\s*\(\s*\d+\s*(?:,\s*\d+\s*)?\) +"), ""),
     (KernRe(r"__diagnose_as\s*\(\s*\S+\s*(?:,\s*\d+\s*)*\) +"), ""),
     (KernRe(r"DECL_BUCKET_PARAMS\s*\(\s*(\S+)\s*,\s*(\S+)\s*\)"), r"\1, \2"),
+    (KernRe(r"__no_context_analysis\s*"), ""),
     (KernRe(r"__attribute_const__ +"), ""),
 ]
 
@@ -204,6 +217,8 @@ function_xforms = [
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


