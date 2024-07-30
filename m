Return-Path: <netdev+bounces-114096-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE674940EE2
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6898D2834D5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44170194AD7;
	Tue, 30 Jul 2024 10:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B1KHYyS7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203E5194147
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 10:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334946; cv=none; b=ZLA2V78ZbqbruygUfmI0AaIJcbuRcffLayZjSh59lebZkb7heR+Lnqm3eQeyVWuYu17RD0iexfEFzTaBweNgnTL3OGIg9Uh1IZHWWQkzJ8xLn39z3nasKq0VOh/A1M7Ih4WEHO0NTmBMANH1zN0347mt7YrbtW4NXok4KlxppfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334946; c=relaxed/simple;
	bh=FAKMTn+nJq28RNhqQGFEW56rWI6zLx4spm+AYLeNgMc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EgEFi9Y7PPL8UWVK73cY8+bOJc38G3JkyWqhqHxsv+0yOwl6DW3HLeZgPrRMgf92SjJJ536XaCk+tF4Xhb+iGxRHfccbLzpnVMaec4rvv77kKrfpiCn0KufipMLZwwP46QL4aeY8h/FI+B228SafFWUpVNAEsOlf1SkvXLod3g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B1KHYyS7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A61C32782;
	Tue, 30 Jul 2024 10:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722334945;
	bh=FAKMTn+nJq28RNhqQGFEW56rWI6zLx4spm+AYLeNgMc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B1KHYyS7NmGI913LL9MFULJydvxlM+VGWqRAAwDa0LEIFN9vlExg2uhto86S1ASrd
	 i56dFKzUjEYwXdQHnDTA3UuWRz6NE/TKbMSfr20n8g3vp9B6paPXv9fUYcz0CXgi9k
	 YNTsoWEVakXvu7q7jnooXVKUcjq10YeX4LXDq73I3iUWIElbnw91AAcvnRpySV2WdP
	 FH2vVcnQquP19lUfdzGyrn7s++bYA79GWabRZ+k0V1rqSpawAjEkKrLUKZPMo7X2CO
	 C9vMhj9oHwGoFC0uurI1bOCmp+QnEMGo6jEOzxjIYt3URMvJP8Vyhcq/1f7Sh28Tm5
	 szn+8e2Qz/1Qg==
Date: Tue, 30 Jul 2024 11:22:21 +0100
From: Simon Horman <horms@kernel.org>
To: Ahmed Zaki <ahmed.zaki@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	hkelam@marvell.com, Junfeng Guo <junfeng.guo@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: Re: [PATCH iwl-next v5 02/13] ice: parse and init various DDP parser
 sections
Message-ID: <20240730102221.GS97837@kernel.org>
References: <20240725220810.12748-1-ahmed.zaki@intel.com>
 <20240725220810.12748-3-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240725220810.12748-3-ahmed.zaki@intel.com>

On Thu, Jul 25, 2024 at 04:07:58PM -0600, Ahmed Zaki wrote:
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
> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


