Return-Path: <netdev+bounces-12453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 36FCD737977
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 05:03:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 673A828136A
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 03:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD22017C6;
	Wed, 21 Jun 2023 03:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B015BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 03:03:51 +0000 (UTC)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4636EE7E;
	Tue, 20 Jun 2023 20:03:49 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id DE6108062;
	Wed, 21 Jun 2023 11:03:35 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 11:03:35 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 21 Jun
 2023 11:03:34 +0800
Message-ID: <cce9e2d7-6a62-7e9d-fa44-d577273e672e@starfivetech.com>
Date: Wed, 21 Jun 2023 11:03:33 +0800
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
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Conor Dooley
	<conor.dooley@microchip.com>
CC: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor@kernel.org>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, Peter Geis <pgwipeout@gmail.com>, Frank
	<Frank.Sae@motor-comm.com>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, Yanhong Wang
	<yanhong.wang@starfivetech.com>
References: <20230526090502.29835-1-samin.guo@starfivetech.com>
 <20230526090502.29835-2-samin.guo@starfivetech.com>
 <20230526-glutinous-pristine-fed571235b80@spud>
 <1dbf113c-7592-68bd-6aaf-05ff1d8c538c@starfivetech.com>
 <15eb4ffe-ea12-9a2c-ae9d-c34860384b60@starfivetech.com>
 <20230620-clicker-antivirus-99e24a06954e@wendy>
 <1a5c39d8-812f-4a8d-bc65-205695661973@linaro.org>
From: Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <1a5c39d8-812f-4a8d-bc65-205695661973@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



-------- =E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF --------
=E4=B8=BB=E9=A2=98: Re: [PATCH v3 1/2] dt-bindings: net: motorcomm: Add p=
ad driver strength cfg
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
=E6=94=B6=E4=BB=B6=E4=BA=BA: Conor Dooley <conor.dooley@microchip.com>, G=
uo Samin <samin.guo@starfivetech.com>
=E6=97=A5=E6=9C=9F: 2023/6/20

> On 20/06/2023 10:26, Conor Dooley wrote:
>> Hey,
>>
>> On Tue, Jun 20, 2023 at 11:09:52AM +0800, Guo Samin wrote:
>>> From: Guo Samin <samin.guo@starfivetech.com>
>>>> From: Conor Dooley <conor@kernel.org>
>>>>> On Fri, May 26, 2023 at 05:05:01PM +0800, Samin Guo wrote:
>>>>>> The motorcomm phy (YT8531) supports the ability to adjust the driv=
e
>>>>>> strength of the rx_clk/rx_data, the value range of pad driver
>>>>>> strength is 0 to 7.
>>
>>>>>> +  motorcomm,rx-clk-driver-strength:
>>>>>> +    description: drive strength of rx_clk pad.
>>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
>>>>>
>>>>> I think you should use minimum & maximum instead of these listed ou=
t
>>>>> enums.
>>
>>>>  You have also had this comment since v1 & were reminded of it on
>>>>> v2 by Krzysztof: "What do the numbers mean? What are the units? mA?=
"
>>
>>>> The good news is that we just got some data about units from Motorco=
mm.=20
>>>> Maybe I can post the data show of the unit later after I get the com=
plete data.
>>
>>> Sorry, haven't updated in a while.
>>
>> NW chief.
>>
>>> I just got the detailed data of Driver Strength(DS) from Motorcomm , =
which applies to both rx_clk and rx_data.
>>>
>>> |----------------------|
>>> |     ds map table     |
>>> |----------------------|
>>> | DS(3b) | Current (mA)|
>>> |--------|-------------|
>>> |   000  |     1.20    |
>>> |   001  |     2.10    |
>>> |   010  |     2.70    |
>>> |   011  |     2.91    |
>>> |   100  |     3.11    |
>>> |   101  |     3.60    |
>>> |   110  |     3.97    |
>>> |   111  |     4.35    |
>>> |--------|-------------|
>>>
>>> Since these currents are not integer values and have no regularity,
>=20
> There is no mA unit in DT schema, so I don't see what by "not integer
> values". 1200 uA is an integer.
>=20
>>> it is not very good to use in the drive/dts in my opinion.
>>
>> Who says you have to use mA? What about uA?
>=20
> Yep

>=20
>>
>>> Therefore, I tend to continue to use DS(0-7) in dts/driver, and addin=
g
>>> a description of the current value corresponding to DS in dt-bindings=
.=20
>>
>> I think this goes against not putting register values into the dts &
>> that the accurate description of the hardware are the currents.
>=20
> For vendor properties register values are often accepted, but logical
> unit is much more readable in the DTS. Also allows further customizatio=
n
> or extending when new variant appears. You cannot do extend a property
> easily when it holds a register value, without changing the meaning per
> variant.
>

Hi Conor & Krzysztof=EF=BC=8C
Thanks for taking the time to review.
Yes, uA can be used to avoid the problem of decimals.

In addition to this, we need to deal with the DS under different IOPAD.
these values were existed at IO 1.8V. When the IO is set to 3.3V, the val=
ues will change.

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


Best regards,
Samin
>>
>>> Like This:
>>>
>>> +  motorcomm,rx-clk-driver-strength:
>>> +    description: drive strength of rx_clk pad.
>>
>> You need "description: |" to preserve the formatting if you add tables=
,
>> but I don't think that this is a good idea. Put the values in here tha=
t
>> describe the hardware (IOW the currents) and then you don't need to ha=
ve
>> this table.
>>
>>> +      |----------------------|
>>> +      | rx_clk ds map table  |
>>> +      |----------------------|
>>> +      | DS(3b) | Current (mA)|
>>> +      |   000  |     1.20    |
>>> +      |   001  |     2.10    |
>>> +      |   010  |     2.70    |
>>> +      |   011  |     2.91    |
>>> +      |   100  |     3.11    |
>>> +      |   101  |     3.60    |
>>> +      |   110  |     3.97    |
>>> +      |   111  |     4.35    |
>>> +      |--------|-------------|
>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>> +    enum: [ 0, 1, 2, 3, 4, 5, 6, 7 ]
>>> +    default: 3
>>> +
>>
>>> Or use minimum & maximum instead of these listed out enums
>>
>> With the actual current values, enum rather than min + max.
>=20
>=20
>=20
> Best regards,
> Krzysztof
>=20

