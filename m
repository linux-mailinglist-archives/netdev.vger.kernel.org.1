Return-Path: <netdev+bounces-17907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93671753897
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 12:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E6528206E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 10:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E33C8F2;
	Fri, 14 Jul 2023 10:45:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F52847B
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 10:45:29 +0000 (UTC)
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E3730ED;
	Fri, 14 Jul 2023 03:45:25 -0700 (PDT)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
	by ex01.ufhost.com (Postfix) with ESMTP id 14CEA24E21B;
	Fri, 14 Jul 2023 18:45:23 +0800 (CST)
Received: from EXMBX062.cuchost.com (172.16.6.62) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Fri, 14 Jul
 2023 18:45:23 +0800
Received: from starfive-sdk.starfivetech.com (171.223.208.138) by
 EXMBX062.cuchost.com (172.16.6.62) with Microsoft SMTP Server (TLS) id
 15.0.1497.42; Fri, 14 Jul 2023 18:45:21 +0800
From: Samin Guo <samin.guo@starfivetech.com>
To: <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>
CC: Emil Renner Berthing <kernel@esmil.dk>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Conor Dooley <conor@kernel.org>, "Rob
 Herring" <robh+dt@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Richard Cochran <richardcochran@gmail.com>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jose Abreu
	<joabreu@synopsys.com>, Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit
	<hkallweit1@gmail.com>, Peter Geis <pgwipeout@gmail.com>, Yanhong Wang
	<yanhong.wang@starfivetech.com>, Samin Guo <samin.guo@starfivetech.com>,
	Tommaso Merciai <tomm.merciai@gmail.com>
Subject: [PATCH v1 0/2] Add ethernet nodes for StarFive JH7110 SoC
Date: Fri, 14 Jul 2023 18:45:19 +0800
Message-ID: <20230714104521.18751-1-samin.guo@starfivetech.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [171.223.208.138]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX062.cuchost.com
 (172.16.6.62)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This series adds ethernet nodes for StarFive JH7110 RISC-V SoC,
and has been tested on StarFive VisionFive-2 v1.2A and v1.3B SBC boards.

The first patch adds ethernet nodes for jh7110 SoC, the second patch
adds ethernet nodes for visionfive 2 SBCs.

This series relies on xingyu's syscon patch[1].
For more information and support, you can visit RVspace wiki[2].

[1]: https://patchwork.kernel.org/project/linux-riscv/patch/20230704020239.288500-7-xingyu.wu@starfivetech.com
[2]: https://wiki.rvspace.org


Samin Guo (2):
  riscv: dts: starfive: jh7110: Add ethernet device nodes
  riscv: dts: starfive: visionfive 2: Add configuration of gmac and phy

 .../jh7110-starfive-visionfive-2-v1.2a.dts    | 13 ++++
 .../jh7110-starfive-visionfive-2-v1.3b.dts    | 31 +++++++++
 .../jh7110-starfive-visionfive-2.dtsi         | 34 +++++++++
 arch/riscv/boot/dts/starfive/jh7110.dtsi      | 69 +++++++++++++++++++
 4 files changed, 147 insertions(+)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
prerequisite-patch-id: 06c3560d00fe0f65a09c09002b46cd7c1c59facc
-- 
2.17.1


