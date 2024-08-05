Return-Path: <netdev+bounces-115628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CF7947478
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 06:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF495281375
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 04:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640F13D50E;
	Mon,  5 Aug 2024 04:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C1CHzfXg"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4CBA94B
	for <netdev@vger.kernel.org>; Mon,  5 Aug 2024 04:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722833848; cv=none; b=GNGwuzWor0HOxXF2sTIfF0Fv8qQn2ZKtEQKco8XDVElKfy+cNfCmNYte0aGAiNUy1HyLOsLMfeEvdVDwXru1eAnoq/MrJZvT24/6dkn7ZKo81zpbXwJP2THZRtNNrSZqqqjc2YOIx1HODQ3kbWSJuNsJ7N7E2eYQSy72aiaYBVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722833848; c=relaxed/simple;
	bh=4mw4xw180wEtM/ofwSO2sJEDO3PWVnZB2oKDGCyAVkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbAjipZr6T+kiKjk92aluBezXEhlazHq8HSTO55kVGhLKrgWdmEN/DpLiiF6GjIVZGYco869RMSz/kBYbRwkxgc8LXRkQyUh6QGD9Lb+xWq/yzdSlE+2K84lw8WIUGf1Pw8NCcbyEnuRaL/CeIzTOR+girvWSTJZFKncYU1m9bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C1CHzfXg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722833848; x=1754369848;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4mw4xw180wEtM/ofwSO2sJEDO3PWVnZB2oKDGCyAVkM=;
  b=C1CHzfXgElOrw9hpFzftdkPGc2wLqAkroZBeyDzd0RUWBgf97DyvxFDo
   8WNcQTWP8O+wqpFZGGSPhVwdB0O4n2gECEfnq77A+ZcD3gV+oHB9LZJNI
   klAI7gaKP6nMVdcnAJfg9Rik/S5u2beMrhRX5ai0KSUuUv1LxPRNtW3KX
   dX3DhD5ExeeDr4Ij24vTHBvdJsu5VxqtZnVkqrwswuYReMTdnA2l/JHqA
   UedQhOrJS4QbbeVYkX8wjiMzpaNKdyE5lUjQazSIvAtjKpnQ9Xaekd9Kt
   B2k+T/Hw+zmRzgGUev3sWEJOLdcqH8LLDDvITCIQsj7tg2OWqmfcGLb4F
   g==;
X-CSE-ConnectionGUID: ATtkeMa6Scyt0nw2AT+X8w==
X-CSE-MsgGUID: XWdoCDkOTky+MqdavlKybQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11154"; a="24545369"
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="24545369"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 21:57:27 -0700
X-CSE-ConnectionGUID: KY0I1FwARe6GICFlnwpL7Q==
X-CSE-MsgGUID: P7iZpUy9QaCMBwKSm0tW/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,263,1716274800"; 
   d="scan'208";a="55973510"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2024 21:57:24 -0700
Date: Mon, 5 Aug 2024 06:55:45 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, pawel.chmielewski@intel.com,
	sridhar.samudrala@intel.com, jacob.e.keller@intel.com,
	pio.raczynski@gmail.com, konrad.knitter@intel.com,
	marcin.szycik@intel.com, wojciech.drewek@intel.com,
	nex.sw.ncis.nat.hpm.dev@intel.com, jiri@resnulli.us,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [iwl-next v2 4/7] ice, irdma: move interrupts code to irdma
Message-ID: <ZrBbUfqMwniZF1wv@mev-dev.igk.intel.com>
References: <20240801093115.8553-1-michal.swiatkowski@linux.intel.com>
 <20240801093115.8553-5-michal.swiatkowski@linux.intel.com>
 <a39489ca-9784-427e-ae05-a3f632d4a2b3@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a39489ca-9784-427e-ae05-a3f632d4a2b3@intel.com>

