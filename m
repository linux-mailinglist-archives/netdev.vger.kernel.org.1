Return-Path: <netdev+bounces-158391-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EB6EA11966
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 07:01:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B458316731C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 06:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028E71E572F;
	Wed, 15 Jan 2025 06:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iW+YR61Q"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E24483CD2
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 06:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736920899; cv=none; b=PMZ90aJLDGJDqHypWzLTTwuaxhNOvXFysWWk3h/179IW+CjweLXcJX7AOliRRFMfBXcLdigkr374aH8YrndRN8Z6c7FXlzdpsIQEYEJTxFe4QhvyjtOSoRpJS+wqqfFCsfs0Y+WASZbtiivuL9mS0So42LzuMddJMfIw7sZzgJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736920899; c=relaxed/simple;
	bh=yGZ+VrltVnZcAleYWtfVGTO7Qw8orcy/1CeZXPK80zo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E6QAaEWxVxcGmVmkKvIjOZf9EJYDPFdnFTLg0fMUbUDuweFO4tcraa6PCwhW+gJeXxcsMUT1eCj6AzvW62v2ke0/ogANzqyjNAwW4UG5EBJkKh4pgMePi1LrFV/Xwd6OpT6uRm7sq1G45t11TRiucLOj1H3/aFO7uqVruqwtlFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iW+YR61Q; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736920898; x=1768456898;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yGZ+VrltVnZcAleYWtfVGTO7Qw8orcy/1CeZXPK80zo=;
  b=iW+YR61QM8RlbtiYHF4utyrdrvGVfaJX9HNixiEC1Joim9dYC3gd8ZGZ
   B8NCxOYs2ovQfgxEDB/8ivMeKAJb/8Y5suU8GaakCK5TkfrhjnnBFTIxI
   5pe6Gcskvvuy7NClXIRx5EH3sV/zDiZiJLMbcPdBzVS0DRLKOsnnWvNTp
   wd3jM5Q5ezPyh03UdalyoHXE1vTHGJ0qHKrr3vCrNhueYqRY3kXhbj0ca
   QlD9Hlt2MSiTnivxYv6tvLpQbDaGBuxDp2wlHwAagU2CfEunvTFb+SqT1
   SLT6EaQPOcbua+0h2sZFgGHq01YNGAi/+w1R690qcOPrX3H2k2dp6qjAP
   w==;
X-CSE-ConnectionGUID: Tv2XSmkYRsSO993kCStQ4Q==
X-CSE-MsgGUID: 1dku/K6+Rf2Ucq35fCeNFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11315"; a="62611742"
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="62611742"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 22:01:38 -0800
X-CSE-ConnectionGUID: +pTEnyUnQp6ujySwGk4hxQ==
X-CSE-MsgGUID: PFlfPyPHRRmny59n4LnLrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,316,1728975600"; 
   d="scan'208";a="104998001"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2025 22:01:35 -0800
Date: Wed, 15 Jan 2025 06:58:19 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com, David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 08/10] bnxt_en: Reallocate Rx completion ring
 for TPH support
Message-ID: <Z4dOe6xxfvt9gB4K@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-9-michael.chan@broadcom.com>
 <Z4TQK4pSFJd0y1Jd@mev-dev.igk.intel.com>
 <CACKFLimyogEMB4n9hJs2W+2=MB2iN3DWh1wXsfT9UWpzeKQqcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLimyogEMB4n9hJs2W+2=MB2iN3DWh1wXsfT9UWpzeKQqcQ@mail.gmail.com>

On Tue, Jan 14, 2025 at 01:42:42PM -0800, Michael Chan wrote:
> On Mon, Jan 13, 2025 at 12:38 AM Michal Swiatkowski
> <michal.swiatkowski@linux.intel.com> wrote:
> >
> > On Sun, Jan 12, 2025 at 10:39:25PM -0800, Michael Chan wrote:
> > > From: Somnath Kotur <somnath.kotur@broadcom.com>
> > > @@ -15669,11 +15689,13 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
> > >       cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> > >       bnxt_hwrm_rx_ring_free(bp, rxr, false);
> > >       bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
> > > -     rxr->rx_next_cons = 0;
> > Unrelated?
> 
> This line is unneeded.  It gets overwritten by the clone during
> queue_start().  We remove it since we are making related changes in
> this function.  I'll add a comment about this in the Changelog.
> Thanks.

Sure, thanks.

> 
> >
> > >       page_pool_disable_direct_recycling(rxr->page_pool);
> > >       if (bnxt_separate_head_pool())
> > >               page_pool_disable_direct_recycling(rxr->head_pool);
> > >
> > > +     bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
> > > +     bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
> > > +
> > >       memcpy(qmem, rxr, sizeof(*rxr));
> > >       bnxt_init_rx_ring_struct(bp, qmem);
> > >
> >
> > Rest looks fine:
> > Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>



