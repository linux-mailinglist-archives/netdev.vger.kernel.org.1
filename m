Return-Path: <netdev+bounces-278178-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SG+sFDM43Wk3awkAu9opvQ
	(envelope-from <netdev+bounces-278178-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:38:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E66893F2294
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 133543011176
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 18:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05AE38CFE4;
	Mon, 13 Apr 2026 18:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="OFg5MZpb"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4B38C431;
	Mon, 13 Apr 2026 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105519; cv=none; b=ftnGnyfhPxW3BcEs0oOwwKUUdgTvB+hvZdMEj1wfcH2bIpctiaigV3bwCRAv/FTElHFqvIPxsJ9fC1E2RbyHIZiDHDwijxrrhx+zIkOXISl1SmW8bGyELf+wZoZYGiRPKCsHdrTSr/+qX8/MfHzxuZSw9AbfpXHz2URNeEEaC6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105519; c=relaxed/simple;
	bh=Z+PybH0v/8zQfn1t6sVkaec9wuVix0JrSRz6VyP98xo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eXH2eOhJMP2UiVn1iokG1z4aehYln9yOYfZB3O+5zogvl9zxup/Rj2uZjxQF8lduDPSvfUlrMRemClwS9VBuDEOzbQhELhlorzHAY1q1Pn4iPdcUoJO6wUamUFuIGRqMf46rGraGZydfuLL6WGRHnHZ41YnpBMsHQSealUrre30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OFg5MZpb; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RiJEzJ8eTjeiFv8P6UZ6cKxNVQf/7faTUhy5gtzeM1g=; b=OFg5MZpbXQnaCr+FvINNlc3ASl
	YULz5W5EDTzl6aAciGL9fIm5gnVTz/3iZUQeTOxWJz3uDOK8oTo4Zk0lJofoeMfN2F7kzb4CwnvDj
	TyvLdTywPaMWS8B3H8KfEuYsDY0equsi3yZTJAR91eAeBS+jFlTIs4Kb6JGhUuqLv3RDG8gk/LwiI
	XUdEtIhIo36Zo1BTXAm5XpQusKmlxF+JZY2gmrJl7AW9M6TbXdYY5nLgYHpO+IouurDLL3bicCz1q
	1ToxqAUuAgFH7rXmVsoTXkWLyZL3cM7pNpZlldevrEE5OkjBds7kIgFLTD6rJECzmqtl9J+HxRxqA
	hKWkSOWw==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCMB4-000Pfr-0q;
	Mon, 13 Apr 2026 20:38:30 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy06.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCMAW-000Lu1-0G;
	Mon, 13 Apr 2026 20:38:29 +0200
Message-ID: <bfccb5ef-d5a0-451d-88b3-65dc84ceebc1@iogearbox.net>
Date: Mon, 13 Apr 2026 20:38:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: check qdisc_pkt_len_segs_init() return
 value on ingress
To: David Carlier <devnexen@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Kuniyuki Iwashima <kuniyu@google.com>,
 Samiullah Khawaja <skhawaja@google.com>, Hangbin Liu <liuhangbin@gmail.com>,
 Krishna Kumar <krikku@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260413182225.10683-1-devnexen@gmail.com>
Content-Language: en-US
From: Daniel Borkmann <daniel@iogearbox.net>
Autocrypt: addr=daniel@iogearbox.net; keydata=
 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
In-Reply-To: <20260413182225.10683-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27970/Mon Apr 13 08:24:33 2026)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,fomichev.me,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-278178-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E66893F2294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/13/26 8:22 PM, David Carlier wrote:
> Commit 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> changed qdisc_pkt_len_segs_init() to return an skb drop reason when
> it detects malicious GSO packets. The egress path in __dev_queue_xmit()
> checks this return value and drops bad packets, but the ingress path in
> sch_handle_ingress() ignores it.
> 
> This means malformed GSO packets entering via TC ingress are not dropped
> and could be redirected to another interface or cause incorrect qdisc
> accounting.

Why we need to do this on both sides (and what's the perf impact)? If TC
ingress redirects it to some other device, then don't we hit the same via
__dev_queue_xmit() where the 7fb4c1967011 added the qdisc_pkt_len_segs_init()?

> Check the return value and drop the packet when a bad GSO is detected.
> 
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
> 
> v1 -> v2: reorder variable declarations for reverse xmas tree
> v1: https://lore.kernel.org/netdev/20260408172307.46498-1-devnexen@gmail.com/
>   net/core/dev.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 5a31f9d2128c..d11c22cafca9 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4459,8 +4459,8 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>   		   struct net_device *orig_dev, bool *another)
>   {
>   	struct bpf_mprog_entry *entry = rcu_dereference_bh(skb->dev->tcx_ingress);
> -	enum skb_drop_reason drop_reason = SKB_DROP_REASON_TC_INGRESS;
>   	struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
> +	enum skb_drop_reason drop_reason;
>   	int sch_ret;
>   
>   	if (!entry)
> @@ -4472,7 +4472,15 @@ sch_handle_ingress(struct sk_buff *skb, struct packet_type **pt_prev, int *ret,
>   		*pt_prev = NULL;
>   	}
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
>   	tcx_set_ingress(skb, true);
>   
>   	if (static_branch_unlikely(&tcx_needed_key)) {


