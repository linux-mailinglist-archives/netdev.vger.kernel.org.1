Return-Path: <netdev+bounces-200573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D65AE6209
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 12:17:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 350CB404EFF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 10:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6BD281357;
	Tue, 24 Jun 2025 10:17:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7239517A2E8
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 10:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750760239; cv=none; b=HTa8hrIHORgEPW8S/E90Ir6yW2LOrhqSEVuRZdCurgviPONLR8Or9/1ofJSegL+A+let8aJEI4Yv+WAGmeoeQi/b1fPHcfNyRc/P86sNbr7VNr2oEUMEYzPpkLYuPtiEVmCZmr/331Xf1X99N6LcFbmPxzemSccO4ttiCzWUMgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750760239; c=relaxed/simple;
	bh=xAT3jdisnod1R8/QbX141njCZB/OeuHQlAiilKiNFNk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgg+AzXU7Cm/+/cIG8b2vUZy6sdQ03NuktkDSAG+zcAGYkklp51EPmC5u7qWRhyR1MYyKQ8+bDo/06BDRVy8CqnFLWHorG7TWFpyHnsRX8NV8FZa3BbdwuyhrK6A3lLJeHrACi1S2eMOod5a95DLBLuXa+upJN9eZjfAA40ptbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.36] (g36.guest.molgen.mpg.de [141.14.220.36])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 5EA3161E647A8;
	Tue, 24 Jun 2025 12:16:53 +0200 (CEST)
Message-ID: <4376ccbe-e688-49b0-bef1-42b46387be25@molgen.mpg.de>
Date: Tue, 24 Jun 2025 12:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net v1] ice: check correct pointer
 in fwlog debugfs
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com
References: <20250624092636.798390-1-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250624092636.798390-1-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Michal,


Thank you for the patch.

Am 24.06.25 um 11:26 schrieb Michal Swiatkowski:
> pf->ice_debugfs_pf_fwlog should be check for an error here.

be check*ed*

> Fixes: 96a9a9341cda ("ice: configure FW logging")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_debugfs.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> index 9fc0fd95a13d..cb71eca6a85b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
> +++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
> @@ -606,7 +606,7 @@ void ice_debugfs_fwlog_init(struct ice_pf *pf)
>   
>   	pf->ice_debugfs_pf_fwlog = debugfs_create_dir("fwlog",
>   						      pf->ice_debugfs_pf);
> -	if (IS_ERR(pf->ice_debugfs_pf))
> +	if (IS_ERR(pf->ice_debugfs_pf_fwlog))
>   		goto err_create_module_files;
>   
>   	fw_modules_dir = debugfs_create_dir("modules",

With the above fixed:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

