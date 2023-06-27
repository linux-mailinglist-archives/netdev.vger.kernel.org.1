Return-Path: <netdev+bounces-14161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BB4A73F4FA
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 08:55:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBE871C20A96
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F0B846A;
	Tue, 27 Jun 2023 06:53:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E8B15ADD
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 06:53:38 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78851BFB
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 23:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1687848817; x=1719384817;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cMaX5h4/5b/FDMK1ZmdPgL3T82vxDMFJI6IPHzFt+ec=;
  b=K+LarVNHvw3S8UHGFqAocQV1mUf6glatAcriX6XEy2MfYIu++6JGkVK9
   4dPfpFoIeTDfQh+GffaU8Dq3RKvt07lL7pOYGsulweL5Z5dvCHg5lnIsi
   OuQZwmH2BvHdqtCJ7oS+m22PER2V1yNy7KdbpCRMoDL1l6exgvfyifNsL
   OMAHSZZf7Dmn1J0BC8ZqnHb9w8ZE5ifmoTVK58nul+2HWhVnteT/aYDn6
   2hsHgYEP+U2cPaJZxw6JU/Ii64NvLpynL7IgRYOgGN/42eC5GiEU+md7n
   7yXiUwOfJFoFR2kWYVEXxmL6hsRd0teHQzn2GdQ2vhYx3F8L6UdfJ0k6T
   A==;
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; 
   d="scan'208";a="217795299"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Jun 2023 23:53:36 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 26 Jun 2023 23:53:32 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2507.21 via Frontend
 Transport; Mon, 26 Jun 2023 23:53:31 -0700
Date: Tue, 27 Jun 2023 08:53:31 +0200
From: Horatiu Vultur <horatiu.vultur@microchip.com>
To: <Tristram.Ha@microchip.com>
CC: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
	<UNGLinuxDriver@microchip.com>
Subject: Re: [PATCH net] net: dsa: microchip: correct KSZ8795 static MAC
 table access
Message-ID: <20230627065331.6sxkww4x6ke572kb@soft-dev3-1>
References: <1687833188-3184-1-git-send-email-Tristram.Ha@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <1687833188-3184-1-git-send-email-Tristram.Ha@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The 06/26/2023 19:33, Tristram.Ha@microchip.com wrote:
> From: Tristram Ha <Tristram.Ha@microchip.com>

Hi Tristram,

Please make sure you CC all the maintainers.
You can find out the maintainers by running ./scripts/get_maintainer.pl
on your patch file.

> 
> The KSZ8795 driver code was modified to use on KSZ8863/73, which has
> different register definitions.  Some of the new KSZ8795 register
> information are wrong compared with previous code.
> 
> KSZ8795 also behaves differently in that the STATIC_MAC_TABLE_USE_FID
> and STATIC_MAC_TABLE_FID bits are off by 1 when doing MAC table reading
> than writing.  To compensate that a special code was added to shift the
> register value by 1 before applying those bits.  This is wrong when the
> code is running on KSZ8863, so this special is only executed when
> KSZ8795 is detected.
> 
> Fixes: c8e04374f9e1 ("net: dsa: microchip: Make ksz8_w_sta_mac_table() static")

Don't add a new line between Fixes and SoB tags.
Also, are you sure that the blamed commit introduced the issue?
Because that commit just makes ksz8_w_sta_mac_table to be static.

> 
> Signed-off-by: Tristram Ha <Tristram.Ha@microchip.com>
> ---
>  drivers/net/dsa/microchip/ksz8795.c    | 8 +++++++-
>  drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
>  drivers/net/dsa/microchip/ksz_common.h | 7 +++++++
>  3 files changed, 18 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/dsa/microchip/ksz8795.c b/drivers/net/dsa/microchip/ksz8795.c
> index f56fca1b1a22..cc5b19a3d0df 100644
> --- a/drivers/net/dsa/microchip/ksz8795.c
> +++ b/drivers/net/dsa/microchip/ksz8795.c
> @@ -506,7 +506,13 @@ static int ksz8_r_sta_mac_table(struct ksz_device *dev, u16 addr,
>  		(data_hi & masks[STATIC_MAC_TABLE_FWD_PORTS]) >>
>  			shifts[STATIC_MAC_FWD_PORTS];
>  	alu->is_override = (data_hi & masks[STATIC_MAC_TABLE_OVERRIDE]) ? 1 : 0;
> -	data_hi >>= 1;
> +
> +	/* KSZ8795 family switches have STATIC_MAC_TABLE_USE_FID and
> +	 * STATIC_MAC_TABLE_FID definitions off by 1 when doing read on the
> +	 * static MAC table compared to doing write.
> +	 */
> +	if (ksz_is_ksz87xx(dev))
> +		data_hi >>= 1;
>  	alu->is_static = true;
>  	alu->is_use_fid = (data_hi & masks[STATIC_MAC_TABLE_USE_FID]) ? 1 : 0;
>  	alu->fid = (data_hi & masks[STATIC_MAC_TABLE_FID]) >>
> diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
> index a4428be5f483..a0ba2605bb62 100644
> --- a/drivers/net/dsa/microchip/ksz_common.c
> +++ b/drivers/net/dsa/microchip/ksz_common.c
> @@ -331,13 +331,13 @@ static const u32 ksz8795_masks[] = {
>  	[STATIC_MAC_TABLE_VALID]	= BIT(21),
>  	[STATIC_MAC_TABLE_USE_FID]	= BIT(23),
>  	[STATIC_MAC_TABLE_FID]		= GENMASK(30, 24),
> -	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(26),
> -	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(24, 20),
> +	[STATIC_MAC_TABLE_OVERRIDE]	= BIT(22),
> +	[STATIC_MAC_TABLE_FWD_PORTS]	= GENMASK(20, 16),
>  	[DYNAMIC_MAC_TABLE_ENTRIES_H]	= GENMASK(6, 0),
> -	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(8),
> +	[DYNAMIC_MAC_TABLE_MAC_EMPTY]	= BIT(7),
>  	[DYNAMIC_MAC_TABLE_NOT_READY]	= BIT(7),
>  	[DYNAMIC_MAC_TABLE_ENTRIES]	= GENMASK(31, 29),
> -	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(26, 20),
> +	[DYNAMIC_MAC_TABLE_FID]		= GENMASK(22, 16),
>  	[DYNAMIC_MAC_TABLE_SRC_PORT]	= GENMASK(26, 24),
>  	[DYNAMIC_MAC_TABLE_TIMESTAMP]	= GENMASK(28, 27),
>  	[P_MII_TX_FLOW_CTRL]		= BIT(5),
> diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
> index 8abecaf6089e..33d9a2f6af27 100644
> --- a/drivers/net/dsa/microchip/ksz_common.h
> +++ b/drivers/net/dsa/microchip/ksz_common.h
> @@ -569,6 +569,13 @@ static inline void ksz_regmap_unlock(void *__mtx)
>  	mutex_unlock(mtx);
>  }
>  
> +static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
> +{
> +	return dev->chip_id == KSZ8795_CHIP_ID ||
> +	       dev->chip_id == KSZ8794_CHIP_ID ||
> +	       dev->chip_id == KSZ8765_CHIP_ID;
> +}
> +
>  static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
>  {
>  	return dev->chip_id == KSZ8830_CHIP_ID;
> -- 
> 2.17.1
> 

-- 
/Horatiu

