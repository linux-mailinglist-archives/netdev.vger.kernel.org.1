Return-Path: <netdev+bounces-263402-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP6JB3k+p2kNgAAAu9opvQ
	(envelope-from <netdev+bounces-263402-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:03:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5A31F692D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 21:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 33DB1316FACE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 19:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CEB386578;
	Tue,  3 Mar 2026 19:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="Q+QoTRj4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40966375F72
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 19:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.129.93.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772567976; cv=none; b=c5SSRyR86MA1DE+VlXqM6Jj7ecpXogTeY8pUMvp+gJ5BiPStOaeIzZ8RqwNdOtIjvC7PdJ23lFeEckNVBcegINmJ1aooIxiujgwXgarTXS5dCP5RsyGL6NCaxGVWdgTi+tq3QqOT6sggcvpbtWzg2MGDpFstUxRKxGMszdxXAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772567976; c=relaxed/simple;
	bh=Hc0DUDaW4pxUr+vmssBmWGcwNCrwXiW66JlO4gokU4Y=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EjqC3KLs8th78vefbWCXLxHLLvHF9PjFMD2DYpF5HD+QrtYkb39M0rt3QeQVMlUmcTuR45RHQ2rTT5WQkjRu+MvzhvXdw061EFttDROj9KT6I7vP5H2EoaTOQ9RVPPTk5E5T4/ptkArZeN501iC+O5G2uZ6fI0eyaYYwUVImAmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=Q+QoTRj4; arc=none smtp.client-ip=57.129.93.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1772567964; x=1772827164;
	bh=5HArFHOXUsiqRFgB/yRF4JMk5deic6zBEP/abKX8Ndc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Q+QoTRj4oEACaeT/NSKczBsV+Xg/9GJlx+AD2dlD5MeWh7p+upBMpTa4z1G0o0wie
	 WkVn6R7tbc1JxhIRdkN/M16g5d2UeDqpLsPjRC6QROU1LRb7Jb1WvFkK5AqbsIeivP
	 LkG2gRy/3sKc7bJ9hmvyEW9tS09P8xUOc/HLkfxY1LPvJNEb2823ebMIZt4PCrRaXM
	 c91W6ArNiHjJstkDf713cEtGuHqgSBmXkMjPAPPPNXikstxJTFhcxE44mo7YcyXV5U
	 dKwXTQUOT0N3fX2Bh/ZZmNwYNIPTIe5vqxqEd73yyUXqXvqaTi4/naauLmVRcSWt/0
	 uDxmNS+IhPBHg==
Date: Tue, 03 Mar 2026 19:59:19 +0000
To: Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
From: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, netfilter-devel@vger.kernel.org, coreteam@netfilter.org, "Remy D. Farley" <one-d-wide@protonmail.com>
Subject: [PATCH net-next v8 4/5] doc/netlink: nftables: Add sub-messages
Message-ID: <20260303195638.381642-5-one-d-wide@protonmail.com>
In-Reply-To: <20260303195638.381642-1-one-d-wide@protonmail.com>
References: <20260303195638.381642-1-one-d-wide@protonmail.com>
Feedback-ID: 59017272:user:proton
X-Pm-Message-ID: e58a46e25e75575965f34bab2175ffd5eff5ef71
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: AF5A31F692D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[protonmail.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[protonmail.com:s=protonmail3];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263402-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[netfilter.org,strlen.de,nwl.cc,vger.kernel.org,protonmail.com];
	DKIM_TRACE(0.00)[protonmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[one-d-wide@protonmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[protonmail.com];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[protonmail.com:dkim,protonmail.com:email,protonmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

New sub-messsages:
- log
- match
- numgen
- range

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
Signed-off-by: Remy D. Farley <one-d-wide@protonmail.com>
---
 Documentation/netlink/specs/nftables.yaml | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/Documentation/netlink/specs/nftables.yaml b/Documentation/netl=
ink/specs/nftables.yaml
index ba62adfb4..086b16b12 100644
--- a/Documentation/netlink/specs/nftables.yaml
+++ b/Documentation/netlink/specs/nftables.yaml
@@ -1480,15 +1480,24 @@ sub-messages:
       -
         value: immediate
         attribute-set: expr-immediate-attrs
+      -
+        value: log
+        attribute-set: log-attrs
       -
         value: lookup
         attribute-set: expr-lookup-attrs
+      -
+        value: match
+        attribute-set: compat-match-attrs
       -
         value: meta
         attribute-set: expr-meta-attrs
       -
         value: nat
         attribute-set: expr-nat-attrs
+      -
+        value: numgen
+        attribute-set: numgen-attrs
       -
         value: objref
         attribute-set: expr-objref-attrs
@@ -1498,6 +1507,9 @@ sub-messages:
       -
         value: quota
         attribute-set: quota-attrs
+      -
+        value: range
+        attribute-set: range-attrs
       -
         value: reject
         attribute-set: expr-reject-attrs
@@ -1507,6 +1519,9 @@ sub-messages:
       -
         value: tproxy
         attribute-set: expr-tproxy-attrs
+        # There're more sub-messages to go:
+        #   grep -A10 nft_expr_type
+        # and look for .name\s*=3D\s*"..."
   -
     name: obj-data
     formats:
--=20
2.51.2



