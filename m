Return-Path: <netdev+bounces-110725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9890392DF44
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 07:00:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EACF6B21FA9
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 05:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6C0101E4;
	Thu, 11 Jul 2024 05:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5CD20312
	for <netdev@vger.kernel.org>; Thu, 11 Jul 2024 05:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720674022; cv=none; b=qpuBGlrZSxQ6lwC76wQF1CuC3RmD6/CjBd5zfogLsRuWgFXqN7jamYS25nkMwnYrf5+XUVJuSX2G2dK9UYxrxEKQ1kPpcXGWwiJB7dRlYW3YyvA4EV8f8dh1pD0F32wVqdae36q+eZLiNFrtaw1/9lJ5RimoCGKz+c/b+7N44uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720674022; c=relaxed/simple;
	bh=Ju3XI7m5dWN8Ee91J2zjjYNo5yFJLecnNkNFZKoniUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o/9PKnqh9QaeE6OseG1SW6NaSqhsP3dIxUM91gxFGEaXsEk3Yyg8gMTkESyqHEN5WXGNVOzV9ipfUVbhntORQD9r7jGs2TMNLDNwkgxWEzBNPFP5ogmRqzmMSNUn8+F1qfokrPaf24LpatnDcGoG1bxN36tgn7WOB0pI5GsRJO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af435.dynamic.kabel-deutschland.de [95.90.244.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A9F4861E4050B;
	Thu, 11 Jul 2024 06:59:46 +0200 (CEST)
Message-ID: <b0a70c97-2a25-4dca-9db1-aca64206a53c@molgen.mpg.de>
Date: Thu, 11 Jul 2024 06:59:46 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3 10/13] ice: add method to
 disable FDIR SWAP option
To: Ahmed Zaki <ahmed.zaki@intel.com>, Junfeng Guo <junfeng.guo@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>, anthony.l.nguyen@intel.com,
 horms@kernel.org
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-11-ahmed.zaki@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240710204015.124233-11-ahmed.zaki@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Ahmed, dear Junfeng,


Thank you for the patch.


Am 10.07.24 um 22:40 schrieb Ahmed Zaki:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> The SWAP Flag in the FDIR Programming Descriptor doesn't work properly,
> it is always set and cannot be unset (hardware bug).

Please document the datasheet/errata.

> Thus, add a method
> to effectively disable the FDIR SWAP option by setting the FDSWAP instead
> of FDINSET registers.

Please paste the new debug messages.

> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>   .../net/ethernet/intel/ice/ice_flex_pipe.c    | 52 ++++++++++++++++++-
>   .../net/ethernet/intel/ice/ice_flex_pipe.h    |  4 +-
>   drivers/net/ethernet/intel/ice/ice_flow.c     |  2 +-
>   3 files changed, 54 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> index 20d5db88c99f..a750d7e1edd8 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.c
> @@ -2981,6 +2981,51 @@ ice_add_prof_attrib(struct ice_prof_map *prof, u8 ptg, u16 ptype,
>   }
>   
>   /**
> + * ice_disable_fd_swap - set register appropriately to disable FD swap

Below you write SWAP all uppercase.

> + * @hw: pointer to the HW struct
> + * @prof_id: profile ID
> + *
> + * Return: Void.
> + */
> +static void
> +ice_disable_fd_swap(struct ice_hw *hw, u8 prof_id)
> +{
> +	u16 swap_val, i, fvw_num;

Try to use non-fixed-width types, where possible.

> +
> +	swap_val = ICE_SWAP_VALID;
> +	fvw_num = hw->blk[ICE_BLK_FD].es.fvw / ICE_FDIR_REG_SET_SIZE;
> +
> +	/* Since the SWAP Flag in the Programming Desc doesn't work,
> +	 * here add method to disable the SWAP Option via setting
> +	 * certain SWAP and INSET register sets.
> +	 */
> +	for (i = 0; i < fvw_num ; i++) {
> +		u32 raw_swap, raw_in;
> +		u8 j;

unsigned int

> +
> +		raw_swap = 0;
> +		raw_in = 0;
> +
> +		for (j = 0; j < ICE_FDIR_REG_SET_SIZE; j++) {
> +			raw_swap |= (swap_val++) << (j * BITS_PER_BYTE);
> +			raw_in |= ICE_INSET_DFLT << (j * BITS_PER_BYTE);
> +		}
> +
> +		/* write the FDIR swap register set */
> +		wr32(hw, GLQF_FDSWAP(prof_id, i), raw_swap);
> +
> +		ice_debug(hw, ICE_DBG_INIT, "swap wr(%d, %d): 0x%x = 0x%08x\n",
> +			  prof_id, i, GLQF_FDSWAP(prof_id, i), raw_swap);
> +
> +		/* write the FDIR inset register set */
> +		wr32(hw, GLQF_FDINSET(prof_id, i), raw_in);
> +
> +		ice_debug(hw, ICE_DBG_INIT, "inset wr(%d, %d): 0x%x = 0x%08x\n",
> +			  prof_id, i, GLQF_FDINSET(prof_id, i), raw_in);
> +	}
> +}
> +
> +/*
>    * ice_add_prof - add profile
>    * @hw: pointer to the HW struct
>    * @blk: hardware block
> @@ -2991,6 +3036,7 @@ ice_add_prof_attrib(struct ice_prof_map *prof, u8 ptg, u16 ptype,
>    * @es: extraction sequence (length of array is determined by the block)
>    * @masks: mask for extraction sequence
>    * @symm: symmetric setting for RSS profiles
> + * @fd_swap: enable/disable FDIR paired src/dst fields swap option
>    *
>    * This function registers a profile, which matches a set of PTYPES with a
>    * particular extraction sequence. While the hardware profile is allocated
> @@ -3000,7 +3046,7 @@ ice_add_prof_attrib(struct ice_prof_map *prof, u8 ptg, u16 ptype,
>   int
>   ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
>   	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
> -	     struct ice_fv_word *es, u16 *masks, bool symm)
> +	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap)
>   {
>   	u32 bytes = DIV_ROUND_UP(ICE_FLOW_PTYPE_MAX, BITS_PER_BYTE);
>   	DECLARE_BITMAP(ptgs_used, ICE_XLT1_CNT);
> @@ -3020,7 +3066,7 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
>   		status = ice_alloc_prof_id(hw, blk, &prof_id);
>   		if (status)
>   			goto err_ice_add_prof;
> -		if (blk == ICE_BLK_FD) {
> +		if (blk == ICE_BLK_FD && fd_swap) {
>   			/* For Flow Director block, the extraction sequence may
>   			 * need to be altered in the case where there are paired
>   			 * fields that have no match. This is necessary because
> @@ -3031,6 +3077,8 @@ ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
>   			status = ice_update_fd_swap(hw, prof_id, es);
>   			if (status)
>   				goto err_ice_add_prof;
> +		} else if (blk == ICE_BLK_FD) {
> +			ice_disable_fd_swap(hw, prof_id);
>   		}
>   		status = ice_update_prof_masking(hw, blk, prof_id, masks);
>   		if (status)
> diff --git a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
> index b39d7cdc381f..7c66652dadd6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
> +++ b/drivers/net/ethernet/intel/ice/ice_flex_pipe.h
> @@ -6,6 +6,8 @@
>   
>   #include "ice_type.h"
>   
> +#define ICE_FDIR_REG_SET_SIZE	4
> +
>   int
>   ice_acquire_change_lock(struct ice_hw *hw, enum ice_aq_res_access_type access);
>   void ice_release_change_lock(struct ice_hw *hw);
> @@ -42,7 +44,7 @@ bool ice_hw_ptype_ena(struct ice_hw *hw, u16 ptype);
>   int
>   ice_add_prof(struct ice_hw *hw, enum ice_block blk, u64 id, u8 ptypes[],
>   	     const struct ice_ptype_attributes *attr, u16 attr_cnt,
> -	     struct ice_fv_word *es, u16 *masks, bool symm);
> +	     struct ice_fv_word *es, u16 *masks, bool symm, bool fd_swap);
>   struct ice_prof_map *
>   ice_search_prof_id(struct ice_hw *hw, enum ice_block blk, u64 id);
>   int
> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
> index fc2b58f56279..79106503194b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
> @@ -1400,7 +1400,7 @@ ice_flow_add_prof_sync(struct ice_hw *hw, enum ice_block blk,
>   	/* Add a HW profile for this flow profile */
>   	status = ice_add_prof(hw, blk, prof_id, (u8 *)params->ptypes,
>   			      params->attr, params->attr_cnt, params->es,
> -			      params->mask, symm);
> +			      params->mask, symm, true);
>   	if (status) {
>   		ice_debug(hw, ICE_DBG_FLOW, "Error adding a HW flow profile\n");
>   		goto out;


Kind regards,

Paul

