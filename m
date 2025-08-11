Return-Path: <netdev+bounces-212541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC32AB2127D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E501886C0A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D2D296BDB;
	Mon, 11 Aug 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jl61eaUK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7CC296BB4;
	Mon, 11 Aug 2025 16:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754930588; cv=none; b=k+WPxoeb1t9D8rL9dhS0ASEdD286YoDTHZ8FsnwNlITz40ZtJ5nqvJVJEft4ow5+RhfWj+buXF2LPN39d45uurLZXLcTShAvLNT2ZeFyZGglA/uFjDvQLFETY/6Ehu91ykod65GKQrL5B81hSzlf1VFjBmtUAqL/j8/1CtxgcF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754930588; c=relaxed/simple;
	bh=9z+tz1mZ02O2xUsDYySHzgddAuS1zPi5iv/IxcoOFc0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FJlr+dd3JhaMMeJTGfMD1es/Ty6n7w7dDsqMyFy9wl5WfZQrjfNm0IcotTa6/yehwMyb9sF4oQ8VMqJcoosxrycjAyecB72eF5i8rVZxqI7deXTNgKYjs0KYjAPpxpXWe7t4Om8iP/Nqob8wS8+ZghcYiRJVdgZEUQEK89+YtwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jl61eaUK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5857C4CEED;
	Mon, 11 Aug 2025 16:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754930588;
	bh=9z+tz1mZ02O2xUsDYySHzgddAuS1zPi5iv/IxcoOFc0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jl61eaUKy/n/uAo55PqQFasHJ3cCDEODQ42dDdfy8l5VpZaSFLCCkAQue4lRMuYXK
	 FDKMiZU4SE0+96uDG4SR1at/HzjxXh9LawkN4Ak6Py9oWk+cBZG+TqUgMpylxIqYOF
	 e5Ea1QQP5cfDhxBKoe+2dl5PCe728uGiP/3Ob4QkMnNviiHhKo1Vlv+/dUihzl5ih2
	 iQYXQXWJKYNhLbv9DqLc0j2WHjtmXacO5p3JZ3p9le3Xzi3nAd10zv6R7TtRpl/2/p
	 u1ynid+mLO5WsHy1MNsV9g8SrUOn75aSeFn1k148TtQxsgsd3TftPMOZQwUT2xghsC
	 M9TXjSo2P0QUA==
Date: Mon, 11 Aug 2025 09:43:07 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
Cc: "Gupta, Suraj" <Suraj.Gupta2@amd.com>, "andrew+netdev@lunn.ch"
 <andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "Simek, Michal" <michal.simek@amd.com>,
 "sean.anderson@linux.dev" <sean.anderson@linux.dev>, "horms@kernel.org"
 <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "Katakam, Harini" <harini.katakam@amd.com>
Subject: Re: [PATCH net] net: xilinx: axienet: Increment Rx skb ring head
 pointer after BD is successfully allocated in dmaengine flow
Message-ID: <20250811094307.4c2d42ae@kernel.org>
In-Reply-To: <MN0PR12MB5953EF5C6557457C1C893668B728A@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20250805191958.412220-1-suraj.gupta2@amd.com>
	<20250808120534.0414ffd0@kernel.org>
	<BL3PR12MB65712291B55DD8D535BAE667C92EA@BL3PR12MB6571.namprd12.prod.outlook.com>
	<20250811083738.04bf1e31@kernel.org>
	<MN0PR12MB5953EF5C6557457C1C893668B728A@MN0PR12MB5953.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 15:55:02 +0000 Pandey, Radhey Shyam wrote:
> > That wasn't my reading, maybe I misinterpreted the code.
> >
> > From what I could tell the driver tries to give one new buffer for each buffer
> > completed. So it never tries to "catch up" on previously missed allocations. IOW say
> > we have a queue with 16 indexes, after 16 failures (which may be spread out over
> > time) the ring will be empty.  
> 
> Yes, IIRC there is 1:1 mapping for RX DMA callback and
> axienet_rx_submit_desc(). In case there are failure in
> axienet_rx_submit_desc() it is not able to reattempt
> in current implementation. Theoretically there could
> be other error in rx_submit_desc() (like dma_mapping/netdev
> allocation)
> 
> One thought is to have some flag/index to tell that it should
> be reattempted in subsequent axienet_rx_submit_desc() ?

Yes, some kind of counter of buffer that need to be allocated.
The other problem to solve is when the buffers are completely
depleted there will be no callback so no opportunity to refill.
For drivers which refill from NAPI this is usually solved by
periodically scheduling NAPI.

