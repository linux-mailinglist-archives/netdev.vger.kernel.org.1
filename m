Return-Path: <netdev+bounces-292636-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +PWHEZ4PGGrmbQgAu9opvQ
	(envelope-from <netdev+bounces-292636-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:49:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B2155EFED2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 11:49:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C69BE31AB922
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 09:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9CF3AC0D0;
	Thu, 28 May 2026 09:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="3ew0LED+"
X-Original-To: netdev@vger.kernel.org
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C137130C153;
	Thu, 28 May 2026 09:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779961070; cv=none; b=jw4jms9egW4KI4NyBjw6sdXjFBfLwO55zDId/rTsIsF9cwW7KnepxZ+pB4l3kQLOkeXNGg/6l8Jjwr71fseog0pb9H1/+lTijtn8pxgzWQxFAUOVmsk5KDY+FF6sgPY5/BiE/yXEZQD/G1GSas1lBnGDrz8nbCnssEO1kbH+DFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779961070; c=relaxed/simple;
	bh=DbeE1O58EkERW09o40h4qA2vpdQndQc9/Kj8M9LJaLE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XZl7C2paURsusKNtHbk9wurGnRx3+YPe5RMviLr/erR56IHS0MVfDWsQpX9PNb8pgPOl2k9X/mFqup7Yja+E6jyl44uKD2ERG5E56zhSGPxrM4vfw7oSZ3TmFCTIAYIKlgNvZLVXU8U21VUnpzOLRZZynwHIInbU1jy9kFqPaVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=3ew0LED+; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 15C7DA0155;
	Thu, 28 May 2026 11:37:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1779961065; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pCC7dcbSgjbz+3b/O6NNkMSBzrVvzuW6akWbwyW2T7k=;
	b=3ew0LED+1e20K0Eq9g8z/4bCc7+MowrjyVstaFxhzBxKcatd/7lpyh+xjlAh/ZyJ8Wv3il
	Zeh8X/4bP++ZQRn7cnC2yB8WEd9b1kyRO41XrvotkHiONFpbNY1QKK8UfFnX+NCWhpltWI
	+F7TpPMF3fc6VstSGlXLR4L9+6T1H4lwDNhO7SjsaDEHVHE2B9jemiDKM+UMANjauQoCT9
	UAblv3CuCHYPE0US74tDsHl6BW9geps+bKNMsLcH2O5D3xPAVJIm1uStd0Cr0Q0jGHpCtd
	ONTHYlEDIachCt1rdMSahVmEJGKnHJo5NfuhIBgQaT0m3DFEYOqMIQhsPiMVaw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 28 May 2026 11:37:43 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v1 1/2] net: phy: realtek: add support for
 RTL8261
In-Reply-To: <20260528075226.1054-2-javen_xu@realsil.com.cn>
References: <20260528075226.1054-1-javen_xu@realsil.com.cn>
 <20260528075226.1054-2-javen_xu@realsil.com.cn>
