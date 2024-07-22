Return-Path: <netdev+bounces-112433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41A3F939102
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 16:52:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF4B28119F
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 14:52:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67916D9A5;
	Mon, 22 Jul 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elys/iBl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E228F70
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 14:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721659952; cv=none; b=RdRKPxFWffmRayVwVqzZuWUfoDBvXFDWqzWgfhW5IiTQsKsj+iCh/uUHO/uYGgDgCPzNqw2ZSx/QJLfqPz4kFNZGz04kp0k4CA8+97rZ9idTWq6g+jWnz/4+zO/zpqyeHfw4BPovXSbbeDfOKl5JBsewKuDiBrOxAPwCwuI9Yjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721659952; c=relaxed/simple;
	bh=X5vtgBbIFY94UZFzz5Z0wVbQf/UQJQkm65kZtdjyOn8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RF7nt07ft7CEtC79ZSh3P7YVodyULrgW60VaOnL2HEBtG0PgPfYSyWff5CmL24RGUF3IRpsxXAxEqcZIJmcG57aP5p2k8m5bBmmXmJDBR+hyiJxZqCK/bYIYxrwAb8lYaBc+kC7H2rqgKezzXLL2va6rBVoai22zuMnXPEb6T+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elys/iBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5E44C116B1;
	Mon, 22 Jul 2024 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721659952;
	bh=X5vtgBbIFY94UZFzz5Z0wVbQf/UQJQkm65kZtdjyOn8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=elys/iBl/kxiwKS/6b6wSQwH+fkjUizOgFjp0/UX1B620RuU4DmO3AkZK3YYqCvJl
	 BaIUraxvPLoehVdfrX4SGzfCxXLJDIvG3FDpu4aUfHA8y2IyLvZ/3IDtvOXDXMsNip
	 WGS9q3nQnv/m64T2KccMvaaM7cXSL06HimrVY+J2us9BjcNgYJaP+Oo9a3lQ+qsWcN
	 dgGSkAW1Fl/kJ290fcqDNb6PBqHAvTv77nI3nH8AF9QEapVREFk7rcXtqT8IlhByyJ
	 OuQYUmp7zBWl6CF48eP3J6TAznN+q5hMSunYpLw3tLVt9ebyTppfPDYnVc2i6VJvWN
	 0u/QStuZk/quA==
Date: Mon, 22 Jul 2024 15:52:28 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-next v3 02/13] ice: parse and init various DDP parser
 sections
Message-ID: <20240722145228.GF715661@kernel.org>
References: <20240710204015.124233-1-ahmed.zaki@intel.com>
 <20240710204015.124233-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710204015.124233-3-ahmed.zaki@intel.com>

On Wed, Jul 10, 2024 at 02:40:04PM -0600, Ahmed Zaki wrote:
> From: Junfeng Guo <junfeng.guo@intel.com>
> 
> Parse the following DDP sections:
>  - ICE_SID_RXPARSER_IMEM into an array of struct ice_imem_item
>  - ICE_SID_RXPARSER_METADATA_INIT into an array of struct ice_metainit_item
>  - ICE_SID_RXPARSER_CAM or ICE_SID_RXPARSER_PG_SPILL into an array of
>    struct ice_pg_cam_item
>  - ICE_SID_RXPARSER_NOMATCH_CAM or ICE_SID_RXPARSER_NOMATCH_SPILL into an
>    array of struct ice_pg_nm_cam_item
>  - ICE_SID_RXPARSER_CAM into an array of ice_bst_tcam_item
>  - ICE_SID_LBL_RXPARSER_TMEM into an array of ice_lbl_item
>  - ICE_SID_RXPARSER_MARKER_PTYPE into an array of ice_ptype_mk_tcam_item
>  - ICE_SID_RXPARSER_MARKER_GRP into an array of ice_mk_grp_item
>  - ICE_SID_RXPARSER_PROTO_GRP into an array of ice_proto_grp_item
>  - ICE_SID_RXPARSER_FLAG_REDIR into an array of ice_flg_rd_item
>  - ICE_SID_XLT_KEY_BUILDER_SW, ICE_SID_XLT_KEY_BUILDER_ACL,
>    ICE_SID_XLT_KEY_BUILDER_FD and ICE_SID_XLT_KEY_BUILDER_RSS into
>    struct ice_xlt_kb
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Qi Zhang <qi.z.zhang@intel.com>
> Signed-off-by: Junfeng Guo <junfeng.guo@intel.com>
> Co-developed-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>

Hi Ahmed, Junfeng, all,

Some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_parser.c b/drivers/net/ethernet/intel/ice/ice_parser.c

...

