Return-Path: <netdev+bounces-174538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96E46A5F194
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 11:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7406D188CD5A
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D20266EFC;
	Thu, 13 Mar 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kMjB843X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7639266EF5;
	Thu, 13 Mar 2025 10:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863054; cv=none; b=DP5AcudKA0NoArOZUQJ29AjwjBUb8XsJT2+JFbHLdnifJ80atZ9iMSAvX6h0OhcK0C4OZleApyA30H6eT1emhLtKzNeiEv5tcJTuKkT001qNpeMElGaKPnJrv65Nbj5f/cuOvl2mxXsTW/Zf3E83rP7vvXKzS7/0eeJ3ZERk8NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863054; c=relaxed/simple;
	bh=nODtJT29CKvmOEI9QAsNYVKYtKfqusCBX1PfkBziy7w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hPju+gl+r0NlUBCSuw2bTWfZTY4BwD+U4gB6MhuTb33nmCqVAuIa1/4SIgpJ/fj38427mf4UIha0AL/96s/q5O5npJ7LceyWZbJLnhCHahaRgRXBCqxq3YYtl8GcpkpIOyAorN5Y4woewDR3u3s8jyfN6JpuGzlmrN5t+zkfNUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kMjB843X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D7FCC4CEE3;
	Thu, 13 Mar 2025 10:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741863054;
	bh=nODtJT29CKvmOEI9QAsNYVKYtKfqusCBX1PfkBziy7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kMjB843X1w5QW6oeULyneZwnbTPkTzCJirm2kk7nqBtoehRz903zN0tIfvaKQKNzc
	 hJ0KoH0s7t+XB96Yv/QzrmbB796ZiD+3X2eeq70GS7dN5V0o/p19Jezwby39OlBPeA
	 nbavVPgHW3V9JLtCsTqDYt9LlYFaY+DjGoYzt46LTT1xD2qrq1XmWljgIb/zDGGjUy
	 7K+1vjrXUNKj7mhWv4jsHuUjOEEUsKdHR3wgUV/ViCzwzU1TxpUzh42SPGu4Vm8+GT
	 mEDbsigilGcfGC19FNvk4nU+03Bafdlpc9/oi6e2GXRWugSEqFvCZVxUwt1BY4Rgpu
	 fJPJjujonI/9w==
Date: Thu, 13 Mar 2025 11:50:43 +0100
From: Simon Horman <horms@kernel.org>
To: Helge Deller <deller@gmx.de>
Cc: deller@kernel.org, netdev@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tulip: avoid unused variable warning
Message-ID: <20250313105043.GX4159220@kernel.org>
References: <20250309214238.66155-1-deller@kernel.org>
 <20250312131433.GS4159220@kernel.org>
 <d863db0a-1740-45d5-b8de-746fa9d44fcb@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d863db0a-1740-45d5-b8de-746fa9d44fcb@gmx.de>

On Wed, Mar 12, 2025 at 03:08:35PM +0100, Helge Deller wrote:
> On 3/12/25 14:14, Simon Horman wrote:
> > On Sun, Mar 09, 2025 at 10:42:38PM +0100, deller@kernel.org wrote:
> > > From: Helge Deller <deller@gmx.de>
> > > 
> > > When compiling with W=1 and CONFIG_TULIP_MWI=n one gets this warning:
> > >   drivers/net/ethernet/dec/tulip/tulip_core.c: In function ‘tulip_init_one’:
> > >   drivers/net/ethernet/dec/tulip/tulip_core.c:1309:22: warning: variable ‘force_csr0’ set but not used
> > > 
> > > Avoid it by annotating the variable __maybe_unused, which seems to be
> > > the easiest solution.
> > > 
> > > Signed-off-by: Helge Deller <deller@gmx.de>
> > 
> > Hi Helge,
> > 
> > A few thoughts on this:
> 
> Hi Simon,
> 
> Thanks for following up on this!
> 
> > Firstly, thanks for your patch, which I agree addresses the problem you
> > have described.
> > 
> > However, AFAIK, this is a rather old driver and I'm not sure that
> > addressing somewhat cosmetic problems are worth the churn they cause:
> > maybe it's best to leave it be.
> 
> Well, the only reason why I sent this patch is, because some people
> are interested to get a Linux kernel build without any warnings when "W=1"
> option is enabled.
> This code in the tulip driver is one of the last 10 places in the kernel where
> I see a warning at all, so I think it's worth fixing it, although it's just
> cosmetic.
> 
> 
> > But if we do want to fix this problem, I do wonder if the following
> > solution, which leverages IS_ENABLED, is somehow nicer as
> > it slightly reduces the amount of conditionally compiled code,
> > thus increasing compile test coverage.
> 
> Full Ack from my side!
> I wanted to keep my patch small, but your proposed patch is the better one.
> 
> I did not compile-test it, but if it builds you may add my:
> Acked-by: Helge Deller <deller@gmx.de>

Thanks, I posted v2 here:

https://lore.kernel.org/netdev/20250313-tulip-w1-v2-1-2ac0d3d909f9@kernel.org/T/#u

