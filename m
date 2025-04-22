Return-Path: <netdev+bounces-184643-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13030A96B1B
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 14:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F08B189C5A4
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 12:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D65627F4F3;
	Tue, 22 Apr 2025 12:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fC/4EfCn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F2027CCF2;
	Tue, 22 Apr 2025 12:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745326551; cv=none; b=IE/v6fgqk68gyn2jzL1yZKzcH+8oF8XZPtbOPti5RrBIi80MKZ2LpXXgkAUGUgeRC2BRafofjlA04k2mO0JJk0s1kYmwlWPU/dqpRI49RFGCZuI8RI7faOCqVnHdc3LKA8c3htfzSCpNJxGSbz8bBzKl2BmT1+meNlkgvkD05TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745326551; c=relaxed/simple;
	bh=23lGibbpCWsKFhyVf09PLpwkS/HoiLavqSRhsBIhO+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rh1dkFLVCr0Lk3F6jQtGaUpJyk76huLPy0bxR559AJchZgykrmlo8Cek9OZnw/hOB8syCE8m4TsjVfYv1RCzyz50NHmw1ojFOxdBtoCllcgLeU3Ixm/cJ2vRXXnTi55lqAuYXLIy7GHJztQsfCnYS66i1gJL9jlKPgmfLQXKEfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fC/4EfCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DC0C4CEE9;
	Tue, 22 Apr 2025 12:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745326550;
	bh=23lGibbpCWsKFhyVf09PLpwkS/HoiLavqSRhsBIhO+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fC/4EfCnRvTqvUqLczxKDzuKW7t+koIBTllhy5V7l7xpRZx7gzvgeZ7/89h/M379G
	 db5jtNFkOdOHkgMaN0E0KIS1AXajLo/A2BfqkdZyGcfmQA6Upw7icf7kceS+x76IM2
	 4FbyUk99N3HRTJNcWtelg9n7hvkNrK1Wp0Kh1ZctkhOKlw4rLm09z1Sn/rCyihyB1c
	 yVqbMfqyUYGI479lqIJl489OqT4V5sMaliLz7LEjYL3UWzu3QB0eRkZej2Ns2uty0r
	 njGykB5JduHMJ+9su3KUiif/3qEtNZpnYR2DqFN4aYRm1r+qN8w44ExPjEgGQv0T7E
	 0FjkDfCCxl09A==
Date: Tue, 22 Apr 2025 13:55:46 +0100
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net v3 2/3] rtase: Increase the size of ivec->name
Message-ID: <20250422125546.GF2843373@horms.kernel.org>
References: <20250417085659.5740-1-justinlai0215@realtek.com>
 <20250417085659.5740-3-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250417085659.5740-3-justinlai0215@realtek.com>

On Thu, Apr 17, 2025 at 04:56:58PM +0800, Justin Lai wrote:
> Fix the following compile warning reported by the kernel test robot by
> increasing the size of ivec->name.
> 
> drivers/net/ethernet/realtek/rtase/rtase_main.c: In function 'rtase_open':
> >> drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:52: warning:
> '%i' directive output may be truncated writing between 1 and 10 bytes
> into a region of size between 7 and 22 [-Wformat-truncation=]
>      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
>                                                      ^~
>  drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:45: note:
>  directive argument in the range [0, 2147483647]
>      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
>                                               ^~~~~~~~~~
>  drivers/net/ethernet/realtek/rtase/rtase_main.c:1117:4: note:
>  'snprintf' output between 6 and 30 bytes into a destination of
>  size 26
>      snprintf(ivec->name, sizeof(ivec->name), "%s_int%i",
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>        tp->dev->name, i);
>        ~~~~~~~~~~~~~~~~~

Hi Justin,

Given that the type of i is u16, it's theoretical range of values is [0, 65536].
(I expect that in practice the range is significantly smaller.)

So the string representation of i should fit in the minumum of 7 bytes available
(only a maximum of 5 are needed).

And I do notice that newer compilers do not seem to warn about this.

So I don't really think this needs updating.
And if so, certainly not as a fix for 'net'.

Also, as an aside, as i is unsigned, the format specifier really ought
to be %u instead of %i. Not that it seems to make any difference here
given the range of values discussed above.

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202503182158.nkAlbJWX-lkp@intel.com/
> Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

-- 
pw-bot: changes-requested

