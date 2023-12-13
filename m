Return-Path: <netdev+bounces-54797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E680280848F
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 10:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B5531F22782
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 09:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 088D333CD9;
	Thu,  7 Dec 2023 09:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aWo2pJ9v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63E88AC;
	Thu,  7 Dec 2023 01:27:06 -0800 (PST)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B75Fk33022866;
	Thu, 7 Dec 2023 09:26:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=P6ZudTm6wFcbHQdxZ/1YU+ES/AQBa5zRgczcLaOp5NM=;
 b=aWo2pJ9vZz0J8SmZK5qIwmRgp0M2zSV21bMhas8pgpas7xV2hLq0TRwo8E3IsZbc+lvX
 N9J/RjfuhC6VrkyEa8Ne0hLc07GucjcjjmTtITP4Tnd2ojK0Nl1c1FxgPZUNwGUz+8AV
 B0r2ZHcblh1j0GNPoJNgVfGOgcRZ1gwnH2TP0nE0JUimE8++AY2LBbsO3xlpQMstEc2f
 Y9e2nMmc1QzMsXl2fboWcVYcKDcwL2YrY5wJ1leJUmv4fBcr6oyb0UZey0JZAkyG2+c2
 sznQpTto9ouiuWEC4CLPVxHjYX1o+Yk1Tq2jnAN0w9N4wKKYUzUS3MMbDbWLOt4S4Uzl TA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utuhfa604-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Dec 2023 09:26:52 +0000
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B79QpIg030027
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Dec 2023 09:26:51 GMT
Received: from hu-jsuraj-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 7 Dec 2023 01:26:41 -0800
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
To: <quic_jsuraj@quicinc.com>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma
	<bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson
	<andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub
 Kicinski" <kuba@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        "Jose
 Abreu" <joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
CC: <kernel@quicinc.com>
Subject: [PATCH net-next v4 1/3] dt-bindings: net: qcom,ethqos: add binding doc for safety IRQ for sa8775p
Date: Thu, 7 Dec 2023 14:51:25 +0530
Message-ID: <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1701939695.git.quic_jsuraj@quicinc.com>
References: <cover.1701939695.git.quic_jsuraj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: IB39J3u8c5UaSpvIdTqEyulvrfuMloSS
X-Proofpoint-GUID: IB39J3u8c5UaSpvIdTqEyulvrfuMloSS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-07_06,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312070076

Add binding doc for safety IRQ. The safety IRQ will be
triggered for ECC, DPP, FSM error.

Signed-off-by: Suraj Jaiswal <quic_jsuraj@quicinc.com>
---
 Documentation/devicetree/bindings/net/qcom,ethqos.yaml | 9 ++++++---
 Documentation/devicetree/bindings/net/snps,dwmac.yaml  | 6 ++++--
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
index 7bdb412a0185..93d21389e518 100644
--- a/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
+++ b/Documentation/devicetree/bindings/net/qcom,ethqos.yaml
@@ -37,12 +37,14 @@ properties:
     items:
       - description: Combined signal for various interrupt events
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when HW safety error triggered
 
   interrupt-names:
     minItems: 1
     items:
       - const: macirq
-      - const: eth_lpi
+      - enum: [eth_lpi, safety]
+      - const: safety
 
   clocks:
     maxItems: 4
@@ -89,8 +91,9 @@ examples:
                <&gcc GCC_ETH_PTP_CLK>,
                <&gcc GCC_ETH_RGMII_CLK>;
       interrupts = <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
-                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-names = "macirq", "eth_lpi";
+                   <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+                   <GIC_SPI 782 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "macirq", "eth_lpi", "safety";
 
       rx-fifo-depth = <4096>;
       tx-fifo-depth = <4096>;
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 5c2769dc689a..3b46d69ea97d 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -107,13 +107,15 @@ properties:
       - description: Combined signal for various interrupt events
       - description: The interrupt to manage the remote wake-up packet detection
       - description: The interrupt that occurs when Rx exits the LPI state
+      - description: The interrupt that occurs when HW safety error triggered
 
   interrupt-names:
     minItems: 1
     items:
       - const: macirq
-      - enum: [eth_wake_irq, eth_lpi]
-      - const: eth_lpi
+      - enum: [eth_wake_irq, eth_lpi, safety]
+      - enum: [eth_wake_irq, eth_lpi, safety]
+      - enum: [eth_wake_irq, eth_lpi, safety]
 
   clocks:
     minItems: 1
-- 
2.25.1


