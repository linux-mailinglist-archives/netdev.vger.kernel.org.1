Return-Path: <netdev+bounces-143320-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F8D9C1FF2
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 16:03:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6F0284003
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 15:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892A31F4721;
	Fri,  8 Nov 2024 15:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QMuNQ79/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1421E3772;
	Fri,  8 Nov 2024 15:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731078195; cv=none; b=JbgJBwpPJgY9EknIo4kMglfP9Fnby2xTviNRCOWIrQWeDCJYJR8aSj/xE5bQuRN2XL3i8gAlw4cIr9VYMqp3a+pEzShqpokjctZIcDbQytzsb8Uq/9DoiVu39LkmukFqhbKyZ71/tY1XVz14Q7Y7duGWDdeNH78HQmRm2HJYueI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731078195; c=relaxed/simple;
	bh=eO/169y/RDrJ9YFf2P0i4jCDwhotL6vp5e4BQUh08Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aktn2EKYLLKqcjxwdg0HNOSfZwOTe4P5tBaIJWsnsQp4/86Eh0jK937s/60eDujswFb5/IvybMy34+cJbUsiTTNKKqCV11R/nAa5jGNC+2XLXoQLJWIgUw3e0FIIANIs9RXa5ShPBP5O0Mcom+C2K74b1HV9ApaanxJAa3mY10I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QMuNQ79/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A969C4CECD;
	Fri,  8 Nov 2024 15:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731078194;
	bh=eO/169y/RDrJ9YFf2P0i4jCDwhotL6vp5e4BQUh08Iw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QMuNQ79/27UY+78SPsaXOTUTgmChvQM1sblExDs2MyIo6gzVtaOi2/9tPROLhgGDp
	 VfooZ1SU52Oywiofrvj8hqvaQBuzX/Dcpxbcj9crqQInridQQ52kWefAH8j0TKw0oi
	 R4B03kzPPX1Up+LhfpReqgOC+ev6RaVpW7DyhhyRehZp8W/y+QLfrhFFgPGyiCagww
	 eHXDnXSKW0MRrA20zjE2X7rWz2T/s8A2E/Bw8cIh8xaR3k9W1nSGfm8m9ieEm3t9+R
	 IEDKCjgMTXGkmc8F4OFfTk70gA1NYEXcpvkRe7EgZuILCmDk5syHZY004KBNh4/S2o
	 BjEUbKAThKgIQ==
Date: Fri, 8 Nov 2024 15:03:10 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Karsten Keil <isdn@linux-pingi.de>, Jakub Kicinski <kuba@kernel.org>,
	Jeff Johnson <quic_jjohnson@quicinc.com>,
	Dan Carpenter <dan.carpenter@linaro.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v2] mISDN: Fix typos
Message-ID: <20241108150310.GE4507@kernel.org>
References: <20241102134856.11322-1-algonell@gmail.com>
 <20241106112513.9559-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106112513.9559-1-algonell@gmail.com>

On Wed, Nov 06, 2024 at 01:24:20PM +0200, Andrew Kreimer wrote:
> Fix typos:
>   - syncronized -> synchronized
>   - interfacs -> interface
>   - otherwhise -> otherwise
>   - ony -> only
>   - busses -> buses
>   - maxinum -> maximum
> 
> Via codespell.
> 
> Reported-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
> v1:
>   - Fix typos in printk messages.
>   - https://lore.kernel.org/netdev/20241102134856.11322-1-algonell@gmail.com/
> 
> v2:
>   - Address all non-false-positive suggestions, including comments.
>   - The syncronized ==> synchronized suggestions for struct hfc_multi were skipped.

Thanks Andrew.

Reviewed-by: Simon Horman <horms@kernel.org>


