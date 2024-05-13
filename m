Return-Path: <netdev+bounces-96091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A79988C44D0
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 18:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620C3280D35
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 16:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3E8153BF6;
	Mon, 13 May 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lApNT+j5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D3C57CAA
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 16:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715616356; cv=none; b=TdtIetOccK+gNghc5lWzQS31qnNTJvyk8OjzyY4WIZU/66gXB2y/vKpg07zTs1UM9mgNzU/HhLQ4j/d+zzBhm42bJl42sTLXzIhmQNeYPSRgxE14p3AYtILwuDAO3Wc0Xazaq0r4NgEgsGZqAe3vKVtGe/5W+J8exu+G3EmZbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715616356; c=relaxed/simple;
	bh=LORKsNqk+QgxIQWMAMEAfbSBqWqiSfgiC4QfHFnqnHk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSftSKba9RoChW5riL5wTgeYM7lapOxuIdvFK+CKM0F/wFxM9OqSUCko/gk0Cu/wfIquWOOjacRSKkEUEJjdK8oo6QQQef1WoWL4+vHFjeRGH9O/8jY8X6uaT+qjYvje1IUIQ3gTk3Fekco2/d2Vdch/9nH7v3SinYfUEGOnaHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lApNT+j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38BAC2BD11;
	Mon, 13 May 2024 16:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715616356;
	bh=LORKsNqk+QgxIQWMAMEAfbSBqWqiSfgiC4QfHFnqnHk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lApNT+j56bSWl+lAyBfrV6icWyBXcdM973hE4o1lKxBAwj8xDUaN+A1/iwVnokSlx
	 BXjiYadaySb6J70NHsihZloSRVcKs/44UrBGhIYnG75C5V47HlG3OCxFVYZ1kbM3+9
	 g6w4N1FVW4OM+ampO7l9lBJLuPDrxbS1elI9bT3p8OJXrEH0Gie/3BFslspuDAUhzN
	 /AurJF3h121wp4AE4T32vnxZNOUFex6Zdd97jp5SKVNtSChCBrtiL7cg9YI+0ZAxUn
	 a/M6RaxEPbyi1mOQRCPWKdyGlhbxJvPzYcIg14vPDobpoElr/7FGCbLbU/NwcZ86HQ
	 TGicU+03yvMhw==
Date: Mon, 13 May 2024 17:05:51 +0100
From: Simon Horman <horms@kernel.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	jacob.e.keller@intel.com, michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com, sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com, wojciech.drewek@intel.com,
	pio.raczynski@gmail.com, jiri@nvidia.com,
	mateusz.polchlopek@intel.com, shayd@nvidia.com
Subject: Re: [iwl-next v2 03/15] ice: add basic devlink subfunctions support
Message-ID: <20240513160551.GP2787@kernel.org>
References: <20240513083735.54791-1-michal.swiatkowski@linux.intel.com>
 <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513083735.54791-4-michal.swiatkowski@linux.intel.com>

On Mon, May 13, 2024 at 10:37:23AM +0200, Michal Swiatkowski wrote:

...

> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> index 9223bcdb6444..f20d7cc522a6 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.h
> @@ -4,9 +4,42 @@
>  #ifndef _DEVLINK_PORT_H_
>  #define _DEVLINK_PORT_H_
>  
> +#include "../ice.h"
> +
> +/**
> + * struct ice_dynamic_port - Track dynamically added devlink port instance
> + * @hw_addr: the HW address for this port
> + * @active: true if the port has been activated
> + * @devlink_port: the associated devlink port structure
> + * @pf: pointer to the PF private structure
> + * @vsi: the VSI associated with this port

nit: An entry for @sfnum should go here.

> + *
> + * An instance of a dynamically added devlink port. Each port flavour
> + */
> +struct ice_dynamic_port {
> +	u8 hw_addr[ETH_ALEN];
> +	u8 active: 1;
> +	struct devlink_port devlink_port;
> +	struct ice_pf *pf;
> +	struct ice_vsi *vsi;
> +	u32 sfnum;
> +};

...

