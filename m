Return-Path: <netdev+bounces-62883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12CE829A31
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 13:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CC7C1B237A3
	for <lists+netdev@lfdr.de>; Wed, 10 Jan 2024 12:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98977482CA;
	Wed, 10 Jan 2024 12:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="v8cV/GhV"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E50A9481D6
	for <netdev@vger.kernel.org>; Wed, 10 Jan 2024 12:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id D23945C00B5;
	Wed, 10 Jan 2024 07:10:00 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 10 Jan 2024 07:10:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704888600; x=1704975000; bh=Q3Pp+hpTFNoGoAOBgcPw3l2yX4+D
	5yZWhUErGbZ3JWk=; b=v8cV/GhVSpKGzIT60qmbsMQoTcJWPPYIkqvULzdEyxJF
	Nsd008uo1ucNBg65e1gYDpjF4fJDOFeWJeuB/Fe3PaWkWbpxbbsS/PkBylY6aGZy
	Bp0jUKNc3W/tgroZOprNWeRBIbtqzNWMMoxZfBmr1GbBzWVh/YLkT1db/BQU8UaU
	BwPOmLcRbjTMybqGrIBwCE1lsuxPu65ET+hCHdehdOmZVmWx43BWkEcUNwar3vow
	6lYNGibmq2xQnAvQLoROL+mpfWrExM5UVdHGufXRhvVRXhsunqIUlSNcSYkfD3Ze
	fCbCGpkMBNdrBOUrWiMQYqyEIZ9PSyK+9IMQfdjrZA==
X-ME-Sender: <xms:GImeZelo8AZJVJlLuNSDvSRURzgfdIY_BjZXWAzs_4E2ozXFjNZaqA>
    <xme:GImeZV0dYP-wflmZ9iKzE7pFkYg7CnD_4pGQtFZ-ZASlgMRIuKIrQ46J_GqvMEi4Q
    Axaqfq2k-RGRQw>
X-ME-Received: <xmr:GImeZcpmasXHkY2-r7t_8kzRj5-qMdhFtKzUafl0qQUDZqcoVshA4JbzcmMd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeiuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:GImeZSmswtlaI7Yl7aJrhcfwLVT1Xi7cT-YfzG0VwbxcVCP9nyhH0Q>
    <xmx:GImeZc3nnx5VIa17keuWVQntHxqwWsG_thPxAb9wQklufgakl3lfPw>
    <xmx:GImeZZt8OqzKOKaNZeFj9n44BzOUBjQh582XLajR5zbKjiB-pCHxhg>
    <xmx:GImeZVsHtH_vnhU5Q1xKJRP_HPLu1f4ioqTVQjZGzX1z4zgScREfmA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 10 Jan 2024 07:09:59 -0500 (EST)
Date: Wed, 10 Jan 2024 14:09:55 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZ6JE0odnu1lLPtu@shredder>
References: <20240104125844.1522062-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240104125844.1522062-1-jiri@resnulli.us>

On Thu, Jan 04, 2024 at 01:58:44PM +0100, Jiri Pirko wrote:
> diff --git a/net/sched/cls_api.c b/net/sched/cls_api.c
> index adf5de1ff773..253b26f2eddd 100644
> --- a/net/sched/cls_api.c
> +++ b/net/sched/cls_api.c
> @@ -1428,6 +1428,7 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>  		      struct tcf_block_ext_info *ei,
>  		      struct netlink_ext_ack *extack)
>  {
> +	struct net_device *dev = qdisc_dev(q);
>  	struct net *net = qdisc_net(q);
>  	struct tcf_block *block = NULL;
>  	int err;
> @@ -1461,9 +1462,18 @@ int tcf_block_get_ext(struct tcf_block **p_block, struct Qdisc *q,
>  	if (err)
>  		goto err_block_offload_bind;
>  
> +	if (tcf_block_shared(block)) {
> +		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
> +		if (err) {
> +			NL_SET_ERR_MSG(extack, "block dev insert failed");
> +			goto err_dev_insert;
> +		}
> +	}

While this patch fixes the original issue, it creates another one:

# ip link add name swp1 type dummy
# tc qdisc replace dev swp1 root handle 10: prio bands 8 priomap 7 6 5 4 3 2 1
# tc qdisc add dev swp1 parent 10:8 handle 108: red limit 1000000 min 200000 max 200001 probability 1.0 avpkt 8000 burst 38 qevent early_drop block 10
RED: set bandwidth to 10Mbit
# tc qdisc add dev swp1 parent 10:7 handle 107: red limit 1000000 min 500000 max 500001 probability 1.0 avpkt 8000 burst 63 qevent early_drop block 10
RED: set bandwidth to 10Mbit
Error: block dev insert failed.

The reproducer does not fail if I revert this patch and apply Victor's
[1] instead.

[1] https://lore.kernel.org/netdev/20231231172320.245375-1-victor@mojatatu.com/

> +
>  	*p_block = block;
>  	return 0;
>  
> +err_dev_insert:
>  err_block_offload_bind:
>  	tcf_chain0_head_change_cb_del(block, ei);
>  err_chain0_head_change_cb_add:

