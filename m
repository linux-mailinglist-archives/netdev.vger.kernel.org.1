Return-Path: <netdev+bounces-99738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 219BA8D62BA
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D018228B514
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 13:17:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DF11422C7;
	Fri, 31 May 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+iaJH+q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3406339A1
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 13:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717161347; cv=none; b=HTkhons1lF/7xXJJDqQ5iUuqiNTWJ+OQZ240E6yudTTHVh6CZHQGBkZTV/ki9BqMq4rTUQZlu585pg0+wRla9cXfAW8F10nWcuoJy2/b4qk6U9pYOE0E+EEGJ3hjjtsY5ol8GCp7IlM4ePzLlQtk8QiBTidPLdpvyKSYPRWkhf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717161347; c=relaxed/simple;
	bh=jicBXvi5RlbnZo0yegOKGBtoOQPvjAfIaE5jcq/MBts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ShllFs3Q1at2G4AdN02G4O/kRc28KQ57pd7KsRrpyx/WfoLzXA3abRBQz7b57CtCj7a0DswKvyOZQTAuSG0fBk5GZIabGGTLjCzvp84hWg3nPg12dcZ0bn8K21/QairiYGBHiA/X4Px2OUzi8RLP7mMdjo8rC6PyeM4wxjlXxXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+iaJH+q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DDC6C116B1;
	Fri, 31 May 2024 13:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717161346;
	bh=jicBXvi5RlbnZo0yegOKGBtoOQPvjAfIaE5jcq/MBts=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+iaJH+qfzIKMGzUi+mHyH/FycCxQa1ThAL8A86wXOPneOzl4Al/fkmlsSyuSQ6oO
	 jKVSqXPZ+OvLfC4T5moysMq4GtsmL84izHgvDmE4OqjukFxwpkY3SN7oS+PjHutVRE
	 XLDATJC1A7wgnp4DSLid9fKwFRyU9NjMp6Ww6t0Xw7iLKr6wRrLWh2ugn7yPl+mNUu
	 x2QnyDCqthOPhurnwi214BXZe6E04AMR9PqHhdqJhG4cUbfjktYTCzI9quq7Wuhr1a
	 NCE7+A7PWjQn2nu3o7u9EpmgLsQKQraSbRlcTl7Y6FC+WOc0cdyIxvgC8ImXhXGu7X
	 W8gn7XF2PlPQw==
Date: Fri, 31 May 2024 14:15:42 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, anthony.l.nguyen@intel.com,
	Junfeng Guo <junfeng.guo@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Wojciech Drewek <wojciech.drewek@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v2 04/13] ice: add parser internal helper
 functions
Message-ID: <20240531131542.GF123401@kernel.org>
References: <20240527185810.3077299-1-ahmed.zaki@intel.com>
 <20240527185810.3077299-5-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527185810.3077299-5-ahmed.zaki@intel.com>

On Mon, May 27, 2024 at 12:58:01PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Add the following internal helper functions:
> 
> - ice_bst_tcam_match():
>   to perform ternary match on boost TCAM.
> 
> - ice_pg_cam_match():
>   to perform parse graph key match in cam table.
> 
> - ice_pg_nm_cam_match():
>   to perform parse graph key no match in cam table.
> 
> - ice_ptype_mk_tcam_match():
>   to perform ptype markers match in tcam table.
> 
> - ice_flg_redirect():
>   to redirect parser flags to packet flags.
> 
> - ice_xlt_kb_flag_get():
>   to aggregate 64 bit packet flag into 16 bit key builder flags.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_parser.c | 196 ++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_parser.h |  52 ++++--
>  2 files changed, 233 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c
> index 19dd7472b5ba..91dbe70d7fe5 100644
> --- a/drivers/net/ethernet/intel/ice/ice_parser.c
> +++ b/drivers/net/ethernet/intel/ice/ice_parser.c
> @@ -957,6 +957,105 @@ static struct ice_pg_nm_cam_item *ice_pg_nm_sp_cam_table_get(struct ice_hw *hw)
>  					ice_pg_nm_sp_cam_parse_item, false);
>  }
>  
> +static bool __ice_pg_cam_match(struct ice_pg_cam_item *item,
> +			       struct ice_pg_cam_key *key)
> +{
> +	return (item->key.valid &&
> +		!memcmp(&item->key.val, &key->val, sizeof(key->val)));
> +}
> +
> +static bool __ice_pg_nm_cam_match(struct ice_pg_nm_cam_item *item,
> +				  struct ice_pg_cam_key *key)
> +{
> +	return (item->key.valid &&
> +		!memcmp(&item->key.val, &key->val, sizeof(key->val)));
> +}

Hi,

The size of &item->key.val is 9 bytes, while the size of key->val is 13 bytes.
So this will compare data beyond the end of &item->key.val.

I think this is caused by the presence of the next_proto field
in the val struct_group of struct ice_pg_cam_key.

I do also wonder if there could be some consolidation in
the definitions of struct ice_pg_cam_key and struct ice_pg_nm_cam_key.
The main difference seems to be the presence of next_proto at
the end of the latter.

Flagged by Smatch.

...

> +/**
> + * ice_xlt_kb_flag_get - aggregate 64 bits packet flag into 16 bits xlt flag
> + * @kb: xlt key build
> + * @pkt_flag: 64 bits packet flag
> + */
> +u16 ice_xlt_kb_flag_get(struct ice_xlt_kb *kb, u64 pkt_flag)
> +{
> +	struct ice_xlt_kb_entry *entry = &kb->entries[0];
> +	u16 flag = 0;
> +	int i;
> +
> +	/* check flag 15 */
> +	if (kb->flag15 & pkt_flag)
> +		flag = (u16)BIT(ICE_XLT_KB_FLAG0_14_CNT);

nit: It's not clear to me that this cast is necessary.
     Likewise twice more in this function, and elsewhere in this patchset.

> +
> +	/* check flag 0 - 14 */
> +	for (i = 0; i < ICE_XLT_KB_FLAG0_14_CNT; i++) {
> +		/* only check first entry */
> +		u16 idx = (u16)(entry->flg0_14_sel[i] & ICE_XLT_KB_MASK);
> +
> +		if (pkt_flag & BIT(idx))
> +			flag |= (u16)BIT(i);
> +	}
> +
> +	return flag;
> +}

...

