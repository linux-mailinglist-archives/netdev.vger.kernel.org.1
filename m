Return-Path: <netdev+bounces-19456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232A75ABE6
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 12:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8961C21371
	for <lists+netdev@lfdr.de>; Thu, 20 Jul 2023 10:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1800174F3;
	Thu, 20 Jul 2023 10:26:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BD1174E6
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 10:26:47 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95BE10D2
	for <netdev@vger.kernel.org>; Thu, 20 Jul 2023 03:26:45 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id C42F25C0108;
	Thu, 20 Jul 2023 06:26:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 20 Jul 2023 06:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689848802; x=1689935202; bh=6utYKYW8xmsQh
	LvS+tPHYhPT4tMcCVK/uYdc5KQBgvc=; b=A8fU3Zvs6YMjn73Cdl9nP6lldaexV
	3vZ95gFokLo4gxwYsHKVp34QjwK3WPSyZh8zukhDSznlj7eVv8bUV2wD6ZlZhywv
	rb3x99xupOQdTWNTuALLYch+uYvUUoIDTJ9JSt5q4nnEMrxc6okQ1pf0OtcgLi+p
	JJTvuXs6wTScD3sbyfLxkN2UevIbaEibRCyej2zJeFxY9J3/9cW7AbgM8njE2vIl
	mikf1W7rd9AE1u6Q+R6duAtz++KMljr0cPoLqTQ1X1PnaJgIudZaoago7Nw9Y9zC
	0pduFr1RUfi58vMyQbb4cjVxoNFf+XmgtaPKzYVuw1FeS3YryB1hwrgRg==
X-ME-Sender: <xms:4gu5ZEZUcnT4NkMBNSIHjUQGJmase360oK3r0sj0k3ALJfGgxu63wg>
    <xme:4gu5ZPbh4vhMJkn61850ce9-Ij5O56CdZDEjdn8CLT3a-amoyFns1pxdY1O8_JJ92
    xil-M8G-iQkzEM>
X-ME-Received: <xmr:4gu5ZO-RxWnIVnXilbSIzXjcaRQGzXOgiCo4Azzyi865PNFBLpFsFe_DzQ8ZnenQnNgr7mMY90XsM3fFGvXawNm5-R8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrhedtgddvjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:4gu5ZOpIc5ki4vlsQK5ZrosHrmAdAHSSb01HoeroCn0gUZibhZWeyw>
    <xmx:4gu5ZPoLlEnbaopjWinbaotye3unRlPJTpt4RFry7E1N_bzYOXxmFA>
    <xmx:4gu5ZMRRKq4O4AYN0xN1zLBloQnlVDh-TpU_5l8fYpK3uwC8yyOkwg>
    <xmx:4gu5ZACGFidy9nsfL-kPpIPX6Ih6hoK_4VTtU4bl01hZU89d1axBxQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Jul 2023 06:26:41 -0400 (EDT)
