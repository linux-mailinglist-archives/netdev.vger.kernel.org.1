Return-Path: <netdev+bounces-277867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wO6LC77i22lOIQkAu9opvQ
	(envelope-from <netdev+bounces-277867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:21:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 999773E5603
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3899E3009986
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797712E5B1B;
	Sun, 12 Apr 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ILmDpHmm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56890150997;
	Sun, 12 Apr 2026 18:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776018105; cv=none; b=nhG/mxSAou8ihqJPc8nPrBoAaPwo1+zrHyu+llrqntKj+10m1Avw+P/fNhF94hCYH+aEsxplTkt0Xdz0N9xReeY2jMrUYOozjTp4gxaDdbSRj3DlH4/KzeYbRveWTHOyc9AjgnZpozwQ+xiEphsu1dSCl21a4FhQml29620dbo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776018105; c=relaxed/simple;
	bh=Umub7q+trBwt23P1YLCCuab8C7yKrqAGLZRQd3B9zNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=puWQ9qbKiXQtFDUNKM1m/MUZfgyeY6aKkzvpJpJmL17o/zdUEpjiVmXYN1JVUuPobmkEbBKDesr9FhWHrk/ZwEHD+zcNhC7YJ1MRK/m49RzWvj6OwvtBMtWTnveWYqtiRiD+WxYl2F/abHhLKhAKV1qimw0R8qIrGrpE6Ly0DZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ILmDpHmm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6EBEC19424;
	Sun, 12 Apr 2026 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776018105;
	bh=Umub7q+trBwt23P1YLCCuab8C7yKrqAGLZRQd3B9zNc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ILmDpHmm49IajNYVZV8Wnl7LQFtYVdMyKHAcPCVFH5s2qZW5e/hSRSb2FJnUukM4G
	 h98UTmPbmfaJCtU8KLNKf8LOlYA0EkBm37adyLtK5hiXRNhvXiACT4Xpqr9Uvuayiy
	 65E+CK+aRie8/JXK4391twD/lOgcYLflAwTWn2/nth9B/HhKUwR+PQ/V12o6UfMg8m
	 ohLJysYWUbNNUdtZGTZk7pk1GlS+yx3Uw7rzmK3QxVJnmCDlllduAnNd3FVKeMzISe
	 DFTFuYUk+2L6EOVziEk9heuDMe8a7gis0Ig8roQwhhULGX21XGNGHMvReXVHY2d5QL
	 NlgH7ItAtBurQ==
Date: Sun, 12 Apr 2026 11:21:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, sdf@fomichev.me, kuniyu@google.com, skhawaja@google.com,
 liuhangbin@gmail.com, krikku@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: check qdisc_pkt_len_segs_init() return value on
 ingress
Message-ID: <20260412112143.61aea041@kernel.org>
In-Reply-To: <20260408172307.172736-1-devnexen@gmail.com>
References: <20260408172307.172736-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277867-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,redhat.com,kernel.org,fomichev.me,gmail.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 999773E5603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed,  8 Apr 2026 18:23:07 +0100 David Carlier wrote:
> Commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> changed qdisc_pkt_len_segs_init() to return an skb drop reason when
> it detects malicious GSO packets. The egress path in __dev_queue_xmit()
> checks this return value and drops bad packets, but the ingress path in
> sch_handle_ingress() ignores it.
> 
> This means malformed GSO packets entering via TC ingress are not dropped
> and could be redirected to another interface or cause incorrect qdisc
> accounting.
> 
> Check the return value and drop the packet when a bad GSO is detected.
> 
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: David Carlier <devnexen@gmail.com>

Not sure this can happen today, but okay.
Hopefully we won't get a patch for every Sashiko report we knowingly
ignored :|

> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5a31f9d2128c..2b5f508fc479 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4459,7 +4459,7 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>  		   struct net_device *orig_dev, bool *another)
>  {
>  	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
> -	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
> +	enum skb_drop_reason drop_reason;

this needs to move one line down now to keep the variable ordering.

>  	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
>  	int sch_ret;
>  
> @@ -4472,7 +4472,15 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>  		*pt_prev = NULL;
>  	}
>  
> -	qdisc_pkt_len_segs_init(skb);
> +	drop_reason = qdisc_pkt_len_segs_init(skb);
> +	if (unlikely(drop_reason)) {
> +		kfree_skb_reason(skb, drop_reason);
> +		*ret = NET_RX_DROP;
> +		bpf_net_ctx_clear(bpf_net_ctx);
> +		return NULL;
> +	}
> +
> +	drop_reason = SKB_DROP_REASON_TC_INGRESS;
>  	tcx_set_ingress(skb, true);
>  
>  	if (static_branch_unlikely(&tcx_needed_key)) {
-- 
pw-bot: cr

