Return-Path: <netdev+bounces-255414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CJopDEARfmkbVQIAu9opvQ
	(envelope-from <netdev+bounces-255414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:27:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E063C25E7
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 15:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EB6DF3017DCE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 14:26:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4868F362153;
	Sat, 31 Jan 2026 14:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZ8ffB0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1681A357A20;
	Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769869522; cv=none; b=G2HMvXho3JYfmYO4AGA5hN0LG2WAnsUcKlSAEKVJQs8o2h8eD8C3yA6HIB/BL4jF9W+uSaATPdhK/kZ3pAcXKlb/i9v1ytYBhkLHG9sNeY+zTQm2usaJDGoxA+KS7QmCmGP/1SQACJTsSALmbydi2d/ponFAk0w+zgnakT8gkFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769869522; c=relaxed/simple;
	bh=aiHLIfS5F+miX7dW9x3ionw6eHjNQsSUUYhH3F5IK/s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgcI4ixYV9DCuI5GCdsSjaCnF1LGwY5/cF6Sbe3mKBKnZEkU+YJxRgAwJjWANby5XB3P8ZzinQ9UQCynzS8nJZ3z72z7BR5QFBGqwiUAYbG9ztkT/soXD+0rRDp3SaLYJh+0bSSIMQf29jGml+Q6nJOx3hVW7c+5qnbeNKctAKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZ8ffB0o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B123C2BCB2;
	Sat, 31 Jan 2026 14:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769869521;
	bh=aiHLIfS5F+miX7dW9x3ionw6eHjNQsSUUYhH3F5IK/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZ8ffB0okAa/JZq9EY0ksEvsodBd6UavOLLuUMYwJGch0xaJ5NzYy/XmzPvHPCo3q
	 RqSaKMODYYaWzPYPITpqTiZ4yCGBhA0Hqk0xQYThuoP3/dzmCL9UShHBcj9vbLKvXk
	 5iYtPT8ML/OhYwkWrBTnCoRX14C8GyC0dy4WHAaf2dj5JS8NnxttcDA2fqoZ8+Qdec
	 9pp7YED0qK5vhb7GtLxFuNVzNwefL1IxAyM3xMdf0X3e2Bo7Suzfbz4hi0xetRN8TL
	 1VHVBEenAyQxB8YZ8M0U7zBdg2/K4wZpYEhp7J2WPpk3U60jnUMJVi2JX2ltmfVDss
	 pqkDmdp3yNW+w==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vmBuZ-0000000AVkS-2YEf;
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
Subject: [PATCH v4 11/41] docs: kdoc_parser: fix parser to support multi-word types
Date: Sat, 31 Jan 2026 15:24:45 +0100
Message-ID: <f2b1c15602871f866ea179808fded10dbad447da.1769867953.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255414-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,infradead.org:email,intel.com:email]
X-Rspamd-Queue-Id: 0E063C25E7
X-Rspamd-Action: no action

The regular expression currently expects a single word for the
type, but it may be something like  "struct foo".

Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 tools/lib/python/kdoc/kdoc_parser.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 0b6cba442d72..21cc4e19a1e8 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -1026,7 +1026,7 @@ class KernelDoc:
 
         default_val = None
 
-        r= KernRe(OPTIONAL_VAR_ATTR + r"[\w_]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+        r= KernRe(OPTIONAL_VAR_ATTR + r"\s*[\w_\s]*\s+(?:\*+)?([\w_]+)\s*[\d\]\[]*\s*(=.*)?")
         if r.match(proto):
             if not declaration_name:
                 declaration_name = r.group(1)
@@ -1037,7 +1037,7 @@ class KernelDoc:
                                   r.groups(), proto)
 
         else:
-            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
+            r= KernRe(OPTIONAL_VAR_ATTR + r"(?:[\w_\s]*)?\s+(?:\*+)?(?:[\w_]+)\s*[\d\]\[]*\s*(=.*)?")
 
             if r.match(proto):
                 default_val = r.group(1)
-- 
2.52.0


