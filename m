Return-Path: <netdev+bounces-151338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E529EE3D0
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 11:12:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9986B28795F
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 10:12:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F1C2101A0;
	Thu, 12 Dec 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODxq46j9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABD7220FA8A
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 10:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733998320; cv=none; b=F7/WOHt5hQ8P3IiDnyYYgqROlkGbMPQF2500+491moANE1o+HvmGnH++FcFDqWB5ZBsup9zhYTHSHW9vKnneLG9t3+MFaZiUcV86Wre2UfO6uUKHDzWmCjnbfMJ+0oLLIky32LP5xOLjBAQ1aUjt6k+3g8A+HiiLiqZeluZzGBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733998320; c=relaxed/simple;
	bh=tz/PR/oOH4PSpF2A5K68wm2YyiXmiwOjbScvrXg19Ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bLzqkPEtJ4i2oVnuNjSWAcwpG6fFvohsbMGCitNhoT59SSyPLS4zLXfW3b9iejUQddmqgEkGST8Lok9HldLAgcty+gFsqJMLvTSqwdvRgdO07N67yDwtxg03wJnCHzKqZ8EB7wkfTcgl77mocMiQYykdXr4G1z0fUx68SESFB2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODxq46j9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7138C4CED1;
	Thu, 12 Dec 2024 10:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733998320;
	bh=tz/PR/oOH4PSpF2A5K68wm2YyiXmiwOjbScvrXg19Ac=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ODxq46j9ufJi/H9YVf+0luqzNbqdCBzfx5s4eeu1D1nRGeyxdVx03WGWz0rRw468H
	 x4PHeq6Q0T4jA8WVR0/nw8P/OkXBMKPGKvhB4zXEgTrfWtwq3OgTofEytsea3KqOA9
	 7sHk9k6cULpTs4JxJF6oqGekJ5mrkZ0JPVNpRdN7yL2dQkfSlDUhgsm+tr+DwKVg4f
	 RNm1pdhdfHOmBOzwZTfuY28yvvmkzuj4IjjwDCcOTIubjRsJGscZLjIyqoFq0Bq1xG
	 WkDemzeuRumWTvbCuQcRrYKlOYjfU4HhYd44L7wdF8lK1L/HItc/RoKmjVRA6FT+rX
	 nCdkHkf4vFJBQ==
Date: Thu, 12 Dec 2024 10:11:56 +0000
From: Simon Horman <horms@kernel.org>
To: Uday Shankar <ushankar@purestorage.com>
Cc: Breno Leitao <leitao@debian.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH] netconsole: allow selection of egress interface via MAC
 address
Message-ID: <20241212101156.GF2806@kernel.org>
References: <20241211021851.1442842-1-ushankar@purestorage.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241211021851.1442842-1-ushankar@purestorage.com>

On Tue, Dec 10, 2024 at 07:18:52PM -0700, Uday Shankar wrote:
> Currently, netconsole has two methods of configuration - kernel command
> line parameter and configfs. The former interface allows for netconsole
> activation earlier during boot, so it is preferred for debugging issues
> which arise before userspace is up/the configfs interface can be used.
> The kernel command line parameter syntax requires specifying the egress
> interface name. This requirement makes it hard to use for a couple
> reasons:
> - The egress interface name can be hard or impossible to predict. For
>   example, installing a new network card in a system can change the
>   interface names assigned by the kernel.
> - When constructing the kernel parameter, one may have trouble
>   determining the original (kernel-assigned) name of the interface
>   (which is the name that should be given to netconsole) if some stable
>   interface naming scheme is in effect. A human can usually look at
>   kernel logs to determine the original name, but this is very painful
>   if automation is constructing the parameter.
> 
> For these reasons, allow selection of the egress interface via MAC
> address. To maintain parity between interfaces, the local_mac entry in
> configfs is also made read-write and can be used to select the local
> interface, though this use case is less interesting than the one
> highlighted above.
> 
> Signed-off-by: Uday Shankar <ushankar@purestorage.com>

Hi Uday,

Overall this looks good to me. But I have some minor feedback.

Firstly, this patch doesn't apply to net-next.
Which means that the Netdev CI doesn't run.
So, please rebase and post a v2.
But please first wait for review from others.

