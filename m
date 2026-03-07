Return-Path: <netdev+bounces-265159-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDn2JwJfrGmlpAEAu9opvQ
	(envelope-from <netdev+bounces-265159-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:23:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A61222CEEC
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 18:23:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 14D96300F946
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 17:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B0313556;
	Sat,  7 Mar 2026 17:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVmTxiki"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43294311959
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 17:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772904192; cv=none; b=DPOM1kHNoycoLWXbURJ0Cvrsh8Otab8tXC2HdtZD6etdFWUL763vqeLxZmFTOeCV9czI+22j75xY5L6cZr2F4ubWPYU4A/lPR3VrgEf3+dWJic++JVkDi2+7iUUj1r53ONNHGZlblqKqZAZgsRNz4tgDpsdU7nK83q7/BI3T/wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772904192; c=relaxed/simple;
	bh=BzOM1lldFOAMXywLTI7LATbp2773HuhGfEVLnhYc+Io=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=i3LlmefndcJB0RueWvB+c/yjxcONjW6bA1iMBFffcE7QdgHmranr8QLn4kigmQu0YD5CzoDD9U9Nc8dgi5He5Voj6izbpQ2qsc30B/SY3hyCJPiRTGHLqwMDTWkfv9dUPiQ33vspJcMh9sIet1IyZWjs+6lTIYnMqgk+vHE6WTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVmTxiki; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c7393536e53so1099310a12.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 09:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772904191; x=1773508991; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1RMexYaZxcgHftIV215qI4ewau8GuOaml5QTVuKL44=;
        b=QVmTxiki6Y4k/gqMXm5Am/9Elyvs31EOQ0dhLegniSRMcG3Tqa0eWZuUFfdN7gMWT1
         4jJy2scIbICKgHYvLjTRGOeRkvV2YH32AjiGXIXEZO9f7TzOa8OeTg4q3eDI6BuGCRm0
         1ZqemTHZ//CfBZacHU4KM9h9HtYbDoKSQPezvU/p9oTggEPrLsgPjm8MlxPceha3e8BL
         q/J5TJOspTsYZwCUgSa+WLfFu+WkRPalEvO7EhvIniNEttZ1vmSG0l+gt5g+Cz/xqLTS
         bAkWUDUPgtXafiNkH009Tx102Q58BoeU67Iaaf1ghHs1EZzQ7I5LSRiMZCoY5jtvcapj
         hwHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772904191; x=1773508991;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g1RMexYaZxcgHftIV215qI4ewau8GuOaml5QTVuKL44=;
        b=tSCtvBwU8RFJVWRbnCe8M1lHjCvTy4TiMDTwkSVW818nvXZ1lCDSoPu2FXqt9IR2Ij
         eX3QTmhirheK7Li2chmBltjSrySZCmbYEJ+jFBiBjHye7EpJSaHL5Oc7eeZinHrTaOAj
         AyOMPKKyBnJAfzqyykw51DTthaXAS0dioisf98Q+Dk3BrVDntjlY+HeTPR4EzA+V8BBy
         6apLhhUdEUp+nG6ZxcimwBcmT6lWKvRe3+wdUjztUSZqUdgvIOYf3GVtujc7ndGl/GUk
         p+FGCtiIzTdJGl94DVp5Z+Y7ThmPNsDHc0K/WQLKesQhZkZEjy3NHERaqc102G10DJVQ
         eC9w==
X-Forwarded-Encrypted: i=1; AJvYcCWTZcbH8cfsX6cW0LvWhSEaNIiwmtPVCDtXO8MsTAU1LNKqJ4kF6wzVlHjIJVS7FkaZ+9a5Oac=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgDUw4S4Xh+sPY21bkvndX74KFfRo6/Ti02DNqbxHZ/ZVZzSHT
	FdbUQ9VwZE2XiMY5D4JMdMUIUEkToWU+Rq08YLKoGKvoYj/riGV5x0IlZHXvQw==
X-Gm-Gg: ATEYQzyigGFY+PXYO4swKMOjX7Ek2MowlN14UOXFhaZqtT9IzM9xcDOlP9kZRaZOQv1
	hBXYJR/wOHqceC8iFuyiFeOgywaD+5jsPoJgXNPz7OeiiS2kHyb/ozGAcjAW6q3pPgYJmUm1sYL
	Vff8dh5fMWNXAzexSxafIvwuFMbZXLvsOXjuz1llJWNB2CSnrKoeNItsqJUk5E9RLGuJJA/R1bL
	n/jPvWputTnJckaeCR85gqfBCad+hGe0StrYspD0jmOer4NBrgJBzq7rQXYn/r8vU1gvVJpSGuH
	0Oc92ryRKacV/cN+PD6udF8H0vKUyiqeaiuy4a72cE4PzSNObCEk6YuJfC9ZkBxP77OunCM8Rqw
	Kz1KJxv2wI494x14stvJ0mz+2MskYUg6MGKwQ2QZ47zwurEhiSKClgTosyZFahDkmw/vmtIdNSA
	YSdY14AgPow94/kO70OJXplg9168CSeD4CJI+yw0emag==
X-Received: by 2002:a05:6a20:cf85:b0:334:a681:389c with SMTP id adf61e73a8af0-39858fb290dmr5932235637.15.1772904190618;
        Sat, 07 Mar 2026 09:23:10 -0800 (PST)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c739dfbf4fesm4853022a12.0.2026.03.07.09.23.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 09:23:10 -0800 (PST)
Date: Sun, 8 Mar 2026 02:23:06 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org
Cc: netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: [PATCH net] netfilter: nf_flow_table_offload: fix heap overflow in
 flow_action_entry_next()
Message-ID: <aaxe-uH2Qr6qM4E9@v4bel>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 1A61222CEEC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265159-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.931];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

flow_action_entry_next() increments num_entries and returns a pointer
into the flow_action_entry array without any bounds checking.  The array
is allocated with a fixed size of NF_FLOW_RULE_ACTION_MAX (16) entries,
but certain combinations of IPv6 + SNAT + DNAT + double VLAN (QinQ)
require 17 or more entries, causing a slab-out-of-bounds write in the
kmalloc-4k slab.

The maximum possible entry count is:
  tunnel(2) + eth(4) + VLAN(4) + IPv6_NAT(10) + redirect(1) = 21

Increase NF_FLOW_RULE_ACTION_MAX to 24 (with headroom) to cover the
worst case.

Fixes: efce49dfe6a8 ("netfilter: flowtable: add vlan pop action offload support")
Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
---
 net/netfilter/nf_flow_table_offload.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_flow_table_offload.c b/net/netfilter/nf_flow_table_offload.c
index 9b677e116487..e843f6d0355e 100644
--- a/net/netfilter/nf_flow_table_offload.c
+++ b/net/netfilter/nf_flow_table_offload.c
@@ -727,7 +727,7 @@ int nf_flow_rule_route_ipv6(struct net *net, struct flow_offload *flow,
 }
 EXPORT_SYMBOL_GPL(nf_flow_rule_route_ipv6);
 
-#define NF_FLOW_RULE_ACTION_MAX	16
+#define NF_FLOW_RULE_ACTION_MAX	24
 
 static struct nf_flow_rule *
 nf_flow_offload_rule_alloc(struct net *net,
-- 
2.43.0