Message-ID: <d37ead5b1f9549d4903138cc4f70ffd0@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[tipi-net.de:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[tipi-net.de];
	TAGGED_FROM(0.00)[bounces-292636-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,realsil.com.cn,vger.kernel.org,makrotopia.org,nxp.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nb@tipi-net.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[tipi-net.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,tipi-net.de:mid,tipi-net.de:dkim,realsil.com.cn:email]
X-Rspamd-Queue-Id: 9B2155EFED2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Javen

On 28.5.2026 09:52, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261. Its PHY id is
> 0x001cc898 and 0x001cc899.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 315 +++++++++++++++++++++++++
>  1 file changed, 315 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c
> index 27268811f564..fe743fd0421b 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -22,6 +22,9 @@
>  #include "../phylib.h"
>  #include "realtek.h"
> 
> +#define RTL_8261C_CG			0x001cc898
> +#define RTL_8261CE_CG			0x001cc899

Imho these should be added below RTL_8261C and not at the top.

> +
>  #define RTL8201F_IER_PAGE			0x07
>  #define RTL8201F_IER				0x13
>  #define RTL8201F_IER_LINK			BIT(13)
> @@ -141,6 +144,10 @@
>  #define RTL8211F_PHYSICAL_ADDR_WORD1		17
>  #define RTL8211F_PHYSICAL_ADDR_WORD2		18
> 
> +#define RTL8261X_EXT_ADDR_REG			0xa436
> +#define RTL8261X_EXT_DATA_REG			0xa438
> +#define RTL_8261X_SUB_PHY_ID_ADDR		0x801d
> +
>  #define RTL822X_VND1_SERDES_OPTION			0x697a
>  #define RTL822X_VND1_SERDES_OPTION_MODE_MASK		GENMASK(5, 0)
>  #define RTL822X_VND1_SERDES_OPTION_MODE_2500BASEX_SGMII		0
> @@ -252,6 +259,57 @@
>  #define RTL_8251B				0x001cc862
>  #define RTL_8261C				0x001cc890
> 
> +#define RTL8261C_CE_MODEL		0x00
> +#define RTL8261D_MODEL			0x81
> +#define RTL8261X_PHYSR_REG		0xa434
> +#define RTL8261X_GBCR_REG		0xa412
> +#define RTL8261X_IMR			0xa4d2
> +#define RTL8261X_ISR			0xa4d4
> +#define RTL8261X_INT_AUTONEG_ERROR	BIT(0)
> +#define RTL8261X_INT_PAGE_RECV		BIT(2)
> +#define RTL8261X_INT_AUTONEG_DONE	BIT(3)
> +#define RTL8261X_INT_LINK_CHG		BIT(4)
> +#define RTL8261X_INT_PHY_REG_ACCESS	BIT(5)
> +#define RTL8261X_INT_PME		BIT(7)
> +#define RTL8261X_INT_ALDPS_CHG		BIT(9)
> +#define RTL8261X_INT_JABBER		BIT(10)
> +#define RTL8261X_PHYSR_LINK		BIT(2)
> +#define RTL8261X_PHYSR_DUPLEX		BIT(3)
> +#define RTL8261X_PHYSR_SPEED_L		GENMASK(5, 4)
> +#define RTL8261X_PHYSR_SPEED_H		GENMASK(10, 9)
> +
> +/* Concatenated 4-bit speed code values (SPD_H << 2 | SPD_L) */
> +#define RTL8261X_SPEED_CODE_500M	0x3	/* H=0, L=3 */
> +#define RTL8261X_SPEED_CODE_1000M	0x7	/* H=1, L=3 */
> +#define RTL8261X_SPEED_CODE_2500M	0x8	/* H=2, L=0 */
> +#define RTL8261X_SPEED_CODE_5000M	0x9	/* H=2, L=1 */
> +#define RTL8261X_SPEED_500		500

500 MBit/s isnt a standard rate which also isnt represented in ethtool.
Is this just for documentation or intended to be used? If yes, how?

> [...]

> +
> +static int rtl8261x_get_features(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	ret = genphy_c45_pma_read_abilities(phydev);
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Supplement Multi-Gig speeds that may not be automatically detected
> +	 * RTL8261X supports 2.5G/5G in addition to standard 10G
> +	 */
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_2500baseT_Full_BIT,
> +			 phydev->supported);
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_5000baseT_Full_BIT,
> +			 phydev->supported);

Feature bits for 2.5 and 5 GBit/s are set unconditionally - even for the 
generic variant.
Do all variants have these capabilities? If not better add check for at 
least the generic one.

> +
> +	return 0;
> +}
> +
> +static int rtl8261x_config_master_slave(struct phy_device *phydev)
> +{
> +	u16 val;
> +	/*
> +	 * Configure bits 15:14 of MMD 7.0x0020
> +	 *
> +	 * Bit 15 (Enable) | Bit 14 (Value) | Mode
> +	 * ----------------|----------------|-------------
> +	 *       0         |       0        | Auto (disabled)
> +	 *       1         |       0        | Force Slave
> +	 *       1         |       1        | Force Master
> +	 */
> +	switch (phydev->master_slave_set) {
> +	case MASTER_SLAVE_CFG_MASTER_FORCE:
> +		val = RTL8261X_MS_MASTER;
> +		break;
> +	case MASTER_SLAVE_CFG_SLAVE_FORCE:
> +		val = RTL8261X_MS_SLAVE;
> +		break;
> +	case MASTER_SLAVE_CFG_UNKNOWN:
> +	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
> +	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
> +	default:
> +		val = RTL8261X_MS_AUTO;
> +		break;
> +	}
> +
> +	return phy_modify_mmd(phydev, MDIO_MMD_AN, RTL8261X_MULTIG_CTRL,
> +			      RTL8261X_MASTER_SLAVE_MASK, val);
> +}

RTL8261X_MULTIG_CTRL is a IEEE-defined register, so it can use 
MDIO_AN_10GBT_CTRL instead.
Also the define for RTL8261X_MULTIG_CTRL can be dropped.

While at it I would suggest to add MDIO_AN_10GBT_CTRL_MS_ENABLE (bit 15) 
and
MDIO_AN_10GBT_CTRL_MS_VALUE (bit 14) to include/uapi/linux/mdio.h and 
also make use of it.
RTL8261X_MS_AUTO would become

   val = MDIO_AN_10GBT_CTRL_MS_ENABLE | MDIO_AN_10GBT_CTRL_MS_VALUE;

> [...]

