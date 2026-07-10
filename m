Return-Path: <netdev+bounces-306609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 2C2mN7cJUWpx+QIAu9opvQ
	(envelope-from <netdev+bounces-306609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:03:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42ECF73C08C
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 17:03:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306609-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306609-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A8DC30DCD23
	for <lists+netdev@lfdr.de>; Fri, 10 Jul 2026 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D48E4343E6;
	Fri, 10 Jul 2026 14:47:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.3ffe.de (0001.3ffe.de [159.69.201.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91822423A71;
	Fri, 10 Jul 2026 14:47:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694849; cv=none; b=cjxZuYWxvMm9/Muzi0c55dclI+i7QgzSjgXLByfk73T7ge1RbBfCIAj1WLyzjpnFeSZ8rxFE+DMJdzlcQH9b+EQ7Tr6COz59QuXsWC/xxLhIdcZzYYf3CiHmDTxeaytwNLrXf0rCYQ/lKkUSS5FOw4T35rfMbW9LdszS7YcYpN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694849; c=relaxed/simple;
	bh=0jxv2UVmjG4b3H5M8fybUYp7q+5N7UU6o2pQTgtkXtc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=GYiy1/WgHPMg9EJWx5jQqOza/lOZAGe0Zi2baGHBFs2aiLZXwd77ZDoCM5ucdqvd18IO306ndBW7mGK+uBAPqnfzB85M3Q4VtO2CINUUzlVGSOmzQJFs2sWV+31zZvYsXCq40bX7Ei6dLKn+ZFTue+nJiAFpVsoE5QNvoxe8dCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=walle.cc; arc=none smtp.client-ip=159.69.201.130
Received: from localhost (unknown [IPv6:2a02:810b:4320:1000:4685:ff:fe12:5967])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.3ffe.de (Postfix) with ESMTPSA id 028853B7;
	Fri, 10 Jul 2026 16:47:24 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 10 Jul 2026 16:47:24 +0200
Message-Id: <DJUZ1VG8U9SL.2W0CJM7NSMK2@kernel.org>
Subject: Re: [PATCH net v2] net: dpaa: fix mode setting
Cc: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From: "Michael Walle" <mwalle@kernel.org>
To: "Sean Anderson" <sean.anderson@linux.dev>, "Madalin Bucur"
 <madalin.bucur@nxp.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Russell
 King" <linux@armlinux.org.uk>
X-Mailer: aerc 0.20.0
References: <20260710143430.2276141-1-mwalle@kernel.org>
 <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
In-Reply-To: <a5c5b8a6-85a8-7830-e19b-ffd5de750e3c@linux.dev>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306609-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sean.anderson@linux.dev,m:madalin.bucur@nxp.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux@armlinux.org.uk,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mwalle@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 42ECF73C08C

On Fri Jul 10, 2026 at 4:39 PM CEST, Sean Anderson wrote:
> On 7/10/26 10:22, Michael Walle wrote:
>> Before converting to the phylink interface, the init function would have
>> set the correct I/F mode depending on the maximum link speed of an
>> interface. After converting to phylink, the established link speed
>> is used to determine this setting and is set in the .link_up()
>> callback. The callback isn't called because the link is never
>> established between the PCS and a connected SGMII PHY.
>> To fix it, don't use the current speed, but set the mode depending on
>> the interface (which implies the maximum speed) in .mac_config().
>>=20
>> Fixes: 5d93cfcf7360 ("net: dpaa: Convert to phylink")
>> Suggested-by: Sean Anderson <sean.anderson@linux.dev>
>> Signed-off-by: Michael Walle <mwalle@kernel.org>
>> ---
>> FWIW, I dropped setting a non-reserved mode in init(). The hardware
>> default is 0 and the mac_config() will set a valid mode anyway.
>>=20
>> Changes in v2:
>>   - the setting is/was based on the maximum speed, not the current
>>     speed. thus, move the setting into mac_config().
>>   - Link to v1: https://lore.kernel.org/r/20260706121011.1948906-1-mwall=
e@kernel.org/
>>=20
>>   .../net/ethernet/freescale/fman/fman_dtsec.c  | 26 ++++++++++---------
>>   1 file changed, 14 insertions(+), 12 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/freescale/fman/fman_dtsec.c b/drivers/=
net/ethernet/freescale/fman/fman_dtsec.c
>> index fe35703c509e..7075f93bab49 100644
>> --- a/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> +++ b/drivers/net/ethernet/freescale/fman/fman_dtsec.c
>> @@ -900,22 +900,28 @@ static void dtsec_mac_config(struct phylink_config=
 *config, unsigned int mode,
>>   {
>>   	struct mac_device *mac_dev =3D fman_config_to_mac(config);
>>   	struct dtsec_regs __iomem *regs =3D mac_dev->fman_mac->regs;
>> -	u32 tmp;
>> +	u32 ecntrl, maccfg2;
>> +
>> +	maccfg2 =3D ioread32be(&regs->maccfg2);
>> +	maccfg2 &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE);
>>  =20
>>   	switch (state->interface) {
>>   	case PHY_INTERFACE_MODE_RMII:
>> -		tmp =3D DTSEC_ECNTRL_RMM;
>> +		ecntrl =3D DTSEC_ECNTRL_RMM;
>> +		maccfg2 |=3D MACCFG2_NIBBLE_MODE;
>>   		break;
>>   	case PHY_INTERFACE_MODE_RGMII:
>>   	case PHY_INTERFACE_MODE_RGMII_ID:
>>   	case PHY_INTERFACE_MODE_RGMII_RXID:
>>   	case PHY_INTERFACE_MODE_RGMII_TXID:
>> -		tmp =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>> +		ecntrl =3D DTSEC_ECNTRL_GMIIM | DTSEC_ECNTRL_RPM;
>> +		maccfg2 |=3D MACCFG2_BYTE_MODE;
>>   		break;
>>   	case PHY_INTERFACE_MODE_SGMII:
>>   	case PHY_INTERFACE_MODE_1000BASEX:
>>   	case PHY_INTERFACE_MODE_2500BASEX:
>> -		tmp =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>> +		ecntrl =3D DTSEC_ECNTRL_TBIM | DTSEC_ECNTRL_SGMIIM;
>> +		maccfg2 |=3D MACCFG2_BYTE_MODE;
>>   		break;
>>   	default:
>>   		dev_warn(mac_dev->dev, "cannot configure dTSEC for %s\n",
>> @@ -923,7 +929,8 @@ static void dtsec_mac_config(struct phylink_config *=
config, unsigned int mode,
>>   		return;
>>   	}
>>  =20
>> -	iowrite32be(tmp, &regs->ecntrl);
>> +	iowrite32be(ecntrl, &regs->ecntrl);
>> +	iowrite32be(maccfg2, &regs->maccfg2);
>>   }
>>  =20
>>   static void dtsec_link_up(struct phylink_config *config, struct phy_de=
vice *phy,
>> @@ -948,15 +955,10 @@ static void dtsec_link_up(struct phylink_config *c=
onfig, struct phy_device *phy,
>>   	iowrite32be(tmp, &regs->ecntrl);
>>  =20
>>   	tmp =3D ioread32be(&regs->maccfg2);
>> -	tmp &=3D ~(MACCFG2_NIBBLE_MODE | MACCFG2_BYTE_MODE | MACCFG2_FULL_DUPL=
EX);
>> -	if (speed >=3D SPEED_1000)
>> -		tmp |=3D MACCFG2_BYTE_MODE;
>> -	else
>> -		tmp |=3D MACCFG2_NIBBLE_MODE;
>> -
>>   	if (duplex =3D=3D DUPLEX_FULL)
>>   		tmp |=3D MACCFG2_FULL_DUPLEX;
>> -
>> +	else
>> +		tmp &=3D ~MACCFG2_FULL_DUPLEX;
>
> Did you test this when forcing 10/100 speed?

No I didn't. Well I can't. I have a very weird board which only
supports 1000base-X (and copper SFPs in 1000basex autoneg mode). On
top of that there is a Marvell 88E1112 in between the SFP and the
MAC, for which the PHY driver is completely broken. Long story
short, I'm not able to test that (yet/at all? Not sure).

-michael

>
>>   	iowrite32be(tmp, &regs->maccfg2);
>>  =20
>>   	mac_dev->update_speed(mac_dev, speed);
>
> If so,
>
> Reviewed-by: Sean Anderson <sean.anderson@linux.dev>




