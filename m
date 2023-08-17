Return-Path: <netdev+bounces-28501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87B5A77FA57
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 17:08:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42709282039
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 15:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1555F156FC;
	Thu, 17 Aug 2023 15:07:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A730156F3
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 15:07:05 +0000 (UTC)
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1406106
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 08:07:04 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id E49C7320082A;
	Thu, 17 Aug 2023 11:07:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 17 Aug 2023 11:07:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1692284821; x=1692371221; bh=pefaaJKB9QRP9
	N2ZpbXkIDZQCRxAJCZ4whUpRmQACFY=; b=xkM3db5+OA86A7YwB8mnCQPPC/H4e
	PJnWLlmAL+F8BxvEmEB1+qvc/weveq9e1+l8kqaYvfqz/vLERjBI0H7QjAsdk06W
	iMmxJKEu0M9i3HT74+A2ZO0rlplrn/j/lqppQ15cOqoURGUqNJAOayCklvbOcKRy
	+9EU8OXgDwb1gHrwcEF7ZviMlaYFA1WjFZS5pBzxWzvCD2RpFAhEwJfCB9Wu0Z+u
	Jn5MiQbMbWkELF3toP4hCF8odlbjqYabdJWe14YFqNbd7hc/OHGV7S3Bwobr/JED
	7dFbnT7mWclALxp9dh7v8oFXRvpiwSs6ptszsb2SSMzs7DcKM/oruy7dg==
X-ME-Sender: <xms:lTfeZHItmTo4SS9_strJLPYW3NRGZUQtIHeRQunv3kmRTJxn78JOUQ>
    <xme:lTfeZLLhGpt7CP99IWBQ4qDG5fxd3sGGxWuR6naANbXrQlGbkSuPBIk89kFNLFaK5
    aytmuufLeFNrEE>
X-ME-Received: <xmr:lTfeZPtcsJSl43IzydPMq11GBoztPncnhb3nkfDlNvyZ99-EJq8JyHBQVOScKHqVODJgbZespSUrjRjaTvdcKDu_LO8wcw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrudduuddgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:lTfeZAaF6GhvUWj1HDAfmvhErvDkiZIZv5383_aRCtMj630SN1T9hg>
    <xmx:lTfeZObLT6Q4T0kiwQEK1TPxkp_M4YV8OYfF13lUxOxDyHnJhoRAwQ>
    <xmx:lTfeZEARGZRxsbEC9SXgJao_lS-L4BoQY9xOvWIoqUa4KRISVKr5Yw>
    <xmx:lTfeZFUrONgL87RJoKFakXROS71Mhy_aCdQr9U_Fph-DmQ5q_w-b6Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Aug 2023 11:07:00 -0400 (EDT)
Date: Thu, 17 Aug 2023 18:06:55 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] IPv4: add extack info for IPv4 address
 add/delete
Message-ID: <ZN43j89A388r5NdW@shredder>
References: <20230817032815.1675525-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230817032815.1675525-1-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 17, 2023 at 11:28:15AM +0800, Hangbin Liu wrote:
> Add extack info for IPv4 address add/delete, which would be useful for
> users to understand the problem without having to read kernel code.
> 
> No extack message for the ifa_local checking in __inet_insert_ifa() as
> it has been checked in find_matching_ifa().
> 
> Suggested-by: Ido Schimmel <idosch@idosch.org>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Thanks for the follow-up. A couple of minor comments below.

> ---
>  net/ipv4/devinet.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
> index 5deac0517ef7..40f90d01ce0e 100644
> --- a/net/ipv4/devinet.c
> +++ b/net/ipv4/devinet.c
> @@ -509,6 +509,7 @@ static int __inet_insert_ifa(struct in_ifaddr *ifa, struct nlmsghdr *nlh,
>  				return -EEXIST;
>  			}
>  			if (ifa1->ifa_scope != ifa->ifa_scope) {
> +				NL_SET_ERR_MSG(extack, "ipv4: Invalid scope value");
>  				inet_free_ifa(ifa);
>  				return -EINVAL;
>  			}
> @@ -664,6 +665,7 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  	ifm = nlmsg_data(nlh);
>  	in_dev = inetdev_by_index(net, ifm->ifa_index);
>  	if (!in_dev) {
> +		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
>  		err = -ENODEV;
>  		goto errout;
>  	}
> @@ -688,6 +690,7 @@ static int inet_rtm_deladdr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		return 0;
>  	}
>  
> +	NL_SET_ERR_MSG(extack, "ipv4: Address not found");
>  	err = -EADDRNOTAVAIL;
>  errout:
>  	return err;
> @@ -839,13 +842,23 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
>  
>  	ifm = nlmsg_data(nlh);
>  	err = -EINVAL;
> -	if (ifm->ifa_prefixlen > 32 || !tb[IFA_LOCAL])
> +
> +	if (ifm->ifa_prefixlen > 32) {
> +		NL_SET_ERR_MSG(extack, "IPv4: Invalid prefix length");

s/IPv4/ipv4/

To be consistent with the rest and IPv6.

> +		goto errout;
> +	}
> +
> +	if (!tb[IFA_LOCAL]) {
> +		NL_SET_ERR_MSG(extack, "ipv4: Local address is not supplied");
>  		goto errout;
> +	}
>  
>  	dev = __dev_get_by_index(net, ifm->ifa_index);
>  	err = -ENODEV;
> -	if (!dev)
> +	if (!dev) {
> +		NL_SET_ERR_MSG(extack, "ipv4: Device not found");
>  		goto errout;
> +	}
>  
>  	in_dev = __in_dev_get_rtnl(dev);
>  	err = -ENOBUFS;
> @@ -896,7 +909,14 @@ static struct in_ifaddr *rtm_to_ifaddr(struct net *net, struct nlmsghdr *nlh,
>  		struct ifa_cacheinfo *ci;
>  
>  		ci = nla_data(tb[IFA_CACHEINFO]);
> -		if (!ci->ifa_valid || ci->ifa_prefered > ci->ifa_valid) {

IPv6 just says for both "address lifetime invalid"

> +		if (!ci->ifa_valid) {
> +			NL_SET_ERR_MSG(extack, "ipv4: valid_lft is zero");
> +			err = -EINVAL;
> +			goto errout_free;
> +		}
> +
> +		if (ci->ifa_prefered > ci->ifa_valid) {
> +			NL_SET_ERR_MSG(extack, "ipv4: preferred_lft is greater than valid_lft");
>  			err = -EINVAL;
>  			goto errout_free;
>  		}
> @@ -954,6 +974,7 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  			int ret = ip_mc_autojoin_config(net, true, ifa);
>  
>  			if (ret < 0) {
> +				NL_SET_ERR_MSG(extack, "ipv4: Multicast auto join failed");
>  				inet_free_ifa(ifa);
>  				return ret;
>  			}
> @@ -967,8 +988,10 @@ static int inet_rtm_newaddr(struct sk_buff *skb, struct nlmsghdr *nlh,
>  		inet_free_ifa(ifa);
>  
>  		if (nlh->nlmsg_flags & NLM_F_EXCL ||
> -		    !(nlh->nlmsg_flags & NLM_F_REPLACE))
> +		    !(nlh->nlmsg_flags & NLM_F_REPLACE)) {
> +			NL_SET_ERR_MSG(extack, "ipv4: Address already assigned");
>  			return -EEXIST;
> +		}
>  		ifa = ifa_existing;
>  
>  		if (ifa->ifa_rt_priority != new_metric) {
> -- 
> 2.38.1
> 

