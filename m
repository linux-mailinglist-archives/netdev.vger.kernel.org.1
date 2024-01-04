Return-Path: <netdev+bounces-61549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9A18243D4
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 15:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5FC3284DBA
	for <lists+netdev@lfdr.de>; Thu,  4 Jan 2024 14:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A052C20B1A;
	Thu,  4 Jan 2024 14:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nhWXa02B"
X-Original-To: netdev@vger.kernel.org
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BAFB225D3
	for <netdev@vger.kernel.org>; Thu,  4 Jan 2024 14:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 134AD3200B32;
	Thu,  4 Jan 2024 09:32:19 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Jan 2024 09:32:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1704378739; x=1704465139; bh=vGxhhuGJmBt8A36J1dEbOHdQszu5
	76tOBWvPFflxn4E=; b=nhWXa02BJddmMMAqlOZjWcWVghkOF+8dbQMelrlgCCQB
	YpXd6+bzWcz4opVJs5gzpOsFmRM2hPjkOVDYW9R0cnQ5XKSzQ9/FFh5tmW1fDHhV
	SAv++yWbpJzNMVJyDzgxAXEZ64N8P/8ubkVppEGHxH2rd5cPqidGtbLEZymQPS0d
	lHzLHWKfHG9KVDk3hBsa7BcVymC76HF/PHZzW4LdhYxSj7/ws3koSt5znMDiBssw
	N9TEKlATVsJ2cv7jvn1WDhq20G/V+QuMaoAczjC7F9PHXdtYc7O27V9/BTjnWTFV
	9huBzhOwbVEhdmYboO0CE8d2LBvunMwMybTVOLPDzw==
X-ME-Sender: <xms:c8GWZRKduwc6785_D_AkVfOUUiRiORwMuyIemTSqngJQBLv3g8mZmQ>
    <xme:c8GWZdIojopk3H246gqmdjUKtbRnZ_3zEKxeWY_Z50VBFNiKALREk1HsaRn3MnJ0w
    HsX6-mNIX1FATA>
X-ME-Received: <xmr:c8GWZZtlLGwKhOELhHLYIs1tPscT5BxF4q84uiTdjCmAAJv8CEzaVPafnrO6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdegjedgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepkfguohcu
    ufgthhhimhhmvghluceoihguohhstghhsehiughoshgthhdrohhrgheqnecuggftrfgrth
    htvghrnhephefhtdejvdeiffefudduvdffgeetieeigeeugfduffdvffdtfeehieejtdfh
    jeeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiughoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:c8GWZSbx90sujkNmNmMAdArzNO3OJ46lxtK0FDD2d9CadsUOUcJBMg>
    <xmx:c8GWZYaVhZrrLxyyMl_HIGsl7jWzEQdeqnHUFMdeNw-EHMfhBw_m6Q>
    <xmx:c8GWZWCqpVsga5xnj7nVPkGrTDjY_HUBbGzAL0NJ4KXFUBCilESxaQ>
    <xmx:c8GWZVSVNNgdnsSbKJmDnEhSzGtsBnZUYUN_pHzMmIly8gVm_IN4BA>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jan 2024 09:32:18 -0500 (EST)
Date: Thu, 4 Jan 2024 16:32:15 +0200
From: Ido Schimmel <idosch@idosch.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com,
	xiyou.wangcong@gmail.com, victor@mojatatu.com,
	pctammela@mojatatu.com, mleitner@redhat.com, vladbu@nvidia.com,
	paulb@nvidia.com
Subject: Re: [patch net-next] net: sched: move block device tracking into
 tcf_block_get/put_ext()
Message-ID: <ZZbBb6-jhc2atf8e@shredder>
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
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Inserting the device to block xarray in qdisc_create() is not suitable
> place to do this. As it requires use of tcf_block() callback, it causes
> multiple issues. It is called for all qdisc types, which is incorrect.
> 
> So, instead, move it to more suitable place, which is tcf_block_get_ext()
> and make sure it is only done for qdiscs that use block infrastructure
> and also only for blocks which are shared.
> 
> Symmetrically, alter the cleanup path, move the xarray entry removal
> into tcf_block_put_ext().
> 
> Fixes: 913b47d3424e ("net/sched: Introduce tc block netdev tracking infra")
> Reported-by: Ido Schimmel <idosch@nvidia.com>
> Closes: https://lore.kernel.org/all/ZY1hBb8GFwycfgvd@shredder/
> Reported-by: Kui-Feng Lee <sinquersw@gmail.com>
> Closes: https://lore.kernel.org/all/ce8d3e55-b8bc-409c-ace9-5cf1c4f7c88e@gmail.com/
> Reported-and-tested-by: syzbot+84339b9e7330daae4d66@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007c85f5060dcc3a28@google.com/
> Reported-and-tested-by: syzbot+806b0572c8d06b66b234@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000082f2f2060dcc3a92@google.com/
> Reported-and-tested-by: syzbot+0039110f932d438130f9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000007fbc8c060dcc3a5c@google.com/
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Tested-by: Ido Schimmel <idosch@nvidia.com>

