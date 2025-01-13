Return-Path: <netdev+bounces-157648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 15237A0B17C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:44:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 463E8188344C
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867DF23315B;
	Mon, 13 Jan 2025 08:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RQHtEaWL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE4FF233D85
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 08:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736757805; cv=none; b=bzIUvOjuJwDP5QahXzdBfNEpyFbVoR/cOXOnc1se+mXiIIbC1WzvGd1dG9CEq13iLXXV2PhhPQ9jtDHjR5I9O7kogT4YYm9XfRs1NJHwSeCXKwtA87zwrVQqfsdPoW0wHLma5SNtq/Y+N1EJAAsFrOmRT+x6jJ1ogMR4KolrB7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736757805; c=relaxed/simple;
	bh=qK1Vk6wvBPeEhxJyHy70I+pDdjWlzvYHobBu3c9nWZw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=apel9GHvowwhHNIY3+9KtyNBp+T07CN/Yj6NIE8O645nlj4O4rCrycTe+QPV24tFTdd63SHjGEbOvwtRFkx+tn/rSPHIZyRLaWUW2gdwP583EeFOCEMwtQaUV0jvYto3WqCnY+9WpreTEJtdzn68XCAVgmA9/PelbXLIBLFlWzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RQHtEaWL; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736757804; x=1768293804;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qK1Vk6wvBPeEhxJyHy70I+pDdjWlzvYHobBu3c9nWZw=;
  b=RQHtEaWLmDOKDUe10ciRGPVwTt3kqvXIXB29jaftLNuYs2MjW0kUv8xx
   IRpIEh0WeXiD0TLXXrIecjMrb4qLuJ02lbcqrOmE04gbAMSM98rbB5mgE
   MuoN5jlx6em/B/6KIw1Q5jEt7EIyIBTHpslcgt6bh4+zhu9JttHCsawCf
   MPkTEUi1P1LdC/k/QipoZJd20Uv6mkDcP+XNxIJS8WH5s97K4fj9svpLg
   I57o2cWfbbrpAX2KCix1M3QVAIHJgmyuPFWEe9pBa7DFF7oWlMuu9UKG9
   +VBVtchR/d0vy2naI8oDZ7iXmFp1pu2cI/LmifnP9vMN5aQBdI0N5aPPF
   A==;
X-CSE-ConnectionGUID: HZuN6gbAQ8OLLYQKCgEnyA==
X-CSE-MsgGUID: tG/VMtZkQyyIiSM8ZHLHhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11313"; a="54549594"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="54549594"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:43:23 -0800
X-CSE-ConnectionGUID: oXUpXpB+S++XwSl/euicAw==
X-CSE-MsgGUID: wmvcn1BiQMWtiNOdUmSCqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="108468333"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 00:43:20 -0800
Date: Mon, 13 Jan 2025 09:40:01 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
	somnath.kotur@broadcom.com,
	Ajit Khaparde <ajit.khaparde@broadcom.com>,
	David Wei <dw@davidwei.uk>
Subject: Re: [PATCH net-next 09/10] bnxt_en: Extend queue stop/start for Tx
 rings
Message-ID: <Z4TRYfno5jCz84KD@mev-dev.igk.intel.com>
References: <20250113063927.4017173-1-michael.chan@broadcom.com>
 <20250113063927.4017173-10-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250113063927.4017173-10-michael.chan@broadcom.com>

On Sun, Jan 12, 2025 at 10:39:26PM -0800, Michael Chan wrote:
> From: Somnath Kotur <somnath.kotur@broadcom.com>
> 
> In order to use queue_stop/queue_start to support the new Steering
> Tags, we need to free the TX ring and TX completion ring if it is a
> combined channel with TX/RX sharing the same NAPI.  Otherwise
> TX completions will not have the updated Steering Tag.  With that
> we can now add napi_disable() and napi_enable() during queue_stop()/
> queue_start().  This will guarantee that NAPI will stop processing
> the completion entries in case there are additional pending entries
> in the completion rings after queue_stop().
> 
> There could be some NQEs sitting unprocessed while NAPI is disabled
> thereby leaving the NQ unarmed.  Explictily Re-arm the NQ after
> napi_enable() in queue start so that NAPI will resume properly.
> 
> Reviewed-by: Ajit Khaparde <ajit.khaparde@broadcom.com>
> Signed-off-by: Somnath Kotur <somnath.kotur@broadcom.com>
> Reviewed-by: Michael Chan <michael.chan@broadcom.com>
> ---
> Cc: David Wei <dw@davidwei.uk>
> 
> Discussion about adding napi_disable()/napi_enable():
> 
> https://lore.kernel.org/netdev/5336d624-8d8b-40a6-b732-b020e4a119a2@davidwei.uk/#t
> ---
>  drivers/net/ethernet/broadcom/bnxt/bnxt.c | 99 ++++++++++++++++++++++-
>  1 file changed, 98 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index fe350d0ba99c..eddb4de959c6 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -7341,6 +7341,22 @@ static int hwrm_ring_free_send_msg(struct bnxt *bp,
>  	return 0;
>  }
>  
> +static void bnxt_hwrm_tx_ring_free(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
> +				   bool close_path)
> +{
> +	struct bnxt_ring_struct *ring = &txr->tx_ring_struct;
> +	u32 cmpl_ring_id;
> +
> +	if (ring->fw_ring_id == INVALID_HW_RING_ID)
> +		return;
> +
> +	cmpl_ring_id = close_path ? bnxt_cp_ring_for_tx(bp, txr) :
> +		       INVALID_HW_RING_ID;
> +	hwrm_ring_free_send_msg(bp, ring, RING_FREE_REQ_RING_TYPE_TX,
> +				cmpl_ring_id);
> +	ring->fw_ring_id = INVALID_HW_RING_ID;
> +}
> +
>  static void bnxt_hwrm_rx_ring_free(struct bnxt *bp,
>  				   struct bnxt_rx_ring_info *rxr,
>  				   bool close_path)
> @@ -11247,6 +11263,69 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init)
>  	return 0;
>  }
>  
> +static void bnxt_tx_queue_stop(struct bnxt *bp, int idx)
> +{
> +	struct bnxt_tx_ring_info *txr;
> +	struct netdev_queue *txq;
> +	struct bnxt_napi *bnapi;
> +	int i;
> +
> +	bnapi = bp->bnapi[idx];
> +	bnxt_for_each_napi_tx(i, bnapi, txr) {
> +		WRITE_ONCE(txr->dev_state, BNXT_DEV_STATE_CLOSING);
> +		synchronize_net();
> +
> +		if (!(bnapi->flags & BNXT_NAPI_FLAG_XDP)) {
> +			txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
> +			if (txq) {
> +				__netif_tx_lock_bh(txq);
> +				netif_tx_stop_queue(txq);
> +				__netif_tx_unlock_bh(txq);
> +			}
> +		}
> +		bnxt_hwrm_tx_ring_free(bp, txr, true);
> +		bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
> +		bnxt_free_one_tx_ring_skbs(bp, txr, txr->txq_index);
> +		bnxt_clear_one_cp_ring(bp, txr->tx_cpr);
> +	}
> +}
> +
> +static int bnxt_tx_queue_start(struct bnxt *bp, int idx)
> +{
> +	struct bnxt_tx_ring_info *txr;
> +	struct netdev_queue *txq;
> +	struct bnxt_napi *bnapi;
> +	int rc, i;
> +
> +	bnapi = bp->bnapi[idx];
> +	bnxt_for_each_napi_tx(i, bnapi, txr) {
> +		rc = bnxt_hwrm_cp_ring_alloc_p5(bp, txr->tx_cpr);
> +		if (rc)
> +			return rc;
> +
> +		rc = bnxt_hwrm_tx_ring_alloc(bp, txr, false);
> +		if (rc) {
> +			bnxt_hwrm_cp_ring_free(bp, txr->tx_cpr);
What about ring allocated in previous steps? Don't you need to free them
too?

> +			return rc;
> +		}
> +		txr->tx_prod = 0;
> +		txr->tx_cons = 0;
> +		txr->tx_hw_cons = 0;
> +
> +		WRITE_ONCE(txr->dev_state, 0);
> +		synchronize_net();
> +
> +		if (bnapi->flags & BNXT_NAPI_FLAG_XDP)
> +			continue;
> +
> +		txq = netdev_get_tx_queue(bp->dev, txr->txq_index);
> +		if (txq)
> +			netif_tx_start_queue(txq);
> +	}
> +
> +	return 0;
> +}
> +
>  static void bnxt_free_irq(struct bnxt *bp)
>  {
>  	struct bnxt_irq *irq;
> @@ -15647,6 +15726,16 @@ static int bnxt_queue_start(struct net_device *dev, void *qmem, int idx)
>  	cpr = &rxr->bnapi->cp_ring;
>  	cpr->sw_stats->rx.rx_resets++;
>  
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS) {
> +		rc = bnxt_tx_queue_start(bp, idx);
> +		if (rc)
> +			netdev_warn(bp->dev,
> +				    "tx queue restart failed: rc=%d\n", rc);
> +	}
> +
> +	napi_enable(&rxr->bnapi->napi);
> +	bnxt_db_nq_arm(bp, &cpr->cp_db, cpr->cp_raw_cons);
> +
>  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
>  		vnic = &bp->vnic_info[i];
>  
> @@ -15675,6 +15764,7 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	struct bnxt *bp = netdev_priv(dev);
>  	struct bnxt_rx_ring_info *rxr;
>  	struct bnxt_vnic_info *vnic;
> +	struct bnxt_napi *bnapi;
>  	int i;
>  
>  	for (i = 0; i <= BNXT_VNIC_NTUPLE; i++) {
> @@ -15686,15 +15776,22 @@ static int bnxt_queue_stop(struct net_device *dev, void *qmem, int idx)
>  	/* Make sure NAPI sees that the VNIC is disabled */
>  	synchronize_net();
>  	rxr = &bp->rx_ring[idx];
> -	cancel_work_sync(&rxr->bnapi->cp_ring.dim.work);
> +	bnapi = rxr->bnapi;
> +	cancel_work_sync(&bnapi->cp_ring.dim.work);
>  	bnxt_hwrm_rx_ring_free(bp, rxr, false);
>  	bnxt_hwrm_rx_agg_ring_free(bp, rxr, false);
>  	page_pool_disable_direct_recycling(rxr->page_pool);
>  	if (bnxt_separate_head_pool())
>  		page_pool_disable_direct_recycling(rxr->head_pool);
>  
> +	if (bp->flags & BNXT_FLAG_SHARED_RINGS)
> +		bnxt_tx_queue_stop(bp, idx);
> +
> +	napi_disable(&bnapi->napi);
> +
>  	bnxt_hwrm_cp_ring_free(bp, rxr->rx_cpr);
>  	bnxt_clear_one_cp_ring(bp, rxr->rx_cpr);
> +	bnxt_db_nq(bp, &cpr->cp_db, cpr->cp_raw_cons);
>  
>  	memcpy(qmem, rxr, sizeof(*rxr));
>  	bnxt_init_rx_ring_struct(bp, qmem);
> -- 
> 2.30.1