On Fri, Aug 02, 2024 at 02:49:08PM +0200, Przemek Kitszel wrote:
> On 8/1/24 11:31, Michal Swiatkowski wrote:
> > Move responsibility of MSI-X requesting for RDMA feature from ice driver
> > to irdma driver. It is done to allow simple fallback when there is not
> > enough MSI-X available.
> > 
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > ---
> >   drivers/infiniband/hw/irdma/hw.c         |  2 -
> >   drivers/infiniband/hw/irdma/main.c       | 46 ++++++++++++++++-
> >   drivers/infiniband/hw/irdma/main.h       |  3 ++
> >   drivers/net/ethernet/intel/ice/ice.h     |  2 -
> >   drivers/net/ethernet/intel/ice/ice_idc.c | 64 ++++++------------------
> >   include/linux/net/intel/iidc.h           |  2 +
> >   6 files changed, 63 insertions(+), 56 deletions(-)
> > 
> > diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
> > index ad50b77282f8..69ce1862eabe 100644
> > --- a/drivers/infiniband/hw/irdma/hw.c
> > +++ b/drivers/infiniband/hw/irdma/hw.c
> > @@ -498,8 +498,6 @@ static int irdma_save_msix_info(struct irdma_pci_f *rf)
> >   	iw_qvlist->num_vectors = rf->msix_count;
> >   	if (rf->msix_count <= num_online_cpus())
> >   		rf->msix_shared = true;
> > -	else if (rf->msix_count > num_online_cpus() + 1)
> > -		rf->msix_count = num_online_cpus() + 1;
> >   	pmsix = rf->msix_entries;
> >   	for (i = 0, ceq_idx = 0; i < rf->msix_count; i++, iw_qvinfo++) {
> > diff --git a/drivers/infiniband/hw/irdma/main.c b/drivers/infiniband/hw/irdma/main.c
> > index 3f13200ff71b..69ad137be7aa 100644
> > --- a/drivers/infiniband/hw/irdma/main.c
> > +++ b/drivers/infiniband/hw/irdma/main.c
> > @@ -206,6 +206,43 @@ static void irdma_lan_unregister_qset(struct irdma_sc_vsi *vsi,
> >   		ibdev_dbg(&iwdev->ibdev, "WS: LAN free_res for rdma qset failed.\n");
> >   }
> > +static int irdma_init_interrupts(struct irdma_pci_f *rf, struct ice_pf *pf)
> > +{
> > +	int i;
> > +
> > +	rf->msix_count = num_online_cpus() + IRDMA_NUM_AEQ_MSIX;
> > +	rf->msix_entries = kcalloc(rf->msix_count, sizeof(*rf->msix_entries),
> > +				   GFP_KERNEL);
> > +	if (!rf->msix_entries)
> > +		return -ENOMEM;
> > +
> > +	for (i = 0; i < rf->msix_count; i++)
> > +		if (ice_alloc_rdma_qvector(pf, &rf->msix_entries[i]))
> > +			break;
> > +
> > +	if (i < IRDMA_MIN_MSIX) {
> > +		for (; i >= 0; i--)
> > +			ice_free_rdma_qvector(pf, &rf->msix_entries[i]);
> 
> you call ice_free_rdma_qvector() for i=0 even if the very first alloc
> attempt has failed
> 

Good point, I will fix it, thanks

> > +
> > +		kfree(rf->msix_entries);
> > +		return -ENOMEM;
> > +	}
> > +
> > +	rf->msix_count = i;
> > +
> > +	return 0;
> > +}
> 
> [...]
> 
> > --- a/drivers/infiniband/hw/irdma/main.h
> > +++ b/drivers/infiniband/hw/irdma/main.h
> > @@ -117,6 +117,9 @@ extern struct auxiliary_driver i40iw_auxiliary_drv;
> >   #define IRDMA_IRQ_NAME_STR_LEN (64)
> > +#define IRDMA_NUM_AEQ_MSIX	1
> > +#define IRDMA_MIN_MSIX		2
> > +
> >   enum init_completion_state {
> >   	INVALID_STATE = 0,
> >   	INITIAL_STATE,
> > diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
> > index 8247d27541b0..1311be1d2c30 100644
> > --- a/drivers/net/ethernet/intel/ice/ice.h
> > +++ b/drivers/net/ethernet/intel/ice/ice.h
> > @@ -97,8 +97,6 @@
> >   #define ICE_MIN_MSIX		(ICE_MIN_LAN_TXRX_MSIX + ICE_MIN_LAN_OICR_MSIX)
> >   #define ICE_MAX_MSIX		256
> >   #define ICE_FDIR_MSIX		2
> > -#define ICE_RDMA_NUM_AEQ_MSIX	4
> 
> you have to extend commit message to tell why there is a 4 -> 1 change
>

Ok, I will

> > -#define ICE_MIN_RDMA_MSIX	2
> >   #define ICE_ESWITCH_MSIX	1
> >   #define ICE_NO_VSI		0xffff
> >   #define ICE_VSI_MAP_CONTIG	0
> 
> 

