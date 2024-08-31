Return-Path: <netdev+bounces-123988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A194B9672DB
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 19:39:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44FC1C21354
	for <lists+netdev@lfdr.de>; Sat, 31 Aug 2024 17:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1954658210;
	Sat, 31 Aug 2024 17:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mADuve5h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A8524F
	for <netdev@vger.kernel.org>; Sat, 31 Aug 2024 17:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725125979; cv=none; b=TDVHNPa3UBCWdeFGG0LVURG6M8BW0iL9wzXIhYLHiaVpi8vbR5mWi8HTUrrjEHafsltlgsXJTRDsFMn5HbKG+1bpikc8v1xWDd6EwPMqXXVSkOuavW3Z/dcShzHwJx0746+iyztpuT4mxth4shclOtKPdvMJk7FGqagqgIuhSUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725125979; c=relaxed/simple;
	bh=6SMAQxAGQuRTpvcOEwC7QTvR5Nu6tSJG1pUC0/B4WZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WvNzpAZp4QSB3h06N+kMmDE7/6C0gSdzMzvMCXCaWE1ywt1L1H+zk/i0lY9iYm+lF1x9HlhWIIXLtp7f3gxT1dAaIbC82DDammwMn+sSDTMcc9ya4FLeSYvIUxOvGtDg8QVTBc+kofvUqrym8r+0VA6uEiURrLa63nQxdR5jtec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mADuve5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7DFFC4CEC0;
	Sat, 31 Aug 2024 17:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725125978;
	bh=6SMAQxAGQuRTpvcOEwC7QTvR5Nu6tSJG1pUC0/B4WZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mADuve5h9RJTEDMHgRO5u5WIDjU5/hidlImSeZsLKW6m8/nyB7pGZKRVaZckPPSAh
	 SsKAf+9kWt77Nx/iIWweq0Nq+sZnJlB25T8Xgz+XLyGcbRkX4beeQxhFt9HDPbm6xd
	 hpnEIR+DT7X31bYPrQJSamaYQF7GV2ZWAR2wo4D8yIL8V9lIsKP63+aqEmoqeLr5SJ
	 SZOY18pfmJWeGN99NvpEn7vD3NlGkDIS2na+PPTLLHqSDrjEhhY7oX3ffuNUVsjvxx
	 b9UW1zh/KZcvp/1wMQJILZb0cF6ztebepvFcXmdRdLP5MqOudOzbR9Ro2BA/0yWjSv
	 W4qGlzFplcn4A==
Date: Sat, 31 Aug 2024 20:39:34 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Feng Wang <wangfe@google.com>, netdev@vger.kernel.org,
	antony.antony@secunet.com
Subject: Re: [PATCH] xfrm: add SA information to the offloaded packet
Message-ID: <20240831173934.GC4000@unreal>
References: <20240822200252.472298-1-wangfe@google.com>
 <Zs62fyjudeEJvJsQ@gauss3.secunet.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs62fyjudeEJvJsQ@gauss3.secunet.de>

On Wed, Aug 28, 2024 at 07:32:47AM +0200, Steffen Klassert wrote:
> On Thu, Aug 22, 2024 at 01:02:52PM -0700, Feng Wang wrote:
> > From: wangfe <wangfe@google.com>
> > 
> > In packet offload mode, append Security Association (SA) information
> > to each packet, replicating the crypto offload implementation.
> > The XFRM_XMIT flag is set to enable packet to be returned immediately
> > from the validate_xmit_xfrm function, thus aligning with the existing
> > code path for packet offload mode.
> > 
> > This SA info helps HW offload match packets to their correct security
> > policies. The XFRM interface ID is included, which is crucial in setups
> > with multiple XFRM interfaces where source/destination addresses alone
> > can't pinpoint the right policy.
> > 
> > Signed-off-by: wangfe <wangfe@google.com>
> 
> Applied to ipsec-next, thanks Feng!

Steffen,

What is your position on this patch?
It is the same patch (logically) as the one that was rejected before?
https://lore.kernel.org/all/ZfpnCIv+8eYd7CpO@gauss3.secunet.de/

Thanks

