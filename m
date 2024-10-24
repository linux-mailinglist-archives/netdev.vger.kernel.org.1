Return-Path: <netdev+bounces-138723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 354C49AEA50
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 17:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E99DE2834EA
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 15:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8EB1EABCC;
	Thu, 24 Oct 2024 15:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Noua3rKC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267A81E7C00
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 15:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783368; cv=none; b=BrxJAdEiZRdG4N01XjmAhYESpYFwyZ0lc8TmCLbZQfs60y6zfUVcAsdAqRO2na/hADMKuJbwujtXgZa71bH6VbcBgN6Y/7GiFqZFAkZexhXn+fOFLGK9AfvSiRyugNzFV5OmmGHyCA3BnO5wf7uRunpRIr6NPLNS00rJJT7gf3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783368; c=relaxed/simple;
	bh=hqjOsOMElCCUYZjQNxPPt7PE9LtcXYLcTepUmNVQeGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mydyvzQU+nm85gUkmnttVPJAXvexd73A90Wxj0jvv+OZbFbeyJ7kzIIbQJTY8Jj0F5WhReKaipSOaQ0UqhY13w4j1Xc1CrdWrnDjlhiGCN1BmLo3Q86eu9QnKXAuitA+GjT9O+D6czOC2XNWlRZtek90uwCz0dfoJCAO+lmTlV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Noua3rKC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 888C8C4CEC7;
	Thu, 24 Oct 2024 15:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729783367;
	bh=hqjOsOMElCCUYZjQNxPPt7PE9LtcXYLcTepUmNVQeGc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Noua3rKCcUpHHngMPJVCbAvkqRFKAWJOnhIUZgPjAY0yH+kuvJIcZyJncmxyTPY8W
	 e/nW3zu9ZhIJc91fQX+mEtdvecz5NqGWs3O86Ib413dA4PsAmCq1TxSmqltSO8D96W
	 LyXVrVfXDSzZvBS/logzbjQUsHu0rGtAzLNImMjAxK/2XAcy1pp36tNbAm+eQKiFQ7
	 b/UypLMwkr6EcmmsZb+uAd7dpt/5YlCwgpT/9uvJB1fNIYEUFse88HfYFSt1ZUYF+/
	 pSaA0YcRpwEQWc9q1cIvqpr1Ese5ooQojWKS6R1n0MUurBuSDY4oCGTi+p2O06eFDr
	 3OpbkBsR5yw/Q==
Date: Thu, 24 Oct 2024 16:22:43 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Gax-c <zichenxie0106@gmail.com>, kuba@kernel.org, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	idosch@nvidia.com, netdev@vger.kernel.org, zzjas98@gmail.com,
	chenyuan0y@gmail.com
Subject: Re: [PATCH v2] netdevsim: Add trailing zero to terminate the string
 in nsim_nexthop_bucket_activity_write()
Message-ID: <20241024152243.GY1202098@kernel.org>
References: <20241022171907.8606-1-zichenxie0106@gmail.com>
 <20241024105508.GA1202098@kernel.org>
 <8734klit9w.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8734klit9w.fsf@nvidia.com>

On Thu, Oct 24, 2024 at 02:15:54PM +0200, Petr Machata wrote:
> 
> Simon Horman <horms@kernel.org> writes:
> 
> > On Tue, Oct 22, 2024 at 12:19:08PM -0500, Gax-c wrote:
> >
> >> diff --git a/drivers/net/netdevsim/fib.c b/drivers/net/netdevsim/fib.c
> >> index 41e80f78b316..16c382c42227 100644
> >> --- a/drivers/net/netdevsim/fib.c
> >> +++ b/drivers/net/netdevsim/fib.c
> >> @@ -1377,10 +1377,12 @@ static ssize_t nsim_nexthop_bucket_activity_write(struct file *file,
> >>  
> >>  	if (pos != 0)
> >>  		return -EINVAL;
> >> -	if (size > sizeof(buf))
> >> +	if (size > sizeof(buf) - 1)
> >
> > I don't think this change for the best.
> > If the input data is well formatted it will end with a '\0'.
> > Which may be copied into the last byte of buf.
> >
> > With this change the maximum size of the input data is
> > unnecessarily reduced by one.
> 
> The buffer is 128 bytes, and sscanf'd into it is a u32 and u16, say 18
> bytes or so total. Arguably the buffer is unnecessarily large. I think
> the -1 above doesn't hurt.
> 
> Though if (user_buf[size - 1]) return -EINVAL; would work, too?

It might be fun if size is 0.

I realised after sending that 128 is really just an arbitrary value,
and losing 1 byte is unlikely to hurt. So I withdraw my previous comment:
I think this patch is fine module the review already given by yourself
and Ido.

