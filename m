Return-Path: <netdev+bounces-217737-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F12AFB39A74
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:42:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B3403A38EF
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 10:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10BE30BF7E;
	Thu, 28 Aug 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/MrN/V9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8AB30ACE8
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 10:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377640; cv=none; b=FD6avwZb11xPQo78v4otj+54QduHqL+iaLZA1M+jwaHoBy4rliavU2a12Td8cojuDadk94oLi0kjg6BNkiNRWaybhdA3K+jwQtffrf0H1QRCctkZJeqfVmQk2wdO2dkZC+aiLtiUkE1buZU6OCbF0jarbREnTlM2uJTLeJumL98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377640; c=relaxed/simple;
	bh=NwR50ZpM6+Ymc6dkl0+mc9OsZhEF6EybCCscmIk+Dzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9FZKzZyaLIBIC7WxL3lo9qS0Ic3yumJ10LyJan4o4k0kxivseRqIC2a57jFUcr+4BaO4tJQy0j9OxrlUngrN08GmQfGEbNwBlaq8M47/q9iWB0o0gSgSKXc41uSxkeE8uYAGySJNo+F3zxBTL58NVDaucUANyak/DRjIJh4WJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/MrN/V9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C80CAC4CEEB;
	Thu, 28 Aug 2025 10:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756377640;
	bh=NwR50ZpM6+Ymc6dkl0+mc9OsZhEF6EybCCscmIk+Dzo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b/MrN/V9C+XQmfWdIPZiTK9ah1S1Zvix6O9zkq3Qk26i/Wna/kqG9XOV+7+c7Wc9n
	 JOaIkR3bmfJ0nePmMaaodHhqeCe+bzLayOWcV/yN7bzttvT2ekqaA8euLSU9xVRBpg
	 ASE0RGmdG/2Lw7YAcyeunohVxv0bsNNnWqgIodTSFLiCWvgeNYOaT9lijWiI9wGljk
	 JDP+cO/0LiLRW/NOm3mYHeUoRyxWxK7wEC8DINQU5qmiOMB4gXijI7bPNt6wLLx05d
	 SzfiX/U+JRiEeHGtjhwB4asa3qE+5NnfTBuTbC8YkeTvtEc1sXzExl8u6cKszlWGmR
	 9fwoNM83X5gdw==
Date: Thu, 28 Aug 2025 11:40:36 +0100
From: Simon Horman <horms@kernel.org>
To: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, madhu.chittim@intel.com,
	netdev@vger.kernel.org,
	Sridhar Samudrala <sridhar.samudrala@intel.com>
Subject: Re: [PATCH net-next v1] idpf: add support for IDPF PCI programming
 interface
Message-ID: <20250828104036.GA10519@horms.kernel.org>
References: <20250826172845.265142-1-pavan.kumar.linga@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826172845.265142-1-pavan.kumar.linga@intel.com>

On Tue, Aug 26, 2025 at 10:28:45AM -0700, Pavan Kumar Linga wrote:
> At present IDPF supports only 0x1452 and 0x145C as PF and VF device IDs
> on our current generation hardware. Future hardware exposes a new set of
> device IDs for each generation. To avoid adding a new device ID for each
> generation and to make the driver forward and backward compatible,
> make use of the IDPF PCI programming interface to load the driver.
> 
> Write and read the VF_ARQBAL mailbox register to find if the current
> device is a PF or a VF.
> 
> PCI SIG allocated a new programming interface for the IDPF compliant
> ethernet network controller devices. It can be found at:
> https://members.pcisig.com/wg/PCI-SIG/document/20113
> with the document titled as 'PCI Code and ID Assignment Revision 1.16'
> or any latest revisions.
> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Reviewed-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_main.c b/drivers/net/ethernet/intel/idpf/idpf_main.c
> index 8c46481d2e1f..b161715e1168 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_main.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_main.c
> @@ -7,11 +7,57 @@
>  
>  #define DRV_SUMMARY	"Intel(R) Infrastructure Data Path Function Linux Driver"
>  
> +#define IDPF_NETWORK_ETHERNET_PROGIF				0x01
> +#define IDPF_CLASS_NETWORK_ETHERNET_PROGIF			\
> +	(PCI_CLASS_NETWORK_ETHERNET << 8 | IDPF_NETWORK_ETHERNET_PROGIF)
> +
>  MODULE_DESCRIPTION(DRV_SUMMARY);
>  MODULE_IMPORT_NS("LIBETH");
>  MODULE_IMPORT_NS("LIBETH_XDP");
>  MODULE_LICENSE("GPL");
>  
> +/**
> + * idpf_dev_init - Initialize device specific parameters
> + * @adapter: adapter to initialize
> + * @ent: entry in idpf_pci_tbl
> + *
> + * Return: %0 on success, -%errno on failure.
> + */
> +static int idpf_dev_init(struct idpf_adapter *adapter,
> +			 const struct pci_device_id *ent)
> +{
> +	u8 is_vf = 0;
> +	int err;
> +
> +	switch (ent->device) {
> +	case IDPF_DEV_ID_PF:
> +		goto dev_ops_init;
> +	case IDPF_DEV_ID_VF:
> +		is_vf = 1;
> +		goto dev_ops_init;
> +	default:
> +		if (ent->class == IDPF_CLASS_NETWORK_ETHERNET_PROGIF)
> +			goto check_vf;
> +
> +		return -ENODEV;
> +	}
> +
> +check_vf:
> +	err = idpf_is_vf_device(adapter->pdev, &is_vf);
> +	if (err)
> +		return err;
> +
> +dev_ops_init:
> +	if (is_vf) {
> +		idpf_vf_dev_ops_init(adapter);
> +		adapter->crc_enable = true;
> +	} else {
> +		idpf_dev_ops_init(adapter);
> +	}
> +
> +	return 0;
> +}

Hi Pavan,

I think that in Kernel Networking code the usual use cases
of goto labels are: for error handling; and, optimisation,
f.e. in the datapath.

I don't think this code falls into either category.
So I suggest implementing it without gotos.

Thanks!

...

