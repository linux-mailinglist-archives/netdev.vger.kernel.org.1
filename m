Return-Path: <netdev+bounces-19742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 844A475BFB2
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D301C215EC
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 07:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10B4D20EE;
	Fri, 21 Jul 2023 07:27:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF44E20E4
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 07:27:50 +0000 (UTC)
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC64189;
	Fri, 21 Jul 2023 00:27:47 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
	by fd01.gateway.ufhost.com (Postfix) with ESMTP id 3FD3C24DD54;
	Fri, 21 Jul 2023 15:27:38 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 15:27:36 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 15:27:34 +0800
Message-ID: <ce3e0ffb-abcd-2392-8767-db460bce4b4b@starfivetech.com>
Date: Fri, 21 Jul 2023 15:27:33 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfivetech.com>,
	<linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Conor Dooley <conor.dooley@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Emil Renner Berthing <kernel@esmil.dk>,
	Richard Cochran <richardcochran@gmail.com>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jose Abreu
	<joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Peter Geis <pgwipeout@gmail.com>, Yanhong Wang
	<yanhong.wang@starfivetech.com>, Tommaso Merciai <tomm.merciai@gmail.com>
References: <20230714104521.18751-1-samin.guo@starfivetech.com>
 <20230720-cardstock-annoying-27b3b19e980a@spud>
 <42beaf41-947e-f585-5ec1-f1710830e556@starfivetech.com>
 <A0012BE7-8947-49C8-8697-1F879EE7B0B7@kernel.org>
From: Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <A0012BE7-8947-49C8-8697-1F879EE7B0B7@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



-------- =E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF --------
=E4=B8=BB=E9=A2=98: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH=
7110 SoC
From: Conor Dooley <conor@kernel.org>
=E6=94=B6=E4=BB=B6=E4=BA=BA: Guo Samin <samin.guo@starfivetech.com>, Rob =
Herring <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt=
@linaro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <p=
almer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng=
@starfivetech.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infra=
dead.org, devicetree@vger.kernel.org, netdev@vger.kernel.org
=E6=97=A5=E6=9C=9F: 2023/7/21

>=20
>=20
> On 21 July 2023 03:09:19 IST, Guo Samin <samin.guo@starfivetech.com> wr=
ote:
>>
>>
>> -------- =E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF --------
>> =E4=B8=BB=E9=A2=98: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive=
 JH7110 SoC
>> From: Conor Dooley <conor@kernel.org>
>> =E6=94=B6=E4=BB=B6=E4=BA=BA: Conor Dooley <conor@kernel.org>, Rob Herr=
ing <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@lin=
aro.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palme=
r@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@sta=
rfivetech.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead=
.org, devicetree@vger.kernel.org, netdev@vger.kernel.org, Samin Guo <sami=
n.guo@starfivetech.com>
>> =E6=97=A5=E6=9C=9F: 2023/7/21
>>
>>> From: Conor Dooley <conor.dooley@microchip.com>
>>>
>>> On Fri, 14 Jul 2023 18:45:19 +0800, Samin Guo wrote:
>>>> This series adds ethernet nodes for StarFive JH7110 RISC-V SoC,
>>>> and has been tested on StarFive VisionFive-2 v1.2A and v1.3B SBC boa=
rds.
>>>>
>>>> The first patch adds ethernet nodes for jh7110 SoC, the second patch
>>>> adds ethernet nodes for visionfive 2 SBCs.
>>>>
>>>> This series relies on xingyu's syscon patch[1].
>>>> For more information and support, you can visit RVspace wiki[2].
>>>>
>>>> [...]
>>>
>>> Applied to riscv-dt-for-next, thanks!
>>>
>>> [1/2] riscv: dts: starfive: jh7110: Add ethernet device nodes
>>>       https://git.kernel.org/conor/c/1ff166c97972
>>> [2/2] riscv: dts: starfive: visionfive 2: Add configuration of gmac a=
nd phy
>>>       https://git.kernel.org/conor/c/b15a73c358d1
>>>
>>> Thanks,
>>> Conor.
>>
>>
>> Hi Conor=EF=BC=8C
>>
>> Thank you so much=EF=BC=81=20
>>
>> There is a question about the configuration of phy that I would like t=
o consult you.
>>
>> Latest on motorcomm PHY V5[1]: Follow Rob Herring's advice
>> motorcomm,rx-xxx-driver-strength Changed to motorcomm,rx-xxx-drv-micro=
amp .
>> V5 has already received a reviewed-by from Andrew Lunn, and it should =
not change again.
>>
>> Should I submit another pacthes based on riscv-dt-for-next?=20
>=20
> Huh, dtbs_check passed for these patches,
> I didn't realise changes to the motorcomm stuff
> were a dep. for this. I'll take a look later.
>
Hi Conor,

Thanks for taking the time to follow this.

After discussing with HAL, I have prepared the code and considered adding=
 the following patch to=20
Motorcomm's patchsetes v6. (To fix some spelling errors in v5[1])
which will then send patches based on linux-next. What do you think? @And=
rew @Conor

[1] https://patchwork.kernel.org/project/netdevbpf/cover/20230720111509.2=
1843-1-samin.guo@starfivetech.com



--- a/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
+++ b/arch/riscv/boot/dts/starfive/jh7110-starfive-visionfive-2-v1.3b.dts
@@ -28,8 +28,8 @@
        motorcomm,tx-clk-adj-enabled;
        motorcomm,tx-clk-100-inverted;
        motorcomm,tx-clk-1000-inverted;
-       motorcomm,rx-clk-driver-strength =3D <3970>;
-       motorcomm,rx-data-driver-strength =3D <2910>;
+       motorcomm,rx-clk-drv-microamp =3D <3970>;
+       motorcomm,rx-data-drv-microamp =3D <2910>;
        rx-internal-delay-ps =3D <1500>;
        tx-internal-delay-ps =3D <1500>;
 };
@@ -37,8 +37,8 @@
 &phy1 {
        motorcomm,tx-clk-adj-enabled;
        motorcomm,tx-clk-100-inverted;
-       motorcomm,rx-clk-driver-strength =3D <3970>;
-       motorcomm,rx-data-driver-strength =3D <2910>;
+       motorcomm,rx-clk-drv-microamp =3D <3970>;
+       motorcomm,rx-data-drv-microamp =3D <2910>;
        rx-internal-delay-ps =3D <300>;
        tx-internal-delay-ps =3D <0>;
 };


Best regards,
Samin

>>
>> [1] https://patchwork.kernel.org/project/netdevbpf/cover/2023072011150=
9.21843-1-samin.guo@starfivetech.com
>>
>>
>> Best regards,
>> Samin


