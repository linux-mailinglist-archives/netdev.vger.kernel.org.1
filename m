Return-Path: <netdev+bounces-108167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619E691E0AB
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF858B22943
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE8B15E5BA;
	Mon,  1 Jul 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb0hRoG5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AA115532E
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 13:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840445; cv=none; b=CeH9l4Oov8cfRcZiZ0Lzl+rGdgEWQkjaNUw8EEpBNpM+qXHT/IoFvrFaHQhq3ptuYYg769HOnDUs1NHuPiRCrwJWHflUzIrOB5YIt0qNBzcRnLaetRnkfSKMQuX8mbXLKfBauDkPj7DGBpYuculcVTgJaTKrLZqoV67sdwfGdDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840445; c=relaxed/simple;
	bh=MdY5UR7M3EZd1PTsJ/zmuKA5VFeW4CLRWVUQwWBfnfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bTg7FFk0dwntL/U/vmGkZfsUe9L7JyUPwS5djLOuNJM5TKMgyjOvJBQsVIm/w1++LyIZAidwFirGXEKqMexeP6R+BbY68W9bN5GqGz93mMwdAN5EAD2fa5Nlpp3+FArO+PpOpbpG53JDRCOpj/lVkhJP9/ldtrkkGP5wKC4tJP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb0hRoG5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8229C116B1;
	Mon,  1 Jul 2024 13:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840445;
	bh=MdY5UR7M3EZd1PTsJ/zmuKA5VFeW4CLRWVUQwWBfnfI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lb0hRoG5GGtI3lhF1K5o0YaA2wh6E1r7ygMb6vX8v8TIs5/c4q+WZZx7sEP6oCPIC
	 qtt7Ub8lWO9j8pTpjZ95poUZc/Lc+3V5Gj6n1984zBhfmEbAinV/JrX1zlbGaqgk5V
	 h0Kj1M6g5TkXvSj8DLw5A4o5A1MUXkuuyUpg3MJ0Xc5/tUt2ej7zyLTE4yt/dVtcQt
	 xh8ttW1nUVZZxEufWYXFvAyDmeYZQtn5z2nCAWW4dqbG9C07r8t9XUj2dthHrKIy2R
	 aFmAwP8Cs1fyZF/Tow9xXHdxXBI7tGjFkw56NGOLdfUmojFWV4XfRIXeP6DHbmCr6L
	 01E6e+6YgogRA==
Date: Mon, 1 Jul 2024 14:27:21 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 5/7] ice: Disable shared pin on E810 on setfunc
Message-ID: <20240701132721.GC17134@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-14-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627151127.284884-14-karol.kolacinski@intel.com>

On Thu, Jun 27, 2024 at 05:09:29PM +0200, Karol Kolacinski wrote:
> When setting a new supported function for a pin on E810, disable other
> enabled pin that shares the same GPIO.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 65 ++++++++++++++++++++++++
>  1 file changed, 65 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c

...

> @@ -1885,6 +1942,14 @@ static int ice_verify_pin(struct ptp_clock_info *info, unsigned int pin,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	/* On adapters with SMA_CTRL disable other pins that share same GPIO */
> +	if (ice_is_feature_supported(pf, ICE_F_SMA_CTRL)) {
> +		ice_ptp_disable_shared_pin(pf, pin, func);
> +		pf->ptp.pin_desc[pin].func = func;
> +		pf->ptp.pin_desc[pin].chan = chan;
> +		return ice_ptp_set_sma_cfg_e810t(pf);

This appears to be resolved in the following patch by calling
ice_ptp_set_sma_cfg_() instead, but this fails to build because
ice_ptp_set_sma_cfg_e810t() does not exits.

> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.45.2
> 
> 

