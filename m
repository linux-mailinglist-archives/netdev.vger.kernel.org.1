Return-Path: <netdev+bounces-60498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DFC581F945
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 15:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 532A11F242E9
	for <lists+netdev@lfdr.de>; Thu, 28 Dec 2023 14:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2003C8F1;
	Thu, 28 Dec 2023 14:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rYZC5WDH"
X-Original-To: netdev@vger.kernel.org
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC1DCA50
	for <netdev@vger.kernel.org>; Thu, 28 Dec 2023 14:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 682E43200A27;
	Thu, 28 Dec 2023 09:58:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 28 Dec 2023 09:58:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703775496; x=1703861896; bh=8GZsdbwlN5tR5s2RGkdl36aEZGQu
	0+VOS+BivVUTp2o=; b=rYZC5WDHuihVb2GGWYvJUkw2A6d84pWbJf+SzBLW34Fe
	YQSks5Ey17Fmm7nmpMF9GH3FZA/ilxf1Qbzbm85S6gq0lqNciJMUEilZAAgGql0q
	tjn4oIGiKtymwe9KM7j2KYMRkAe7jdXlM+AkfbXB1RWHt5C4tKoheRU8NlLnbPf0
	RoPSzWxXj8eyiY0cRD+/203/2xeLri4ivkCEFNEquChjb6ai5oUp14lpiyDtZ1pu
	lSvxT8+hQwLk5EqER5+CxB7RmLzdTifmJys+Ibu1hwPcYlUGM0mvcWiwdAnncQiR
	i/s++7mcl+lFQwFIiN2wpAeYFXoMCHjmPZoy24nkIw==
X-ME-Sender: <xms:CI2NZWDCCFnuPdwksSfCiYEKK1G1MZErKH8M7-v8Tu1d1kNj73fwTg>
    <xme:CI2NZQgf0387xk4fdFO2d4awVonfSjS3C39Qz7b_kqCiRLTK68v30wOCQLVw0Eo-P
    -1LZrzZkyvlZ7E>
X-ME-Received: <xmr:CI2NZZm-hZ2UdTefxt65CPKx227D2jdYb5s1upI5R6nWG390CkzQYUsLmWBZ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdefuddgjedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhepvddufeevkeehueegfedtvdevfefgudeifeduieefgfelkeehgeelgeejjeeg
    gefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepih
    guohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:CI2NZUwJH-MfyAs38jhYRJcOQjd3yDJpo7QmGgCqDi361j2UHg0_cQ>
    <xmx:CI2NZbQB5UxrdBsnzxMlbThDZYDMkVcbeYCLwm8_EKyaC3Pp8o-x-Q>
    <xmx:CI2NZfYN4KdPZ0Sk7ss8JUQ3mBOWCfGyK5p5bcCFqd99fRGlVV9CSQ>
    <xmx:CI2NZTaKDTILK0MN2K0E5pNhw1ALeASjISIqpnzaVYyEawiHOud9-Q>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 Dec 2023 09:58:15 -0500 (EST)
Date: Thu, 28 Dec 2023 16:58:12 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, xiyou.wangcong@gmail.com,
	jiri@resnulli.us, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com, pctammela@mojatatu.com, netdev@vger.kernel.org,
	kernel@mojatatu.com
Subject: Re: [PATCH net-next 1/1] net/sched: We should only add appropriate
 qdiscs blocks to ports' xarray
Message-ID: <ZY2NBHCcK9nJ7vT2@shredder>
References: <20231228140909.96711-1-victor@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231228140909.96711-1-victor@mojatatu.com>

On Thu, Dec 28, 2023 at 11:09:09AM -0300, Victor Nogueira wrote:
> We should only add qdiscs to the blocks ports' xarray in ingress that
> support ingress_block_set/get or in egress that support
> egress_block_set/get.
> 
> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
> 

Unnecessary blank line

> Signed-off-by: Victor Nogueira <victor@mojatatu.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>

Reported-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Ido Schimmel <idosch@nvidia.com>

Thanks!

