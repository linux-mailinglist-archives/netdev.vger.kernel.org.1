Return-Path: <netdev+bounces-254364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HntFhdAemmr4wEAu9opvQ
	(envelope-from <netdev+bounces-254364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:57:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA26A6672
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 17:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E99F730D38C6
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39E48376481;
	Wed, 28 Jan 2026 16:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ietd/thr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102BE376463;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619036; cv=none; b=BB2mEZxqTHfDpm5LQQhXz6eSUpEH9I6hfE2jt8Y61uoYkKET9FputaxAGAD70svZo5YUUnq9KtAUrSL863uvTzQomPyDaZRMJdpUkZ6KQ8O41W0wLutQVqXqUPYbo1Yr6q48SXGqU7yR0nclr5+qTvBOopSrKx07+mMcwCaEH/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619036; c=relaxed/simple;
	bh=eEXbBuQJszefL3B/0u0xuMDgFhmsCIKucbWpvC7EagQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uoX4DQcqIfNoMb/N9ERHVjUE0AaCGuyTRwxSwof0HXzY9nQrH/uHJM/kOr9UsGcarErsCCeYAxLol5oimIWmqgm8knI93WdpDPMe1XlaTpWYVnSLNEj8TvPZw9GbYOiEDZznp6uFRujA0BDy9ovS2aw+lVBxGAn7LwF0dV7RH1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ietd/thr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9A9FC116C6;
	Wed, 28 Jan 2026 16:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619035;
	bh=eEXbBuQJszefL3B/0u0xuMDgFhmsCIKucbWpvC7EagQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ietd/thrp+Wgkn2FFcx+NtiFEntfcPxqSCbgnMI1Np48edS47DIEacKLeZrEbEgTi
	 /N/D+IQp/zYdnxRFSbMOkAp4sgVKIyPBsNiQqz3qAja/7y4VaPdsbUGxwQeS5v07ZT
	 zMRKQHtOdNxh6Q01gndXZlvisf55hyjj3dLKkTITU+e8CTEdLkRbZn1czO0EpuxECe
	 bLE7UIzYBz9SO/y143/sRYVssD5+i/2SxI0CwwgMfj1fQWE1OI6EXR8wLXbUdPIYqx
	 8Tss/yqO6ap9UOfyd0K41+5VBldEbNNdn1RRgljnvivP8Hn0EqipVVWsIs4YBoWH5H
	 9dCLt2k6fynFg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kT-0000000DB50-48Df;
	Wed, 28 Jan 2026 17:50:33 +0100
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
Subject: [PATCH v2 18/25] docs: kdoc_re: Change NestedMath args replacement to \0
Date: Wed, 28 Jan 2026 17:50:16 +0100
Message-ID: <323b4c67ae7fd241670ef0b5ff6eeb10d968415e.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254364-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAA26A6672
X-Rspamd-Action: no action

Future patches will allow parsing each argument instead of the
hole set. Prepare for it by changing the replace all args from
\1 to \0.

No functional changes.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 tools/lib/python/kdoc/kdoc_re.py     | 9 +++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index db140363104a..4d52a00acfad 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -160,7 +160,7 @@ struct_xforms = [
 # is allowed.
 #
 struct_nested_prefixes = [
-    (re.compile(r'\bSTRUCT_GROUP\('), r'\1'),
+    (re.compile(r'\bSTRUCT_GROUP\('), r'\0'),
 ]
 
 #
diff --git a/tools/lib/python/kdoc/kdoc_re.py b/tools/lib/python/kdoc/kdoc_re.py
index b6e11ee0be21..28ca5032f40c 100644
--- a/tools/lib/python/kdoc/kdoc_re.py
+++ b/tools/lib/python/kdoc/kdoc_re.py
@@ -271,8 +271,9 @@ class NestedMatch:
         It matches a regex that it is followed by a delimiter,
         replacing occurrences only if all delimiters are paired.
 
-        if r'\1' is used, it works just like re: it places there the
-        matched paired data with the delimiter stripped.
+        if r'\0' is used, it works on a similar way of using re.group(0):
+        it places the entire args of the matched paired data, with the
+        delimiter stripped.
 
         If count is different than zero, it will replace at most count
         items.
@@ -288,9 +289,9 @@ class NestedMatch:
             # Value, ignoring start/end delimiters
             value = line[end:pos - 1]
 
-            # replaces \1 at the sub string, if \1 is used there
+            # replaces \0 at the sub string, if \0 is used there
             new_sub = sub
-            new_sub = new_sub.replace(r'\1', value)
+            new_sub = new_sub.replace(r'\0', value)
 
             out += new_sub
 
-- 
2.52.0


