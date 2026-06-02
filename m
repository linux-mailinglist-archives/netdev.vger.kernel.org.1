Return-Path: <netdev+bounces-294234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LJb6GdHhHmpPYQAAu9opvQ
	(envelope-from <netdev+bounces-294234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:59:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F9662F16F
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 15:59:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmx.net header.s=s31663417 header.b=bOr5Qr6z;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=gmx.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 241A53081EA9
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 13:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36DA23E3165;
	Tue,  2 Jun 2026 13:47:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FAF9463
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 13:47:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780408068; cv=none; b=sWRLETYRmwcYWKy9fK88hupsichxai6Kr3rr/L8ve0qFX/7RhxNEuDgQMFG68IFWTktLiv+hjxgMRzxGXXe20UHuwvF0IKZEqffYHTRtcA0+2UzdXkMzmHLOihIpz2B8xR+LNfN9gzXcwH+iakxWb++8kOjnfPSblUYGSwfp15M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780408068; c=relaxed/simple;
	bh=y/Fa9vPqin9CvFFuxiSSOCnsnKWAsLazPH8p/Ou2sX0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZSGXTDmh8kl3n5w7Pez+m1mNXXGDCVqYS0ZR5WX30fek0TegYU2ZpmDPhwlccf//G2BbXzul8sPEZxAWjH/p+i99Opx+0x44SBFuHIgOF0xKyJCNbhK3nOUBCO1uQIpwwaoT8lj1Mq+ui7ppkrvd6wBTy7q7AYOB7IfJR1ZwMP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=bOr5Qr6z; arc=none smtp.client-ip=212.227.15.15
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1780408055; x=1781012855; i=wahrenst@gmx.net;
	bh=rvz1aHdoWu7joD1m4gygfrAwE4GeJm3FcU5AYqv3Xyk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=bOr5Qr6zxrJwKSTtve0T1+shs3wh2SCnzDuZWT2jcrqYF6UhU7imYiKfUF3FBuj2
	 laWxjlvwb+38folMePx+ryMKtFIRhdqz2F8cnThV2PBDDxzKcYPYej8JKQCZwLeX7
	 LwnsHUsiwLnLU2vyxrzji7zdb19jTg96OTxuJZrZ1Yjoil/RoiovpiTP1ZKAjhctq
	 9GDTwHQXXJdKJmHcyCtIsxHj4MZJLasr5pCtbzVUdL8Bvuk9P2yeULgnAJhBN6mWZ
	 jKMlpjlF4c/bbnuVRtSUJ+XN70aNaBdCr4OUTetp8FKHXcY9/QyvgOJdpnvv5o71v
	 e38kii6AZ9D/mVFsbQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1wzKQo0LHV-00dKLW; Tue, 02
 Jun 2026 15:47:35 +0200
Message-ID: <9dc8482d-a4cf-42b1-b1c4-230f160af4b3@gmx.net>
Date: Tue, 2 Jun 2026 15:47:33 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 2/2] net: phy: dp83822: Add optional external PHY clock
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
References: <20260528184642.33424-1-wahrenst@gmx.net>
 <20260528184642.33424-3-wahrenst@gmx.net>
 <20260601200122.17d1cea2@kernel.org>
Content-Language: en-US
From: Stefan Wahren <wahrenst@gmx.net>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
In-Reply-To: <20260601200122.17d1cea2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yhN5Psqz82TPNX9muUDZW73+w0/Co+vdrrPK5kytPkVihuTOElG
 6dcXNNgB6dARUUqtNtZfr7uYwz5oy6ZmGqQUPWtF1PcP5lJDsDKAJ1Wu+9S5W51SvfVjiuT
 ttLZUmNBKuAfLopU57s8OyehXE6RxqtmEiIYx8F9ghnvh9zlaX/eb70bCnAWPY7PJO/YZEF
 1VqMZ3PsqrBM/La7JXjxw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:RizFXEMO41o=;pl8QwraBKFXudRBfdnNsIvjOtcD
 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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmx.net,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmx.net:s=s31663417];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294234-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:andrew@lunn.ch,m:hkallweit1@gmail.com,m:linux@armlinux.org.uk,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wahrenst@gmx.net,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmx.net:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmx.net];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 00F9662F16F

Hi Jakub,

