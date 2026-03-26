Return-Path: <netdev+bounces-272223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AFjxBgiRxWlG/QQAu9opvQ
	(envelope-from <netdev+bounces-272223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:03:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7240933B376
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 21:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B522A302AC25
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C6F03A381B;
	Thu, 26 Mar 2026 20:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VxAsTmHQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC773976BE
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774555206; cv=none; b=KCu/ybBDTKtI3fNPD0qKJNG4zkimaw+Yf5bn9ZZYPll+wvV51Sq5vpYnfv8uagwUmXVSChOf0YNPP1l7xbJ4eppnTzW2fwod5cJA5D1Ola4f753G+dJZlvYKqS9T+ixjaHXzI806uZ0kRvTFc71tXud7njnLFf/i2o6awsITWFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774555206; c=relaxed/simple;
	bh=sZCu+zV806RkYMwGhzwSVjIEcYHK2rC1VqIBfMqEoWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jSTU+1jnguPmgdLP1Pa3Gpyk1Ngt5PKjFDcOmYU4Dql4LL0YwsutJfaM24SUSk58vj3DAisEkD3rXN3nw2JabmUm/uNyZcbf35VzczgbzTWgjir5KYRwLcquE6sLIUrQFMh5ww+x0CsqWGgdyTFDRLJXQhFQaL12LVaBn4Dr210=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VxAsTmHQ; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-6674cba2c50so3807023a12.0
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 13:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774555203; x=1775160003; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DmJ4jvJu+2RaqY+ZPxeE/qs9ff0J/6mOVazKfaw6kqU=;
        b=VxAsTmHQGTLncq6sOArDnMx+aWMA05cVd0MZ9KsFEDkrBAnaablj3jiVJLaVOS29NZ
         4gI/ocRd1PWz0bYubAV7fbtwhcnX8MK22B/xIHrD5xxK/THDecAXwiR7+NUJTBp8rsYw
         XH4RGuQ1XBWyAKvthj2zFEtqEixc3iPSje507SuWouwt/b1192Jt1Vcy0AwJj/ZVzbSM
         8yMYvpANEqMfT4le14yTrFfaK1RRcVoH0tUVAL54aAgA/3QUVOutQq6+Wbmu354kEEU7
         wu9G13WDFQc8VB4sevXZ4Zz3jzhFbWTbi9518ZRRNd8PHAq0Fu19QRwYQNeXJPnEKN3c
         fWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774555203; x=1775160003;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DmJ4jvJu+2RaqY+ZPxeE/qs9ff0J/6mOVazKfaw6kqU=;
        b=KWnvXFbxW6udRVnt3L+dRxrKH3hiPMhhBPbppJI0j4I3m712gK3LZTtQUJCHm9zk5V
         +BAhw7TGm8sxheii042n6KHrlr/MVOgXOXSBWCtuxZ0ClaHP3k5y9qHdV2O0R2oTBvc4
         z1ZoEE0DXlKTGcE6YC/CStcKzIyT/529/6szVkuKD60sn/wguuB6jvi24ATKO8XBwdEq
         Q1DNvaFSWNxWa/nDpDo+ZgwA0XD9ThXXnKjVdEd4SzjGMPp2QNDj8WZq6d5argkLW8eU
         eDOlSbgjP/EqCIQ5J+hRiBhS1QrowFyGloPZu/B6WbRnYMXYuTvY6JUQpQ4Doi2Pes8k
         b8Rw==
X-Forwarded-Encrypted: i=1; AJvYcCU1ys/75H0V7TrXABGAmYXrqQvjodJR+FtMKfI/oj3kit0jBzk11USX9zjFVrGeDJnfkBddGG4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfppAOMn2Rvv/WBqJm2kILfYgSwz6ips30539HoJ1g4InJWQGh
	1v3GxtbYabfTr5lLK7t+cPEqehNIIP2lN2Byt8CUY//nvhCDuidkzYJQ
X-Gm-Gg: ATEYQzxbKGnPFm5Bdxydn9Ky0IglxAjndiLXKvuVD6bPEgi+EsBCpmLyTD/jU55a/zp
	SXheKIQFQSvC56SyG7UibK1UyoFm0mQqNOfDD1EkZxwgZ1aNWICDZXtI9ddegNQnwTJcAevh1Mg
	zVhD6BL2x8gjfGpFN36z53EZ3avlG5q9XxOVrrJyViPYA0mqdL6igPYa+KJnMo9FHy3Uj92duuh
	0vwYnvkOQ1fYvartBvg3e3n+dyGktfFXz1omoO7bn2lyd35P2UNp9fY9UHdjMf/xnJUsmALdoEk
	qy1sSP8XVsH/Mbs0hQz4V4DD+1RJG+TwI+QqMRVRTToPHrD9lcKSbV7Q4AqdOFpj/mguLY5zcdO
	epd96vKis7gqkeHKjej4bz5WwMnjl/lB3ci5m8OqJhP40f38MX/9F4NiiZ1CZuEOTYOgNK3nQZ2
	oO2qGS/UbbrHa/oCikEaaibnBkkhYduwNR4QxE2lzX6GTrC2MYQSX9VF5WD973S6AJoT1lqPYi1
	S/ZY1gfSP20ivV5dTHxKseFnRY4Ygyii6mYcGZl3Ivj1JXvuw18aFduKZppcqlhB/UcdubX+3yo
	B3rE4BljJ7qxj2+48epHiNNYn9izn1bnpQ==
X-Received: by 2002:a17:907:c0e:b0:b9b:207c:f7e4 with SMTP id a640c23a62f3a-b9b2e75d17bmr214143366b.13.1774555202793;
        Thu, 26 Mar 2026 13:00:02 -0700 (PDT)
Received: from ?IPV6:2001:1c00:20d:1300:1b1c:4449:176a:89ea? (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9b2042f7e9sm162059466b.56.2026.03.26.13.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2026 13:00:02 -0700 (PDT)
Message-ID: <d59bfdca-08cb-4595-8583-eec61e282599@gmail.com>
Date: Thu, 26 Mar 2026 21:00:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: "Lucien.Jheng" <lucienzx159@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no
Cc: frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com
References: <20260326153518.8387-1-lucienzx159@gmail.com>
Content-Language: en-US
From: Eric Woudstra <ericwouds@gmail.com>
In-Reply-To: <20260326153518.8387-1-lucienzx159@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272223-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,mork.no];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ericwouds@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7240933B376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/26/26 4:35 PM, Lucien.Jheng wrote:
> AN8811HB needs a MCU soft-reset cycle before firmware loading begins.
> Assert the MCU (hold it in reset) and immediately deassert (release)
> via a dedicated PBUS register pair (0x5cf9f8 / 0x5cf9fc), accessed
> through the PHY-addr+8 MDIO bus node rather than the BUCKPBUS indirect
> path.  This clears the MCU state before the firmware loading sequence
> starts.

Perhapse you can register this extra device in the probe() function:

struct mdio_device *mdiodev;

mdiodev = mdio_device_create(phydev->mdio.bus,
			     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
if (IS_ERR(mdiodev))
	return PTR_ERR(mdiodev);

ret = mdio_device_register(mdiodev);
if (ret) {
	mdio_device_free(mdiodev);
	return ret;
}

priv->pbusdev = mdiodev;

In the define part add:

#define EN8811H_PBUS_ADDR_OFFS	8

Add to struct en8811h_priv:

struct mdio_device	*pbusdev;

And in the remove function:

mdio_device_remove(priv->pbusdev);
mdio_device_free(priv->pbusdev);

Then you can use the device:

ret = en8811hb_some_neat_function(priv->pbusdev);

> 
> Add __air_pbus_reg_write() as a low-level helper for this access, then
> implement an8811hb_mcu_assert() / _deassert() on top of it.  Wire both
> into an8811hb_load_firmware() and en8811h_restart_mcu() so every
> firmware load or MCU restart on AN8811HB correctly sequences the reset
> control registers.
> 
> Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB support")
> Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
> ---
> Changes in v2:
> - Rewrite commit message: The previous wording was ambiguous,
>   as it suggested the MCU remains asserted during the entire
>   firmware loading process, rather than a quick reset cycle
>   before it starts.
>   Clarify that assert and deassert is an immediate soft-reset
>   cycle to clear MCU state before firmware loading begins.
> - Add Fixes: 0a55766b7711 ("net: phy: air_en8811h: add Airoha AN8811HB
>   support").
> - Change phydev_info() to phydev_dbg() in an8811hb_mcu_assert() and
>   an8811hb_mcu_deassert() to avoid noise during normal boot.
> 
>  drivers/net/phy/air_en8811h.c | 105 ++++++++++++++++++++++++++++++++++
>  1 file changed, 105 insertions(+)
> 
> diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
> index 29ae73e65caa..01fce1b93618 100644
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@ -170,6 +170,16 @@
>  #define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
>  #define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
> 
> +#define AN8811HB_MCU_SW_RST		0x5cf9f8
> +#define   AN8811HB_MCU_SW_RST_HOLD		BIT(16)
> +#define   AN8811HB_MCU_SW_RST_RUN		(BIT(16) | BIT(0))
> +#define AN8811HB_MCU_SW_START		0x5cf9fc
> +#define   AN8811HB_MCU_SW_START_EN		BIT(16)
> +
> +/* MII register constants for PBUS access (PHY addr + 8) */
> +#define AIR_PBUS_ADDR_HIGH		0x1c
> +#define AIR_PBUS_DATA_HIGH		0x10
> +
>  /* Led definitions */
>  #define EN8811H_LED_COUNT	3
> 
> @@ -254,6 +264,36 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
>  	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
>  }
> 
> +static int __air_pbus_reg_write(struct phy_device *phydev,
> +				u32 pbus_reg, u32 pbus_data)
> +{
> +	struct mii_bus *bus = phydev->mdio.bus;
> +	int pbus_addr = phydev->mdio.addr + 8;
> +	int ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, AIR_EXT_PAGE_ACCESS,
> +			      upper_16_bits(pbus_reg));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_ADDR_HIGH,
> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, (pbus_reg & GENMASK(5, 2)) >> 2,
> +			      lower_16_bits(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_DATA_HIGH,
> +			      upper_16_bits(pbus_data));
> +	if (ret < 0)
> +		return ret;
> +
> +	return 0;
> +}
> +
>  static int __air_buckpbus_reg_write(struct phy_device *phydev,
>  				    u32 pbus_address, u32 pbus_data)
>  {
> @@ -570,10 +610,65 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
>  	return ret;
>  }
> 
> +static int an8811hb_mcu_assert(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
> +				   AN8811HB_MCU_SW_RST_HOLD);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	msleep(50);
> +	phydev_dbg(phydev, "MCU asserted\n");
> +
> +unlock:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
> +static int an8811hb_mcu_deassert(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	phy_lock_mdio_bus(phydev);
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
> +				   AN8811HB_MCU_SW_START_EN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
> +				   AN8811HB_MCU_SW_RST_RUN);
> +	if (ret < 0)
> +		goto unlock;
> +
> +	msleep(50);
> +	phydev_dbg(phydev, "MCU deasserted\n");
> +
> +unlock:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
>  static int an8811hb_load_firmware(struct phy_device *phydev)
>  {
>  	int ret;
> 
> +	ret = an8811hb_mcu_assert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = an8811hb_mcu_deassert(phydev);
> +	if (ret < 0)
> +		return ret;
> +
>  	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>  				     EN8811H_FW_CTRL_1_START);
>  	if (ret < 0)
> @@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
>  {
>  	int ret;
> 
> +	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
> +		ret = an8811hb_mcu_assert(phydev);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = an8811hb_mcu_deassert(phydev);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
>  	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
>  				     EN8811H_FW_CTRL_1_START);
>  	if (ret < 0)
> --
> 2.34.1
> 


