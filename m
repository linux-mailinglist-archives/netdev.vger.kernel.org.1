Return-Path: <netdev+bounces-60485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6745D81F7F5
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 12:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F19EB22E6E
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E28C6FD6;
	Thu, 28 Dec 2023 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="K/c2lISJ"
X-Original-To: netdev@vger.kernel.org
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943877487
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 9526B5C010C;
	Thu, 28 Dec 2023 06:50:32 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 28 Dec 2023 06:50:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703764232; x=1703850632; bh=5Tz+ddZhvIe/ipoqLbMxzYrK7vLl
	U9qHLQSpyFNKa/8=; b=K/c2lISJUFM8RTWb7gR5AwhUweZ/kKznDgCnaHMd0ZI0
	g+TeBlCrKf+sct9qQkQIBfmQV6DFFOQixHnHzqqzUyj0kPTN0v/wvu9IjhV0vJp9
	X4xsO8VTh4YldvWaVguWGTEgnVkMyFMvPWZdSEFx73nPZX1Jh0/fqwsSkftsodig
	mWyHy/1qW/adELPmmPmKzVsehKn76rv+5BGEOrmO4ZnZhO+p0TzeuD679SqxrH8h
	3flig/T/FiwGcVo26NYKUL8cQrpKxy6d+jtS2vMrEDtLi0R7eFIqQwXA0q4+HjS+
	sR9+WQntAAEuv8wmjQ2qi/dQG6J55KqD3oN1aDiRiQ==
X-ME-Sender: <xms:CGGNZQ9J0-4HbwT_jQSxzUhOMsAlwDOMgRbY93shxwN4r8DXLB5AHQ>
    <xme:CGGNZYuxYycaVO_shdIj-6gWIr5u_eSWbe0LDSOAiwr49jKcavsydlro2r1mQXyKQ
    t3mAgmAt4GATJ0>
X-ME-Received: <xmr:CGGNZWDSeYQ7432foySERxQhTJUHT6mzjAoJNbCI0jMF1gUG8Gk0yUpba-RT>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:CGGNZQc_RFCOdxYXbZUWMRsk3v0jrey4Yca0X0k_l-2TjBnlsqUSiw>
    <xmx:CGGNZVPkZuZ0ch4Z-wB2TCxxxJkJ10QJfRn5Z1jEDTMBK27a7UQqig>
    <xmx:CGGNZallXIIiEwr3LRMvGE5Asp2EXf50lZ6aTZ71Iz2d8L2qhwRkZQ>
    <xmx:CGGNZak0a4G1CKVCyIvsKt8sV0Z1raOJRQPacOcgQ_6Tk8HUxTmzcA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 06:50:31 -0500 (EST)
Date: Thu, 28 Dec 2023 13:50:29 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next v8 1/5] net/sched: Introduce tc block netdev
 tracking infra
Message-ID: <ZY1hBb8GFwycfgvd@shredder>
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

Another problem, shouldn't there be a check that these operations are
actually implemented? The following now crashes with a NULL pointer
dereference:

# tc qdisc replace dev swp1 root handle 1: tbf rate 1Mbit burst 256k limit 1M

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
> +
>  static int qdisc_block_indexes_set(struct Qdisc *sch, struct nlattr **tca,
>  				   struct netlink_ext_ack *extack)
>  {
> @@ -1350,6 +1387,10 @@ static struct Qdisc *qdisc_create(struct net_device *dev,
>  	qdisc_hash_add(sch, false);
>  	trace_qdisc_create(ops, dev, parent);
>  
> +	err = qdisc_block_add_dev(sch, dev, extack);
> +	if (err)
> +		goto err_out4;
> +
>  	return sch;
>  
>  err_out4:

