Return-Path: <netdev+bounces-164561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA832A2E3D1
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:54:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CC3A3A5101
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7226130E58;
	Mon, 10 Feb 2025 05:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xm+Ro8f1"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6C02F2E
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 05:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739166853; cv=none; b=Ew3JkjknnmmiEtpg4+uvzQnAz7/JTgWf5MvBEc8WZtO1enGsOpNJVOOd4KlCI6+Dxv0tlk8gXvP390DGtlhfcu5hKMyyuBrWKbMe5NAOr6di9XQy5ueGy1i2RfpmLnmq7bG2J1mmrt83bMyr7g6lctSOd0cAtL8VnTD8HkRUki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739166853; c=relaxed/simple;
	bh=/u8/nOiV2tiPmC3JD800u44XyghZ/YaazPRAQSG/EZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPLv+YGnQN9A7RLf+v7DP/kjuC54yw87qk+dZUYOfE0HE0POA6yUwMa9H9+FgG3tzg9N0zNkVPUpqikLsRAiqqWF0u2pQfAG0ytP2yLLvyWFwMqiKJ5p1m6ML2FCZG0gYsm3QomXqHuheaNkmgpuRmTsz+X1Ap+VQnumy7gqJ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xm+Ro8f1; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739166851; x=1770702851;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/u8/nOiV2tiPmC3JD800u44XyghZ/YaazPRAQSG/EZs=;
  b=Xm+Ro8f1I1dit0Ub6VpWSqdXEdXR7lJDLcVzwsjL1i58JzeqJzBgTDoS
   +ZSrQx6GgXJfM2iWqLxMzJAHJtYLePDJ/TI5/wYMlpbNPW2xBy8fQmWpA
   59AufnHdBWdb9tN77gjm7zxkWIS+90wky7CohPFss6+4xrNGZGohy8X/x
   hFplNGlxBh6nfkH7iE61PrY+jVrwc6871L2er8hpBGcWqwf304nA441OR
   +2sOdlPnpYvPMlRo9rdRiGOJvIbhwrzYBTesmmOWxYOEx+P/lF9btCUl4
   ioUSh8wV2iXRI3057Gl6S63EuRw2TqbQutgAMSw9e0Rg8G0mVyGn0mLBu
   w==;
X-CSE-ConnectionGUID: e5WwQyjXThC/Rc6DJVOLqQ==
X-CSE-MsgGUID: i05Ywr+5TTao3MM7zcD/VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11340"; a="50716413"
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="50716413"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:54:11 -0800
X-CSE-ConnectionGUID: +D+F6v1gQ1+Uq2rmkOOrzw==
X-CSE-MsgGUID: 3qZNfQjEQRuVMLvCv9Wc8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,273,1732608000"; 
   d="scan'208";a="111924120"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2025 21:54:09 -0800
Date: Mon, 10 Feb 2025 06:50:37 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	marcin.szycik@linux.intel.com, jedrzej.jagielski@intel.com,
	przemyslaw.kitszel@intel.com, piotr.kwapulinski@intel.com,
	anthony.l.nguyen@intel.com, dawid.osuchowski@intel.com
Subject: Re: [iwl-next v1 3/4] ixgbe: add Tx hang detection unhandled MDD
Message-ID: <Z6mTraxmxHzsvrZ3@mev-dev.igk.intel.com>
References: <20250207104343.2791001-1-michal.swiatkowski@linux.intel.com>
 <20250207104343.2791001-4-michal.swiatkowski@linux.intel.com>
 <20250207145710.GX554665@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207145710.GX554665@kernel.org>

On Fri, Feb 07, 2025 at 02:57:10PM +0000, Simon Horman wrote:
> On Fri, Feb 07, 2025 at 11:43:42AM +0100, Michal Swiatkowski wrote:
> > From: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> > 
> > Add Tx Hang detection due to an unhandled MDD Event.
> > 
> > Previously, a malicious VF could disable the entire port causing
> > TX to hang on the E610 card.
> > Those events that caused PF to freeze were not detected
> > as an MDD event and usually required a Tx Hang watchdog timer
> > to catch the suspension, and perform a physical function reset.
> > 
> > Implement flows in the affected PF driver in such a way to check
> > the cause of the hang, detect it as an MDD event and log an
> > entry of the malicious VF that caused the Hang.
> > 
> > The PF blocks the malicious VF, if it continues to be the source
> > of several MDD events.
> > 
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> > Signed-off-by: Slawomir Mrozowicz <slawomirx.mrozowicz@intel.com>
> > Co-developed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> > Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > index aa3b498558bc..e07b56625595 100644
> > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_type.h
> > @@ -1044,6 +1044,7 @@ struct ixgbe_nvm_version {
> >  #define IXGBE_GCR_EXT_VT_MODE_16        0x00000001
> >  #define IXGBE_GCR_EXT_VT_MODE_32        0x00000002
> >  #define IXGBE_GCR_EXT_VT_MODE_64        0x00000003
> > +#define IXGBE_GCR_EXT_VT_MODE_MASK	0x00000003
> 
> nit: For consistency I think spaces should be used to indent 0x00000003
> 

Will fix, I wondered if I should follow normal style or be consistent.

> >  #define IXGBE_GCR_EXT_SRIOV             (IXGBE_GCR_EXT_MSIX_EN | \
> >  					 IXGBE_GCR_EXT_VT_MODE_64)
> >  
> 
> ...
> 
> > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> 
> ...
> 
> > +static u32 ixgbe_poll_tx_icache(struct ixgbe_hw *hw, u16 queue, u16 idx)
> > +{
> > +	IXGBE_WRITE_REG(hw, IXGBE_TXDESCIC, queue * idx);
> > +	return IXGBE_READ_REG(hw, IXGBE_TXDESCIC);
> > +}
> > +
> > +/**
> > + * ixgbe_check_illegal_queue - search for queue with illegal packet
> > + * @adapter: structure containing ring specific data
> > + * @queue: queue index
> > + *
> > + * Check if tx descriptor connected with input queue
> > + * contains illegal packet.
> > + *
> > + * Returns: true if queue contain illegal packet.
> > + */
> > +static bool ixgbe_check_illegal_queue(struct ixgbe_adapter *adapter,
> > +				      u16 queue)
> > +{
> > +	u32 hdr_len_reg, mss_len_reg, type_reg;
> > +	struct ixgbe_hw *hw = &adapter->hw;
> > +	u32 mss_len, header_len, reg;
> > +
> > +	for (u16 i = 0; i < IXGBE_MAX_TX_DESCRIPTORS; i++) {
> > +		/* HW will clear bit IXGBE_TXDESCIC_READY when address
> > +		 * is written to address field. HW will set this bit
> > +		 * when iCache read is done, and data is ready at TIC_DWx.
> > +		 * Set descriptor address.
> > +		 */
> > +		read_poll_timeout(ixgbe_poll_tx_icache, reg,
> > +				  !(reg & IXGBE_TXDESCIC_READY), 0, 0, false,
> > +				  hw, queue, i);
> > +
> > +		/* read tx descriptor access registers */
> > +		hdr_len_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_VLAN_MACIP_LENS_REG));
> > +		type_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_TYPE_TUCMD_MLHL));
> > +		mss_len_reg = IXGBE_READ_REG(hw, IXGBE_TIC_DW2(IXGBE_MSS_L4LEN_IDX));
> > +
> > +		/* check if Advanced Context Descriptor */
> > +		if (FIELD_GET(IXGBE_ADVTXD_DTYP_MASK, type_reg) !=
> > +		    IXGBE_ADVTXD_DTYP_CTXT)
> > +			continue;
> > +
> > +		/* check for illegal MSS and Header length */
> > +		mss_len = FIELD_GET(IXGBE_ADVTXD_MSS_MASK, mss_len_reg);
> > +		header_len = FIELD_GET(IXGBE_ADVTXD_HEADER_LEN_MASK,
> > +				       hdr_len_reg);
> > +		if ((mss_len + header_len) > SZ_16K) {
> > +			e_warn(probe,
> > +			       "mss len + header len too long\n");
> 
> nit: The above two lines can be a single line.
>

Will fix

> > +			return true;
> > +		}
> > +	}
> > +
> > +	return false;
> > +}
> > +
> > +/**
> > + * ixgbe_handle_mdd_event - handle mdd event
> > + * @adapter: structure containing ring specific data
> > + * @tx_ring: tx descriptor ring to handle
> > + *
> > + * Reset VF driver if malicious vf detected or
> > + * illegal packet in an any queue detected.
> > + */
> > +static void ixgbe_handle_mdd_event(struct ixgbe_adapter *adapter,
> > +				   struct ixgbe_ring *tx_ring)
> > +{
> > +	u16 vf, q;
> > +
> > +	if (adapter->vfinfo && ixgbe_check_mdd_event(adapter)) {
> > +		/* vf mdd info and malicious vf detected */
> > +		if (!ixgbe_get_vf_idx(adapter, tx_ring->queue_index, &vf))
> > +			ixgbe_vf_handle_tx_hang(adapter, vf);
> > +	} else {
> > +		/* malicious vf not detected */
> > +		for (q = 0; q < IXGBE_MAX_TX_QUEUES; q++) {
> > +			if (ixgbe_check_illegal_queue(adapter, q) &&
> > +			    !ixgbe_get_vf_idx(adapter, q, &vf))
> > +				/* illegal queue detected */
> > +				ixgbe_vf_handle_tx_hang(adapter, vf);
> 
> It looks like ixgbe_vf_handle_tx_hang() will run for each illegal queue.
> Could that be more than once for a given vf? If so, is that desirable?
> 

Yes, it will be called for each hanged queue of a given VF. I assume
this is fine, as the function is counting the hang events, not resetting
VF.

Thanks for the review,
Michal

> > +		}
> > +	}
> > +}
> > +
> >  /**
> >   * ixgbe_clean_tx_irq - Reclaim resources after transmit completes
> >   * @q_vector: structure containing interrupt and ring information
> 
> ...

