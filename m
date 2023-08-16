Return-Path: <netdev+bounces-28251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD5877EC4D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 23:56:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6682F1C2123C
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 21:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CF01AA95;
	Wed, 16 Aug 2023 21:56:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187C51AA85
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 21:56:15 +0000 (UTC)
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52D841FC3;
	Wed, 16 Aug 2023 14:56:13 -0700 (PDT)
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37GG7AX8006141;
	Wed, 16 Aug 2023 21:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : subject :
 date : message-id : in-reply-to : references : mime-version; s=pps0720;
 bh=YGcM0JtQz2iRHlYmQwbApVV7mHlgmm2fK96UcbfHXBE=;
 b=PiR2vUplJp1S/S4vmzq3MhAvTGUFtfljuMHD3FTNd4aopXitvaza9Ty9gaBThvqB+VUT
 S1fMdof0cjLAzn+pxPpUuGhgE7IlXGTSWr+mbt25jgCGl8RN+X2JvYzIw6TX9hfiGoqi
 psYyGY1g7U5Ykb9NWgF09Dbub3B7snehU/fnEusbhwEBhuC+xHpRvJ/qH3B8aJuRNL+1
 sS95YF2+/7sOzaPS0F+iOjkNSrtlYg+7hpFGlIp3JMWvf8XpXLfWA8Rsaaqt/oPb9ehD
 fazEX10HhQBgqXRxE/az5HAqNgHRjR6D9Io0x3e9+M+TwYdFjegdLb47MfesVongHqCk qw== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3sh07b3sgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Aug 2023 21:55:48 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id C0279D2E4;
	Wed, 16 Aug 2023 21:55:47 +0000 (UTC)
Received: from hpe.com (unknown [16.231.227.39])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id B5EDC80BA10;
	Wed, 16 Aug 2023 21:55:46 +0000 (UTC)
From: nick.hawkins@hpe.com
To: christophe.jaillet@wanadoo.fr, simon.horman@corigine.com, andrew@lunn.ch,
        verdun@hpe.com, nick.hawkins@hpe.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/5] dt-bindings: net: Add HPE GXP UMAC
Date: Wed, 16 Aug 2023 16:52:18 -0500
Message-Id: <20230816215220.114118-4-nick.hawkins@hpe.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230816215220.114118-1-nick.hawkins@hpe.com>
References: <20230816215220.114118-1-nick.hawkins@hpe.com>
X-Proofpoint-GUID: Xs2m14yHU1fIouAa3BX2ifJe2SkQDUnO
X-Proofpoint-ORIG-GUID: Xs2m14yHU1fIouAa3BX2ifJe2SkQDUnO
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_19,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308160195
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Nick Hawkins <nick.hawkins@hpe.com>

Provide access to the register regions and interrupt for Universal
MAC(UMAC). The driver under the hpe,gxp-umac binding will provide an
interface for sending and receiving networking data from both of the
UMACs on the system.

Signed-off-by: Nick Hawkins <nick.hawkins@hpe.com>

---

v3:
 *Remove MDIO references
 *Modify description for use-ncsi
v2:
 *Move mac-addresses into ports
 *Remove | where not needed
---
 .../devicetree/bindings/net/hpe,gxp-umac.yaml | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml

diff --git a/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
new file mode 100644
index 000000000000..d3f72694c814
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/hpe,gxp-umac.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/hpe,gxp-umac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HPE GXP Unified MAC Controller
+
+maintainers:
+  - Nick Hawkins <nick.hawkins@hpe.com>
+
+description:
+  HPE GXP 802.3 10/100/1000T Ethernet Unifed MAC controller.
+  Device node of the controller has following properties.
+
+properties:
+  compatible:
+    const: hpe,gxp-umac
+
+  use-ncsi:
+    type: boolean
+    description:
+      Indicates if the device should use NCSI (Network Controlled
+      Sideband Interface). Only one of the two MACs can support
+      NCSI and it requires there to be a physical connection on
+      the board to be present. This property indicates that
+      physical connection is present and should be used.
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ethernet-ports:
+    type: object
+    additionalProperties: false
+    description: Ethernet ports to PHY
+
+    properties:
+      "#address-cells":
+        const: 1
+
+      "#size-cells":
+        const: 0
+
+    patternProperties:
+      "^port@[0-1]$":
+        type: object
+        additionalProperties: false
+        description: Port to PHY
+
+        properties:
+          reg:
+            minimum: 0
+            maximum: 1
+
+          phy-handle:
+            maxItems: 1
+
+          mac-address: true
+
+        required:
+          - reg
+          - phy-handle
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ethernet-ports
+
+examples:
+  - |
+    ethernet@4000 {
+      compatible = "hpe,gxp-umac";
+      reg = <0x4000 0x80>;
+      interrupts = <22>;
+      ethernet-ports {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        port@0 {
+          reg = <0>;
+          phy-handle = <&int_phy0>;
+          mac-address = [00 00 00 00 00 00];
+        };
+
+        port@1 {
+          reg = <1>;
+          phy-handle = <&ext_phy1>;
+          mac-address = [00 00 00 00 00 00];
+        };
+      };
+    };
-- 
2.17.1


