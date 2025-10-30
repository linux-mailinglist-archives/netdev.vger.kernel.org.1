Return-Path: <netdev+bounces-234321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82666C1F58C
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 10:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B80274E9A21
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D80CD34217C;
	Thu, 30 Oct 2025 09:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dwJPnFQo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2690341AB1
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 09:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761817150; cv=none; b=mtJ8jcXuQe4fst7o/slRtLqmoIcLVqb5MDBm4OEEnKkq19L/Fgsrid7jvQk0jVTTStYDphWWb7D5o1Uqn1xscrQRUrdrjklLiSQgjdgPeuIKVPhfNi7mgub128BrIyhKgT9qgf3f1mFCAQNyrQ6PxLhE8dHC6R++CmULoGOpeTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761817150; c=relaxed/simple;
	bh=D9Qw2iE75aVPPzUFpNOjF3ap1NmTGoUfaoeWm9dihs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fo7pcODrSubC1F8I/tvRkkd1kwZfycdCDyHy2gUtg1mOnmIhAOtCu6Y9KqfyNc6nv7GIDUq2wme4n8qO0nHYWRMeYgKAkyhX0q0wF2JfhiM4xlSCpCQqeOJ+frH15THyTTJR/eOHZyQs+F7D/yCHptmRxdWNvmEClODZ6oKAHso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dwJPnFQo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761817149; x=1793353149;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=D9Qw2iE75aVPPzUFpNOjF3ap1NmTGoUfaoeWm9dihs0=;
  b=dwJPnFQovNHXtYdAs3Ik6g0t3LCbdrrUWSHNtLoQP2ZmGjQHi7eUrpVy
   5/sNa8w5Lvvh0GUGd2EMJR8xcYr8BzJgPPQJgbo3Eeio/YFNCAk47bi99
   AYLrNDsZS4FhC3Z0X5ldFKBA+p2Wzhfl0UqfyBlp77RocZeenyz8EuEHY
   lxg9hGJZkEInQpBNQN5XVrDalMlAe6VjgWAqM/p7LCPfnsUedg8PFOoxQ
   g6kBPWAnCAjagUtCTVPDB2BLJIZfitGgyJdaiuUV1n7CugHb56VlTucbY
   n7eBVlP5QkNhykEeX5okUaLWDOt0/vYIRcmuGFiCGURpLvcYejjLKk6Z2
   w==;
X-CSE-ConnectionGUID: sdbv8NfyTom+9m1Yhm8BAg==
X-CSE-MsgGUID: Sub0mACPTEKVa//P1G40FQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11597"; a="63651685"
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="63651685"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:39:09 -0700
X-CSE-ConnectionGUID: +Cj4KHwBTCmEZ957sydacg==
X-CSE-MsgGUID: rj6wnQijQU6bu713+C/Kpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,266,1754982000"; 
   d="scan'208";a="185565380"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Oct 2025 02:39:06 -0700
Date: Thu, 30 Oct 2025 10:37:03 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	aleksander.lobakin@intel.com, przemyslaw.kitszel@intel.com,
	jacob.e.keller@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v3] ice: use netif_get_num_default_rss_queues()
Message-ID: <aQMxvzYqJkwNBYf0@mev-dev.igk.intel.com>
References: <20251030083053.2166525-1-michal.swiatkowski@linux.intel.com>
 <370cf4f0-c0a8-480a-939d-33c75961e587@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <370cf4f0-c0a8-480a-939d-33c75961e587@molgen.mpg.de>

On Thu, Oct 30, 2025 at 10:10:32AM +0100, Paul Menzel wrote:
> Dear Michal,
> 
> 
> Thank you for your patch. For the summary, I’d add:
> 
> ice: Use netif_get_num_default_rss_queues() to decrease queue number
> 
> Am 30.10.25 um 09:30 schrieb Michal Swiatkowski:
> > On some high-core systems (like AMD EPYC Bergamo, Intel Clearwater
> > Forest) loading ice driver with default values can lead to queue/irq
> > exhaustion. It will result in no additional resources for SR-IOV.
> 
> Could you please elaborate how to make the queue/irq exhaustion visible?
> 

What do you mean? On high core system, lets say num_online_cpus()
returns 288, on 8 ports card we have online 256 irqs per eqch PF (2k in
total). Driver will load with the 256 queues (and irqs) on each PF.
Any VFs creation command will fail due to no free irqs available.
(echo X > /sys/class/net/ethX/device/sriov_numvfs)

