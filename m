Return-Path: <netdev+bounces-294654-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tI2XOpbeH2rzrQAAu9opvQ
	(envelope-from <netdev+bounces-294654-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:58:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 377B56356EB
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 09:58:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=VRmizK1z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294654-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294654-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5ABC0301AD24
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 07:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B50063939C0;
	Wed,  3 Jun 2026 07:38:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49671CD2C;
	Wed,  3 Jun 2026 07:38:15 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780472298; cv=none; b=d5Z8mX08ZSG6KpZs0zEZXhnXIYfnRw1F3tViTvLJwRi0eZh+YSyrfvZqQa3rF9v6fj0NmaRkt0Hev5FoKw4Z1vJE7rLpFiCqzfFcUDZkg+5toiEgaz4TW8Tgxb4fYzqy6tjQPD0Fji3SpRnAQzPGYyW66mLnGF5/uo3MXucO/pQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780472298; c=relaxed/simple;
	bh=Oa2Cd+P3omoYI1AjlRbpl09ecKfrievf5S/TKQExzww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rhYxNv+mXjbZFc/qLL7Zsso9TEOKyVnw4AQwvZ98v5uaHlxrd1V/SHtummCA+YAPYwNu7DKJlzrYeGVj8FEu4xiYZtpbGTf6YAgBqhUIEZGbvFN0+SjGAKheBJdOrnLgR7TIlhLS/6MbA1qazgjC5A9gGQZoifEgON8I9Vv4IhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=VRmizK1z; arc=none smtp.client-ip=185.246.84.56
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 20BCD1A37CE;
	Wed,  3 Jun 2026 07:38:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E80BF60735;
	Wed,  3 Jun 2026 07:38:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id AC92610888413;
	Wed,  3 Jun 2026 09:38:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1780472293; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=48HKF5qjcBD5u80VYLFsYdeOwq3OA1OOkqyyNJNd6yc=;
	b=VRmizK1zfwNUjE3Ea0qajR/iqcVhtG8/BDd4TohC9qlNQaPVPzrGMRr0Vx7qmK2p15TRPg
	8Pke9rtrDmxtgqYHAR4IWi5EeNaBUi9pgopLIzECbuNwleaXRvwzeoA75/aEoXvcG/PM34
	ykNuwc2ToFnGX2/GnktvtG2YZNFfeuG092mIfWtFGWxmQg7Xi0wMcZMy7NVOLtb3T8O/9b
	rPzsiNTZBMxA9iYEopzHTsTApV05ptsFjeflr9c4HgmlolrhXr8hzCz8/R70JdR+5xxqMj
	iS/WXw4EEmCdBlRF9zCRYdYcOIhumdQaU8Wdgx8mNMtiC7gsWCeIcfwEzFDjMA==
Message-ID: <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
Date: Wed, 3 Jun 2026 09:38:07 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
To: javen <javen_xu@realsil.com.cn>, hkallweit1@gmail.com,
 nic_swsd@realtek.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260603065916.334-2-javen_xu@realsil.com.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294654-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:javen_xu@realsil.com.cn,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[realsil.com.cn,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:mid,bootlin.com:from_mime,bootlin.com:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 377B56356EB



On 6/3/26 08:59, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Add support for rtl8116af dummy phy driver, match phy id and read link
> speed from MII_BMCR.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>

Can you elaborate more on why this is needed ?

The cover says :
"
In this mode, the driver
needs a dummy PHY ID so that phylib can attach to a dummy Realtek PHY driver,
while selected standard PHY registers are handled through the SerDes register.
"

Why can't you use the SerDes registers for your PHY driver ? The phrase above
suggests that the "SerDes registers" have the typical C22/45 layout. There are PHYs
and PCSs out there that aren't accessed through regular MDIO with regmap being
used to translate the mdio accesses done by phylib into the actual register
access method used.

Maxime

> ---
>  drivers/net/phy/realtek/realtek_main.c | 54 ++++++++++++++++++++++++++
>  include/net/phy/realtek_phy.h          |  1 +
>  2 files changed, 55 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 27268811f564..9b92828c49d9 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -2659,6 +2659,47 @@ static int rtlgen_sfp_get_features(struct phy_device *phydev)
>  	return 0;
>  }
>  
> +static int rtl8116af_sfp_get_features(struct phy_device *phydev)
> +{
> +	linkmode_set_bit(ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
> +			 phydev->supported);
> +
> +	phydev->speed = SPEED_1000;
> +	phydev->duplex = DUPLEX_FULL;
> +
> +	phydev->port = PORT_FIBRE;
> +
> +	return 0;
> +}
> +
> +static int rtl8116af_sfp_read_status(struct phy_device *phydev)
> +{
> +	int val, err;
> +
> +	err = genphy_update_link(phydev);
> +	if (err)
> +		return err;
> +
> +	if (!phydev->link)
> +		return 0;
> +
> +	val = phy_read(phydev, MII_BMCR);
> +	if (val < 0)
> +		return val;
> +
> +	if (val & BMCR_SPEED1000)
> +		phydev->speed = SPEED_1000;
> +	else if (val & BMCR_SPEED100)
> +		phydev->speed = SPEED_100;
> +
> +	if (val & BMCR_FULLDPLX)
> +		phydev->duplex = DUPLEX_FULL;
> +	else
> +		phydev->duplex = DUPLEX_HALF;
> +
> +	return 0;
> +}
> +
>  static int rtlgen_sfp_read_status(struct phy_device *phydev)
>  {
>  	int val, err;
> @@ -2947,6 +2988,19 @@ static struct phy_driver realtek_drvs[] = {
>  		.write_page	= rtl821x_write_page,
>  		.read_mmd	= rtl822x_read_mmd,
>  		.write_mmd	= rtl822x_write_mmd,
> +	}, {
> +		PHY_ID_MATCH_EXACT(PHY_ID_RTL8116AF_DUMMY),
> +		.name		= "RTL8116af PHY Mode",
> +		.flags		= PHY_IS_INTERNAL,
> +		.get_features	= rtl8116af_sfp_get_features,
> +		.config_aneg	= rtlgen_sfp_config_aneg,
> +		.read_status	= rtl8116af_sfp_read_status,
> +		.suspend	= genphy_suspend,
> +		.resume		= rtlgen_resume,
> +		.read_page	= rtl821x_read_page,
> +		.write_page	= rtl821x_write_page,
> +		.read_mmd	= rtl822x_read_mmd,
> +		.write_mmd	= rtl822x_write_mmd,
>  	}, {
>  		PHY_ID_MATCH_EXACT(0x001ccad0),
>  		.name		= "RTL8224 2.5Gbps PHY",
> diff --git a/include/net/phy/realtek_phy.h b/include/net/phy/realtek_phy.h
> index d683bc1b0659..cbf91af0ead6 100644
> --- a/include/net/phy/realtek_phy.h
> +++ b/include/net/phy/realtek_phy.h
> @@ -3,5 +3,6 @@
>  #define _REALTEK_PHY_H
>  
>  #define	PHY_ID_RTL_DUMMY_SFP	0x001ccbff
> +#define PHY_ID_RTL8116AF_DUMMY  0x001ccbfe
>  
>  #endif /* _REALTEK_PHY_H */


