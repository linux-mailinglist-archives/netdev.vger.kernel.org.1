Return-Path: <netdev+bounces-19700-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B87575BC1D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 04:09:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478F41C2142D
	for <lists+netdev@lfdr.de>; Fri, 21 Jul 2023 02:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9F38F;
	Fri, 21 Jul 2023 02:09:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFBD6363
	for <netdev@vger.kernel.org>; Fri, 21 Jul 2023 02:09:33 +0000 (UTC)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBFC19B3;
	Thu, 20 Jul 2023 19:09:31 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id CA85424E2EB;
	Fri, 21 Jul 2023 10:09:23 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 10:09:23 +0800
Received: from [192.168.120.43] (171.223.208.138) by EXMBX062.cuchost.com
 (172.16.6.62) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 21 Jul
 2023 10:09:21 +0800
Message-ID: <42beaf41-947e-f585-5ec1-f1710830e556@starfivetech.com>
Date: Fri, 21 Jul 2023 10:09:19 +0800
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
From: Guo Samin <samin.guo@starfivetech.com>
In-Reply-To: <20230720-cardstock-annoying-27b3b19e980a@spud>
Content-Type: text/plain; charset="UTF-8"
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



-------- =E5=8E=9F=E5=A7=8B=E4=BF=A1=E6=81=AF --------
=E4=B8=BB=E9=A2=98: Re: [PATCH v1 0/2] Add ethernet nodes for StarFive JH=
7110 SoC
From: Conor Dooley <conor@kernel.org>
=E6=94=B6=E4=BB=B6=E4=BA=BA: Conor Dooley <conor@kernel.org>, Rob Herring=
 <robh+dt@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro=
.org>, Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@d=
abbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Hal Feng <hal.feng@starfi=
vetech.com>, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.or=
g, devicetree@vger.kernel.org, netdev@vger.kernel.org, Samin Guo <samin.g=
uo@starfivetech.com>
=E6=97=A5=E6=9C=9F: 2023/7/21

> From: Conor Dooley <conor.dooley@microchip.com>
>=20
> On Fri, 14 Jul 2023 18:45:19 +0800, Samin Guo wrote:
>> This series adds ethernet nodes for StarFive JH7110 RISC-V SoC,
>> and has been tested on StarFive VisionFive-2 v1.2A and v1.3B SBC board=
s.
>>
>> The first patch adds ethernet nodes for jh7110 SoC, the second patch
>> adds ethernet nodes for visionfive 2 SBCs.
>>
>> This series relies on xingyu's syscon patch[1].
>> For more information and support, you can visit RVspace wiki[2].
>>
>> [...]
>=20
> Applied to riscv-dt-for-next, thanks!
>=20
> [1/2] riscv: dts: starfive: jh7110: Add ethernet device nodes
>       https://git.kernel.org/conor/c/1ff166c97972
> [2/2] riscv: dts: starfive: visionfive 2: Add configuration of gmac and=
 phy
>       https://git.kernel.org/conor/c/b15a73c358d1
>=20
> Thanks,
> Conor.


Hi Conor=EF=BC=8C

Thank you so much=EF=BC=81=20

There is a question about the configuration of phy that I would like to c=
onsult you.

Latest on motorcomm PHY V5[1]: Follow Rob Herring's advice
motorcomm,rx-xxx-driver-strength Changed to motorcomm,rx-xxx-drv-microamp=
 .
V5 has already received a reviewed-by from Andrew Lunn, and it should not=
 change again.

Should I submit another pacthes based on riscv-dt-for-next?=20

[1] https://patchwork.kernel.org/project/netdevbpf/cover/20230720111509.2=
1843-1-samin.guo@starfivetech.com

=20
Best regards,
Samin

