Return-Path: <netdev+bounces-171586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1573BA4DB82
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 11:57:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6EF1743DB
	for <lists+netdev@lfdr.de>; Tue,  4 Mar 2025 10:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9D21FF1B8;
	Tue,  4 Mar 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k/mLl2Ah"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D091FECCD;
	Tue,  4 Mar 2025 10:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741085810; cv=none; b=QkPSQKCzm6Go/adEPt5bQb+ne1rlo/ULI6ZN4IgGjn0SIy9GDJfINwFrB83L0iZuOB1a4+jeVsCl8uf2wlWViIogToB9jERvJkcIBrEtOCagivY8MBqtmxYRZ94UwqnsXVx5M9N55QBEV75ldYIWYR8F3lvUFyEZSeap4pmkjYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741085810; c=relaxed/simple;
	bh=Ho0uDUwZsUu2joPt/9at1q75NpuT57XEi+Bi0+7lpw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JTtQAqHRJOTMINICDxrPMiIFa8LlmEEJPQPRr9Oek29T5ZQXgGo4g9TPQFlAdzqaC2ejBsMseHBjf4jdlqak90zKnGw9hGH9G4LoNZbfuSK/03Dij918yzh1emu6YhuEDFpHhv99oKIxChfJLQt39teyR1nx00RCjFp0oQFGizE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k/mLl2Ah; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741085808; x=1772621808;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ho0uDUwZsUu2joPt/9at1q75NpuT57XEi+Bi0+7lpw8=;
  b=k/mLl2AhBjP6FFgUHxrsRguvOaPSbdH90ewiorn9nWOXYM4Ht5Z1K5/X
   wxmG10xwBgjL/ddEVQRDXDf3JSlYraegbm+gPx6VDW/U/TqkGZs4gbpWE
   4GdqHzDTO6McDzEg1KltOz/raginqnW82hRmtemDnTf4AB0EOf3LmoLWC
   ZejVd3wwU4v0NKnll14yqqtsDshejzIbiWD6NC3qfZ8xR8TZRXL6mG216
   C60FbvMOejW0QWrO3k5wuDwyvMlt5Dwvb2SYaeV5bnQ6JQaHxoYvQG5t5
   ZQsHFd8qw8BjMjKf6ETg/CN9r155QePvhHFch97n6GHQ3mxNGmHZ8ee1e
   A==;
X-CSE-ConnectionGUID: o9uP4OpxQ7qD19ly8/4VRg==
X-CSE-MsgGUID: L8tjPhw9QB2ezudetSmdQg==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41895277"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41895277"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:56:47 -0800
X-CSE-ConnectionGUID: 1tN/fHZ0QaSiagDBcHt6lw==
X-CSE-MsgGUID: edlY+mtwSRyJTDfIachLPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155530072"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 02:56:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpPx3-0000000H68b-2o0Q;
	Tue, 04 Mar 2025 12:56:41 +0200
Date: Tue, 4 Mar 2025 12:56:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasesh Mody <rmody@marvell.com>, GR-Linux-NIC-Dev@marvell.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1 1/1] bnx2: Fix unused data compilation warning
Message-ID: <Z8bcaR9MS7dk8Q0p@smile.fi.intel.com>
References: <20250228100538.32029-1-andriy.shevchenko@linux.intel.com>
 <20250303172114.6004ef32@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303172114.6004ef32@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Mar 03, 2025 at 05:21:14PM -0800, Jakub Kicinski wrote:
> On Fri, 28 Feb 2025 12:05:37 +0200 Andy Shevchenko wrote:
> > In some configuration, compilation raises warnings related to unused
> > data. Indeed, depending on configuration, those data can be unused.
> > 
> > Mark those data as __maybe_unused to avoid compilation warnings.
> 
> Will making dma_unmap_addr access the first argument instead of
> pre-processing down to nothing not work?

I looked at the implementation of those macros and I have no clue
how to do that in a least intrusive way. Otherwise it sounds to me
quite far from the scope of the small compilation error fix that
I presented here.

-- 
With Best Regards,
Andy Shevchenko



