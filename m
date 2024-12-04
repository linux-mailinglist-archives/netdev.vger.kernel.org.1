Return-Path: <netdev+bounces-149046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F649E3EAB
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACF83B474FC
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 15:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BFE20B1EC;
	Wed,  4 Dec 2024 15:05:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B42B1FECCF
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733324733; cv=none; b=ZlwZt718xnX0vRJxDp3FdZXk8QsJFavP/ihH2QgbcnYfyfS46EPv4I+MNcWqatBiKEYQIGVRGGcVkKOcXiJGF96dOcvEnxVTZFYozRMthOfoi4ppCG1kKr1ZhDr9tesrUqXEk3/KXu+Mt9wyrEJ+tWnK1u2fZq1rEwkmUCPBjvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733324733; c=relaxed/simple;
	bh=ayicYYVSFQvgHq3DJstUtSqUM355N67uvzqrp9QyLNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJwiNSrgiSVI/LkiOGpu6k/yPlYEdqICZvDueAgz64Y9ufkaVRoKdqs3/8LEwDDnMki1f+bWcsjOM8iXGQ2Q32n5j/zqXHNdw01bW/Yo00XSyqHl7YVCbZaNU7dF/FAtMIpVoRj5w4gv4emMV4eeNB+Aq/9REaHQHAmUJwyJTP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af1e1.dynamic.kabel-deutschland.de [95.90.241.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 34F6F61E64778;
	Wed, 04 Dec 2024 16:05:05 +0100 (CET)
Message-ID: <f684e517-19c5-4dd9-9de6-34aefe289552@molgen.mpg.de>
Date: Wed, 4 Dec 2024 16:05:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: move static_assert to
 declaration section
To: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Marcin Szycik <marcin.szycik@linux.intel.com>
References: <20241204150224.346606-1-mateusz.polchlopek@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241204150224.346606-1-mateusz.polchlopek@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Mateusz,


Thank you for the patch.

Am 04.12.24 um 16:02 schrieb Mateusz Polchlopek:
> static_assert() needs to be placed in the declaration section,
> so move it there in ice_cfg_tx_topo() function.
> 
> Current code causes following warnings on some gcc versions:

Please list the versions you know of.

> error: ISO C90 forbids mixed declarations and code
> [-Werror=declaration-after-statement]

The above could be in one line, as it’s pasted.

> Fixes: c188afdc3611 ("ice: fix memleak in ice_init_tx_topology()")
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_ddp.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_ddp.c b/drivers/net/ethernet/intel/ice/ice_ddp.c
> index 69d5b1a28491..e885f84520ba 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ddp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ddp.c
> @@ -2388,6 +2388,8 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
>   	int status;
>   	u8 flags;
>   
> +	static_assert(ICE_PKG_BUF_SIZE == ICE_AQ_MAX_BUF_LEN);
> +
>   	if (!buf || !len)
>   		return -EINVAL;
>   
> @@ -2482,7 +2484,6 @@ int ice_cfg_tx_topo(struct ice_hw *hw, const void *buf, u32 len)
>   	}
>   
>   	/* Get the new topology buffer, reuse current topo copy mem */
> -	static_assert(ICE_PKG_BUF_SIZE == ICE_AQ_MAX_BUF_LEN);
>   	new_topo = topo;
>   	memcpy(new_topo, (u8 *)section + offset, size);

The diff looks good.


Kind regards,

Paul

