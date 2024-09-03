Return-Path: <netdev+bounces-124607-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7365496A2A1
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 17:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DD791F28FF0
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 15:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787F618BC06;
	Tue,  3 Sep 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZeaettQk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5190018BBB6;
	Tue,  3 Sep 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725377130; cv=none; b=cD29OaLmsiF6/i7CdrIqwUmip4z8P+Sd2YRPqbz2LmsFH3x7wx64xzUfPJiDYBY+1tfI9s1RHBXphNVhO5DdKeXs0bB7Xq6k2VtGFUBx3JFi9gaPwXWlwybm7TWTCYDVaMDXhXutysUdMhW+w5pLSLHby7BmJnVp0DmpOXPw9f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725377130; c=relaxed/simple;
	bh=NzTUmUqb1pcIqhYJTsD/7reom8G6ax17uBj3IOYVPCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pTrBdfrqG55nmwOkdLNHdmbAgm3n206PVS4XHRPX6IKil+mhg9NmhzPpBUR206RsJWTNtCTfv/h1WmSFXhEOoJNvtFHY08oDRSbraCB5480JTKBF+B/SiUyX90IjWVIHIBBbeXKJ6zFUYXmk+EpeSJx52s8yd2sY2DzggpsTKd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZeaettQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D193C4CEC4;
	Tue,  3 Sep 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725377130;
	bh=NzTUmUqb1pcIqhYJTsD/7reom8G6ax17uBj3IOYVPCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZeaettQkOkHlYywmGqrgRmeCu5Hlh4aCuJLM9CPgIdPSLxLsW41+FsMRMltGu5pWE
	 Ut3sRsMu9hi/VHGzoG6EBLUvSPdoiY/zQeii2rpiPDuNDfHf/jysRh6fQqJj6pxrqs
	 dgUj27QwgA1tH3SHkIXI1Xq9QSYg05RhQ/3UwlDq/CHBuX6wLLN84+kSfgBfmAo1ZN
	 4D3uQFqvo1abKTtKsgqCgLGfaBsmi8MZvlpGi1ll038LpaRUtPiVU9uqqGV4dPUr9L
	 8N20lY4pGykKF0Z+SwfBDyYerAH4uJ7FdC45KnDtsgs2CEQCqYhQnCuvZlETiHb/sO
	 GnQcHSdgb3tkA==
Date: Tue, 3 Sep 2024 16:25:24 +0100
From: Simon Horman <horms@kernel.org>
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	netdev@vger.kernel.org, llvm@lists.linux.dev,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	intel-wired-lan@lists.osuosl.org, Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: Consistently use
 ethtool_puts() to copy strings
Message-ID: <20240903152524.GC4792@kernel.org>
References: <20240902-igc-ss-puts-v1-1-c66a73b532c7@kernel.org>
 <88384607-4fcf-4ab1-8edf-9258df0bbf3c@embeddedor.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88384607-4fcf-4ab1-8edf-9258df0bbf3c@embeddedor.com>

On Mon, Sep 02, 2024 at 01:55:41PM -0600, Gustavo A. R. Silva wrote:
> 
> 
> On 02/09/24 06:46, Simon Horman wrote:
> > ethtool_puts() is the preferred method for copying ethtool strings.
> > And ethtool_puts() is already used to copy ethtool strings in
> > igc_ethtool_get_strings(). With this patch igc_ethtool_get_strings()
> > uses it for all such cases.
> > 
> > In general, the compiler can't use fortification to verify that the
> > destination buffer isn't over-run when the destination is the first
> > element of an array, and more than one element of the array is to be
> > written by memcpy().
> > 
> > For the ETH_SS_PRIV_FLAGS the problem doesn't manifest as there is only
> > one element in the igc_priv_flags_strings array.
> > 
> > In the ETH_SS_TEST case, there is more than one element of
> > igc_gstrings_test, and from the compiler's perspective, that element is
> > overrun. In practice it does not overrun the overall size of the array,
> > but it is nice to use tooling to help us where possible. In this case
> > the problem is flagged as follows.
> > 
> > Flagged by clang-18 as:
> > 
> > In file included from drivers/net/ethernet/intel/igc/igc_ethtool.c:5:
> > In file included from ./include/linux/if_vlan.h:10:
> > In file included from ./include/linux/netdevice.h:24:
> > In file included from ./include/linux/timer.h:6:
> > In file included from ./include/linux/ktime.h:25:
> > In file included from ./include/linux/jiffies.h:10:
> > In file included from ./include/linux/time.h:60:
> > In file included from ./include/linux/time32.h:13:
> > In file included from ./include/linux/timex.h:67:
> > In file included from ./arch/x86/include/asm/timex.h:5:
> > In file included from ./arch/x86/include/asm/processor.h:19:
> > In file included from ./arch/x86/include/asm/cpuid.h:62:
> > In file included from ./arch/x86/include/asm/paravirt.h:21:
> > In file included from ./include/linux/cpumask.h:12:
> > In file included from ./include/linux/bitmap.h:13:
> > In file included from ./include/linux/string.h:374:
> > .../fortify-string.h:580:4: warning: call to '__read_overflow2_field' declared with 'warning' attribute: detected read beyond size of field (2nd parameter); maybe use struct_group()? [-Wattribute-warning]
> > 
> > And Smatch as:
> > 
> > .../igc_ethtool.c:771 igc_ethtool_get_strings() error: __builtin_memcpy() '*igc_gstrings_test' too small (32 vs 160)
> > 
> > Curiously, not flagged by gcc-14.
> > 
> > Compile tested only.
> > 
> > Signed-off-by: Simon Horman <horms@kernel.org>
> > ---
> >   drivers/net/ethernet/intel/igc/igc_ethtool.c | 8 ++++----
> >   1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > index 457b5d7f1610..ccace77c6c2d 100644
> > --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> > @@ -768,8 +768,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
> >   	switch (stringset) {
> >   	case ETH_SS_TEST:
> > -		memcpy(data, *igc_gstrings_test,
> > -		       IGC_TEST_LEN * ETH_GSTRING_LEN);
> 
> I think this problem should be solved if we use the array's address,
> which in this case is `igc_gstrings_test`, instead of the address of
> the first row. So, the above should look as follows:
> 
> memcpy(data, igc_gstrings_test, IGC_TEST_LEN * ETH_GSTRING_LEN);

Thanks for the advice.
FWIIW, I do like the consistency of using ethtool_puts().
But, OTOH, your suggestion is much simpler.
I will send an updated the patch accordingly.

> 
> > +		for (i = 0; i < IGC_TEST_LEN; i++)
> > +			ethtool_puts(&p, igc_gstrings_test[i]);
> >   		break;
> >   	case ETH_SS_STATS:
> >   		for (i = 0; i < IGC_GLOBAL_STATS_LEN; i++)
> > @@ -791,8 +791,8 @@ static void igc_ethtool_get_strings(struct net_device *netdev, u32 stringset,
> >   		/* BUG_ON(p - data != IGC_STATS_LEN * ETH_GSTRING_LEN); */
> >   		break;
> >   	case ETH_SS_PRIV_FLAGS:
> > -		memcpy(data, igc_priv_flags_strings,
> > -		       IGC_PRIV_FLAGS_STR_LEN * ETH_GSTRING_LEN);
> 
> In this case, the code is effectively reading from the array's address.

True. In light of your other suggestion I'll drop this hung.

