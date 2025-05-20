Return-Path: <netdev+bounces-192067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8050CABE75F
	for <lists+netdev@lfdr.de>; Wed, 21 May 2025 00:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 420467B63E5
	for <lists+netdev@lfdr.de>; Tue, 20 May 2025 22:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2525F976;
	Tue, 20 May 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0SqrZ2+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC9825CC46;
	Tue, 20 May 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747780784; cv=none; b=ogdznWQ1H8GCK86yOjgKvWgFOyokbTHGUBPsVGijl3dlXFxSnm/C/ChJRycJhJQFz7x5D5AWYe5YfDf4vJaeR54XYH+U59XrFpmsXwrsmCpQi41TF5kKHh2RosZX/kRoN4lwDUEaCHq7CHrogK2fioUT6L/7wpXAMEzWEJ1g4Uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747780784; c=relaxed/simple;
	bh=Ba/FhmLexBi3mPBWZB+4SlEG/6brlQ6vfvQAbNqiwqw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f6zrwrPTSrll3LlyJMsID72sQPim2eSSaTeBZnB4120CnPZeGi+vGirPb1+iGhSf25AT7wJaM9+ZzMFMyeWY+Eja+OH1prFDiiZooreQYk9KA5lXW5euCe+r0HDmRiVVe00L599k7UWE1w5lH8aH1FPGV06i2JZynatAwlV/zj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0SqrZ2+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D70AC4CEE9;
	Tue, 20 May 2025 22:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747780784;
	bh=Ba/FhmLexBi3mPBWZB+4SlEG/6brlQ6vfvQAbNqiwqw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=B0SqrZ2+Pr88VCSbssvnXmw1Bnr/JVMF8S6WA+sisgl1IboJsa6DCT1eWb0nWy4Nu
	 zwLOTn0SCZEIhTA+iA/wpFgEJCwTiyFxPHx4/rFp/b8e0Q1avyYMdrrdXMpAVYmwGO
	 ymIfhJIVNdgdCAHBRtmARdXT8hqZKmdHR81NQqKwgpvl2jyVQsbb5qynAATxqMAT2S
	 rc0/0JVwSHs++YRk2H2ncfnjoQiSToRRzFi+L2yo8TDWjO96+lZl9nPoAl8ngzD6Fy
	 dqTgYe8GkKWNviFC61B3Sy0tsACp5MIiIR46Z08Y2Bo1S+VBILf2icigNAHSgrGQkC
	 vPm9FLBs6Ml5Q==
Date: Tue, 20 May 2025 15:39:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jinjian Song <jinjian.song@fibocom.com>
Cc: andrew+netdev@lunn.ch, angelogioacchino.delregno@collabora.com,
 chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 corbet@lwn.net, danielwinkler@google.com, davem@davemloft.net,
 edumazet@google.com, haijun.liu@mediatek.com, helgaas@kernel.org,
 horms@kernel.org, johannes@sipsolutions.net,
 linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 loic.poulain@linaro.org, m.chetan.kumar@linux.intel.com,
 matthias.bgg@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com,
 ricardo.martinez@linux.intel.com, ryazanov.s.a@gmail.com, liuqf@fibocom.com
Subject: Re: [net v1] net: wwan: t7xx: Fix napi rx poll issue
Message-ID: <20250520153942.7cb63bac@kernel.org>
In-Reply-To: <20250516084842.26c80cb5@kernel.org>
References: <20250515031743.246178-1-jinjian.song@fibocom.com>
	<20250515175251.58b5123f@kernel.org>
	<20250516084842.26c80cb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 20 May 2025 15:05:34 +0800 Jinjian Song wrote:
> >Synchronization is about ensuring that the condition validating
> >by the if() remains true for as long as necessary.
> >You need to wrap the read with READ_ONCE() and write with WRITE_ONCE().
> >The rest if fine because netdev unregister sync against NAPIs in flight.
> >  
> 
> Hi Jakub,
>   I think I got your point.
>   I can use the atomic_t usage in struct t7xx_ccmni to synchronization.
>   
>   static void t7xx_ccmni_wwan_dellink(...) {
> 
>   [...]
> 
>   if (WARN_ON(ctlb->ccmni_inst[if_id] != ccmni))
>     return;
> 
>   unregister_netdevice(dev);
> 
>   //Add here use this variable(ccmnii->usage) to synchronization
> 
>   if (atomic_read(&ccmni->usage) == 0)
>      ccmni == NULL;
> 
>   }
> 
>   How about this modify?

Just use READ_ONCE() / WRITE_ONCE() on the pointer as I suggested.

