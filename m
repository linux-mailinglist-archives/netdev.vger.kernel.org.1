Return-Path: <netdev+bounces-307186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1Uc2AKLsVGpNhQAAu9opvQ
	(envelope-from <netdev+bounces-307186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:48:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C73B74BDC3
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 15:48:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=VH7hRci+;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307186-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-307186-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6C443040D9B
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 13:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F12420871;
	Mon, 13 Jul 2026 13:46:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB23427A04;
	Mon, 13 Jul 2026 13:46:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783950378; cv=none; b=fn3DlLHCxVHIv6ytvjLC5lHtE43T7lxgPC4QfCdUceA/mD2cJd1a0eNr+tj+shlKEtyl/ytN8xs4LR2LbVau6oie6XpQwTUJ8jZ9rpn5dYCo0XZFMuva6Ci1HZy+NiIwYf+89eoCiZsw7fHMioP0Ugk6IaMfU8Fy14eFwtaXB9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783950378; c=relaxed/simple;
	bh=Xq63b95fnJWEWifXL9TwilpDNub7RhHfakC0HRER//U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hrukRXe68gtMP4Em0xT4/H7FD9a+Cn1kMcc0Bm2mvJbrwjVHBAdeem2BSqW1S+zRdVS7i5CZ3GZs7a0O4n8B2mLJuXLZmAu1XpIDwDjr4ZonVOPgVFlaktnlaB1m0M7XJdYzGs5ckttxJgOXjFAXbdHzGTcNPkL1E43LJBnU6xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VH7hRci+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E9D1F00A3A;
	Mon, 13 Jul 2026 13:46:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783950376;
	bh=C7RB5+tejbIxG7f2sHs02Xqkdz1T/+FU8q47R7ERcKo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VH7hRci+jWfBxRlRGHexCrDf5994tjSE0Vg84RhXi0Cb0zLQE0I16ImcpnjC3xoTO
	 xKONGufNzo2HnM1MAsSsN4Efw3CootgW46sn79LTwrr0gfXAqB7RxVojGbeO20MhG1
	 B7q0stzsmEiEQ9CodCLpPa9nRMb6LE145sYlFqqXZA6WlFmszrQLWcsv8FrK6AlN37
	 O8U5KcJ95Xd70N5yQYZsNU/UFeGrNWPdeMAt5dqjD+7sM5o5aSJ3/IYAZphWnCYTJ2
	 +vr1btNU7nw15LdhDxGyrba7aFcW9UOQ7f+t9KWFdAPHMRR4gEGxpnJwQZvA4f3YNm
	 /q2kxMi8L1Ebg==
From: Simon Horman <horms@kernel.org>
To: bestswngs@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	jmaloy@redhat.com,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	hoang.h.le@dektech.com.au,
	xmei5@asu.edu,
	linux-kernel@vger.kernel.org,
	tung.quang.nguyen@est.tech
Subject: Re: [PATCH net v2] tipc: fix NULL deref in tipc_named_node_up() on empty publication list
Date: Mon, 13 Jul 2026 14:46:10 +0100
Message-ID: <20260713134610.1779498-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260706163024.1205930-2-bestswngs@gmail.com>
References: <20260706163024.1205930-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:bestswngs@gmail.com,m:horms@kernel.org,m:jmaloy@redhat.com,m:netdev@vger.kernel.org,m:tipc-discussion@lists.sourceforge.net,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:hoang.h.le@dektech.com.au,m:xmei5@asu.edu,m:linux-kernel@vger.kernel.org,m:tung.quang.nguyen@est.tech,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-307186-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6C73B74BDC3

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
tipc: fix NULL deref in tipc_named_node_up() on empty publication list

This commit fixes a NULL pointer dereference in tipc_named_node_up() that
occurs when the cluster_scope publication list is empty. The fix introduces
an early return to avoid calling named_distribute() with an empty list.

> diff --git a/net/tipc/name_distr.c b/net/tipc/name_distr.c
> index ba4f4906e13b7..60ccaa862162c 100644
> --- a/net/tipc/name_distr.c
> +++ b/net/tipc/name_distr.c
> @@ -218,6 +218,10 @@ void tipc_named_node_up(struct net *net, u32 dnode, u16 capabilities)
>  	spin_unlock_bh(&tn->nametbl_lock);
>  
>  	read_lock_bh(&nt->cluster_scope_lock);
> +	if (list_empty(&nt->cluster_scope)) {
> +		read_unlock_bh(&nt->cluster_scope_lock);
> +		return;
> +	}

[Severity: Critical]
Does this early return prevent the transmission of the last_bulk
synchronization message to the peer node?

In tipc_named_dequeue(), the peer node sets *open = true only when receiving
a message where msg_is_last_bulk(hdr) is true:

net/tipc/name_distr.c:tipc_named_dequeue() {
        ...
        if (*open && (*rcv_nxt == seqno)) {
                (*rcv_nxt)++;
                __skb_unlink(skb, namedq);
                ...
                return skb;
        }
        ...
}

If *open is false, all subsequent non-bulk name publications will fail this
sequence check and remain in the namedq indefinitely. 

Without sending the last_bulk message, could this cause a permanent stall
of name table updates and an unbounded memory leak of socket buffers on the
peer node?

>  	named_distribute(net, &head, dnode, &nt->cluster_scope, seqno);

[Severity: High]
This isn't a bug introduced by this patch, but looking at named_distribute()
called here, what happens if buffer allocation fails during the loop?

Inside named_distribute():

net/tipc/name_distr.c:named_distribute() {
        ...
        if (!skb) {
                skb = named_prepare_buf(net, PUBLICATION, msg_rem, dnode);
                if (!skb) {
                        pr_warn("Bulk publication failure\n");
                        return;
                }
        ...
}

If the function returns early due to allocation failure, the messages
already added to the queue are transmitted by tipc_node_xmit(), but none
of them will have the last_bulk flag set since that happens at the very end
of the function.

Could this also prevent the receiving node from transitioning its named_open
state to true, leading to the exact same permanent stall and memory leak of
subsequent normal name publications?

>  	tipc_node_xmit(net, &head, dnode, 0);
>  	read_unlock_bh(&nt->cluster_scope_lock);
-- 
pw-bot: changes-requested

