Return-Path: <netdev+bounces-102522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B51B5903759
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 11:02:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24FD428D09D
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 09:02:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1857171667;
	Tue, 11 Jun 2024 09:02:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4303174EE3
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 09:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718096553; cv=none; b=hqk0VP4h8bu9ckenLWN6jH+nKp8O73sXzamSa4XJpclpR0UgtNGGirnKOQQCLdajBi3TUhFGKPnb1ow8vNnmBu1C9xS4+12vZltQ0CSReFuhflqGra4BCywQa2ZYA+9crYkAIjhYEjZDQhA7txgVIVYKki810Hzs5qyTGOaXiSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718096553; c=relaxed/simple;
	bh=3jmsTadGnHTB8VWy8DyDXvNmubHoMiVIM1bBwO3YxV4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eAfvj8cIzgPKyNy9SEVklYh2SudLakIWIU4P/z3ZW04xQmxE1YVR1w4E/Kgh+9D5ADLdpgu+4PdbdHsXECzcDArYeF9Q7E/QJBYpBRkLVXYJ1FVDhdpYw5Y6uxTxqujkPGDqPaYs03L9LwAsWm9PpschxiJJorZcoKiLg4UPWnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5E86761E5FE05;
	Tue, 11 Jun 2024 11:01:58 +0200 (CEST)
Message-ID: <f95c09fb-3a97-4afd-87ec-aedc719241c3@molgen.mpg.de>
Date: Tue, 11 Jun 2024 11:01:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [iwl-next v1] ice: Check all ice_vsi_rebuild()
 errors in function
To: Karen Ostrowska <karen.ostrowska@intel.com>,
 Eric Joyner <eric.joyner@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20240528090140.221964-1-karen.ostrowska@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240528090140.221964-1-karen.ostrowska@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Eric, dear Karen,


Thank you for the patch.


Am 28.05.24 um 11:01 schrieb Karen Ostrowska:
> From: Eric Joyner <eric.joyner@intel.com>
> 
> Check the return value from ice_vsi_rebuild() and prevent the usage of
> incorrectly configured VSI.

Was this found during code review, or is this seen in practice? If the 
latter, please document the test system and test case.

> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Karen Ostrowska <karen.ostrowska@intel.com>

Should there be a Fixes: tag?


Kind regards,

Paul


> ---
>   drivers/net/ethernet/intel/ice/ice_main.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index f60c022f7960..e8c30b1730a6 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -4135,15 +4135,23 @@ int ice_vsi_recfg_qs(struct ice_vsi *vsi, int new_rx, int new_tx, bool locked)
>   
>   	/* set for the next time the netdev is started */
>   	if (!netif_running(vsi->netdev)) {
> -		ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +		if (err)
> +			goto rebuild_err;
>   		dev_dbg(ice_pf_to_dev(pf), "Link is down, queue count change happens when link is brought up\n");
>   		goto done;
>   	}
>   
>   	ice_vsi_close(vsi);
> -	ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	err = ice_vsi_rebuild(vsi, ICE_VSI_FLAG_NO_INIT);
> +	if (err)
> +		goto rebuild_err;
> +
>   	ice_pf_dcb_recfg(pf, locked);
>   	ice_vsi_open(vsi);
> +
> +rebuild_err:
> +	dev_err(ice_pf_to_dev(pf), "Error during VSI rebuild: %d. Unload and reload the driver.\n", err);
>   done:
>   	clear_bit(ICE_CFG_BUSY, pf->state);
>   	return err;