Also, as this is a new feature, I wonder if a selftest should be added.
Perhaps some variant of netcons_basic.sh as has been done here:

* [PATCH net-next 0/4] netconsole: selftest for userdata overflow
  https://lore.kernel.org/netdev/20241204-netcons_overflow_test-v1-0-a85a8d0ace21@debian.org/

...

> diff --git a/net/core/netpoll.c b/net/core/netpoll.c
> index 2e459b9d88eb..485093387b9f 100644
> --- a/net/core/netpoll.c
> +++ b/net/core/netpoll.c

...

> @@ -570,11 +571,20 @@ int netpoll_parse_options(struct netpoll *np, char *opt)
>  	cur++;
>  
>  	if (*cur != ',') {
> -		/* parse out dev name */
> +		/* parse out dev_name or local_mac */
>  		if ((delim = strchr(cur, ',')) == NULL)
>  			goto parse_failed;
>  		*delim = 0;
> -		strscpy(np->dev_name, cur, sizeof(np->dev_name));
> +		if (!strchr(cur, ':')) {
> +			strscpy(np->dev_name, cur, sizeof(np->dev_name));
> +			eth_broadcast_addr(np->local_mac);
> +		} else {
> +			if (!mac_pton(cur, np->local_mac)) {
> +				goto parse_failed;
> +			}

nit: No need for braces in the conditional above:

			if (!mac_pton(cur, np->local_mac))
				goto parse_failed;

> +			/* force use of local_mac for device lookup */
> +			np->dev_name[0] = '\0';
> +		}
>  		cur = delim;
>  	}
>  	cur++;

...

> @@ -674,29 +685,46 @@ int __netpoll_setup(struct netpoll *np, struct net_device *ndev)
>  }
>  EXPORT_SYMBOL_GPL(__netpoll_setup);
>  
> +/* upper bound on length of %pM output */
> +#define MAX_MAC_ADDR_LEN (4 * ETH_ALEN)

I think 3 * ETH_ALEN is enough for the hex digits, colons (':') and
trailing NUL character ('\0').

And I think that defining it as such would allow it to be reused in
local_mac_store.

Also, this seems to occur a few times throughout the tree.
Perhaps adding it somewhere more global would make sense.

> +
> +static char *local_dev(struct netpoll *np, char *buf)
> +{
> +	if (np->dev_name[0]) {
> +		return np->dev_name;
> +	}

nit: No need for braces in the conditional above.

> +
> +	snprintf(buf, MAX_MAC_ADDR_LEN, "%pM", np->local_mac);
> +	return buf;
> +}
> +
>  int netpoll_setup(struct netpoll *np)
>  {
>  	struct net_device *ndev = NULL;
>  	bool ip_overwritten = false;
>  	struct in_device *in_dev;
>  	int err;
> +	char buf[MAX_MAC_ADDR_LEN];

nit: Please maintain reverse xmas tree order - longest line to shortest -
     for local variable declarations.
>  
>  	skb_queue_head_init(&np->skb_pool);
>  
>  	rtnl_lock();
> +	struct net *net = current->nsproxy->net_ns;

Please declare local variables at the top of the function.

>  	if (np->dev_name[0]) {
> -		struct net *net = current->nsproxy->net_ns;
>  		ndev = __dev_get_by_name(net, np->dev_name);
> +	} else if (is_valid_ether_addr(np->local_mac)) {
> +		ndev = dev_getbyhwaddr_rcu(net, ARPHRD_ETHER, np->local_mac);
>  	}
>  	if (!ndev) {
> -		np_err(np, "%s doesn't exist, aborting\n", np->dev_name);
> +		np_err(np, "%s doesn't exist, aborting\n", local_dev(np, buf));
>  		err = -ENODEV;
>  		goto unlock;
>  	}
>  	netdev_hold(ndev, &np->dev_tracker, GFP_KERNEL);
>  
>  	if (netdev_master_upper_dev_get(ndev)) {
> -		np_err(np, "%s is a slave device, aborting\n", np->dev_name);
> +		np_err(np, "%s is a slave device, aborting\n",
> +		       local_dev(np, buf));
>  		err = -EBUSY;
>  		goto put;
>  	}

...

