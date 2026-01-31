Return-Path: <netdev+bounces-255546-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id bqDfK7GTfml6awIAu9opvQ
	(envelope-from <netdev+bounces-255546-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:43:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF6C4637
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 00:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4BF70300F9C8
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181E9389E1A;
	Sat, 31 Jan 2026 23:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mNff3gl2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5242F90C5;
	Sat, 31 Jan 2026 23:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769903021; cv=none; b=IajtgUjNLjxEyTReA5CHJphG1L0H0GwJWUjGBoBOpt7M5/udtYKEJ5isyd4q2PC0sSBcXiK/fFWEKzRv6adk3h8Ifpy7+z0BMrySBy865NTkMgeZbyZ2DhvETRxpAsdK+jBpB8eq34+mAY4eainXwhXWGONpJh3y7S22XVua8I4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769903021; c=relaxed/simple;
	bh=7YxeSSCc50++u6wdURteD83+RX8mp/2o//1rcx1Nwu0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7xSgP56JR+nICeyJPS+NlP67ORElDNKjLEuUaAkkcpoedC+mvhM0eLE66griYC7SUOoy/9Ao5INzQ6/Ih1eUWDRPR2NyolJhUZw/YMpQtXZ9lamGwlYVn2t62yz0Y5Jpj9ZEy05EikJEI9v3op3zUI5OKw/ze53RN20pTUJ8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mNff3gl2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B6DC4CEF1;
	Sat, 31 Jan 2026 23:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769903020;
	bh=7YxeSSCc50++u6wdURteD83+RX8mp/2o//1rcx1Nwu0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mNff3gl2LuIFdKj4cVoWWs62TnJwSgKeFEljS1pr5T6TTevNe95D+iy8peE9VWAAF
	 3X0BMHgPW2NHZ7il7f2abGm602gT0Kj6d3V3nQ6Ly08n/wS4XrU+nuD08VAWssB7Qv
	 1KAbvr8l318KlswhaoVhrzk3wAAnqDwCBI7lCL1/wTWxZskQwUxdTCkejbqysrzP4x
	 JMsLXUpP3DWNzBiCOO/C6OpPK7tn3oo4rEEHyokRDpr0antnFeug7j0/fXWN3zeLSb
	 Prlk6edeUkDszPAOUEopIEiOp9KqET7RRJFNPw+WEwVt2tSbYYwctN1B+V9zDS8gcm
	 YrO/4UIR5SyGA==
Date: Sat, 31 Jan 2026 15:43:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 razor@blackwall.org, pabeni@redhat.com, willemb@google.com,
 sdf@fomichev.me, john.fastabend@gmail.com, martin.lau@kernel.org,
 jordan@jrife.io, maciej.fijalkowski@intel.com, magnus.karlsson@intel.com,
 dw@davidwei.uk, toke@redhat.com, yangzhenze@bytedance.com,
 wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 03/16] net: Add lease info to queue-get
 response
Message-ID: <20260131154338.4d6b36a2@kernel.org>
In-Reply-To: <20260129222830.439687-4-daniel@iogearbox.net>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-4-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255546-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,davidwei.uk,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E9BF6C4637
X-Rspamd-Action: no action

On Thu, 29 Jan 2026 23:28:17 +0100 Daniel Borkmann wrote:
> Populate nested lease info to the queue-get response that returns the
> ifindex, queue id with type and optionally netns id if the device
> resides in a different netns.

> +enum netif_lease_dir {
> +	NETIF_VIRT_TO_PHYS,
> +	NETIF_PHYS_TO_VIRT,
> +};
> +
> +struct netdev_rx_queue *
> +__netif_get_rx_queue_lease(struct net_device **dev, unsigned int *rxq,
> +			   enum netif_lease_dir dir);

dev.h

>  #endif /* _LINUX_NETDEV_RX_QUEUE_H */
> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> index a0b4a9197b91..7d073894ca74 100644
> --- a/net/core/netdev-genl.c
> +++ b/net/core/netdev-genl.c
> @@ -391,8 +391,11 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  			 u32 q_idx, u32 q_type, const struct genl_info *info)
>  {
>  	struct pp_memory_provider_params *params;
> +	struct net_device *orig_netdev = netdev;
> +	struct nlattr *nest_lease, *nest_queue;
>  	struct netdev_rx_queue *rxq;
>  	struct netdev_queue *txq;
> +	u32 lease_q_idx = q_idx;

No need to init this, no?

>  	void *hdr;
>  
>  	hdr = genlmsg_iput(rsp, info);
> @@ -410,6 +413,37 @@ netdev_nl_queue_fill_one(struct sk_buff *rsp, struct net_device *netdev,
>  		if (nla_put_napi_id(rsp, rxq->napi))
>  			goto nla_put_failure;
>  
> +		if (netif_rx_queue_lease_get_owner(&netdev, &lease_q_idx)) {

Does it work if we factored this out to a helper?

Also apparently the words lessee and lessor are legit English words.

I wonder if using those would make the code quite a bit easier to
follow when we have to refer to the lease in a specific direction.

