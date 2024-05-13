Return-Path: <netdev+bounces-96092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A4138C44D9
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:10:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B70F1C21399
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70DD155351;
	Mon, 13 May 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="imdllbMD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35C215534D
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616592; cv=none; b=ZZdVl3P8rtjK5ZpJiHVTilhDD8aBflCkqT2goKGCUrIpUkMgsRekwNv72eN0+4Aazlnr2d4HElRs00B0SfYBcTV9YvTkWKM1kGULannBD1zD7U1qLmy7QGreliwLufdc+OEjZawefqT++OYEFCqDkegzhxSN8RwCkWogBbltuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616592; c=relaxed/simple;
	bh=cbtWqYrDgwnkSB19r6+N772IAd9Ks2qmFgoKuDX/Mck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gMUhQ/Co9UF4+aqXd9Yowe0KoUfQ6Hy81ri+B5bREqR232lSiCp15TH10H5rRZgCibU9YxFfVAxwy5yc42yYE/Oata2kWJg/thqwYsRMYIoj6qo4ZLR3xIUH41vU33+sFv3HVdniWQM5QPIZilPW+02cTms2Z90eOF9P45rJT+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=imdllbMD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B874EC2BD11;
	Mon, 13 May 2024 16:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616592;
	bh=cbtWqYrDgwnkSB19r6+N772IAd9Ks2qmFgoKuDX/Mck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=imdllbMDqD3BqHC47qwYsFHScle2A4eNPfcxNiIoTRhtI8hZoRzSW3Uf9Y7QXDiar
	 QuwS1uprtgagrESOXzT2pd+xQzbrAIgi8xceDKcnd/FDB/D1zBvCe8cUdBvpY65ZT4
	 VFjyvFMWdTCilXBxtiqTq1B3LqLiM32feUL1Yc6B54lOhfzYut9sSn3KCPoNlc2Zx/
	 SChT3XLHUJaqme+4gbeHXfCNViMDP9zzr14VlrqrO9AI0lq10MECSRvLX8I8fMkBaW
	 PRHx0ktZqmer+kcvXVfoyfJY0iVacLTfjuTvrFBrP6px3I222JivCbcDdDq0ThZwz1
	 XsWQPFNfrhewQ==
Date: Mon, 13 May 2024 17:09:47 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 08/15] ice: make reprresentor code generic
Message-ID: <20240513160947.GQ2787@kernel.org>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-9-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513083735.54791-9-michal.swiatkowski@linux.intel.com>

On Mon, May 13, 2024 at 10:37:28AM +0200, Michal Swiatkowski wrote:
> Keep the same flow of port representor creation, but instead of general
> attach function create helpers for specific representor type.
> 
> Store function pointer for add and remove representor.
> 
> Type of port representor can be also known based on VSI type, but it
> is more clean to have it directly saved in port representor structure.
> 
> Add devlink lock for whole port representor creation and destruction.
> 
> Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

nit: In subject, reprresentor -> representor

> ---
>  .../ethernet/intel/ice/devlink/devlink_port.h |  1 +
>  drivers/net/ethernet/intel/ice/ice_eswitch.c  | 74 +++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_eswitch.h  | 11 +--
>  drivers/net/ethernet/intel/ice/ice_repr.c     | 88 +++++++++----------
>  drivers/net/ethernet/intel/ice/ice_repr.h     | 16 +++-
>  drivers/net/ethernet/intel/ice/ice_sriov.c    |  4 +-
>  drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  4 +-
>  7 files changed, 121 insertions(+), 77 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> index e4acd855d9f9..6e14b9e4d621 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> @@ -23,6 +23,7 @@ struct ice_dynamic_port {
>  	struct devlink_port devlink_port;
>  	struct ice_pf *pf;
>  	struct ice_vsi *vsi;
> +	unsigned long repr_id;

nit: Please add an entry for repr_id to the Kernel doc for this structure.

     And also the attached field which is added by the last patch
     of this series.

>  	u32 sfnum;
>  };
>  

...

