Return-Path: <netdev+bounces-254617-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6APoAxcWe2kZBQIAu9opvQ
	(envelope-from <netdev+bounces-254617-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:11:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id CD804AD40C
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:11:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4980B301FDD0
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F883806CF;
	Thu, 29 Jan 2026 08:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="maC+j0hn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513083793B9;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=iy/ErCp33l3vTvtAgjHub0iXx4Bm/SfxlnOSlFnv4LsWWbtAqapxM5hbYobUCmWQwwAQJ4bs8E1p8hbe+M6snpn9rycXEp2+VOHmzw5zQzFLIrpMzb5khvZHCosbUrTZf5lusxlh9R3VI5T5L3BuoOl75r0IencgVmE+gB5cxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=+PHSHQk42n1s2eoXmKBeCEHsRg0AhUmcVaeG8R0cpiE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOlepQAK5OvQiPNOXPexWHTgR2tCrpGr43ndNF4cBwkUGy/Lmn8C0hSr4QAlg4S6Q2M+F73n5kiHkw7HBS69ew42zb7dEQf++cxfQjjU8mN8ql/4CPfCwTjX7g5N/qahGnGBg6Osp7f0SNRK2Xb/CspitA/8VE4w4CBtOAjIPKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=maC+j0hn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B783FC2BCAF;
	Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674110;
	bh=+PHSHQk42n1s2eoXmKBeCEHsRg0AhUmcVaeG8R0cpiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=maC+j0hnj48daFZ8ng1N2+Dhr0gXmdF5Aqm760IJ2bxebUBl3pXpyOaCZo5TOLpcn
	 IkhsbrLqlgISNP7BK4HxZGS/wC52393Hqu752r7dwz2uwcE0UgsqEgf8I4w6QkpTvR
	 zO5SBxLAC5X6LmYBUnqih4ID5SoZKccfIanf1ICyGDDg15aIQOQDcrhhJE0s0H4lhD
	 9LT10mZfR+Sdy4BSjUGvxct4kZ89OCUsXJ5hBwFlRyyKEUp5onfAw8iDMin87GMPqo
	 OSvCg7qLVeNPWtAVEP2dQydfkutav+M6NUuiTA+lBI7silsWnPxs8sJUZAh0U81WzC
	 ayaNzT6hHpUEg==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4m-0000000ERNF-41KV;
	Thu, 29 Jan 2026 09:08:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 11/30] docs: kdoc_parser: fix parser to support multi-word types
Date: Thu, 29 Jan 2026 09:08:02 +0100
Message-ID: <ed3918b24518ee58bd92c6c2729fe0927d1bde95.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769673038.git.mchehab+huawei@kernel.org>
References: <cover.1769673038.git.mchehab+huawei@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-254617-lists,netdev=lfdr.de,huawei];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD804AD40C
X-Rspamd-Action: no action

The regular expression currently expects a single word for the
type, but it may be something like  "struct foo".

Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
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