> +/**
> + * ice_parser_create_table - create an item table from a section
> + * @hw: pointer to the hardware structure
> + * @sect_type: section type
> + * @item_size: item size in byte
> + * @length: number of items in the table to create
> + * @parse_item: the function to parse the item
> + * @no_offset: ignore header offset, calculate index from 0
> + *
> + * Return: a pointer to the allocated table or ERR_PTR.
> + */
> +static
> +void *ice_parser_create_table(struct ice_hw *hw, u32 sect_type,
> +			      u32 item_size, u32 length,
> +			      void (*parse_item)(struct ice_hw *hw, u16 idx,
> +						 void *item, void *data,
> +						 int size),
> +			      bool no_offset)
> +{
> +	struct ice_pkg_enum state = {};
> +	struct ice_seg *seg = hw->seg;
> +	void *table, *data, *item;
> +	u16 idx = U16_MAX;
> +
> +	if (!seg)
> +		return ERR_PTR(-EINVAL);
> +
> +	table = kzalloc(item_size * length, GFP_KERNEL);
> +	if (!table)
> +		return ERR_PTR(-ENOMEM);
> +
> +	do {
> +		data = ice_pkg_enum_entry(seg, &state, sect_type, NULL,
> +					  ice_parser_sect_item_get);
> +		seg = NULL;
> +		if (data) {
> +			struct ice_pkg_sect_hdr *hdr =
> +				(struct ice_pkg_sect_hdr *)state.sect;

nit: As the type of state.sect is void * I don't think there is a
     need to explicitly cast it to another type of pointer.

			struct ice_pkg_sect_hdr *hdr = state.sect;

> +
> +			if (no_offset)
> +				idx++;
> +			else
> +				idx = le16_to_cpu(hdr->offset) +
> +					state.entry_idx;
> +
> +			item = (void *)((uintptr_t)table + idx * item_size);
> +			parse_item(hw, idx, item, data, item_size);
> +		}
> +	} while (data);
> +
> +	return table;
> +}

...

> +/**
> + * ice_imem_parse_item - parse 384 bits of IMEM entry
> + * @hw: pointer to the hardware structure
> + * @idx: index of IMEM entry
> + * @item: item of IMEM entry
> + * @data: IMEM entry data to be parsed
> + * @size: size of IMEM entry
> + */
> +static void ice_imem_parse_item(struct ice_hw *hw, u16 idx, void *item,
> +				void *data, int __maybe_unused size)
> +{
> +	struct ice_imem_item *ii = item;
> +	u8 *buf = (u8 *)data;

Similarly, I don't think there is a need to explicitly cast here:

	u8 *buf = data;

> +
> +	ii->idx = idx;
> +
> +	ice_imem_bm_init(&ii->b_m, *(u8 *)buf);
> +	ice_imem_bkb_init(&ii->b_kb,
> +			  *((u16 *)(&buf[ICE_IMEM_BKB_IDD])) >>
> +			   ICE_IMEM_BKB_OFF);
> +
> +	ii->pg_prio = FIELD_GET(ICE_IMEM_PGP, *(u16 *)buf);
> +
> +	ice_imem_npkb_init(&ii->np_kb,
> +			   *((u32 *)(&buf[ICE_IMEM_NPKB_IDD])) >>
> +			    ICE_IMEM_NPKB_OFF);
> +	ice_imem_pgkb_init(&ii->pg_kb,
> +			   *((u64 *)(&buf[ICE_IMEM_PGKB_IDD])) >>
> +			    ICE_IMEM_PGKB_OFF);
> +
> +	ice_imem_alu_init(&ii->alu0,
> +			  &buf[ICE_IMEM_ALU0_IDD],
> +			  ICE_IMEM_ALU0_OFF);
> +	ice_imem_alu_init(&ii->alu1,
> +			  &buf[ICE_IMEM_ALU1_IDD],
> +			  ICE_IMEM_ALU1_OFF);
> +	ice_imem_alu_init(&ii->alu2,
> +			  &buf[ICE_IMEM_ALU2_IDD],
> +			  ICE_IMEM_ALU2_OFF);
> +}
> +
> +/**
> + * ice_imem_table_get - create an imem table
> + * @hw: pointer to the hardware structure
> + *
> + * Return: a pointer to the allocated IMEM table.
> + */
> +static struct ice_imem_item *ice_imem_table_get(struct ice_hw *hw)
> +{
> +	return (struct ice_imem_item *)
> +		ice_parser_create_table(hw, ICE_SID_RXPARSER_IMEM,
> +					sizeof(struct ice_imem_item),
> +					ICE_IMEM_TABLE_SIZE,
> +					ice_imem_parse_item, false);
> +}

Or here.
And, likewise, for other similar calls to ice_parser_create_table().

...


