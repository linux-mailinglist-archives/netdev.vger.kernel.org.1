Return-Path: <netdev+bounces-233888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 090D4C1A263
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 13:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374CB1884090
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 12:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832D33A010;
	Wed, 29 Oct 2025 12:12:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30312EA490;
	Wed, 29 Oct 2025 12:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739945; cv=none; b=AoD6gFyNTv/F11reyhTejOxMGec2dHYCw+yyJmIUthJ/585hQKHit66xqcW1XfJMv42qteXLraOGIAOW+Z8OJNoIJ4UUzKIZVTlKeLRV/hnh12be1oeoRjRZ0GHgtxPV7mcXl60MC20DtkO9wQdn/Z0UHptKCyvpw2kE8F2wJ7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739945; c=relaxed/simple;
	bh=D9ubV1MzwQjGbT7HGhaPF/W0DxBMGpzGkD/kypt2MLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fc9UPzXu+TjIFF+6izhtDY8f4BWrabK83E19ks5d1ytyQpvGY+3h9tIZcQQgmHVv/UwPcG/c+rk2tb2s3FEOn/BU36xOpQpHSxfUVlkR7im8NTwEhvu7BOap73nTYKs3CcHMO70eMfQ3MHq3sNOEdnED6mAVmsjU6pAk1nCGczg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vE52C-000000007C6-3Tbc;
	Wed, 29 Oct 2025 12:12:12 +0000
Date: Wed, 29 Oct 2025 12:12:08 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Andreas Schirm <andreas.schirm@siemens.com>,
	Lukas Stockmann <lukas.stockmann@siemens.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Peter Christen <peter.christen@siemens.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v4 05/12] net: dsa: lantiq_gswip: define and use
 GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID
Message-ID: <aQIEmPfkaYPTtTaY@makrotopia.org>
References: <cover.1761693288.git.daniel@makrotopia.org>
 <7d1a0368e95da42999af379d90de5d791283d24e.1761693288.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7d1a0368e95da42999af379d90de5d791283d24e.1761693288.git.daniel@makrotopia.org>

I've just received a definite answer from MaxLinear confirming that

"The condition of GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID is: (ETHSW_VERSION &
0x00ff) >= 0x22"

This matches the implementation now suggested.

On Wed, Oct 29, 2025 at 12:17:18AM +0000, Daniel Golle wrote:
> When adding FDB entries to the MAC bridge table on GSWIP 2.2 or later it
> is needed to set an (undocumented) bit to mark the entry as valid. If this
> bit isn't set for entries in the MAC bridge table, then those entries won't
> be considered as valid MAC addresses.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> v4: keep previous behavior for GSWIP 2.1 and earlier
> 
>  drivers/net/dsa/lantiq/lantiq_gswip.h        | 1 +
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 7 ++++++-
>  2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index 56de869fc472..42000954d842 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -224,6 +224,7 @@
>  #define  GSWIP_TABLE_MAC_BRIDGE_KEY3_FID	GENMASK(5, 0)	/* Filtering identifier */
>  #define  GSWIP_TABLE_MAC_BRIDGE_VAL0_PORT	GENMASK(7, 4)	/* Port on learned entries */
>  #define  GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC	BIT(0)		/* Static, non-aging entry */
> +#define  GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID	BIT(1)		/* Valid bit */
>  
>  #define XRX200_GPHY_FW_ALIGN	(16 * 1024)
>  
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 0ac87eb23bb5..ff2cdb230e2c 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -1149,7 +1149,12 @@ static int gswip_port_fdb(struct dsa_switch *ds, int port,
>  	mac_bridge.key[2] = addr[1] | (addr[0] << 8);
>  	mac_bridge.key[3] = FIELD_PREP(GSWIP_TABLE_MAC_BRIDGE_KEY3_FID, fid);
>  	mac_bridge.val[0] = add ? BIT(port) : 0; /* port map */
> -	mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
> +	if (GSWIP_VERSION_GE(priv, GSWIP_VERSION_2_2_ETC))
> +		mac_bridge.val[1] = add ? (GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC |
> +					   GSWIP_TABLE_MAC_BRIDGE_VAL1_VALID) : 0;
> +	else
> +		mac_bridge.val[1] = GSWIP_TABLE_MAC_BRIDGE_VAL1_STATIC;
> +
>  	mac_bridge.valid = add;
>  
>  	err = gswip_pce_table_entry_write(priv, &mac_bridge);
> -- 
> 2.51.1
> 

