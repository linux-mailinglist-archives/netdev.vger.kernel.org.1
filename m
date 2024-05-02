Return-Path: <netdev+bounces-92909-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2008B94A2
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 08:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461101C21504
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 06:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070F921105;
	Thu,  2 May 2024 06:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TVDr5Cjr"
X-Original-To: netdev@vger.kernel.org
Received: from wfout5-smtp.messagingengine.com (wfout5-smtp.messagingengine.com [64.147.123.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67641200C1
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 06:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714630980; cv=none; b=jhPscJn68xNmmpkuY6WcP9a/2VgIfYjOoWXyhE97LB70PEhR/wHpFysEjO1ppRTszn2etXy5thNydYsDEoiMhBCqFCMmoAi7b2yLg5fizQ8QqcALaXnrr0fVhs3RHs836JhRPkTwxG2SbfZhCMpLtXpq2axwXtMoukTSRMnrfJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714630980; c=relaxed/simple;
	bh=Bsm5wQGwVvOpdAPKjH9pZW1JAyombJr2RwoLLUg1jK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTW/B8QE3m1ZmdVekSmRnMq8tA2mSIdqV7Lg2MDDz8e9dUCTHMMeN2f/39680ZoXNlvjkq62AOSV/LCKljw/9UmgFHXH+YGFsKTTODORC/AO5ujcGyhWwAl+KIF3ThxQ5La8axQopezSAys2fcDszPycszwaILt5T1UkG2/+EEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TVDr5Cjr; arc=none smtp.client-ip=64.147.123.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfout.west.internal (Postfix) with ESMTP id D93011C000C8;
	Thu,  2 May 2024 02:22:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 02 May 2024 02:22:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714630977; x=1714717377; bh=Yg62CKvh6ZqN6gl3u38yklT3PMj7
	p3gciBkza1doWLY=; b=TVDr5CjrhDyqAfF7cAW+OO3ik3HCsd2MDKMdacr+kfBG
	RfAmY6tykTpHG5Ks+tLqG1TweXudno44Ivk+C3G+Kejn3ZnzvDWjSaZp+I7/Xkp4
	b7rQJTfAkP01GdsndPt/sPBhCZnFcqnLs+iMRNTRQ0EzI9G9fn15nGShabT+3K5m
	RzwdXPWMO/IwVC3HikfsE5DABEG3tRGZhDp+lh6eke2XzIRqDwfg1hm5GU25kXhV
	bUm+3H2zMDbl6ef5KbZf2IeiL9EFAyV5FFlOQLzV7b+qUw+2RyotAfZhK/xQ737U
	7IAoAlN54dcQk5doGJewjNF58/haXUcCyUdoTDgTTw==
X-ME-Sender: <xms:QTEzZuMKKvbiEmqx8XwQVqbIS54n0PeMeOTxHgxUT2OmYzK6Ulo-DQ>
    <xme:QTEzZs-w6MDqL9DAMvL7MtTwTfNJtxWLiSnlalvY1D3WLijznXk7rssykYO0wH7bS
    cwmrrAJ3FZ4Pj8>
X-ME-Received: <xmr:QTEzZlSaIapn8CEA6g43XN2KT-cX6C6HKBQSQc_SQRPizQxu0SZTrlIbebXW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddujedguddthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedt
    hfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:QTEzZuuZSQMrrun4lfz7M__tmi7NHG00gIhvBaBbR8WfE5qMQPu1uQ>
    <xmx:QTEzZmdvh3HwscPLrJWGRT8F4kxT6wLCkw3FhOadb3by4R_PVI0zhw>
    <xmx:QTEzZi2Vm4p4LV95URQObLPlbHQdvNEo6fy1mTp1nyMLzs0LH4_VdQ>
    <xmx:QTEzZq-DXsqZnw_qD5QcNT67S5wpFc4IPfsNbULmyG0UYIPedJXy7A>
    <xmx:QTEzZm4LdWTHGXmbcW7ipD7cFSBfdyy47GXGPUc6APrpatRtiuFmWD_G>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 2 May 2024 02:22:56 -0400 (EDT)
Date: Thu, 2 May 2024 09:22:48 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Naresh Kamboju <naresh.kamboju@linaro.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/sched: unregister lockdep keys in
 qdisc_create/qdisc_alloc error path
Message-ID: <ZjMxOATg5FdUnaPK@shredder>
References: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2aa1ca0c0a3aa0acc15925c666c777a4b5de553c.1714496886.git.dcaratti@redhat.com>

On Tue, Apr 30, 2024 at 07:11:13PM +0200, Davide Caratti wrote:
> Naresh and Eric report several errors (corrupted elements in the dynamic
> key hash list), when running tdc.py or syzbot. The error path of
> qdisc_alloc() and qdisc_create() frees the qdisc memory, but it forgets
> to unregister the lockdep key, thus causing use-after-free like the
> following one:

[...]

> Fix this ensuring that lockdep_unregister_key() is called before the
> qdisc struct is freed, also in the error path of qdisc_create() and
> qdisc_alloc().
> 
> Fixes: af0cb3fa3f9e ("net/sched: fix false lockdep warning on qdisc root lock")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/netdev/20240429221706.1492418-1-naresh.kamboju@linaro.org/
> CC: Naresh Kamboju <naresh.kamboju@linaro.org>
> CC: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Davide Caratti <dcaratti@redhat.com>

Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

