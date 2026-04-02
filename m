Return-Path: <netdev+bounces-274332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC9kK+jYzWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:48:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02654382D31
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:48:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DCA8130034AE
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4224D30E84B;
	Thu,  2 Apr 2026 02:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvj8JC+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8F530E0FD
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 02:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775097955; cv=none; b=J6Bm/EN53EHAOQJ9+nM0oRkh7TFHdrRJMIGqzbYTf874vxQWtwg08SdI8Agu4YJpsJpTam+ATHEDuHmjBB+dncZIfWGmWn/s4dbDL3IdyXjnfnj15Xsc3w1utV5Bp98QViv5ioBPgwcENMfxRxY+Eg3vPooNotAinOoJJ/UJqIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775097955; c=relaxed/simple;
	bh=jZA+cGoTEquEaBsiIGcwX+LtEMWX7AzvfV0frxPFh/I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nVQESq9HNyCwqJoSqr4APBHIf+8UI1Q9UuflO7rqueVaQnyESCwEHKPbLSJE84ImjsX7olrDihK97+AOXJmI/eyQfyQsvhzrt0or1zyeVDP3q/o2syjO4rWmGpiRqxEAqMGHUlov6QiY7ovZVkIg7UUcTK4sf0Df2wXxkvBdtlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvj8JC+M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AAE2C4CEF7;
	Thu,  2 Apr 2026 02:45:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775097954;
	bh=jZA+cGoTEquEaBsiIGcwX+LtEMWX7AzvfV0frxPFh/I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Cvj8JC+M62mxb4EYaJkDvKZCDE4LzXJ/tvUHQH55/a3JT3Q6RaEQfdAK6pmLVCGJG
	 WDrqXhtGAlwyjjZyi+6mqQv43bAqu9jlm/qbfEoWO3Kuv6lMIcC1qi2GOB31hHkd6U
	 NMY/aU7wrs1ha4gsxIL+DJoL0yfZi4Nf9LkYWKbHc0j/HWW6cPzDIrG6qGM3evM+Ga
	 15GO3M/GW6mZsIDqfxepLovMW2TIwEuBnwpuC5Ci+UG5RSp3wLiIEgEx6sKgFaVdTK
	 rdHRI6890xT7bgvX1bPWcrkof1RBUwNlR7PQXVYmWnAVr9UN0OW/FZGTb7nhGAJSuc
	 PrmV3SIMt9dyg==
Date: Wed, 1 Apr 2026 19:45:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nikolaos Gkarlis <nickgarlis@gmail.com>
Cc: netdev@vger.kernel.org, kuniyu@google.com
Subject: Re: [PATCH net v4] rtnetlink: add missing netlink_ns_capable()
 check for peer netns
Message-ID: <20260401194553.6e8a17f8@kernel.org>
In-Reply-To: <20260328213338.450601-1-nickgarlis@gmail.com>
References: <20260328213338.450601-1-nickgarlis@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274332-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 02654382D31
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 28 Mar 2026 22:33:38 +0100 Nikolaos Gkarlis wrote:
> -static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
> +static struct net *rtnl_get_peer_net(struct sk_buff *skb,
> +				     const struct rtnl_link_ops *ops,
>  				     struct nlattr *tbp[],
>  				     struct nlattr *data[],
>  				     struct netlink_ext_ack *extack)
>  {
>  	struct nlattr *tb[IFLA_MAX + 1];
> +	struct net *net;
>  	int err;
>  
>  	if (!data || !data[ops->peer_type])

There's an early return hiding outside of the context here.
the patch is technically correct, I think, because if we take this
shortcut we end up with the same netns as tgt_net so we'll validate
that it's capable later. But it's probably not obvious to a casual
reader of this code (or AI agents, sigh)

So let's rewrite this along the lines of:

        struct nlattr *tb[IFLA_MAX + 1], **attrs;
        struct net *net;
        int err;
 
        if (!data || !data[ops->peer_type]) {
               attrs = tbp;
	} else {
        	err = rtnl_nla_parse_ifinfomsg(tb, data[ops->peer_type], extack);
	        if (err < 0)
        	        return ERR_PTR(err);
 
	        if (ops->validate) {
        	        err = ops->validate(tb, NULL, extack);
                	if (err < 0)
	                        return ERR_PTR(err);
        	}
 
		attrs = tb;
	}

        net = rtnl_link_get_net_ifla(attrs);
        if (IS_ERR_OR_NULL(net))
                return net;
 
        if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
...

?

> @@ -3915,7 +3917,16 @@ static struct net *rtnl_get_peer_net(const struct rtnl_link_ops *ops,
>  			return ERR_PTR(err);
>  	}
>  
> -	return rtnl_link_get_net_ifla(tb);
> +	net = rtnl_link_get_net_ifla(tb);
> +	if (IS_ERR_OR_NULL(net))
> +		return net;
> +
> +	if (!netlink_ns_capable(skb, net->user_ns, CAP_NET_ADMIN)) {
> +		put_net(net);
> +		return ERR_PTR(-EPERM);
> +	}
> +
> +	return net;

