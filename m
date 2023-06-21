Return-Path: <netdev+bounces-12455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4637379B6
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:29:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7371C20BCD
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01D817EC;
	Wed, 21 Jun 2023 03:29:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26E515BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:29:07 +0000 (UTC)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80E31985;
	Tue, 20 Jun 2023 20:29:03 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 93F4C7FC9;
	Wed, 21 Jun 2023 11:29:01 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 11:29:01 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 11:29:00 +0800
Message-ID: <8e2a50b2-a9ab-e164-a3c2-b7bc11ccdb53@starfivetech.com>
Date: Wed, 21 Jun 2023 11:28:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver
 strength cfg
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: Conor Dooley <conor@kernel.org>, <linux-kernel@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>, Peter Geis
	<pgwipeout@gmail.com>, Frank <Frank.Sae@motor-comm.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Yanhong Wang
	<yanhong.wang@starfivetech.com>
References: <20230526090502.29835-1-samin.guo@starfivetech.com>
 <20230526090502.29835-2-samin.guo@starfivetech.com>
 <20230526-glutinous-pristine-fed571235b80@spud>
 <1dbf113c-7592-68bd-6aaf-05ff1d8c538c@starfivetech.com>
 <15eb4ffe-ea12-9a2c-ae9d-c34860384b60@starfivetech.com>
 <b0a61cf4-adb1-4261-b6a5-aeb1e3c1b1aa@lunn.ch>
From: Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <b0a61cf4-adb1-4261-b6a5-aeb1e3c1b1aa@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS064.cuchost.com (172.16.6.24) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add pad driver strength c=
fg
From: Andrew Lunn <andrew@lunn.ch>
to: Guo Samin <samin.guo@starfivetech.com>
data: 2023/6/20

>> I just got the detailed data of Driver Strength(DS) from Motorcomm ,
>> which applies to both rx_clk and rx_data.
>>
>> |----------------------|
>> |     ds map table     |
>> |----------------------|
>> | DS(3b) | Current (mA)|
>> |--------|-------------|
>> |   000  |     1.20    |
>> |   001  |     2.10    |
>> |   010  |     2.70    |
>> |   011  |     2.91    |
>> |   100  |     3.11    |
>> |   101  |     3.60    |
>> |   110  |     3.97    |
>> |   111  |     4.35    |
>> |--------|-------------|
>>
>> Since these currents are not integer values
>=20
> Integers is not a problem. Simply use uA.
>=20
>> and have no regularity, it is not very good to use in the drive/dts
>> in my opinion.
>=20
> I think they are fine to use. Add a lookup table, microamps to
> register value. Return -EINVAL if the requested value is not in the
> table. List the valid values in the schema, so the checker tool might
> point out problems.
>=20
>       Andrew

Thanks Andrew,
I'll use a lookup table to try.
Another thing we need to deal with DS under different IO voltages(1.8V/2.=
5V/3.3V).

The IO voltage can be configured via a hardware pull-up resistor (visionf=
ive 2 is configured to 1.8V by default),=20
and then the IO voltage can be obtained or set through the register=EF=BC=
=880xA001=EF=BC=89

Chip_Config (EXT_0xA001)
|Bit  |Symbol  |Access  |Default  |Description |
|5:4  |Cfg_ldo |RW      |0x0      |Rgmii ldo voltage and RGMII/MDC/MDIO P=
AD's level shifter control. Depends on strapping.|
                                  |2'b11: 1.8v   2'b10: 1.8v    2'b01: 2.=
5v    2'b00: 3.3v                                |

      |----------------------|           =20
      | ds map table(1.8V)   |
      |----------------------|
      | DS(3b) | Current (mA)|
      |   000  |     1.20    |
      |   001  |     2.10    |
      |   010  |     2.70    |
      |   011  |     2.91    |
      |   100  |     3.11    |
      |   101  |     3.60    |
      |   110  |     3.97    |
      |   111  |     4.35    |
      |--------|-------------|


      |----------------------|
      | ds map table(3.3V)   |
      |----------------------|
      | DS(3b) | Current (mA)|
      |   000  |     3.07    |
      |   001  |     4.08    |
      |   010  |     4.37    |
      |   011  |     4.68    |
      |   100  |     5.02    |
      |   101  |     5.45    |
      |   110  |     5.74    |
      |   111  |     6.14    |
      |--------|-------------|
=20
(The current value of 2.5V is not available to us now)

When we need to deal with current values at different voltages, using reg=
ister values in drives may be simpler, comparing the current value.
Of course, I will also follow your suggestion and use the current value +=
 lookup table to implement a solution. Thanks!

Best regards,
Samin

