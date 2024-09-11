Return-Path: <netdev+bounces-127479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7932F9758AC
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 18:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0074F1F23C94
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AD01AED2E;
	Wed, 11 Sep 2024 16:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="A0GkQkbv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-24.smtpout.orange.fr [80.12.242.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A111A76D1
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726073113; cv=none; b=ini0s9VxSGXgGRpiz+6fgCl23+/sd5efngTK5hrDQVrVwRjlm/viPIDsa36z6daF1M6JLXxuJsaOaCcwRAExgY0getxNgibdzL2Fr38vME55g4IA5IqGu4N0vZxiNGAxuaYlYKRoichZs0LaClQs8nDNdkKyXDzEHuMrWPPj46A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726073113; c=relaxed/simple;
	bh=0C4pyzHqU2uZnhHV1u90GXJZEhiWgCBkyp1OFAxXpnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z3DplqtCTs0vY+P+3JwwPoStKk+TCgH0MhUfYMPJRxErKWDc9f2Avp3LH0UXPkKtJut/Y9sg7GNGd0s+GWsxpuTEe+U+wm/yxehAqrQtHo+zKdEBAF2n7uEoopkwZ/c9ZHAez0SyEWmi0RL8G+2sEK2xS2hM+aWPFqHjxKbkHQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=A0GkQkbv; arc=none smtp.client-ip=80.12.242.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id oQShseUj484dOoQShsRZiD; Wed, 11 Sep 2024 18:45:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1726073103;
	bh=oz7sEm4TmuoZotUnLKmSUBPrxRGrP40SdxvR1To+EnU=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=A0GkQkbvUPq172zCDeYgo+fq7+CnUC7327LK7/x4XxpQBseiW84xhnF+a99iKl81t
	 nw+iYPAue49VDgxXXy/hyQTySlBIFjjL3hcxOz/qdOtWlYkWfi7/l/jk4DSb/G3TlA
	 heMNXAuwKNlk9FnZxe24Y0ketlqwdNLqI9P7irKiqf7I/BF+2jWK51FwX0YexcU5aT
	 IwGyNfcQ5/qEQEdFgCKMFQCvE+DtuxNDphmUcbS54e5OKJ8/5rqRMvWSU+hBXwbA/j
	 Qry7OQJpJA3kSBXjAaT3fuMdT6Humk6TWZk+Y5slIDOb90cQfxp/OP5N9fJ/Cb5g5a
	 jmsh9kKug9cOg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 11 Sep 2024 18:45:03 +0200