> +
> +static int rtl8261x_read_status(struct phy_device *phydev)
> +{
> +	int ret, val, speed_code;
> +
> +	ret = genphy_c45_read_status(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL8261X_PHYSR_REG);
> +	if (val < 0)
> +		return val;
> +
> +	phydev->link = !!(val & RTL8261X_PHYSR_LINK);
> +	if (!phydev->link) {
> +		phydev->speed  = SPEED_UNKNOWN;
> +		phydev->duplex = DUPLEX_UNKNOWN;
> +		return 0;
> +	}

Why does it need to overreide the values from genphy_c45_read_status() ?

> +
> +	phydev->duplex = (val & RTL8261X_PHYSR_DUPLEX) ? DUPLEX_FULL : 
> DUPLEX_HALF;
> +	speed_code = (FIELD_GET(RTL8261X_PHYSR_SPEED_H, val) << 2) |
> +		      FIELD_GET(RTL8261X_PHYSR_SPEED_L, val);
> +	switch (speed_code) {
> +	case RTL8261X_SPEED_CODE_500M:
> +		phydev->speed = RTL8261X_SPEED_500;

See question above (defines).

> +		break;
> +	case RTL8261X_SPEED_CODE_1000M:
> +		phydev->speed = SPEED_1000;
> +		break;
> +	case RTL8261X_SPEED_CODE_2500M:
> +		phydev->speed = SPEED_2500;
> +		break;
> +	case RTL8261X_SPEED_CODE_5000M:
> +		phydev->speed = SPEED_5000;
> +		break;
> +	default:
> +		phydev_warn(phydev, "unknown speed code 0x%x (PHYSR=0x%04x)\n", 
> speed_code, val);
> +		phydev->speed = SPEED_UNKNOWN;
> +	break;
> +	}
> +
> +	return 0;
> +}
> +
> +static int rtl8261x_config_aneg(struct phy_device *phydev)
> +{
> +	u16 adv_1g = 0;
> +	int ret;
> +
> +	if (phydev->autoneg == AUTONEG_DISABLE)
> +		return genphy_c45_pma_setup_forced(phydev);
> +
> +	ret = rtl8261x_config_master_slave(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = genphy_c45_config_aneg(phydev);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			      phydev->advertising))
> +		adv_1g = BIT(9);
> +
> +	ret = phy_modify_mmd_changed(phydev, MDIO_MMD_VEND2,
> +				     RTL8261X_GBCR_REG,
> +				     BIT(9), adv_1g);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret > 0)
> +		return genphy_c45_restart_aneg(phydev);

This does not take rtl8261x_config_master_slave() into account. So maybe 
change rtl8261x_config_master_slave

    return phy_modify_mmd_changed ...

and keep the result in a bool and also trigger auto nego restart if 
needed.

> +
> +	return 0;
> +}



> +
>  static int rtl821x_probe(struct phy_device *phydev)
>  {
>  	struct device *dev = &phydev->mdio.dev;
> @@ -3001,6 +3292,30 @@ static struct phy_driver realtek_drvs[] = {
>  		.resume		= genphy_resume,
>  		.read_mmd	= genphy_read_mmd_unsupported,
>  		.write_mmd	= genphy_write_mmd_unsupported,
> +	}, {
> +		PHY_ID_MATCH_EXACT(RTL_8261C_CG),
> +		.name             = "Realtek RTL8261C_RTL8261D 10Gbps PHY",
> +		.probe            = rtl8261x_probe,

RTL8261C/RTL8261D? Or just the c variant as the phy id suggests?

> +		.get_features     = rtl8261x_get_features,
> +		.config_aneg      = rtl8261x_config_aneg,
> +		.read_status      = rtl8261x_read_status,
> +		.config_intr      = rtl8261x_config_intr,
> +		.handle_interrupt = rtl8261x_handle_interrupt,
> +		.soft_reset       = rtl8261x_soft_reset,
> +		.suspend          = genphy_c45_pma_suspend,
> +		.resume           = genphy_c45_pma_resume,
> +	}, {
> +		PHY_ID_MATCH_EXACT(RTL_8261CE_CG),
> +		.name             = "Realtek RTL8261CE 10Gbps PHY",
> +		.probe            = rtl8261x_probe,
> +		.get_features     = rtl8261x_get_features,
> +		.config_aneg      = rtl8261x_config_aneg,
> +		.read_status      = rtl8261x_read_status,
> +		.config_intr      = rtl8261x_config_intr,
> +		.handle_interrupt = rtl8261x_handle_interrupt,
> +		.soft_reset       = rtl8261x_soft_reset,
> +		.suspend          = genphy_c45_pma_suspend,
> +		.resume           = genphy_c45_pma_resume,
>  	},
>  };

Please also make sure for both patches that checkpatch has no further 
complaints. Thanks.

Nicolai

