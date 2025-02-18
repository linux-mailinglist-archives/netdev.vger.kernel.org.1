Return-Path: <netdev+bounces-167451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A108A3A576
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E8103B0ABD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 18:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A842356AC;
	Tue, 18 Feb 2025 18:26:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179782356AA
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739903168; cv=none; b=RF8F6tg+/Qx2A0zzdd2vBKPpock1V7aS9fKyE1yFG0N8hR4YkvcMLdhJjhyn65fKAImimy4LnUwMfopnt95YqvLLv+I6Lw0Wq7ej3SLBEz5CNR3QOOEV1WjZ6kvJ2yPT95yzcuYyYEBUocYrRVz7/3l50C8eqBIW0p2mJQ3Jt7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739903168; c=relaxed/simple;
	bh=yfS75lF150/BJ9K7bGavXufYwkSRlyw3EkOYJ2T/e7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzg3+28W2ticrWSgI8A1neSNbuSeT/HiPSp1pFWdwigeoWpk/6E7+RN1BPigU0tn4jCzZtpUV8u4PieAmK62rYo4rlKSHEHLzIcQz3C9vDNzpbA7IOIz/Og8SOcTyNPH/lRoOIukIYVfifyFT1BNP9lMLbnaLHl8jOfdb/h8Ugc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af2b0.dynamic.kabel-deutschland.de [95.90.242.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1FAD761E6479A;
	Tue, 18 Feb 2025 19:25:36 +0100 (CET)
Message-ID: <aa596679-a229-4335-806b-45539d8ec1d2@molgen.mpg.de>
Date: Tue, 18 Feb 2025 19:25:35 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] ixgbe: fix media type detection
 for E610 device
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, andrew@lunn.ch,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
References: <20250218161741.4147-1-piotr.kwapulinski@intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250218161741.4147-1-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Piotr,


Thank you for your patch.

Am 18.02.25 um 17:17 schrieb Piotr Kwapulinski:
> The commit 23c0e5a16bcc ("ixgbe: Add link management support for E610
> device") introduced incorrect media type detection for E610 device. It
> reproduces when advertised speed is modified after driver reload.

It’d be great if you gave a concrete example.

> Clear the previous outdated PHY type.

Only the high byte?

> Fixes: 23c0e5a16bcc ("ixgbe: Add link management support for E610 device")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> index 683c668..0dfefd2 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -1453,9 +1453,11 @@ enum ixgbe_media_type ixgbe_get_media_type_e610(struct ixgbe_hw *hw)
>   			hw->link.link_info.phy_type_low = 0;
>   		} else {
>   			highest_bit = fls64(le64_to_cpu(pcaps.phy_type_low));
> -			if (highest_bit)
> +			if (highest_bit) {
>   				hw->link.link_info.phy_type_low =
>   					BIT_ULL(highest_bit - 1);
> +				hw->link.link_info.phy_type_high = 0;
> +			}
>   		}
>   	}


Kind regards,

Paul

