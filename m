Return-Path: <netdev+bounces-144113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1039C59B5
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 14:57:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80BC9284D40
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 13:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B02591FC7CB;
	Tue, 12 Nov 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/4/B46x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886421FBF75;
	Tue, 12 Nov 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731419835; cv=none; b=VG+5NMJR/BuKkEbHtP3cmwcrYoa+GRZSdZMSA4FWmw9PJV46C5ySJ2hcTKPL1ImqTZSHdy0L8J2puPqCAWGIndXC/YU9VE6XIjyhUiKiC4p3nmAazURY9SXp0QpzEThrhPWjckHKLs8FQNRSU5fqHXjS/WrEaWJbL6pV3NBj4J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731419835; c=relaxed/simple;
	bh=690X58wLXuEw3RWxlo54q8TfYewr1w4lhcbv/TRzk+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mYuUc4OBl06gN/Eyu98hbCJbdasDKHkEYKnqLjyPN+w76+bhEeJP3nE9hXWtYYm3IF4DbupC5lz46hrZzwkFy4vWPKCK37s5PP/WMW9vlAflkz2i5RwGo3LMM0m4ZuYyLkeAvuh3Bc/cNwfZ3+uodusbw9EeM4KB8P/iOuvAxMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/4/B46x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24822C4CECD;
	Tue, 12 Nov 2024 13:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731419834;
	bh=690X58wLXuEw3RWxlo54q8TfYewr1w4lhcbv/TRzk+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D/4/B46xdU2kNwx+1Q3YfQfOsQ4aeqSaZtYGiYxqOSmis1LJm/zIfXfOEgRx9KtDA
	 WOwgqSJrrBH5zxoBsnhK1LvCnlxqZYRr1y/ZSFNephwJ6cFC4Wte6T7azlmthAoTJ7
	 zqkK1+xm9cOPisdQeZrpYl6Bs+yNWCKD38uNvXjGWGP7YBjYBlZJ1K7c5DOeOmMy6K
	 LheNQHg/V/NF7ebh7iY2Vul3ywW7U+Pc36WQI+3bv0iulqjfiOUWp2VY0MFuwm5r+0
	 ZvpBcMcMzQDF/PXAdKr2TtYMuAPUmstf3tgtNQwpCN+0vlmufpmnLZk9riRwICfQNd
	 oWAYFfXNiPhNg==
Date: Tue, 12 Nov 2024 13:57:09 +0000
From: Simon Horman <horms@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	pkshih@realtek.com, larry.chiu@realtek.com
Subject: Re: [PATCH net-next 1/2] rtase: Add support for RTL907XD-VA PCIe port
Message-ID: <20241112135709.GO4507@kernel.org>
References: <20241111025532.291735-1-justinlai0215@realtek.com>
 <20241111025532.291735-2-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111025532.291735-2-justinlai0215@realtek.com>

On Mon, Nov 11, 2024 at 10:55:31AM +0800, Justin Lai wrote:
> Add RTL907XD-VA hardware version and modify the speed reported by
> .get_link_ksettings in ethtool_ops.
> 
> Signed-off-by: Justin Lai <justinlai0215@realtek.com>

Hi Justin,

this seems to be doing several things:

1) Adding defines for existing values
2) Correcting the speed for RTL907XD-V1
3) Adding support for RTL907XD-VA

I think these would be best handled as 3 patches.
And I wonder if 2) is a bug fix for net rather than an
enhancement for net-next.

