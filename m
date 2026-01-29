Return-Path: <netdev+bounces-254635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MN5OOdUXe2lCBQIAu9opvQ
	(envelope-from <netdev+bounces-254635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:18:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6245DAD664
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 09:18:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 607D8305DF09
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEB0385EF5;
	Thu, 29 Jan 2026 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HxEvSNHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8525537C105;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769674111; cv=none; b=sQGDUrcR4Cfq9oYfe8RDvtqjRat/IqKTXj0WDLf+UhGUQr3gkRj814rHtDfmczsYvjDjEOr9jYj3Kznely1g581hbDb24Z726winwadgDUmpeowM5qSCpQm5gwrR8g+MsoUCCrw2I4P89kK/uwAGmmyrU07Pflu0aWLspQ1FJqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769674111; c=relaxed/simple;
	bh=aAYr/rdf8rPhk+DzwcPpBGhnCkODn024mb+J5zDgPZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tcacPTVsdrDSLe0lZKA0ISnQuTxnRI7PJ7ngTechVgjUa09WqE9NepeDydISynU6k8np2ewizL/KiGUzPuOCcZ5MRNy/KwR5lYMxsmm9Uvb2WLyf29maS8ey3Az2P2cqIPdIdECGTlJziFgzmCNxT62jHt0QpE+kpF0dQk4SOWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HxEvSNHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2EAC2BCB6;
	Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769674111;
	bh=aAYr/rdf8rPhk+DzwcPpBGhnCkODn024mb+J5zDgPZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxEvSNHQEtL0D59ODsnQi0p3l8kMpRAIJaWt8HUV5lvtVPe2caGw5Z0eLuIIQN8Cr
	 4xRaxDBGT+igKQhlHOaxNvX+eFQ6ZA82YxsTv0FjkNdeBvTBYl+iYm50wea3VTsOcQ
	 fKt6u+LN7F4u4p4Zx30THYRuTvRzoAHmjiH9PlcAVFT47GW9CKIqfpogm1q0jwt9b3
	 7RjMh3jWaL0T1izR+e8ryofdpsfSH4aWF1PVlipelfiqJLjpGEWRmXNp90sSw+dIzh
	 /5erIn2XU+qhq6rfbrfcgR33uPNecU9q3U2RZybpjFOVd8oICaZfNpY9xMZj77zvIS
	 xM/EStNmmUzQA==
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vlN4n-0000000EROH-1jpG;
	Thu, 29 Jan 2026 09:08:29 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v3 27/30] docs: kdoc_parser: minimize differences with struct_group_tagged
Date: Thu, 29 Jan 2026 09:08:18 +0100
Message-ID: <50ef80ed8a1a638d08974e55a7828371bab09c0d.1769673038.git.mchehab+huawei@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254635-lists,netdev=lfdr.de,huawei];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mchehab@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,huawei];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6245DAD664
X-Rspamd-Action: no action

While the previous version does a better job representing
the actual struct, it ends losing documentation from each
member.

Change the replacements to minimize such changes. With that,
the only differences before/after using NestedMatch new
replacement logic are (at man page output):

    --- before.log  2026-01-29 06:14:20.163592584 +0100
    +++ after.log   2026-01-29 06:32:04.811370234 +0100
    @@ -1573701 +1573701 @@
    -.BI "    struct ice_health_tx_hang_buf  tx_hang_buf;"
    +.BI "    struct ice_health_tx_hang_buf tx_hang_buf;"
    @@ -4156451 +4156451 @@
    -.BI "    struct libeth_fq_fp  fp;"
    +.BI "    struct libeth_fq_fp fp;"
    @@ -4164041 +4164041 @@
    -.BI "    struct libeth_xskfq_fp  fp;"
    +.BI "    struct libeth_xskfq_fp fp;"
    @@ -4269434 +4269434 @@
    -.BI "    struct page_pool_params_fast  fast;"
    +.BI "    struct page_pool_params_fast fast;"
    @@ -4269452 +4269452 @@
    -.BI "    struct page_pool_params_slow  slow;"
    +.BI "    struct page_pool_params_slow slow;"
    @@ -4269454 +4269454 @@
    -.BI "    STRUCT_GROUP( struct net_device *netdev;"
    +.BI "    struct net_device *netdev;"

e.g. basically whitespaces, plus a fix NestedMatch to
better handle /* private */ comments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/lib/python/kdoc/kdoc_parser.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/python/kdoc/kdoc_parser.py b/tools/lib/python/kdoc/kdoc_parser.py
index 50d57c6799bb..1e8e156e2a9e 100644
--- a/tools/lib/python/kdoc/kdoc_parser.py
+++ b/tools/lib/python/kdoc/kdoc_parser.py
@@ -126,7 +126,7 @@ struct_xforms = [
     #
     (CFunction('struct_group'), r'\2'),
     (CFunction('struct_group_attr'), r'\3'),
-    (CFunction('struct_group_tagged'), r'struct \1 { \3 } \2;'),
+    (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
     (CFunction('__struct_group'), r'\4'),
 
     #
-- 
2.52.0


