Return-Path: <netdev+bounces-47478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B377EA628
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 23:52:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 304BFB209AE
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 22:52:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65E2324A00;
	Mon, 13 Nov 2023 22:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkptuGKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A53E249FA
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 22:52:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25099C433C7;
	Mon, 13 Nov 2023 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699915944;
	bh=UIvnWyXUtK4lhLZDh5Bp9ms/ksdAdZBHzb69ZVetNqI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gkptuGKoHWK/WcsX5MIfyzlhRy0HPBMxuMxHLCrh/Vqt1/ztx0biPUAmqhmTqESCz
	 4ow188sotvjjD/jAWtHjABtg5PfLH38lfrP3KyvBfi/Gh7KEYDgOTjwr1/NfuFVFlF
	 SA7rgeWJB7UhwGK9s2+FbKCK4zxPet4fk1PYF1s0IGW8GH+yDsosxEJ13pczHqa4n2
	 sh7pA8EY9XEdBcdjdGKioobBveHISfTP+qEFJL20+CrLNDDE5kut8pMObkumrVsE25
	 tYdDC6SzlKQi14fJobsAedwiV+95rkT/RNwSvlYSd3BttSMe14KbubDbRUJbtpHJdt
	 EBA8x6h3raNrg==
Date: Mon, 13 Nov 2023 17:52:22 -0500
From: Jakub Kicinski <kuba@kernel.org>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
 <joabreu@synopsys.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: stmmac: avoid rx queue overrun
Message-ID: <20231113175222.674a3971@kernel.org>
In-Reply-To: <d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>
References: <d9486296c3b6b12ab3a0515fcd47d56447a07bfc.1699897370.git.baruch@tkos.co.il>
	<d95413e44c97d4692e72cec13a75f894abeb6998.1699897370.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 19:42:50 +0200 Baruch Siach wrote:
> dma_rx_size can be set as low as 64. Rx budget might be higher than
> that. Make sure to not overrun allocated rx buffers when budget is
> larger.
> 
> Leave one descriptor unused to avoid wrap around of 'dirty_rx' vs
> 'cur_rx'.

Can we get a Fixes tag for this one as well?

