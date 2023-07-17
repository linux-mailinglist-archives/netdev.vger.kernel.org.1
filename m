Return-Path: <netdev+bounces-18231-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B10F755EA8
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 10:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC62D1C20AB9
	for <lists+netdev@lfdr.de>; Mon, 17 Jul 2023 08:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75110846C;
	Mon, 17 Jul 2023 08:40:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BB45687
	for <netdev@vger.kernel.org>; Mon, 17 Jul 2023 08:40:09 +0000 (UTC)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0CBF4;
	Mon, 17 Jul 2023 01:40:08 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id A198D826C;
	Mon, 17 Jul 2023 16:40:06 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:40:06 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 17 Jul
 2023 16:40:05 +0800
Message-ID: <3859b0f6-d31f-dbc3-833e-222eb6ca6b8c@starfivetech.com>
Date: Mon, 17 Jul 2023 16:40:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>, Frank
	<Frank.Sae@motor-comm.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
	Yanhong Wang <yanhong.wang@starfivetech.com>
References: <20230714101406.17686-1-samin.guo@starfivetech.com>
 <20230714101406.17686-3-samin.guo@starfivetech.com>
 <55cd8a47-89e5-4f62-8162-c744e1a99ad5@lunn.ch>
From: Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <55cd8a47-89e5-4f62-8162-c744e1a99ad5@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



-------- =E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF --------
=E4=B8=BB=E9=A2=98: Re: [PATCH v4 2/2] net: phy: motorcomm: Add pad drive=
 strength cfg support
From: Andrew Lunn <andrew@lunn.ch>
=E6=94=B6=E4=BB=B6=E4=BA=BA: Samin Guo <samin.guo@starfivetech.com>
=E6=97=A5=E6=9C=9F: 2023/7/15

>> +static u32 yt8531_get_ds_map(struct phy_device *phydev, u32 cur)
>> +{
>> +	u32 vol;
>> +	int i;
>> +
>> +	vol =3D yt8531_get_ldo_vol(phydev);
>> +	for (i =3D 0; i < ARRAY_SIZE(yt8531_ldo_vol); i++) {
>> +		if (yt8531_ldo_vol[i].vol =3D=3D vol && yt8531_ldo_vol[i].cur =3D=3D=
 cur)
>> +			return yt8531_ldo_vol[i].ds;
>> +	}
>> +
>> +	phydev_warn(phydev,
>> +		    "No matching current value was found %d, Use default value.\n",=
 cur);
>> +
>> +	return YT8531_RGMII_RX_DS_DEFAULT;
>=20
> If there is a value in DT and it is invalid, return -EINVAL and fail
> the probe. Only use the default if there is no value in DT.
>=20
>     Andrew

Will be fixed in the next version.

Thanks for taking the time to review the code.

Best regards,
Samin

