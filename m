Return-Path: <netdev+bounces-154773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87BE09FFC02
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 17:41:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22ABC7A1F98
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 16:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40BC15666D;
	Thu,  2 Jan 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mPgqiowk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B410714BFA2;
	Thu,  2 Jan 2025 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835956; cv=none; b=LvGU7q8SLM1Ce/Da7A+EdW0BXJg6sqNtb5DJpY/Mt4zceCImfJVPogMruWeZDWElcBGj8fRZuLzwIoDxbV5ES0hrGJBHhX4zbZED4NmfZZmb9RZLrUOKPmfcsz7p1BWIZxgLGZLCYu/j6CFxL9kcuMQs8CkD4lWvV533xferulM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835956; c=relaxed/simple;
	bh=jPFAeCo60VSV9qQBwJyjLnkLChMzPpcMojnaVDgF5bo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AIOPUqPH8+5Kt34RM6keQ90Y+llVZeNfYG+g1QWOl6mc0RQksioTrIjKyaYQ7ApUHAF8Riw3P9MZwdU1OKVpHS5aXnSUA3g92xkQ90h8yoVZL5DxbFQ4TpfIOGhQej4sD2Dsj41pRHcJFWMDCi1czZWwcb3zsViIKVnVUvnDxzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mPgqiowk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB695C4CED0;
	Thu,  2 Jan 2025 16:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735835956;
	bh=jPFAeCo60VSV9qQBwJyjLnkLChMzPpcMojnaVDgF5bo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=mPgqiowk1OW4WsKuS6FSbfUca+/aMwcVgL4mGSx4J4diTEKRVM/na8PIzOCZARtpa
	 EwrXOHSvDO0HHO/cWJkUv8XyL44Mu+FE4TmI0CJ8XjMSJJRtz3b50B/rwFSwC+xRnq
	 3CQxyBcqgied41PFEWIZhHOlXpV553LDdsYMxWt2PhsqzERXpSQAx50jj7Dn/vs3rW
	 wXivo60R0RqELBvIXsIfMvXYkk17jlpTpBKtvY4/PP3tdDvlKLJ2vcRL8gBEGD1KJc
	 mhMtbOyg2m489tyNSpF7cjIXFWjsqicSmc4R9se6JApJRxDDlnIeDmlODxy4VQduZH
	 Nz7Pf5vQF3eOw==
Date: Thu, 2 Jan 2025 08:39:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Haifeng Xu <haifeng.xu@shopee.com>, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Subject: Re: [Question] =?UTF-8?B?aXhnYmXvvJpNZWNoYW5pc20=?= of RSS
Message-ID: <20250102083915.6e5375a1@kernel.org>
In-Reply-To: <87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
References: <da83df12-d7e2-41fe-a303-290640e2a4a4@shopee.com>
	<CANn89iKVVS=ODm9jKnwG0d_FNUJ7zdYxeDYDyyOb74y3ELJLdA@mail.gmail.com>
	<c2c94aa3-c557-4a74-82fc-d88821522a8f@shopee.com>
	<CANn89iLZQOegmzpK5rX0p++utV=XaxY8S-+H+zdeHzT3iYjXWw@mail.gmail.com>
	<b9c88c0f-7909-43a3-8229-2b0ce7c68c10@shopee.com>
	<87e945f6-2811-0ddb-1666-06accd126efb@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 2 Jan 2025 16:01:18 +0000 Edward Cree wrote:
> On 02/01/2025 11:23, Haifeng Xu wrote:
> > We want to make full use of cpu resources to receive packets. So
> > we enable 63 rx queues. But we found the rate of interrupt growth
> > on cpu 0~15 is faster than other cpus(almost twice).  
> ...
> > I am confused that why ixgbe NIC can dispatch the packets
> > to the rx queues that not specified in RSS configuration.  
> 
> Hypothesis: it isn't doing so, RX is only happening on cpus (and
>  queues) 0-15, but the other CPUs are still sending traffic and
>  thus getting TX completion interrupts from their TX queues.
> `ethtool -S` output has per-queue traffic stats which should
>  confirm this.
> 
> (But Eric is right that if you _want_ RX to use every CPU you
>  should just change the indirection table.)

IIRC Niantic had 4 bit entries in the RSS table or some such.
It wasn't possible to RSS across more than 16 queues at a time.
It's a great NIC but a bit dated at this point.

