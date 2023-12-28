Return-Path: <netdev+bounces-60483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB11D81F7CB
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 12:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB4F1C20C65
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 11:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA866FC5;
	Thu, 28 Dec 2023 11:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="M2ce4O+P"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BB76FC7
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id C0EC55C010F;
	Thu, 28 Dec 2023 06:40:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 28 Dec 2023 06:40:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703763653; x=1703850053; bh=npFYJ8Qb2fRNhsmLYiDDRmbTpaap
	KrLg2m2iRoxzT4M=; b=M2ce4O+Pcf/L7vsyFkL8mMNi8wqnx5P1EtQ+SAMJEN5f
	IE9nTZhgPVNg9OfcRqVaPHK96WirKKfnKPIeRL98Lkv1U/B2gVCr0MlVeZJVYWNN
	Z+8wc4sbrwxpgqFZJ101TnQ/9+V2O28Dt+OfrQuNB6WSu5AF81EuxtUpRmJoWCN2
	Gg2kh1l5tkL09w63JacWLIOAvyiIPkUVcBuqnLJil2VFFxMGI3y2FlHrbacjdFPa
	p8FAmcHikqWeXMwSbT471ZjtwYZ+biP+eAPXRxae2O/oYsuBfubBouVqgFYGv5y3
	Vhea8hqbh7ClDOnfNkB0Xez7oarRhrB79Eiu4uD3nw==
X-ME-Sender: <xms:xV6NZUuQx1UF96Li1zoia9NLGGQQiy4qfUkispsr__ySoa-AdU4VJQ>
    <xme:xV6NZRfutSgrbYkOtJIBfZkWoqroy1pXGk3R65rqo4MI_iSzq14K_yuRd_75heLQ5
    NNBL13KrC91ydo>
X-ME-Received: <xmr:xV6NZfxh8y9JfRWNH_Rg9G0iyKH8lkZ6F3qtUdjiikMEifnBTm5mJ2l_ue50>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgfedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:xV6NZXOM3DW9LDKdKEVw4_8viW5LajZeCPAHvBJjM4duKI_QxZ8pwA>
    <xmx:xV6NZU_jXoUrOswYJn9jnZKhsNg2RJmByAg7IuNw6tanZWvtf0XGtg>
    <xmx:xV6NZfVeWpk5j8_QpUxYKpn1E-OblKP3iMRM85oLvg1Svkc6uKkKrg>
    <xmx:xV6NZfUYSspzy5QiAJqqIL7p4zBrYP2eDzXShErKjO3t4Qans1qO0w>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 06:40:52 -0500 (EST)
Date: Thu, 28 Dec 2023 13:40:50 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v8 1/5] net/sched: Introduce tc block netdev
 tracking infra
Message-ID: <ZY1ewk_H4QWmKz_T@shredder>
References: <20231219181623.3845083-1-victor@mojatatu.com>
 <20231219181623.3845083-2-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219181623.3845083-2-victor@mojatatu.com>

On Tue, Dec 19, 2023 at 03:16:19PM -0300, Victor Nogueira wrote:
> +static int qdisc_block_add_dev(struct Qdisc *sch, struct net_device *dev,
> +			       struct netlink_ext_ack *extack)
> +{
> +	const struct Qdisc_class_ops *cl_ops = sch->ops->cl_ops;
> +	struct tcf_block *block;
> +	int err;
> +
> +	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> +	if (block) {
> +		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
> +		if (err) {
> +			NL_SET_ERR_MSG(extack,
> +				       "ingress block dev insert failed");
> +			return err;
> +		}
> +	}
> +
> +	block = cl_ops->tcf_block(sch, TC_H_MIN_EGRESS, NULL);
> +	if (block) {
> +		err = xa_insert(&block->ports, dev->ifindex, dev, GFP_KERNEL);
> +		if (err) {
> +			NL_SET_ERR_MSG(extack,
> +				       "Egress block dev insert failed");
> +			goto err_out;
> +		}
> +	}

The following fails after this patch:

# tc qdisc add dev swp1 ingress
Error: Egress block dev insert failed.

Probably because ingress_tcf_block() ignores the 'cl' argument.

> +
> +	return 0;
> +
> +err_out:
> +	block = cl_ops->tcf_block(sch, TC_H_MIN_INGRESS, NULL);
> +	if (block)
> +		xa_erase(&block->ports, dev->ifindex);
> +
> +	return err;
> +}

