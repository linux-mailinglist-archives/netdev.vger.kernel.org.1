Return-Path: <netdev+bounces-182657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AA7A89885
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 11:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A310174B91
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 09:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C5828B4E8;
	Tue, 15 Apr 2025 09:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ay06r7y9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7C91EEA39;
	Tue, 15 Apr 2025 09:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744710310; cv=none; b=ZmdwSSNG7TshK2CfB+h1Cjm3OGKOq42yamk19cc5nYsPCgxvSFfF49VEb5LBLli2R+/C8hdb2wYMHTovaYoGROnwogyUlXclSS9xyB0/0Gm2e3TslltHtJjRLjUdTWz41DlLuG48vRTN60S3pl0NVQ8BqrhrP2wffvRkph5YpY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744710310; c=relaxed/simple;
	bh=wuQTiHjjMrlc9bOLthNDzDOBl+OzWwDb8C1zkuhKIpY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KBlNlnTRuBrxJf7Mibrk2Td1kv4ktkAbvI0ut0vmtsBvuac9j/2Utl+yJSPyI7YFjLyEB+7xF1DOqJgPJxcHGY/fxdCr1DaJ8eRtBnf+LH2gc6Ow7iPPX6Qee9TbRVeb5CvfbAsskLGIG/N/OI1sXxxWZ+/+QNh4QS2iihe3XmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ay06r7y9; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744710309; x=1776246309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wuQTiHjjMrlc9bOLthNDzDOBl+OzWwDb8C1zkuhKIpY=;
  b=Ay06r7y99IeIwYjqT149Wnh3yuif80lbRKyIdINmFMbSTGIamiX1uWqK
   TvI2ZYwBNAaDPmUyV2hPXVRANZsJfeOb019uf7EA8nlf0b1e3+X4Eiwjq
   Ja1sUUesV7/4lJdC4GpuVRys6viYeFWhpNqG0cXouAimUErcMYEtTH7GD
   B6xHwNVCjDt3kFy3oYsZfFvtu0ClOH/b7C9LZDHjYHSXaoy0gpM1iryuF
   FB0YgJyi8EpalKJ1yDNKKhcuUwmY1lgws8rSSIngai0IrsDQC9UZ2RYyn
   jzgUtFxvPx4Xy63WCuuocxIwLI8o2CWW+aol2podkjtG93XZFWLllE/cE
   A==;
X-CSE-ConnectionGUID: qQyrP4GERJCA+pPajlr5rA==
X-CSE-MsgGUID: iq8uF/2aSUSFIbc8RjJrRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11403"; a="68701248"
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="68701248"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:44:02 -0700
X-CSE-ConnectionGUID: Kbt8K22fS9OXTj5GSEkAYA==
X-CSE-MsgGUID: L1Azbl44TseVUCJuaF8VJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,213,1739865600"; 
   d="scan'208";a="129924471"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2025 02:43:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u4cpf-0000000CVTi-2oXf;
	Tue, 15 Apr 2025 12:43:55 +0300
Date: Tue, 15 Apr 2025 12:43:55 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christoph Hellwig <hch@lst.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rasesh Mody <rmody@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z_4qWxZvZ4RIIhWq@smile.fi.intel.com>
References: <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
 <5ec0a2cc-e5f6-42dd-992c-79b1a0c1b9f5@redhat.com>
 <Z8bq6XJGJNbycmJ9@smile.fi.intel.com>
 <Z8cC_xMScZ9rq47q@smile.fi.intel.com>
 <20250304083524.3fe2ced4@kernel.org>
 <CGME20250305100010eucas1p1986206542bc353300aee7ac8d421807f@eucas1p1.samsung.com>
 <Z8ggoUoKpSPPcs5S@smile.fi.intel.com>
 <067bd072-eb3f-451a-b1c4-59eae777cf00@samsung.com>
 <Z9G0QU5Ew3FusrJH@smile.fi.intel.com>
 <Z_zepIheW2zKq0yg@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z_zepIheW2zKq0yg@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 14, 2025 at 01:08:36PM +0300, Andy Shevchenko wrote:
> On Wed, Mar 12, 2025 at 06:20:17PM +0200, Andy Shevchenko wrote:
> > On Tue, Mar 11, 2025 at 01:51:21PM +0100, Marek Szyprowski wrote:
> > > On 05.03.2025 11:00, Andy Shevchenko wrote:
> > > > On Tue, Mar 04, 2025 at 08:35:24AM -0800, Jakub Kicinski wrote:
> > > >> On Tue, 4 Mar 2025 15:41:19 +0200 Andy Shevchenko wrote:

...

> > > >> I meant something more like (untested):
> > > > We are starving for the comment from the DMA mapping people.
> > > 
> > > I'm really sorry for this delay. Just got back to the everyday stuff 
> > > after spending a week in bed recovering from flu...
> > 
> > Oh, I hope you feel much better now!
> > 
> > ...
> > 
> > > >>   #define DEFINE_DMA_UNMAP_ADDR(ADDR_NAME)
> > > >>   #define DEFINE_DMA_UNMAP_LEN(LEN_NAME)
> > > >> -#define dma_unmap_addr(PTR, ADDR_NAME)           (0)
> > > >> -#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { } while (0)
> > > >> -#define dma_unmap_len(PTR, LEN_NAME)             (0)
> > > >> -#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { } while (0)
> > > >> +#define dma_unmap_addr(PTR, ADDR_NAME)           ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> > > >> +#define dma_unmap_addr_set(PTR, ADDR_NAME, VAL)  do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
> > > >> +#define dma_unmap_len(PTR, LEN_NAME)             ({ typeof(PTR) __p __maybe_unused = PTR; 0; )}
> > > >> +#define dma_unmap_len_set(PTR, LEN_NAME, VAL)    do { typeof(PTR) __p __maybe_unused = PTR; } while (0)
> > 
> > > >> I just don't know how much code out there depends on PTR not
> > > >> existing if !CONFIG_NEED_DMA_MAP_STATE
> > > > Brief checking shows that only drivers/net/ethernet/chelsio/* comes
> > > > with ifdeffery, the rest most likely will fail in the same way
> > > > (note, overwhelming majority of the users is under the network realm):
> > > 
> > > Frankly speaking I wasn't aware of this API till now.
> > > 
> > > If got it right the above proposal should work fine. The addr/len names 
> > > can be optimized out, but the pointer to the container should exist.
> > 
> > Thanks for the reply, would you or Jakub will to send a formal patch?
> > I can test it on my configuration and build.
> 
> Any news here? The problem still persist AFAICT.

Thank you, Marek, for the patch, I just have tested it, and it works as
expected to me.

-- 
With Best Regards,
Andy Shevchenko