> ---
>  drivers/net/ethernet/realtek/rtase/rtase.h    | 10 +++++--
>  .../net/ethernet/realtek/rtase/rtase_main.c   | 26 ++++++++++++++-----
>  2 files changed, 28 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
> index 583c33930f88..2bbfcad613ab 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase.h
> +++ b/drivers/net/ethernet/realtek/rtase/rtase.h
> @@ -9,7 +9,11 @@
>  #ifndef RTASE_H
>  #define RTASE_H
>  
> -#define RTASE_HW_VER_MASK 0x7C800000
> +#define RTASE_HW_VER_MASK     0x7C800000
> +#define RTASE_HW_VER_906X_7XA 0x00800000
> +#define RTASE_HW_VER_906X_7XC 0x04000000
> +#define RTASE_HW_VER_907XD_V1 0x04800000
> +#define RTASE_HW_VER_907XD_VA 0x08000000
>  
>  #define RTASE_RX_DMA_BURST_256       4
>  #define RTASE_TX_DMA_BURST_UNLIMITED 7
> @@ -170,7 +174,7 @@ enum rtase_registers {
>  	RTASE_INT_MITI_TX = 0x0A00,
>  	RTASE_INT_MITI_RX = 0x0A80,
>  
> -	RTASE_VLAN_ENTRY_0     = 0xAC80,
> +	RTASE_VLAN_ENTRY_0 = 0xAC80,

This change doesn't seem related to the rest of the patch.

>  };
>  
>  enum rtase_desc_status_bit {
> @@ -327,6 +331,8 @@ struct rtase_private {
>  	u16 int_nums;
>  	u16 tx_int_mit;
>  	u16 rx_int_mit;
> +
> +	u32 hw_ver;
>  };
>  
>  #define RTASE_LSO_64K 64000
> diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> index f8777b7663d3..73ebdf0bc376 100644
> --- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
> +++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
> @@ -1714,10 +1714,22 @@ static int rtase_get_settings(struct net_device *dev,
>  			      struct ethtool_link_ksettings *cmd)
>  {
>  	u32 supported = SUPPORTED_MII | SUPPORTED_Pause | SUPPORTED_Asym_Pause;
> +	const struct rtase_private *tp = netdev_priv(dev);
>  
>  	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
>  						supported);
> -	cmd->base.speed = SPEED_5000;
> +
> +	switch (tp->hw_ver) {
> +	case RTASE_HW_VER_906X_7XA:
> +	case RTASE_HW_VER_906X_7XC:
> +		cmd->base.speed = SPEED_5000;
> +		break;
> +	case RTASE_HW_VER_907XD_V1:
> +	case RTASE_HW_VER_907XD_VA:
> +		cmd->base.speed = SPEED_10000;
> +		break;
> +	}
> +
>  	cmd->base.duplex = DUPLEX_FULL;
>  	cmd->base.port = PORT_MII;
>  	cmd->base.autoneg = AUTONEG_DISABLE;

> @@ -1974,13 +1986,15 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
>  
>  static bool rtase_check_mac_version_valid(struct rtase_private *tp)
>  {
> -	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
>  	bool known_ver = false;
>  
> -	switch (hw_ver) {
> -	case 0x00800000:
> -	case 0x04000000:
> -	case 0x04800000:
> +	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;

Now that this is setting tp->hw_ver perhaps the name of the function should
be changed? Perhaps rtase_set_mac_version() ? Perhaps a single patch can be
created that reworks this function, preparing for other work, by:

* Changes the name of the function
* Sets tp->hw_ver
* Changes the return type from bool to int
  (as is currently done as part of patch 2/2)

Although a refactor, perhaps that could be part of a series for net that
also includes two more patches that depend on it and:

* Correct the speed for RTL907XD-V1
* Corrects error handling in the case where the version is invalid
  (as is currently done as part of patch 2/2)

And then any remaning enhancements can be addressed as follow-up
patches for net-next.


> +
> +	switch (tp->hw_ver) {
> +	case RTASE_HW_VER_906X_7XA:
> +	case RTASE_HW_VER_906X_7XC:
> +	case RTASE_HW_VER_907XD_V1:
> +	case RTASE_HW_VER_907XD_VA:
>  		known_ver = true;
>  		break;
>  	}
> -- 
> 2.34.1
> 

