Return-Path: <netdev+bounces-260606-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IKTvN9vdnWmuSQQAu9opvQ
	(envelope-from <netdev+bounces-260606-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:20:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2DA18A778
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09A7D3054236
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A9F423EAA0;
	Tue, 24 Feb 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyNFKDu9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EF923E346
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 17:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771953544; cv=none; b=j+WJ3G2Kwzpc9OqrdI63BdxMs7A8/2tsaFncbo9u4/YUT7YA0CZma+nNqnP6q1c5GhcV/5DyRFzp/NvBKA1AXpB+3hFW5ffztCOkJlK0HplhPSNQ2TRYl/jVxO4mVtY/ULaD4k7b3Ju8pmfZriAM+R2Bb3/mgHIlFMArDp4gt0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771953544; c=relaxed/simple;
	bh=i900DRGWs6LR6oE7M0VKybLNsNo5+GIYgR2gjE2Mip8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pz+EmQZEJLtQrDCg7mvRHrFRuDudozVMI7D/VR5uacHVqV/WA0+A6prqXAuHnjxGWGmQjAQOeAHaSThKj2I9Umh6qQVHeATLSpcbLC6wNDtGuMilVhF2ZMXg16aO1FH1HahVPubEUC2aszvvlx9vAlly8h2T43LDBgyK4vXLO7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyNFKDu9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F709C116D0;
	Tue, 24 Feb 2026 17:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771953544;
	bh=i900DRGWs6LR6oE7M0VKybLNsNo5+GIYgR2gjE2Mip8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cyNFKDu9Xm71SYg65fcSRPY3cSRewxuHFC9UEN/Vz0mN2qSWzUQ0uGI+CFFL7kjsP
	 7FssG/8hs+EC+xCGW+YW7dVqzJtI+uMjBtmsLf7YBHUQXMKHYjKL06kIGSTOYev8Dm
	 wrqHVlAFwxHiKU7fMDazh2FcNGI51fqqGnmx1jE1RRl//AsoWHmKBdzAIZ9VjjERTf
	 pPRUz02N5WmrZTJOry3C5oVfXOyRN2VjoefK5GYcE0bAcWbBmi79uo4i8t+gTXVMnA
	 qc+hEm2jdY3Ccidh+PKApfD3dJ+J9oBl374o9TAqn990MXj6j2QFoSQwyAAmYO+sK2
	 NuDFl7gmAlT4g==
Date: Tue, 24 Feb 2026 17:19:00 +0000
From: Simon Horman <horms@kernel.org>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	tgraf@infradead.org
Subject: Re: [PATCH 2/2 net-next] ipv4: bump rt_genid when a relevant devconf
 value changes through netlink
Message-ID: <aZ3dhDV6Fai9zbgV@horms.kernel.org>
References: <20260223153045.32044-1-fmancera@suse.de>
 <20260223153045.32044-2-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223153045.32044-2-fmancera@suse.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-260606-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,suse.de:email]
X-Rspamd-Queue-Id: 5C2DA18A778
X-Rspamd-Action: no action

On Mon, Feb 23, 2026 at 04:30:45PM +0100, Fernando Fernandez Mancera wrote:
> When modifying IPv4 devconf values using netlink for some relevant
> fields the rt_cache_flush() call was missing. In addition, if forwarding
> is enabled on the interface then disable LRO.
> 
> This is needed to avoid possible connectivity issues and ease the
> responsabilities of user space tools.
> 
> Fixes: 9f0f7272ac95 ("ipv4: AF_INET link address family")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
>  net/ipv4/devinet.c | 23 ++++++++++++++++++++++-
>  1 file changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 590c68e979f5..9f55c13a9c1f 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -2159,6 +2159,8 @@ static int inet_set_link_af(struct net_device *dev, const struct nlattr *nla,
>  {
>  	struct in_device *in_dev = __in_dev_get_rtnl(dev);
>  	struct nlattr *a, *tb[IFLA_INET_MAX+1];
> +	struct net *net = dev_net(in_dev->dev);
> +	bool flush_cache = false;
>  	int rem;
>  
>  	if (!in_dev)

Hi Fernando,

Here it is assumed that in_dev may be NULL.
But a few lines above it is now dereferenced unconditionally.

Flagged by Smatch.

-- 
pw-bot: cr

