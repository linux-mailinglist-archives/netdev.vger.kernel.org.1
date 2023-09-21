Return-Path: <netdev+bounces-35448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 480157A98D9
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 19:53:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9FC3B213FF
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7213CD1B;
	Thu, 21 Sep 2023 17:22:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1A1A588;
	Thu, 21 Sep 2023 17:22:37 +0000 (UTC)
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702334F3AE;
	Thu, 21 Sep 2023 10:15:58 -0700 (PDT)
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38LB4M0P001980;
	Thu, 21 Sep 2023 17:06:52 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=selector1; bh=3TMA1x9
	FuXniAWJkqPGs7vBSLWsQf/CGt0HLqhBW5IA=; b=NJmMKWjCNJtH6fcmDfxlUWn
	M5UP8/Js1p0XhnooZBBrNrbSeIN0zwzSrZwWYPL5DWnnib2CFrAqKabflPLCLkrz
	vSEbTlPuKlTyfZLw6pWGtQRJemUSAAph7OeXO87/vNg3WWHrucEKkLBMMkggpUTI
	a5QFzq+lUnbs4P+jaR/2XikhpNHBYiVueLOE+UFksZ30oyAZYMBLRnN7n5W2NeVR
	qDEA9p1VH6D89lHm5tYUAQPQmc9dk2UEeWbpzgkMWPr7RzFrS4h1XrR8mYaRHTE2
	3pN+2kCOYLu/KuGAS/Plw7ZHpm5CG8xPS9CheoSOIXX/7FbL43aeSxwxYIc59eg=
	=
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3t5nx0u3fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Sep 2023 17:06:52 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 7CF01100064;
	Thu, 21 Sep 2023 17:06:51 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 754EA252250;
	Thu, 21 Sep 2023 17:06:51 +0200 (CEST)
Received: from localhost (10.201.21.249) by SHFDAG1NODE2.st.com (10.75.129.70)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 17:06:48 +0200
From: Christophe Roullier <christophe.roullier@foss.st.com>
To: "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue
	<alexandre.torgue@foss.st.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Jose Abreu <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark
 Brown <broonie@kernel.org>,
        Christophe Roullier
	<christophe.roullier@foss.st.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 0/7] Series to deliver Ethernets for STM32MP13
Date: Thu, 21 Sep 2023 17:06:15 +0200
Message-ID: <20230921150622.599232-1-christophe.roullier@foss.st.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.201.21.249]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-21_13,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

STM32MP13 is STM32 SOC with 2 GMACs instances
This board have 2 RMII phy:
  -Ethernet1: RMII with crystal
  -Ethernet2: RMII without crystal
Rework dwmac glue to simplify management for next stm32

Christophe Roullier (7):
  dt-bindings: net: add STM32MP13 compatible in documentation for stm32
  net: ethernet: stmmac: rework glue to simplify management for next
    stm32
  net: ethernet: stmmac: add management of stm32mp13 for stm32
  ARM: dts: stm32: add ethernet1 and ethernet2 support on stm32mp13
  ARM: dts: stm32: add ethernet1/2 RMII pins for STM32MP13F-DK board
  ARM: dts: stm32: add ethernet1 and ethernet2 for STM32MP135F-DK board
  ARM: multi_v7_defconfig: Add MCP23S08 pinctrl support

 .../devicetree/bindings/net/stm32-dwmac.yaml  | 140 +++++++++--
 arch/arm/boot/dts/st/stm32mp13-pinctrl.dtsi   |  71 ++++++
 arch/arm/boot/dts/st/stm32mp131.dtsi          |  31 +++
 arch/arm/boot/dts/st/stm32mp133.dtsi          |  30 +++
 arch/arm/boot/dts/st/stm32mp135f-dk.dts       |  48 ++++
 arch/arm/configs/multi_v7_defconfig           |   1 +
 .../net/ethernet/stmicro/stmmac/dwmac-stm32.c | 226 +++++++++++++-----
 7 files changed, 459 insertions(+), 88 deletions(-)

-- 
2.25.1