X-ME-IP: 90.11.132.44
Message-ID: <e542d2fc-0587-45a3-bc58-ee0a078a626a@wanadoo.fr>
Date: Wed, 11 Sep 2024 18:44:58 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, bryan.whitehead@microchip.com,
 UNGLinuxDriver@microchip.com, linux@armlinux.org.uk,
 maxime.chevallier@bootlin.com, rdunlap@infradead.org, andrew@lunn.ch,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 linux-kernel@vger.kernel.org
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 11/09/2024 à 18:10, Raju Lakkaraju a écrit :
> Support for SFP in the PCI11x1x devices is indicated by the "is_sfp_support_en"
> flag in the STRAP register. This register is loaded at power up from the
> PCI11x1x EEPROM contents (which specify the board configuration).
> 
> Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> ---
> Change List:
> ============
> V1 -> V2:
>    - Change variable name from "chip_rev" to "fpga_rev"
> V0 -> V1:
>    - No changes
> 
>   drivers/net/ethernet/microchip/lan743x_main.c | 34 +++++++++++++++----
>   drivers/net/ethernet/microchip/lan743x_main.h |  3 ++
>   2 files changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 4dc5adcda6a3..20a42a2c7b0e 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -28,9 +28,9 @@
>   
>   #define RFE_RD_FIFO_TH_3_DWORDS	0x3
>   
> -static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
> +static int pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>   {
> -	u32 chip_rev;
> +	u32 fpga_rev;
>   	u32 cfg_load;
>   	u32 hw_cfg;
>   	u32 strap;
> @@ -41,7 +41,7 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>   	if (ret < 0) {
>   		netif_err(adapter, drv, adapter->netdev,
>   			  "Sys Lock acquire failed ret:%d\n", ret);
> -		return;
> +		return ret;
>   	}
>   
>   	cfg_load = lan743x_csr_read(adapter, ETH_SYS_CONFIG_LOAD_STARTED_REG);
> @@ -55,10 +55,15 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>   			adapter->is_sgmii_en = true;
>   		else
>   			adapter->is_sgmii_en = false;
> +
> +		if ((strap & STRAP_SFP_USE_EN_) && (strap & STRAP_SFP_EN_))
> +			adapter->is_sfp_support_en = true;
> +		else
> +			adapter->is_sfp_support_en = false;
>   	} else {
> -		chip_rev = lan743x_csr_read(adapter, FPGA_REV);
> -		if (chip_rev) {
> -			if (chip_rev & FPGA_SGMII_OP)
> +		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
> +		if (fpga_rev) {
> +			if (fpga_rev & FPGA_SGMII_OP)
>   				adapter->is_sgmii_en = true;
>   			else
>   				adapter->is_sgmii_en = false;
> @@ -66,8 +71,21 @@ static void pci11x1x_strap_get_status(struct lan743x_adapter *adapter)
>   			adapter->is_sgmii_en = false;
>   		}
>   	}
> +
> +	if (adapter->is_pci11x1x && !adapter->is_sgmii_en &&
> +	    adapter->is_sfp_support_en) {
> +		netif_err(adapter, drv, adapter->netdev,
> +			  "Invalid eeprom cfg: sfp enabled with sgmii disabled");
> +		return -EINVAL;
> +	}
> +
>   	netif_dbg(adapter, drv, adapter->netdev,
>   		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");
> +	netif_dbg(adapter, drv, adapter->netdev,
> +		  "SFP support %sable\n", adapter->is_sfp_support_en ?
> +		  "En" : "Dis");

Hi,

Maybe using str_enable_disable() or str_enabled_disabled()?

CJ

> +
> +	return 0;
>   }
>   
>   static bool is_pci11x1x_chip(struct lan743x_adapter *adapter)
> @@ -3470,7 +3488,9 @@ static int lan743x_hardware_init(struct lan743x_adapter *adapter,
>   		adapter->max_tx_channels = PCI11X1X_MAX_TX_CHANNELS;
>   		adapter->used_tx_channels = PCI11X1X_USED_TX_CHANNELS;
>   		adapter->max_vector_count = PCI11X1X_MAX_VECTOR_COUNT;
> -		pci11x1x_strap_get_status(adapter);
> +		ret = pci11x1x_strap_get_status(adapter);
> +		if (ret < 0)
> +			return ret;
>   		spin_lock_init(&adapter->eth_syslock_spinlock);
>   		mutex_init(&adapter->sgmii_rw_lock);
>   		pci11x1x_set_rfe_rd_fifo_threshold(adapter);
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.h b/drivers/net/ethernet/microchip/lan743x_main.h
> index 8ef897c114d3..f7e96496600b 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.h
> +++ b/drivers/net/ethernet/microchip/lan743x_main.h
> @@ -36,6 +36,8 @@
>   
>   #define STRAP_READ			(0x0C)
>   #define STRAP_READ_USE_SGMII_EN_	BIT(22)
> +#define STRAP_SFP_USE_EN_		BIT(31)
> +#define STRAP_SFP_EN_			BIT(15)
>   #define STRAP_READ_SGMII_EN_		BIT(6)
>   #define STRAP_READ_SGMII_REFCLK_	BIT(5)
>   #define STRAP_READ_SGMII_2_5G_		BIT(4)
> @@ -1079,6 +1081,7 @@ struct lan743x_adapter {
>   	u8			max_tx_channels;
>   	u8			used_tx_channels;
>   	u8			max_vector_count;
> +	bool			is_sfp_support_en;
>   
>   #define LAN743X_ADAPTER_FLAG_OTP		BIT(0)
>   	u32			flags;


