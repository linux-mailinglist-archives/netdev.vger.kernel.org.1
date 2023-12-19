Return-Path: <netdev+bounces-58841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDC8185B3
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:53:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88ECB1F2530C
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61A2A14ABA;
	Tue, 19 Dec 2023 10:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HRb8YZzp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4797414AAA
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:53:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E17EBC433C7;
	Tue, 19 Dec 2023 10:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702983184;
	bh=2slsZU6RH8mtRlOly51OiH0UfB/9kBoXnIYDL4LN9KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HRb8YZzpdMseTvka7OHc1B8YMh59osjZavB5yLWitPBpHxjwrklQ603R47eftktVm
	 roGU1rwg+7JaZQLbltW/YD1fDkhjEUZiRvF7yPj23Fis4ZarYSSvo+So1qDyhIxdA+
	 QEy9JZJm0YxI3UQboR1qETQVpc1w7CUjsQBqUOHlRZE6GRQo9R7BrSgoFCpfAEBz9p
	 jD6UQwbBwSXoMMyD+srXpQa0Po6a+eugVkQ2epCbNE2d8mRmEBs8P2I5JAvEJ3Ae07
	 LJQcgDd072wp4Pi0TGU07PUA92EGsSWFanit1Diy+3GuL3KkYXXcIT94i8ovO9uenj
	 3FozIhoJxyTCg==
Date: Tue, 19 Dec 2023 10:52:59 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, lorenzo.bianconi@redhat.com, nbd@nbd.name,
	john@phrozen.org, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix possible NULL pointer
 dereference in mtk_wed_wo_queue_tx_clean()
Message-ID: <20231219105259.GF811967@kernel.org>
References: <3c1262464d215faa8acebfc08869798c81c96f4a.1702827359.git.lorenzo@kernel.org>
 <20231218175548.GI6288@kernel.org>
 <ZYC2m3mMhfOpDN2j@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYC2m3mMhfOpDN2j@lore-desk>

On Mon, Dec 18, 2023 at 10:16:11PM +0100, Lorenzo Bianconi wrote:
> > On Sun, Dec 17, 2023 at 04:37:40PM +0100, Lorenzo Bianconi wrote:
> > > In order to avoid a NULL pointer dereference, check entry->buf pointer before running
> > > skb_free_frag in mtk_wed_wo_queue_tx_clean routine.
> > > 
> > > Fixes: 799684448e3e ("net: ethernet: mtk_wed: introduce wed wo support")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > 
> > Hi Lorenzo,
> 
> Hi Simon,
> 
> > 
> > can I clarify that this can actually happen?
> 
> I was able to trigger the crash on a real device (Banana Pi BPI-R4) but
> with a wrong swiotlb configuration. I do not have a strong opinion, I am
> fine to target net-next instead. What do you prefer?

I also don't have a strong opinion here.
But lean towards 'net' if you were able to trigger a crash.

> 
> Regards,
> Lorenzo
> 
> > What I am getting at, is that if not, it might be net-next material.
> > In either case, I have no objection to the change itself.
> > 
> > Reviewed-by: Simon Horman <horms@kernel.org>