> > In most cases there is no performance reason for more than half
> > num_cpus(). Limit the default value to it using generic
> > netif_get_num_default_rss_queues().
> > 
> > Still, using ethtool the number of queues can be changed up to
> > num_online_cpus(). It can be done by calling:
> > $ethtool -L ethX combined $(nproc)
> > 
> > This change affects only the default queue amount.
> 
> How would you judge the regression potential, that means for people where
> the defaults work good enough, and the queue number is reduced now?
>

You can take a look into commit that introduce /2 change in
netif_get_num_default_rss_queues() [1]. There is a good justification
for such situation. In short, heaving physical core number is just a
wasting of CPU resources.

[1] https://lore.kernel.org/netdev/20220315091832.13873-1-ihuguet@redhat.com/

> 
> Kind regards,
> 
> Paul
> 
> 
> > Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> > v2 --> v3:
> >   * use $(nproc) in command example in commit message
> > 
> > v1 --> v2:
> >   * Follow Olek's comment and switch from custom limiting to the generic
> >     netif_...() function.
> >   * Add more info in commit message (Paul)
> >   * Dropping RB tags, as it is different patch now
> > ---
> >   drivers/net/ethernet/intel/ice/ice_irq.c |  5 +++--
> >   drivers/net/ethernet/intel/ice/ice_lib.c | 12 ++++++++----
> >   2 files changed, 11 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/net/ethernet/intel/ice/ice_irq.c b/drivers/net/ethernet/intel/ice/ice_irq.c
> > index 30801fd375f0..1d9b2d646474 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_irq.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_irq.c
> > @@ -106,9 +106,10 @@ static struct ice_irq_entry *ice_get_irq_res(struct ice_pf *pf,
> >   #define ICE_RDMA_AEQ_MSIX 1
> >   static int ice_get_default_msix_amount(struct ice_pf *pf)
> >   {
> > -	return ICE_MIN_LAN_OICR_MSIX + num_online_cpus() +
> > +	return ICE_MIN_LAN_OICR_MSIX + netif_get_num_default_rss_queues() +
> >   	       (test_bit(ICE_FLAG_FD_ENA, pf->flags) ? ICE_FDIR_MSIX : 0) +
> > -	       (ice_is_rdma_ena(pf) ? num_online_cpus() + ICE_RDMA_AEQ_MSIX : 0);
> > +	       (ice_is_rdma_ena(pf) ? netif_get_num_default_rss_queues() +
> > +				      ICE_RDMA_AEQ_MSIX : 0);
> >   }
> >   /**
> > diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> > index bac481e8140d..e366d089bef9 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> > @@ -159,12 +159,14 @@ static void ice_vsi_set_num_desc(struct ice_vsi *vsi)
> >   static u16 ice_get_rxq_count(struct ice_pf *pf)
> >   {
> > -	return min(ice_get_avail_rxq_count(pf), num_online_cpus());
> > +	return min(ice_get_avail_rxq_count(pf),
> > +		   netif_get_num_default_rss_queues());
> >   }
> >   static u16 ice_get_txq_count(struct ice_pf *pf)
> >   {
> > -	return min(ice_get_avail_txq_count(pf), num_online_cpus());
> > +	return min(ice_get_avail_txq_count(pf),
> > +		   netif_get_num_default_rss_queues());
> >   }
> >   /**
> > @@ -907,13 +909,15 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
> >   		if (vsi->type == ICE_VSI_CHNL)
> >   			vsi->rss_size = min_t(u16, vsi->num_rxq, max_rss_size);
> >   		else
> > -			vsi->rss_size = min_t(u16, num_online_cpus(),
> > +			vsi->rss_size = min_t(u16,
> > +					      netif_get_num_default_rss_queues(),
> >   					      max_rss_size);
> >   		vsi->rss_lut_type = ICE_LUT_PF;
> >   		break;
> >   	case ICE_VSI_SF:
> >   		vsi->rss_table_size = ICE_LUT_VSI_SIZE;
> > -		vsi->rss_size = min_t(u16, num_online_cpus(), max_rss_size);
> > +		vsi->rss_size = min_t(u16, netif_get_num_default_rss_queues(),
> > +				      max_rss_size);
> >   		vsi->rss_lut_type = ICE_LUT_VSI;
> >   		break;
> >   	case ICE_VSI_VF:
> 