Date: Thu, 20 Jul 2023 13:26:37 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Beniamino Galvani <bgalvani@redhat.com>
Subject: Re: [PATCHv2 net-next] IPv6: add extack info for inet6_addr_add/del
Message-ID: <ZLkL3eNVNfzZbaBv@shredder>
References: <20230719135644.3011570-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719135644.3011570-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 19, 2023 at 09:56:44PM +0800, Hangbin Liu wrote:
> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index e5213e598a04..4e0836d90e65 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -1027,7 +1027,8 @@ static bool ipv6_chk_same_addr(struct net *net, const struct in6_addr *addr,
>  	return false;
>  }
>  
> -static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
> +static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa,
> +			      struct netlink_ext_ack *extack)
>  {
>  	struct net *net = dev_net(dev);
>  	unsigned int hash = inet6_addr_hash(net, &ifa->addr);
> @@ -1037,7 +1038,7 @@ static int ipv6_add_addr_hash(struct net_device *dev, struct inet6_ifaddr *ifa)
>  
>  	/* Ignore adding duplicate addresses on an interface */
>  	if (ipv6_chk_same_addr(net, &ifa->addr, dev, hash)) {
> -		netdev_dbg(dev, "ipv6_add_addr: already assigned\n");
> +		NL_SET_ERR_MSG(extack, "ipv6_add_addr: already assigned");

How do you trigger it?

# ip link add name dummy10 up type dummy
# ip address add 2001:db8:1::1/64 dev dummy10
# ip address add 2001:db8:1::1/64 dev dummy10
RTNETLINK answers: File exists

Better to add extack in inet6_rtm_newaddr():

if (nlh->nlmsg_flags & NLM_F_EXCL || 
    !(nlh->nlmsg_flags & NLM_F_REPLACE))
	err = -EEXIST;
else
	err = inet6_addr_modify(net, ifa, &cfg)

>  		err = -EEXIST;
>  	} else {
>  		hlist_add_head_rcu(&ifa->addr_lst, &net->ipv6.inet6_addr_lst[hash]);
> @@ -1066,15 +1067,19 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  	     !(cfg->ifa_flags & IFA_F_MCAUTOJOIN)) ||
>  	    (!(idev->dev->flags & IFF_LOOPBACK) &&
>  	     !netif_is_l3_master(idev->dev) &&
> -	     addr_type & IPV6_ADDR_LOOPBACK))
> +	     addr_type & IPV6_ADDR_LOOPBACK)) {
> +		NL_SET_ERR_MSG(extack, "Cannot assign requested address");
>  		return ERR_PTR(-EADDRNOTAVAIL);
> +	}
>  
>  	if (idev->dead) {
> -		err = -ENODEV;			/*XXX*/
> +		NL_SET_ERR_MSG(extack, "Device marked as dead");

This seems to be a transient state when IPv6 device is being deleted. See
addrconf_ifdown(). Maybe "IPv6 device is going away".

> +		err = -ENODEV;
>  		goto out;
>  	}
>  
>  	if (idev->cnf.disable_ipv6) {
> +		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
>  		err = -EACCES;
>  		goto out;
>  	}
> @@ -1103,6 +1108,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	f6i = addrconf_f6i_alloc(net, idev, cfg->pfx, false, gfp_flags);
>  	if (IS_ERR(f6i)) {
> +		NL_SET_ERR_MSG(extack, "Dest allocate failed");

The only thing that can fail in this function is ip6_route_info_create()
which already has an extack argument. Better to pass extack to
addrconf_f6i_alloc() and get a more accurate error message.

>  		err = PTR_ERR(f6i);
>  		f6i = NULL;
>  		goto out;
> @@ -1140,7 +1146,7 @@ ipv6_add_addr(struct inet6_dev *idev, struct ifa6_config *cfg,
>  
>  	rcu_read_lock();
>  
> -	err = ipv6_add_addr_hash(idev->dev, ifa);
> +	err = ipv6_add_addr_hash(idev->dev, ifa, extack);
>  	if (err < 0) {
>  		rcu_read_unlock();
>  		goto out;
> @@ -2488,18 +2494,22 @@ static void addrconf_add_mroute(struct net_device *dev)
>  	ip6_route_add(&cfg, GFP_KERNEL, NULL);
>  }
>  
> -static struct inet6_dev *addrconf_add_dev(struct net_device *dev)
> +static struct inet6_dev *addrconf_add_dev(struct net_device *dev, struct netlink_ext_ack *extack)
>  {
>  	struct inet6_dev *idev;
>  
>  	ASSERT_RTNL();
>  
>  	idev = ipv6_find_idev(dev);
> -	if (IS_ERR(idev))
> +	if (IS_ERR(idev)) {
> +		NL_SET_ERR_MSG(extack, "No such device");

This is not very accurate. See comment below regarding __in6_dev_get().

>  		return idev;
> +	}
>  
> -	if (idev->cnf.disable_ipv6)
> +	if (idev->cnf.disable_ipv6) {
> +		NL_SET_ERR_MSG(extack, "IPv6 is disabled on this device");
>  		return ERR_PTR(-EACCES);
> +	}
>  
>  	/* Add default multicast route */
>  	if (!(dev->flags & IFF_LOOPBACK) && !netif_is_l3_master(dev))
> @@ -2919,21 +2929,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  
>  	ASSERT_RTNL();
>  
> -	if (cfg->plen > 128)
> +	if (cfg->plen > 128) {
> +		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");

For RTM_NEWROUTE IPv6 code just says "Invalid prefix length", so might
as well be consistent with it. Also, I see IPv4 doesn't have such
messages for its RTM_{NEW,DEL}ADDR messages. If you think it's useful
for IPv6, then I suggest also adding it to IPv4.

Same comment for delete path.

>  		return -EINVAL;
> +	}
>  
>  	/* check the lifetime */
> -	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft)
> +	if (!cfg->valid_lft || cfg->preferred_lft > cfg->valid_lft) {
> +		NL_SET_ERR_MSG(extack, "IPv6 address lifetime invalid");
>  		return -EINVAL;
> +	}
>  
> -	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64)
> +	if (cfg->ifa_flags & IFA_F_MANAGETEMPADDR && cfg->plen != 64) {
> +		NL_SET_ERR_MSG(extack, "IPv6 address with mngtmpaddr flag must have prefix length 64");

\"mngtmpaddr\"
a prefix length of

>  		return -EINVAL;
> +	}
>  
>  	dev = __dev_get_by_index(net, ifindex);
> -	if (!dev)
> +	if (!dev) {
> +		NL_SET_ERR_MSG(extack, "Unable to find the interface");

This is already checked in the netlink path (see inet6_rtm_newaddr()),
so this message will never be displayed. If you want to see it, then add
it in inet6_rtm_newaddr().

>  		return -ENODEV;
> +	}
>  
> -	idev = addrconf_add_dev(dev);
> +	idev = addrconf_add_dev(dev, extack);
>  	if (IS_ERR(idev))
>  		return PTR_ERR(idev);
>  
> @@ -2941,8 +2959,10 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  		int ret = ipv6_mc_config(net->ipv6.mc_autojoin_sk,
>  					 true, cfg->pfx, ifindex);
>  
> -		if (ret < 0)
> +		if (ret < 0) {
> +			NL_SET_ERR_MSG(extack, "Multicast auto join failed");
>  			return ret;
> +		}
>  	}
>  
>  	cfg->scope = ipv6_addr_scope(cfg->pfx);
> @@ -2999,22 +3019,29 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  }
>  
>  static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
> -			  const struct in6_addr *pfx, unsigned int plen)
> +			  const struct in6_addr *pfx, unsigned int plen,
> +			  struct netlink_ext_ack *extack)
>  {
>  	struct inet6_ifaddr *ifp;
>  	struct inet6_dev *idev;
>  	struct net_device *dev;
>  
> -	if (plen > 128)
> +	if (plen > 128) {
> +		NL_SET_ERR_MSG(extack, "IPv6 address prefix length larger than 128");
>  		return -EINVAL;
> +	}
>  
>  	dev = __dev_get_by_index(net, ifindex);
> -	if (!dev)
> +	if (!dev) {
> +		NL_SET_ERR_MSG(extack, "Unable to find the interface");
>  		return -ENODEV;
> +	}
>  
>  	idev = __in6_dev_get(dev);
> -	if (!idev)
> +	if (!idev) {
> +		NL_SET_ERR_MSG(extack, "No such address on the device");

A more accurate message would be "IPv6 is disabled on this device". See
ndisc_allow_add().

>  		return -ENXIO;
> +	}
>  
>  	read_lock_bh(&idev->lock);
>  	list_for_each_entry(ifp, &idev->addr_list, if_list) {
> @@ -3037,6 +3064,8 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
>  		}
>  	}
>  	read_unlock_bh(&idev->lock);
> +
> +	NL_SET_ERR_MSG(extack, "IPv6 address not found");
>  	return -EADDRNOTAVAIL;
>  }
>  
> @@ -3079,7 +3108,7 @@ int addrconf_del_ifaddr(struct net *net, void __user *arg)
>  
>  	rtnl_lock();
>  	err = inet6_addr_del(net, ireq.ifr6_ifindex, 0, &ireq.ifr6_addr,
> -			     ireq.ifr6_prefixlen);
> +			     ireq.ifr6_prefixlen, NULL);
>  	rtnl_unlock();
>  	return err;
>  }
> @@ -3378,7 +3407,7 @@ static void addrconf_dev_config(struct net_device *dev)
>  		return;
>  	}
>  
> -	idev = addrconf_add_dev(dev);
> +	idev = addrconf_add_dev(dev, NULL);
>  	if (IS_ERR(idev))
>  		return;
>  
> @@ -4692,7 +4721,7 @@ inet6_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	ifa_flags &= IFA_F_MANAGETEMPADDR;
>  
>  	return inet6_addr_del(net, ifm->ifa_index, ifa_flags, pfx,
> -			      ifm->ifa_prefixlen);
> +			      ifm->ifa_prefixlen, extack);
>  }
>  
>  static int modify_prefix_route(struct inet6_ifaddr *ifp,
> -- 
> 2.38.1
> 

