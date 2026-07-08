Return-Path: <netdev+bounces-305832-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SN+TOR1bTmrVLAIAu9opvQ
	(envelope-from <netdev+bounces-305832-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:13:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 762487272DF
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 16:13:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305832-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305832-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE8173047018
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 14:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED8D8416D05;
	Wed,  8 Jul 2026 14:03:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF76380FF4;
	Wed,  8 Jul 2026 14:03:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783519418; cv=none; b=FNV+vjpLRFmBF+p/ms+YCJ1bh0KbV4hQQHijznIRnrHkl9HzMMeDT3zdMV3vghe1+CuKwaX9fz9sBWyJBneCqPdaJyfMrL+K7Lrw6YlTu/z7f60zCY6TzXyGKi+3rtlEHDpInHYFLrXrnujsct8fv4yzBmUMwEDpmxGxCenK2mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783519418; c=relaxed/simple;
	bh=DxJqZLLdzpL1pm/8LsFefQqmbDOjFIOXZ2uxWg8ValI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqAmDpdedYxu0TWAOYEJug7s4mqVPw/zmhoGMTh4ElIgl7J3C8TEx5bidTt0MUnIHjD74jyfV3c857IJqg++DKLctp8ijwv9n5TRKdY9pqcz38j7koMrBZSM5g+sCUlKKgRGUUqF6dUAA0c9xUt+NJXLvKAPz+7P4/xJPyG49MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 54A906059E; Wed, 08 Jul 2026 16:03:36 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	<netfilter-devel@vger.kernel.org>,
	pablo@netfilter.org
Subject: [PATCH net 04/17] netfilter: ebtables: module names must be null-terminated
Date: Wed,  8 Jul 2026 16:02:56 +0200
Message-ID: <20260708140309.19633-5-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260708140309.19633-1-fw@strlen.de>
References: <20260708140309.19633-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:netfilter-devel@vger.kernel.org,m:pablo@netfilter.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-305832-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 762487272DF

We need to explicitly check the length, else we may pass non-null
terminated string to request_module().

Cc: stable@vger.kernel.org
Fixes: bcf493428840 ("netfilter: ebtables: Fix extension lookup with identical name")
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 net/bridge/netfilter/ebtables.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
index 48187598cdd0..96c9a8f57c87 100644
--- a/net/bridge/netfilter/ebtables.c
+++ b/net/bridge/netfilter/ebtables.c
@@ -403,6 +403,9 @@ ebt_check_match(struct ebt_entry_match *m, struct xt_mtchk_param *par,
 	    left - sizeof(struct ebt_entry_match) < m->match_size)
 		return -EINVAL;
 
+	if (strnlen(m->u.name, XT_EXTENSION_MAXNAMELEN) == XT_EXTENSION_MAXNAMELEN)
+		return -EINVAL;
+
 	match = xt_find_match(NFPROTO_BRIDGE, m->u.name, m->u.revision);
 	if (IS_ERR(match) || match->family != NFPROTO_BRIDGE) {
 		if (!IS_ERR(match))
-- 
2.54.0


