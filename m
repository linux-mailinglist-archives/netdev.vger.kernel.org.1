Return-Path: <netdev+bounces-228508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5CBBBCCFF0
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 14:51:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD7A01A61F0A
	for <lists+netdev@lfdr.de>; Fri, 10 Oct 2025 12:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B252EF651;
	Fri, 10 Oct 2025 12:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SWaGNPgF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CED54414
	for <netdev@vger.kernel.org>; Fri, 10 Oct 2025 12:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760100707; cv=none; b=giYKADb3sAibdmOvKX/OtytNSibeHMYHk7W8lssRLhuyCSsXFxWMI1TPMoJRjtxtSE6irtOZzxv0zi0cB4JUpVkkRvNu4C7fiPF0JJGom6U5PDY/4ooCQlzhtwR/SYaq4z09niY+y0fWF5EZijoCl4DZ0e1NoH+6f4rjIl7navI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760100707; c=relaxed/simple;
	bh=Rab/vi1p1y0j0sOOvzQUfj0Nn80yA8IVfDSqiezGNdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T5titi/0DIfHbT+jibyzT+6IfrQc1Af+lF8wB3i7fhQfi5+DBJM4aO+lRN1YClcFtTR68xErIpBuo7QHRV9DkLWxDmgPS11xsso+uiEUU5+a7EKThfKhgW52DOht1ct/HO3FB9d2ocE2qmkiBhUmT/qUFyN9xjAFPFdzMr+FZP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SWaGNPgF; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760100705; x=1791636705;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Rab/vi1p1y0j0sOOvzQUfj0Nn80yA8IVfDSqiezGNdA=;
  b=SWaGNPgFkTO7IDm5/zx43cijP+TtDu48FIn8FBz2hwTfIA1gnF2XFj6e
   Q4OPnP4wa7Io1evTn7PZKuNAXfglXHTVtoEyMRZgpqoF/Fa9t8ecerowK
   +3dIYrwQpC2J1MYgibqdkcZmyV8nSuhzGVJHSNLn4S0cyL5aRDM9xugJ7
   X2y72wkJbYWsGOG8tBkuTNh8uOcUNXY46qhiFk9eGA4a3mYj/GS0Fu3D/
   xJk9ryp4QBk/ibw4lTOeZF7emBAwQ/4coWHn4P9elg2W+JglcPFEDGCma
   FobnMuicQB+UfW6yCb6C42yFU9B5ndNas9kbJCKkZ8UGSgrUJeA/GTwSZ
   Q==;
X-CSE-ConnectionGUID: NFpZ3SQGTlG9GZaF57+EVw==
X-CSE-MsgGUID: QoUhalPVRsWPkAunVaAF1Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11578"; a="62361399"
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="62361399"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 05:51:45 -0700
X-CSE-ConnectionGUID: hFCtb611RQCXCJQt9+BPDg==
X-CSE-MsgGUID: d9tmwWnASTaGdas+SkoB7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,219,1754982000"; 
   d="scan'208";a="180656930"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.212]) ([172.28.180.212])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2025 05:51:41 -0700
Message-ID: <c2513fa8-1c8c-49d0-a9b0-92f86d058012@linux.intel.com>
Date: Fri, 10 Oct 2025 14:51:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] amd-xgbe: Avoid spurious link down messages during
 interface toggle
To: Raju Rangoju <Raju.Rangoju@amd.com>, netdev@vger.kernel.org
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, thomas.lendacky@amd.com,
 Shyam-sundar.S-k@amd.com
References: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <20251010065142.1189310-1-Raju.Rangoju@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-10-10 8:51 AM, Raju Rangoju wrote:
> During interface toggle operations (ifdown/ifup), the driver currently
> resets the local helper variable 'phy_link' to -1. This causes the link
> state machine to incorrectly interpret the state as a link change event,
> resulting in spurious "Link is down" messages being logged when the
> interface is brought back up.
> 
> Preserve the phy_link state across interface toggles to avoid treating
> the -1 sentinel value as a legitimate link state transition.
> 
> Fixes: 88131a812b16 ("amd-xgbe: Perform phy connect/disconnect at dev open/stop")
> Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/net/ethernet/amd/xgbe/xgbe-drv.c  | 1 -
>   drivers/net/ethernet/amd/xgbe/xgbe-mdio.c | 1 +
>   2 files changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> index f0989aa01855..4dc631af7933 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
> @@ -1080,7 +1080,6 @@ static void xgbe_free_rx_data(struct xgbe_prv_data *pdata)
>   
>   static int xgbe_phy_reset(struct xgbe_prv_data *pdata)
>   {
> -	pdata->phy_link = -1;
>   	pdata->phy_speed = SPEED_UNKNOWN;
>   
>   	return pdata->phy_if.phy_reset(pdata);
> diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> index 1a37ec45e650..7675bb98f029 100644
> --- a/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> +++ b/drivers/net/ethernet/amd/xgbe/xgbe-mdio.c
> @@ -1555,6 +1555,7 @@ static int xgbe_phy_init(struct xgbe_prv_data *pdata)
>   		pdata->phy.duplex = DUPLEX_FULL;
>   	}
>   
> +	pdata->phy_link = 0;
>   	pdata->phy.link = 0;

Took me a sec to spot the difference between the two :)

>   
>   	pdata->phy.pause_autoneg = pdata->pause_autoneg;