Am 02.06.26 um 05:01 schrieb Jakub Kicinski:
> On Thu, 28 May 2026 20:46:42 +0200 Stefan Wahren wrote:
>> In some cases, the PHY can use an external ref clock source instead of =
a
>> crystal.
>>
>> Add an optional clock in the PHY node to make sure that the clock sourc=
e
>> is enabled, if specified, before probing.
>
>> diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
>> index d8c5b5cd1bc0..6fc86be9d593 100644
>> --- a/drivers/net/phy/dp83822.c
>> +++ b/drivers/net/phy/dp83822.c
>> @@ -4,6 +4,7 @@
>>    * Copyright (C) 2017 Texas Instruments Inc.
>>    */
>>  =20
>> +#include <linux/clk.h>
>>   #include <linux/ethtool.h>
>>   #include <linux/etherdevice.h>
>>   #include <linux/kernel.h>
>> @@ -986,11 +987,18 @@ static int dp8382x_probe(struct phy_device *phyde=
v)
>>   {
>>   	struct device *dev =3D &phydev->mdio.dev;
>>   	struct dp83822_private *dp83822;
>> +	struct clk *clk;
>>  =20
>>   	dp83822 =3D devm_kzalloc(dev, sizeof(*dp83822), GFP_KERNEL);
>>   	if (!dp83822)
>>   		return -ENOMEM;
>>  =20
>> +	clk =3D devm_clk_get_optional_enabled(dev, NULL);
>> +	if (IS_ERR(clk)) {
>> +		return dev_err_probe(dev, PTR_ERR(clk),
>> +				     "Failed to request ref clock\n");
>> +	}
> nit: unnecessary parenthesis
I didn't provide the whole story behind this patch. I have a custom=20
i.MX93 board, which have 2 different Ethernet MAC (fec + stmmac). Each=20
of the MACs are connected to one TI DP83825 PHY. Those PHYs share the=20
same MDIO bus and the same input reference clock (RMII slave) from the=20
i.MX93 processor. The MDIO is handled by the fec driver. Since the fec=20
is only aware of a single reference clock (tied to the MAC), it's=20
possible that during probe the reference clock is disabled because the=20
refcount is zero. So the idea is to avoid glitches by adding another=20
clock user (tied to the second PHY).

Here is the device tree extract:
&fec {
 =C2=A0 =C2=A0 pinctrl-names =3D "default";
 =C2=A0 =C2=A0 pinctrl-0 =3D <&pinctrl_fec>;
 =C2=A0 =C2=A0 phy-mode =3D "rmii";
 =C2=A0 =C2=A0 phy-handle =3D <&ethphy1>;
 =C2=A0 =C2=A0 assigned-clocks =3D <&clk IMX93_CLK_ENET_TIMER1>,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <&clk IMX93_CLK_ENET_REF=
>,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <&clk IMX93_CLK_ENET_REF=
_PHY>;
 =C2=A0 =C2=A0 assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV=
2>,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<&clk IMX93=
_CLK_SYS_PLL_PFD1_DIV2>,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<&clk IMX93=
_CLK_SYS_PLL_PFD1_DIV2>;
 =C2=A0 =C2=A0 assigned-clock-rates =3D <100000000>, <50000000>, <50000000=
>;
 =C2=A0 =C2=A0 status =3D "okay";

 =C2=A0 =C2=A0 mdio: mdio {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clock-frequency =3D <5000000>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #address-cells =3D <1>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 #size-cells =3D <0>;

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ethphy1: ethernet-phy@1 {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D "ethernet-phy-ie=
ee802.3-c22";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D <1>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset-gpios =3D <&gpio4 23 GPIO=
_ACTIVE_HIGH>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset-assert-us =3D <30>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };

 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ethphy2: ethernet-phy@2 {
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reg =3D <2>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 compatible =3D "ethernet-phy-id=
2000.a140",=20
"ethernet-phy-ieee802.3-c22";
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 clocks =3D <&clk IMX93_CLK_ENET=
_REF_PHY>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset-gpios =3D <&gpio4 13 GPIO=
_ACTIVE_HIGH>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset-assert-us =3D <30>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 reset-deassert-us =3D <50000>;
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 };
 =C2=A0 =C2=A0 };
};

&eqos {
 =C2=A0 =C2=A0 phy-mode =3D "rmii";
 =C2=A0 =C2=A0 phy-handle =3D <&ethphy2>;
 =C2=A0 =C2=A0 assigned-clocks =3D <&clk IMX93_CLK_ENET_TIMER2>,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <&clk IMX93_CLK_ENET>;
 =C2=A0 =C2=A0 assigned-clock-parents =3D <&clk IMX93_CLK_SYS_PLL_PFD1_DIV=
2>,
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<&clk IMX93=
_CLK_SYS_PLL_PFD1_DIV2>;
 =C2=A0 =C2=A0 assigned-clock-rates =3D <100000000>, <50000000>;

 =C2=A0 =C2=A0 status =3D "okay";
};
> The AI says:
>
>    Does this initialization sequence violate the DP83822 power-on
>    requirements? The PHY framework deasserts the hardware reset line bef=
ore
>    invoking the probe callback. By enabling the external clock here,
>    the clock starts after the hardware reset is already deasserted.
The behavior description is correct, but i'm not sure this is really a=20
violation. I assume that we should also declare PHY_RST_AFTER_CLK_EN in=20
the flags in order to get the PHY reset after clock has been enabled right=
?
>    The datasheet requires the reset signal to be asserted for at least
>    50 ms after power and clocks are stable. Without performing a subsequ=
ent
>    hardware reset here, could the PHY be left in an undefined state or
>    lead to initialization failures?
>
> Did it really read the datasheet or is this a hallucination?
I don't know where these 50 ms comes from, because I found under "7.7=20
Timing Requirements, Power-Up With Unstable XI Clock" a value of 10 us.
>
> FWIW it also says:
>
>    Should this clock pointer be saved in the driver's private data
>    structure (struct dp83822_private) instead of a local variable?
>
>    Without storing it, the dp83822_suspend callback cannot disable the c=
lock
>    when Wake-on-LAN is disabled, which could prevent the clock provider =
from
>    entering low-power states.
I wasn't aware that additional power saving during runtime PM must be=20
part of this change. So this is required?

