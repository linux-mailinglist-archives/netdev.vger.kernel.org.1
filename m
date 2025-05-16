Return-Path: <netdev+bounces-191167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED43BABA4E8
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 22:58:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32B0C50828A
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A4A280039;
	Fri, 16 May 2025 20:58:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B28F255F3E
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 20:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747429088; cv=none; b=baqU1D8EIflQEyB6ZmjsVG3j35KIr6pK2LjAEyXfHu7lVgwedbeRNwq4bISgBZt2505oXfx5uxwwAlv55enzVfZ1Kid1nYsTjTTUQtryzSJIlGNyh2VfK94kfA+fYjfjXAzscowsPai4KozWDb9leGxcTZbK7TmlbvI8DbQoc5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747429088; c=relaxed/simple;
	bh=7rR38ob0Tpa3JczoysMf5UOvZZLz3rgukDvz4ZxJrao=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AVNKHFcS8VBZkbaKEm+HbmmvlwW4SSzG3LynQ2QnXmZSEPOEDMm7g2z1IPyFDa6ps79+HbrCGVEKOUIYVCuP54DP/SPjFgZAXSXboF+UwYG7USN4EBCXh/aNdKHjDmQBFlyg+KJtisPYtAY1Mp/w5jIdLhTHXbrnl7LvGWnVadY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af287.dynamic.kabel-deutschland.de [95.90.242.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2ACF461EA1BD4;
	Fri, 16 May 2025 22:57:34 +0200 (CEST)
Message-ID: <8c8999a7-d586-4bc6-9912-b088d9c3049f@molgen.mpg.de>
Date: Fri, 16 May 2025 22:57:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: add E835 device IDs
To: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 Konrad Knitter <konrad.knitter@intel.com>
References: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250514104632.331559-1-dawid.osuchowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Dawid,


Thank you for your patch.

Am 14.05.25 um 12:46 schrieb Dawid Osuchowski:
> E835 is an enhanced version of the E830.
> It continues to use the same set of commands, registers and interfaces
> as other devices in the 800 Series.
> 
> Following device IDs are added:
> - 0x1248: Intel(R) Ethernet Controller E835-CC for backplane
> - 0x1249: Intel(R) Ethernet Controller E835-CC for QSFP
> - 0x124A: Intel(R) Ethernet Controller E835-CC for SFP
> - 0x1261: Intel(R) Ethernet Controller E835-C for backplane
> - 0x1262: Intel(R) Ethernet Controller E835-C for QSFP
> - 0x1263: Intel(R) Ethernet Controller E835-C for SFP
> - 0x1265: Intel(R) Ethernet Controller E835-L for backplane
> - 0x1266: Intel(R) Ethernet Controller E835-L for QSFP
> - 0x1267: Intel(R) Ethernet Controller E835-L for SFP

Should you resend, it’d be great, if you added the datasheet name, where 
these id’s are present.

> Reviewed-by: Konrad Knitter <konrad.knitter@intel.com>
> Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
> ---
>   drivers/net/ethernet/intel/ice/ice_common.c |  9 +++++++++
>   drivers/net/ethernet/intel/ice/ice_devids.h | 18 ++++++++++++++++++
>   drivers/net/ethernet/intel/ice/ice_main.c   |  9 +++++++++
>   3 files changed, 36 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
> index 6e38d46c2c51..010ad09b3200 100644
> --- a/drivers/net/ethernet/intel/ice/ice_common.c
> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
> @@ -171,6 +171,15 @@ static int ice_set_mac_type(struct ice_hw *hw)
>   	case ICE_DEV_ID_E830_XXV_QSFP:
>   	case ICE_DEV_ID_E830C_SFP:
>   	case ICE_DEV_ID_E830_XXV_SFP:
> +	case ICE_DEV_ID_E835CC_BACKPLANE:
> +	case ICE_DEV_ID_E835CC_QSFP56:
> +	case ICE_DEV_ID_E835CC_SFP:
> +	case ICE_DEV_ID_E835C_BACKPLANE:
> +	case ICE_DEV_ID_E835C_QSFP:
> +	case ICE_DEV_ID_E835C_SFP:
> +	case ICE_DEV_ID_E835_L_BACKPLANE:
> +	case ICE_DEV_ID_E835_L_QSFP:
> +	case ICE_DEV_ID_E835_L_SFP:
>   		hw->mac_type = ICE_MAC_E830;
>   		break;
>   	default:
> diff --git a/drivers/net/ethernet/intel/ice/ice_devids.h b/drivers/net/ethernet/intel/ice/ice_devids.h
> index 34fd604132f5..7761c3501174 100644
> --- a/drivers/net/ethernet/intel/ice/ice_devids.h
> +++ b/drivers/net/ethernet/intel/ice/ice_devids.h
> @@ -36,6 +36,24 @@
>   #define ICE_DEV_ID_E830_XXV_QSFP	0x12DD
>   /* Intel(R) Ethernet Controller E830-XXV for SFP */
>   #define ICE_DEV_ID_E830_XXV_SFP		0x12DE
> +/* Intel(R) Ethernet Controller E835-CC for backplane */
> +#define ICE_DEV_ID_E835CC_BACKPLANE	0x1248
> +/* Intel(R) Ethernet Controller E835-CC for QSFP */
> +#define ICE_DEV_ID_E835CC_QSFP56	0x1249
> +/* Intel(R) Ethernet Controller E835-CC for SFP */
> +#define ICE_DEV_ID_E835CC_SFP		0x124A
> +/* Intel(R) Ethernet Controller E835-C for backplane */
> +#define ICE_DEV_ID_E835C_BACKPLANE	0x1261
> +/* Intel(R) Ethernet Controller E835-C for QSFP */
> +#define ICE_DEV_ID_E835C_QSFP		0x1262
> +/* Intel(R) Ethernet Controller E835-C for SFP */
> +#define ICE_DEV_ID_E835C_SFP		0x1263
> +/* Intel(R) Ethernet Controller E835-L for backplane */
> +#define ICE_DEV_ID_E835_L_BACKPLANE	0x1265
> +/* Intel(R) Ethernet Controller E835-L for QSFP */
> +#define ICE_DEV_ID_E835_L_QSFP		0x1266
> +/* Intel(R) Ethernet Controller E835-L for SFP */
> +#define ICE_DEV_ID_E835_L_SFP		0x1267
>   /* Intel(R) Ethernet Controller E810-C for backplane */
>   #define ICE_DEV_ID_E810C_BACKPLANE	0x1591
>   /* Intel(R) Ethernet Controller E810-C for QSFP */
> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
> index c4264984cfcb..5c941f4426d1 100644
> --- a/drivers/net/ethernet/intel/ice/ice_main.c
> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
> @@ -5906,6 +5906,15 @@ static const struct pci_device_id ice_pci_tbl[] = {
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_QSFP), },
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830C_SFP), },
>   	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E830_XXV_SFP), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_BACKPLANE), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_QSFP56), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835CC_SFP), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_BACKPLANE), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_QSFP), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835C_SFP), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_BACKPLANE), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_QSFP), },
> +	{ PCI_VDEVICE(INTEL, ICE_DEV_ID_E835_L_SFP), },
>   	/* required last entry */
>   	{}
>   };


Kind regards,

Paul

