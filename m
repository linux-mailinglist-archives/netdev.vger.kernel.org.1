Return-Path: <netdev+bounces-254368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6LCjIptAemmr4wEAu9opvQ
	(envelope-from <netdev+bounces-254368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:00:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 03034A6736
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 18:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C3055306E2D5
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A98378D6D;
	Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L52Is0d2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E6B0378830;
	Wed, 28 Jan 2026 16:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769619038; cv=none; b=sWgtO++odJuGDHi5WZF5+XbrApxXUDJXsGzCuaiJN4YmsnmUNAs6E902/CAIJhEDZ8H9/ETBmFTWEsT8ahuETV8AkCgmx69dv1osrj6UK6ybPVPX3SYzXQGmAKxI2YXGUC/xQ5NGlM4OFsHKFCTQfS6pE2oZ7nV6y44Q/HAYjHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769619038; c=relaxed/simple;
	bh=xPgXK1Bxhql6KwBQMghZiM8porm1utQ6AVnpiugaqXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLMGZQuYFL+a1zDwDkpqANqcjxeZQVBS2iR736h88CqjsGLWEH+2FfmDscfyP7OegUxmtI2eC3/CPhI6xkplAR+A4rhuuqAfodWoYEt3ox3VC1YDYz7x24t/c0HKLjbH62C/oXIIR4tB7vhN7EWEhzUYmF1Qwb0yur4ggtcB2MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L52Is0d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF896C4CEF7;
	Wed, 28 Jan 2026 16:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769619038;
	bh=xPgXK1Bxhql6KwBQMghZiM8porm1utQ6AVnpiugaqXI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L52Is0d2Mam9VJ+4YyKHw1zLjYczDjF+baeNR4vHB26sFkhUBDLbAVrQFv2uTDSKC
	 d7cLGmgpmI93G/ZRxWuZS8P4LzgHpLLntNDVJTs163AvSVDSS326iDw8yHfbJzXAUs
	 7akuYBSCS1QjtWefJUVP8iWzgl7unab3zdzhgTO5+ygwLEdzTljtWwYIfnlwAqxRUQ
	 ZaHiv9HLvtufnVmn1+/piCFM3ZQogA3HNU/VunJZQKYtI/bUm4ljfWDkxUfexL0VRA
	 LSdCAMa0h/oR+dWNMSlAFb00nE5+7b24OayJ0TKOejbCXpe0ulDsf0383a+/LA+Xed
	 JMZ2p1xI9Zk9g==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vl8kW-0000000DBB4-0bdW;
	Wed, 28 Jan 2026 17:50:36 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Peter Zijlstra <peterz@infradead.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2 23/25] tools/lib/python/unittest_helper.py
Date: Wed, 28 Jan 2026 17:50:21 +0100
Message-ID: <f370f2a0dfcaa679c9969488c908eaac82026031.1769617841.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254368-lists,netdev=lfdr.de,huawei];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 03034A6736
X-Rspamd-Action: no action

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/unittest_helper.py | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/tools/lib/python/unittest_helper.py b/tools/lib/python/unittest_helper.py
index e438472fa704..3cf1075b1de4 100755
--- a/tools/lib/python/unittest_helper.py
+++ b/tools/lib/python/unittest_helper.py
@@ -8,21 +8,7 @@
 Helper class to better display unittest results.
 
 Those help functions provide a nice colored output summary of each
-executed test and, when a test fails, it shows the different in diff
-format when running in verbose mode, like::
-
-    $ tools/unittests/nested_match.py -v
-    ...
-    Traceback (most recent call last):
-    File "/new_devel/docs/tools/unittests/nested_match.py", line 69, in test_count_limit
-        self.assertEqual(replaced, "bar(a); bar(b); foo(c)")
-        ~~~~~~~~~~~~~~~~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-    AssertionError: 'bar(a) foo(b); foo(c)' != 'bar(a); bar(b); foo(c)'
-    - bar(a) foo(b); foo(c)
-    ?       ^^^^
-    + bar(a); bar(b); foo(c)
-    ?       ^^^^^
-    ...
+executed test.
 
 It also allows filtering what tests will be executed via ``-k`` parameter.
 
-- 
2.52.0


