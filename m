Return-Path: <netdev+bounces-57296-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD43812C2A
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 801711C20983
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EBB38DF4;
	Thu, 14 Dec 2023 09:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oVT6c+VE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF221BE9;
	Thu, 14 Dec 2023 01:49:45 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE9TS2r023593;
	Thu, 14 Dec 2023 09:49:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=AhES8Y7x+ZpiqbfFpeHU+5rxqGlvKWJu/Mp3zVbaca0=; b=oV
	T6c+VELcBW5dn2GehNL+ov3U8He2zOEx868Wb++REhMB4udMHO29plxxxK9ONaCh
	j1XmbFGvWNQFjgiRg5iTb66jmgVK0iM6mdK7HhZ57VwfATbH6605w3CJw+XAAv9e
	Y7s8TrA29yzaM6YvY5su3h+WLcpuiZNronEioEW4ugxAiBU+2HxO7YQZvwpAcW29
	Eoo4dgaFESc8haqenFChVlxby/YP0tiAFLDUCFN0X+4GlBg0nPJIClRImhI8/r0C
	JFHiN5OuFPzWeBCgelrWMDHgtG/TBlsZUwGyUon22Fx3hPBWo/7vZH2W1Dj1BhVd
	JyUkEvk5/Wu954pyNEOw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uysrprq1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:49:31 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9nUYf024558
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:49:30 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:49:25 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 14/14] dt-bindings: net: ar803x: add qca8084 PHY propetry
Date: Thu, 14 Dec 2023 17:48:13 +0800
Message-ID: <20231214094813.24690-15-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231214094813.24690-1-quic_luoj@quicinc.com>
References: <20231214094813.24690-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: mMfo319Ha1GenamwBq7cOMRZqSIvWQa9
X-Proofpoint-GUID: mMfo319Ha1GenamwBq7cOMRZqSIvWQa9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=765 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140065

The following properties are added for qca8084 PHY.

1. add the compatible string "ethernet-phy-id004d.d180" since
   the PHY device is not accessible during MDIO bus register.
2. add property "qcom,phy-addr-fixup" for customizing MDIO address.
3. add property "qcom,phy-work-mode" for specifying qca8084 PHY
   work mode.
4. add the initial clocks and resets.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 .../devicetree/bindings/net/qca,ar803x.yaml   | 158 +++++++++++++++++-
 1 file changed, 155 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/qca,ar803x.yaml b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
index 3acd09f0da86..febff039a44f 100644
--- a/Documentation/devicetree/bindings/net/qca,ar803x.yaml
+++ b/Documentation/devicetree/bindings/net/qca,ar803x.yaml
@@ -14,9 +14,6 @@ maintainers:
 description: |
   Bindings for Qualcomm Atheros AR803x PHYs
 
-allOf:
-  - $ref: ethernet-phy.yaml#
-
 properties:
   qca,clk-out-frequency:
     description: Clock output frequency in Hertz.
@@ -85,6 +82,161 @@ properties:
     $ref: /schemas/regulator/regulator.yaml
     unevaluatedProperties: false
 
+  qcom,phy-addr-fixup:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      MDIO address for 4 PHY devices and 3 PCS devices
+
+  qcom,phy-work-mode:
+    description: PHY device work mode.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1, 2, 3]
+
+  clocks:
+    items:
+      - description: APB bridge clock
+      - description: AHB clock
+      - description: Security control clock
+      - description: TLMM clock
+      - description: TLMM AHB clock
+      - description: CNOC AHB clock
+      - description: MDIO AHB clock
+      - description: MDIO master AHB clock
+      - description: PCS0 system clock
+      - description: PCS1 system clock
+      - description: EPHY0 system clock
+      - description: EPHY1 system clock
+      - description: EPHY2 system clock
+      - description: EPHY3 system clock
+    description: PHY initial common clock configs
+
+  clock-names:
+    items:
+      - const: apb_bridge
+      - const: ahb
+      - const: sec_ctrl_ahb
+      - const: tlmm
+      - const: tlmm_ahb
+      - const: cnoc_ahb
+      - const: mdio_ahb
+      - const: mdio_master_ahb
+      - const: srds0_sys
+      - const: srds1_sys
+      - const: gephy0_sys
+      - const: gephy1_sys
+      - const: gephy2_sys
+      - const: gephy3_sys
+
+  resets:
+    items:
+      - description: PCS0 system reset
+      - description: PCS1 system reset
+      - description: EPHY0 system reset
+      - description: EPHY1 system reset
+      - description: EPHY2 system reset
+      - description: EPHY3 system reset
+      - description: EPHY0 software reset
+      - description: EPHY1 software reset
+      - description: EPHY2 software reset
+      - description: EPHY3 software reset
+      - description: Ethernet DSP reset
+    description: PHY initial common reset configs
+
+  reset-names:
+    items:
+      - const: srds0_sys
+      - const: srds1_sys
+      - const: gephy0_sys
+      - const: gephy1_sys
+      - const: gephy2_sys
+      - const: gephy3_sys
+      - const: gephy0_soft
+      - const: gephy1_soft
+      - const: gephy2_soft
+      - const: gephy3_soft
+      - const: gephy_dsp
+
+allOf:
+  - $ref: ethernet-phy.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - ethernet-phy-id004d.d180
+    then:
+      properties:
+        clocks:
+          items:
+            - description: APB bridge clock
+            - description: AHB clock
+            - description: Security control clock
+            - description: TLMM clock
+            - description: TLMM AHB clock
+            - description: CNOC AHB clock
+            - description: MDIO AHB clock
+            - description: MDIO master AHB clock
+            - description: PCS0 system clock
+            - description: PCS1 system clock
+            - description: EPHY0 system clock
+            - description: EPHY1 system clock
+            - description: EPHY2 system clock
+            - description: EPHY3 system clock
+        clock-names:
+          items:
+            - const: apb_bridge
+            - const: ahb
+            - const: sec_ctrl_ahb
+            - const: tlmm
+            - const: tlmm_ahb
+            - const: cnoc_ahb
+            - const: mdio_ahb
+            - const: mdio_master_ahb
+            - const: srds0_sys
+            - const: srds1_sys
+            - const: gephy0_sys
+            - const: gephy1_sys
+            - const: gephy2_sys
+            - const: gephy3_sys
+        resets:
+          items:
+            - description: PCS0 system reset
+            - description: PCS1 system reset
+            - description: EPHY0 system reset
+            - description: EPHY1 system reset
+            - description: EPHY2 system reset
+            - description: EPHY3 system reset
+            - description: EPHY0 software reset
+            - description: EPHY1 software reset
+            - description: EPHY2 software reset
+            - description: EPHY3 software reset
+            - description: Ethernet DSP reset
+        reset-names:
+          items:
+            - const: srds0_sys
+            - const: srds1_sys
+            - const: gephy0_sys
+            - const: gephy1_sys
+            - const: gephy2_sys
+            - const: gephy3_sys
+            - const: gephy0_soft
+            - const: gephy1_soft
+            - const: gephy2_soft
+            - const: gephy3_soft
+            - const: gephy_dsp
+      required:
+        - qcom,phy-addr-fixup
+        - qcom,phy-work-mode
+        - clocks
+        - clock-names
+        - resets
+        - reset-names
+    else:
+      properties:
+        qcom,phy-addr-fixup: false
+        qcom,phy-work-mode: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.42.0


