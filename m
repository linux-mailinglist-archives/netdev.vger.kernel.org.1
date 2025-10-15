Return-Path: <netdev+bounces-229733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA291BE0508
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 21:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5731519C06F6
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFD3302750;
	Wed, 15 Oct 2025 19:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GprOI7uh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F9532548D
	for <netdev@vger.kernel.org>; Wed, 15 Oct 2025 19:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760555372; cv=none; b=F2qcAE6mNddqzX11E8fRsNX0IAwmPCn60VxMWwCsP+x6f+G63yCEafrjaqteZKy1SLDBPzT7SnRhD8cGEVk1isSOGFw18TkxtjVnvMFZvH7zWGQPFZpf0Gwgu2cycgmHQ8p6/Cf+8nZzHJtJZCMO2JcJF0xinq5Eribox+AsEpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760555372; c=relaxed/simple;
	bh=Qe+2hMfgLx2Jy+G0M+RBidUSC3hrdRGoE4obQZyojsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEBzqAar3pIprWiarHlbMXSi0+ZpzUgy0Xd+IXKW4bwhgcAYqLMxBK2Gp+1n6mynUhSNAnH1Sj2f43m7JXwyO3dxPelG83tdyRRdBNr0RP4cVNZ7waPzlxN+M9Bc+PXnUIOqFxm0znLd8SYZFLXM5sPAlPFIDzN5syUPOVHTIVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GprOI7uh; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760555369; x=1792091369;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Qe+2hMfgLx2Jy+G0M+RBidUSC3hrdRGoE4obQZyojsY=;
  b=GprOI7uhUVQkI/sReWz7jMO1taWU2Tx+3S9X2QjxkjtEipl+HN5C/Fcn
   KWhm4g2LtYxnVQYYWhnHIOjV484PHW1oPFEnhkzyMyF0oz+totEfc5J6N
   MLH6Zt1cmFE68QVI7FMuSuBcu8c33fOhnZosYHGAU2LpjkGGZ3bMmHUn7
   uhUKApQ22iX1/ZbjfAsGAEUgF0nncmQNXaNWOoenUFSN4Ozf7A1sDyoRK
   p1JY3uEISsgQlOhGy0SuUl0wvLfZcvVHPDNjbvF+5ShbFypBi9JTV2NN4
   CtPLTxjPAPRq9VxOp4oMTT+OQ7aDLgXPxgZs8c853Mg8trwXfhMlYXjIC
   w==;
X-CSE-ConnectionGUID: /CrdPS2CSgKyPAZTNjB+LQ==
X-CSE-MsgGUID: nKGzexNRS+OLmiFEZMF5NQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="62650503"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="62650503"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:09:27 -0700
X-CSE-ConnectionGUID: Y1SE77ciQHKOY8Cd1GSsBA==
X-CSE-MsgGUID: 3VE+azRVSYKSJ5rikSIx/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,232,1754982000"; 
   d="scan'208";a="181805376"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:09:26 -0700
Date: Wed, 15 Oct 2025 21:07:26 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ixgbe: guard fwlog code by
 CONFIG_DEBUG_FS
Message-ID: <aO/w7gnXquHNK6k7@mev-dev.igk.intel.com>
References: <20251014141110.751104-1-michal.swiatkowski@linux.intel.com>
 <11eac3d4-d81c-42e2-b9e3-d6f715a946b2@intel.com>
 <aO8wDmPWWEV6+tkZ@mev-dev.igk.intel.com>
 <0c8c5f34-c5cb-4a81-98fc-e3b957a2a8e9@intel.com>
 <e94f188d-3578-447f-8815-6c2393f2f807@roeck-us.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e94f188d-3578-447f-8815-6c2393f2f807@roeck-us.net>

On Wed, Oct 15, 2025 at 10:53:45AM -0700, Guenter Roeck wrote:
> On 10/15/25 10:32, Jacob Keller wrote:
> > 
> > 
> > On 10/14/2025 10:24 PM, Michal Swiatkowski wrote:
> > > On Tue, Oct 14, 2025 at 04:41:43PM -0700, Jacob Keller wrote:
> > > > 
> > > > 
> > > > On 10/14/2025 7:11 AM, Michal Swiatkowski wrote:
> > > > > Building the ixgbe without CONFIG_DEBUG_FS leads to a build error. Fix
> > > > > that by guarding fwlog code.
> > > > > 
> > > > > Fixes: 641585bc978e ("ixgbe: fwlog support for e610")
> > > > > Reported-by: Guenter Roeck <linux@roeck-us.net>
> > > > > Closes: https://lore.kernel.org/lkml/f594c621-f9e1-49f2-af31-23fbcb176058@roeck-us.net/
> > > > > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > > > > ---
> > > > 
> > > > Hm. It probably is best to make this optional and not require debugfs
> > > > via kconfig.
> > > 
> > > Make sense
> > > 
> > > > 
> > > > >   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 2 ++
> > > > >   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.h | 8 ++++++++
> > > > >   2 files changed, 10 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > > > index c2f8189a0738..c5d76222df18 100644
> > > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> > > > > @@ -3921,6 +3921,7 @@ static int ixgbe_read_pba_string_e610(struct ixgbe_hw *hw, u8 *pba_num,
> > > > >   	return err;
> > > > >   }
> > > > > +#ifdef CONFIG_DEBUG_FS
> > > > >   static int __fwlog_send_cmd(void *priv, struct libie_aq_desc *desc, void *buf,
> > > > >   			    u16 size)
> > > > >   {
> > > > > @@ -3952,6 +3953,7 @@ void ixgbe_fwlog_deinit(struct ixgbe_hw *hw)
> > > > >   	libie_fwlog_deinit(&hw->fwlog);
> > > > >   }
> > > > > +#endif /* CONFIG_DEBUG_FS */
> > > > 
> > > > What does the fwlog module from libie do? Seems likely that it won't
> > > > compile without CONFIG_DEBUG_FS either...
> > > 
> > > Right, it shouldn't, because there is a dependency on fs/debugfs.
> > > It is building on my env, but maybe I don't have it fully cleaned.

BTW, it is building because DEBUG_FS also have dummy functions if not
selected.

> > > I wonder, because in ice there wasn't a check (or select) for
> > > CONFIG_DEBUG_FS for fwlog code.
> > > 
> > > Looks like LIBIE_FWLOG should select DEBUG_FS, right?
> > > I will send v2 with that, if it is fine.
> > > 
> > > Thanks
> > > 
> > My only worry is that could lead to ice selecting LIBIE_FWLOG which then
> > selects DEBUG_FS which then means we implicitly require DEBUG_FS regardless.
> > 
> > I don't quite remember the semantics of select and whether that would
> > let you build a kernel without DEBUG_FS.. I think some systems would
> > like to be able to disable DEBUG_FS as a way of limiting scope of
> > available interfaces exposed by the kernel.
> >

Yeah, the idea with dummy functions is better, thanks for your input.

> 
> If fwlog depends on debugfs, why not spell out that dependency and
> provide dummy functions if it isn't enabled ? The Kconfig entries
> selecting it could then be changed to
> 	select LIBIE_FWLOG if DEBUG_FS
> 

Sounds good, thanks.

> Guenter
> 

