Return-Path: <netdev+bounces-293537-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKk9AFQLHWqvVAkAu9opvQ
	(envelope-from <netdev+bounces-293537-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:32:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C33619730
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 06:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5163330479FA
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 04:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5ADB32E143;
	Mon,  1 Jun 2026 04:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="N1iYLA6R";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="aYSZG48E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018FA72603
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 04:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780288176; cv=none; b=GxPDSpn890jjmeSEJ3idUDT+9/xQQ5VYmoCzNElMJ6gnsoMdNimBu/yfr/zfH+xHUH0X3CvUSOXuiDdlse4aDQD0wxhbTuMR+f733wPzDx155plPiIeCK4gTPM1tqNknmzODC6oqLfMvpt3ganIa9EvCMtqHdXfiMhxtjcsJMrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780288176; c=relaxed/simple;
	bh=yLAhiDn0TxgFXYbEMSZ21ewKhKqyCrxym96bpcjMQyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C34hf2az/iQhmuQjcQsFUqfzu787L0s/9J+2Vu94IwhvXKS3d60I+l8zBiRsrDKcEiF1C42ira7svVBKiQn5frtzkjzb1RRxlhSWgALIu504qg1vHB9vIhvNkdsPHPzyt3fYUXMmJLvwUSM4oKaHYEnV8StEC7J759Ym8bPombA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=N1iYLA6R; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=aYSZG48E; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64VLgdIC1375308
	for <netdev@vger.kernel.org>; Mon, 1 Jun 2026 04:29:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eTWDxBuWyNKct2rjVP0PVZRb5Kz9GuUlQA8QIoN9hVE=; b=N1iYLA6RnhJXFvIQ
	6GMm14uBa0J3C6zJR3r3Id760FgfGAlt5Zh+1LNXbpXi5jxxckGmsRBT9Xy2quDV
	9G9mnbJzMo/AwaJjunIiFWw4cRrFEm6WwzTcyGM5URA8uYOujcr8LOKFW7K+yr8M
	9ycqpzpDLdlVP8YHAxLStSArt6IlI8FgRVKMQSXJBENPRFGFAPOO04K8Q60M4RTo
	lN0ZJXZy1OWmL3iKk90OnmfXQX6NKKpt4Jm6b23B3ERy22UeaLHdROv/suy74+Qp
	fcSuGE4icfmaaOp9mqjEtkM9TUVVM2JDTTLqzwr5+gPXZe1Igkp5oWapIClQHmwt
	Hcoa3Q==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efpw7nr3j-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 01 Jun 2026 04:29:33 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2c0c20f7581so10159925ad.0
        for <netdev@vger.kernel.org>; Sun, 31 May 2026 21:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780288173; x=1780892973; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eTWDxBuWyNKct2rjVP0PVZRb5Kz9GuUlQA8QIoN9hVE=;
        b=aYSZG48EEiUPmXH3L7IGq8+pDQEf6YOlHLVjCdWfAC4GMhxwLvp4lOaBl/0RUARklO
         Y6EjBA/tvx+BuhyquBoSotci3a3GfkIeAVcJCkXhEDFjipVCLb/L8iWXwWxwA+HgcQyM
         6n4kmoXz4+GIQx7ejSPVsulxftfgPXMzwmfyooRaENRVXvI5gGJNhpNsYWi7gEVR6AOG
         nHk4C6MA6M+W5onBYUWas5/eWky0AyTljJ8+JL/ki+4aQ9fY3kWIbG14Zy/JKolC/eQ9
         EnmyDjv6OrMhx8sr6Xl4ol9y3FqM1s+zJaCf00Qbjyqzn0sQ4OyAH2UQcNoz12i5F2H2
         3Cdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780288173; x=1780892973;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eTWDxBuWyNKct2rjVP0PVZRb5Kz9GuUlQA8QIoN9hVE=;
        b=nIm8N8KwVTe9GGR9EjMotu/bagSrOH3ix9THD4cTLDZsERnPeLOu9FRDqoXdUzbfm/
         fLZ5RKT0xnJpaS4GWXJuCGUAh5Rl+4nVg77PMYfaNJ+VDtAl5eIOVlVl+3fp2aqvtRuT
         R4WZjlvMdjslnImUGnSBq9xi3OCLz+Cv8D8DwqcVq0+R5bA0GAQNOi1ODKz1vApeaLEg
         7C9TQqx/6Ymm+IAS3HXGKo65CS6MM2v73AiInAXHFmMn8qWJEq8STKvDCJgKHlD8cp6I
         x5MisoNHNMSJZBfeOlk0M6NFh2YskEFSam7K/bcQ3huwFWCfBjikNRklLb+h/Oi8xABk
         px+g==
X-Forwarded-Encrypted: i=1; AFNElJ8SPB16eQ6aGK7XFSU737oxL1D8AAbmTFLebkyrcBbHjqiJ5P7NSXprL+0UnupskXWrdR8zJ2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdghh03JcThy0xJ0acVkqVkBkrk/KRHjBqroWC1iuephgqYk9F
	0sSZa5UNzeEhvOD7tMo/gUV9mKiwkdJ9AgHiqRDinDCxnivHD5hxKdlR88Efk1nxlrltec+8Pnu
	AXLit39CRHrFJiedDYNPWtCyBJmgais57WqRGjg54gzSsZr+hPZ3C1USN7JY=
X-Gm-Gg: Acq92OGWUFLEPKy711bSEdCWFKgxB0hfkaVIVtiPJzxxoiNskNwHtDyZvtsosB/3dEb
	J72aJIkGYUT5iBPVQ/OdgJZhGwdp4QGAPxaghH4ESYjMjcTJ7d619uzIU6pEZRYV+Ds110Qoenp
	RFUqsvBkhVa/ryrdjLHpWjN8ozreAyVgYqdt5Ocwpfz4BOPW19a0cAD+17WXu26C464bXS2fpKA
	8Yn9dyCOhu/pJiehvAz4ANwc5p/g7m2FnTFaqc0PygJdiVsoM0cTTeA7yCUk47GktjhP4kG7tlO
	m222uryLedsNjNtF8j006f103z7Ux0D3jVclsuXTzaBJEv+SEpTdm8tn1ZwXvTh8kZpX16Cp/YL
	XkS7qR2iuXyxOeFz2SV+DJqABJICwvUfF9eUnLyT90ZYSqQyHl59mDzKVCXPw9bU=
X-Received: by 2002:a17:903:1983:b0:2bf:23cf:3e4 with SMTP id d9443c01a7336-2bf367d9da0mr100131365ad.17.1780288172620;
        Sun, 31 May 2026 21:29:32 -0700 (PDT)
X-Received: by 2002:a17:903:1983:b0:2bf:23cf:3e4 with SMTP id d9443c01a7336-2bf367d9da0mr100131075ad.17.1780288172092;
        Sun, 31 May 2026 21:29:32 -0700 (PDT)
Received: from hu-imrashai-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bf23b011f7sm117215715ad.41.2026.05.31.21.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 May 2026 21:29:31 -0700 (PDT)
From: Imran Shaik <imran.shaik@oss.qualcomm.com>
Date: Mon, 01 Jun 2026 09:59:14 +0530
Subject: [PATCH v3 2/4] dt-bindings: clock: qcom: Add Qualcomm Shikra SoC
 Global Clock Controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-shikra-gcc-rpmcc-clks-v3-2-76c455f5d579@oss.qualcomm.com>
References: <20260601-shikra-gcc-rpmcc-clks-v3-0-76c455f5d579@oss.qualcomm.com>
In-Reply-To: <20260601-shikra-gcc-rpmcc-clks-v3-0-76c455f5d579@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>
Cc: Ajit Pandey <ajit.pandey@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Jagadeesh Kona <jagadeesh.kona@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Imran Shaik <imran.shaik@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Proofpoint-GUID: Tm-LCL7sHP9zWBQ7dMneRy2LydwIEgET
X-Proofpoint-ORIG-GUID: Tm-LCL7sHP9zWBQ7dMneRy2LydwIEgET
X-Authority-Analysis: v=2.4 cv=bNIm5v+Z c=1 sm=1 tr=0 ts=6a1d0aad cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=gEfo2CItAAAA:8 a=EUspDBNiAAAA:8 a=rEY_huOQuSSvoCxIK_IA:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22 a=sptkURWiP4Gy88Gu7hUp:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA0MiBTYWx0ZWRfX5xCt0p8OdOUn
 1sduwlDzZYRYe1T6FLDRP9fphehntcaiHnL2djgkrnhCNw58zZS/YCzndq6gAgaeW96AWrDf9UR
 1MNY6XgZd9D/bUEsIoYAEWw24ePKoKwl43csQ+wL00+4M/KkErvO2DSkRyh4XC3ZQ5AtL7Ij1YW
 faaEy1nIlN98hoUEU8NhnXkzIpVKyTVa3fYWJhegWlok//c1OyqUcdTwqpkT5Cr/HnPyNf3yYUy
 gWBvNh7D4AFhf3swiqBIYJD5OQHbfKmk8SUO8La1HUkacvkq+a/jV+Jfn8lg7bfisVu5zbrFBEW
 PhUQQ1gmAJ8VmedTai3IJ0dmtGxvH2efDGS3LClkSmqBznfKXHd5Zk15aTaPTeVZSOcr9sun+ZK
 X4jCEqF1Kjj/44oY5vZznpOIHPEhfJ8cU2uKlQmbBOqZEssPw+LdCrMgZ7zWzPR9NU8wmz3eAzP
 1SvxmeiNoLnebBE/hgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_01,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 phishscore=0 adultscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010042
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293537-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,qualcomm.com:dkim,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,devicetree.org:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,0.21.92.192:email];
	FREEMAIL_TO(0.00)[kernel.org,baylibre.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imran.shaik@oss.qualcomm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 47C33619730
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add device tree bindings for the global clock controller on Qualcomm
Shikra SoC.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Imran Shaik <imran.shaik@oss.qualcomm.com>
---
 .../devicetree/bindings/clock/qcom,shikra-gcc.yaml |  70 ++++++
 include/dt-bindings/clock/qcom,shikra-gcc.h        | 263 +++++++++++++++++++++
 2 files changed, 333 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/qcom,shikra-gcc.yaml b/Documentation/devicetree/bindings/clock/qcom,shikra-gcc.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..da6eebfa84c22c1b287c194992c04a54ca0aabf9
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/qcom,shikra-gcc.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/qcom,shikra-gcc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Global Clock & Reset Controller on Qualcomm Shikra SoC
+
+maintainers:
+  - Imran Shaik <imran.shaik@oss.qualcomm.com>
+  - Taniya Das <taniya.das@oss.qualcomm.com>
+
+description: |
+  Global clock control module provides the clocks, resets and power
+  domains on Qualcomm Shikra SoC platform.
+
+  See also: include/dt-bindings/clock/qcom,shikra-gcc.h
+
+properties:
+  compatible:
+    const: qcom,shikra-gcc
+
+  clocks:
+    items:
+      - description: Board XO source
+      - description: Sleep clock source
+      - description: EMAC0 sgmiiphy mac rclk source
+      - description: EMAC0 sgmiiphy mac tclk source
+      - description: EMAC1 sgmiiphy mac rclk source
+      - description: EMAC1 sgmiiphy mac tclk source
+      - description: PCIE Pipe clock source
+      - description: USB3 phy wrapper pipe clock source
+
+  power-domains:
+    items:
+      - description: CX domain
+
+required:
+  - compatible
+  - clocks
+  - power-domains
+  - '#power-domain-cells'
+
+allOf:
+  - $ref: qcom,gcc.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,rpmcc.h>
+    #include <dt-bindings/power/qcom-rpmpd.h>
+    clock-controller@1400000 {
+        compatible = "qcom,shikra-gcc";
+        reg = <0x01400000 0x1f0000>;
+        clocks = <&rpmcc RPM_SMD_XO_CLK_SRC>,
+                 <&sleep_clk>,
+                 <&emac0_sgmiiphy_rclk>,
+                 <&emac0_sgmiiphy_tclk>,
+                 <&emac1_sgmiiphy_rclk>,
+                 <&emac1_sgmiiphy_tclk>,
+                 <&pcie_pipe_clk>,
+                 <&usb3_phy_wrapper_gcc_usb30_pipe_clk>;
+        power-domains = <&rpmpd RPMPD_VDDCX>;
+        #clock-cells = <1>;
+        #power-domain-cells = <1>;
+        #reset-cells = <1>;
+    };
+
+...
diff --git a/include/dt-bindings/clock/qcom,shikra-gcc.h b/include/dt-bindings/clock/qcom,shikra-gcc.h
new file mode 100644
index 0000000000000000000000000000000000000000..656c959c7e1251ed9af8fd04285fe616dfe9ecdc
--- /dev/null
+++ b/include/dt-bindings/clock/qcom,shikra-gcc.h
@@ -0,0 +1,263 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
+ */
+
+#ifndef _DT_BINDINGS_CLK_QCOM_GCC_SHIKRA_H
+#define _DT_BINDINGS_CLK_QCOM_GCC_SHIKRA_H
+
+/* GCC clocks */
+#define GPLL0							0
+#define GPLL0_OUT_AUX2						1
+#define GPLL1							2
+#define GPLL10							3
+#define GPLL11							4
+#define GPLL12							5
+#define GPLL12_OUT_AUX2						6
+#define GPLL3							7
+#define GPLL3_OUT_MAIN						8
+#define GPLL4							9
+#define GPLL5							10
+#define GPLL6							11
+#define GPLL6_OUT_MAIN						12
+#define GPLL7							13
+#define GPLL8							14
+#define GPLL8_OUT_MAIN						15
+#define GPLL9							16
+#define GPLL9_OUT_MAIN						17
+#define GCC_AHB2PHY_CSI_CLK					18
+#define GCC_AHB2PHY_USB_CLK					19
+#define GCC_BOOT_ROM_AHB_CLK					20
+#define GCC_CAM_THROTTLE_NRT_CLK				21
+#define GCC_CAM_THROTTLE_RT_CLK					22
+#define GCC_CAMERA_AHB_CLK					23
+#define GCC_CAMERA_XO_CLK					24
+#define GCC_CAMSS_AXI_CLK					25
+#define GCC_CAMSS_AXI_CLK_SRC					26
+#define GCC_CAMSS_CAMNOC_ATB_CLK				27
+#define GCC_CAMSS_CAMNOC_DRAGONLINK_ATB_CLK			28
+#define GCC_CAMSS_CAMNOC_NTS_XO_CLK				29
+#define GCC_CAMSS_CCI_0_CLK					30
+#define GCC_CAMSS_CCI_CLK_SRC					31
+#define GCC_CAMSS_CPHY_0_CLK					32
+#define GCC_CAMSS_CPHY_1_CLK					33
+#define GCC_CAMSS_CSI0PHYTIMER_CLK				34
+#define GCC_CAMSS_CSI0PHYTIMER_CLK_SRC				35
+#define GCC_CAMSS_CSI1PHYTIMER_CLK				36
+#define GCC_CAMSS_CSI1PHYTIMER_CLK_SRC				37
+#define GCC_CAMSS_MCLK0_CLK					38
+#define GCC_CAMSS_MCLK0_CLK_SRC					39
+#define GCC_CAMSS_MCLK1_CLK					40
+#define GCC_CAMSS_MCLK1_CLK_SRC					41
+#define GCC_CAMSS_MCLK2_CLK					42
+#define GCC_CAMSS_MCLK2_CLK_SRC					43
+#define GCC_CAMSS_MCLK3_CLK					44
+#define GCC_CAMSS_MCLK3_CLK_SRC					45
+#define GCC_CAMSS_NRT_AXI_CLK					46
+#define GCC_CAMSS_OPE_AHB_CLK					47
+#define GCC_CAMSS_OPE_AHB_CLK_SRC				48
+#define GCC_CAMSS_OPE_CLK					49
+#define GCC_CAMSS_OPE_CLK_SRC					50
+#define GCC_CAMSS_RT_AXI_CLK					51
+#define GCC_CAMSS_TFE_0_CLK					52
+#define GCC_CAMSS_TFE_0_CLK_SRC					53
+#define GCC_CAMSS_TFE_0_CPHY_RX_CLK				54
+#define GCC_CAMSS_TFE_0_CSID_CLK				55
+#define GCC_CAMSS_TFE_0_CSID_CLK_SRC				56
+#define GCC_CAMSS_TFE_1_CLK					57
+#define GCC_CAMSS_TFE_1_CLK_SRC					58
+#define GCC_CAMSS_TFE_1_CPHY_RX_CLK				59
+#define GCC_CAMSS_TFE_1_CSID_CLK				60
+#define GCC_CAMSS_TFE_1_CSID_CLK_SRC				61
+#define GCC_CAMSS_TFE_CPHY_RX_CLK_SRC				62
+#define GCC_CAMSS_TOP_AHB_CLK					63
+#define GCC_CAMSS_TOP_AHB_CLK_SRC				64
+#define GCC_CFG_NOC_USB2_PRIM_AXI_CLK				65
+#define GCC_CFG_NOC_USB3_PRIM_AXI_CLK				66
+#define GCC_DDRSS_GPU_AXI_CLK					67
+#define GCC_DDRSS_MEMNOC_PCIE_SF_CLK				68
+#define GCC_DISP_AHB_CLK					69
+#define GCC_DISP_GPLL0_CLK_SRC					70
+#define GCC_DISP_GPLL0_DIV_CLK_SRC				71
+#define GCC_DISP_HF_AXI_CLK					72
+#define GCC_DISP_THROTTLE_CORE_CLK				73
+#define GCC_DISP_XO_CLK						74
+#define GCC_EMAC0_AHB_CLK					75
+#define GCC_EMAC0_AXI_CLK					76
+#define GCC_EMAC0_AXI_CLK_SRC					77
+#define GCC_EMAC0_AXI_SYS_NOC_CLK				78
+#define GCC_EMAC0_CC_SGMIIPHY_RX_CLK				79
+#define GCC_EMAC0_CC_SGMIIPHY_RX_CLK_SRC			80
+#define GCC_EMAC0_CC_SGMIIPHY_TX_CLK				81
+#define GCC_EMAC0_CC_SGMIIPHY_TX_CLK_SRC			82
+#define GCC_EMAC0_PHY_AUX_CLK					83
+#define GCC_EMAC0_PHY_AUX_CLK_SRC				84
+#define GCC_EMAC0_PTP_CLK					85
+#define GCC_EMAC0_PTP_CLK_SRC					86
+#define GCC_EMAC0_RGMII_CLK					87
+#define GCC_EMAC0_RGMII_CLK_SRC					88
+#define GCC_EMAC1_AHB_CLK					89
+#define GCC_EMAC1_AXI_CLK					90
+#define GCC_EMAC1_AXI_CLK_SRC					91
+#define GCC_EMAC1_AXI_SYS_NOC_CLK				92
+#define GCC_EMAC1_CC_SGMIIPHY_RX_CLK				93
+#define GCC_EMAC1_CC_SGMIIPHY_RX_CLK_SRC			94
+#define GCC_EMAC1_CC_SGMIIPHY_TX_CLK				95
+#define GCC_EMAC1_CC_SGMIIPHY_TX_CLK_SRC			96
+#define GCC_EMAC1_PHY_AUX_CLK					97
+#define GCC_EMAC1_PHY_AUX_CLK_SRC				98
+#define GCC_EMAC1_PTP_CLK					99
+#define GCC_EMAC1_PTP_CLK_SRC					100
+#define GCC_EMAC1_RGMII_CLK					101
+#define GCC_EMAC1_RGMII_CLK_SRC					102
+#define GCC_GP1_CLK						103
+#define GCC_GP1_CLK_SRC						104
+#define GCC_GP2_CLK						105
+#define GCC_GP2_CLK_SRC						106
+#define GCC_GP3_CLK						107
+#define GCC_GP3_CLK_SRC						108
+#define GCC_GPU_CFG_AHB_CLK					109
+#define GCC_GPU_GPLL0_CLK_SRC					110
+#define GCC_GPU_GPLL0_DIV_CLK_SRC				111
+#define GCC_GPU_IREF_CLK					112
+#define GCC_GPU_MEMNOC_GFX_CLK					113
+#define GCC_GPU_SMMU_VOTE_CLK					114
+#define GCC_GPU_SNOC_DVM_GFX_CLK				115
+#define GCC_GPU_THROTTLE_CORE_CLK				116
+#define GCC_LPASS_CONFIG_CLK					117
+#define GCC_LPASS_CORE_AXIM_CLK					118
+#define GCC_MMU_TCU_VOTE_CLK					119
+#define GCC_PCIE_AUX_CLK					120
+#define GCC_PCIE_AUX_CLK_SRC					121
+#define GCC_PCIE_AUX_PHY_CLK_SRC				122
+#define GCC_PCIE_CFG_AHB_CLK					123
+#define GCC_PCIE_CLKREF_EN					124
+#define GCC_PCIE_MSTR_AXI_CLK					125
+#define GCC_PCIE_PIPE_CLK					126
+#define GCC_PCIE_PIPE_CLK_SRC					127
+#define GCC_PCIE_RCHNG_PHY_CLK					128
+#define GCC_PCIE_RCHNG_PHY_CLK_SRC				129
+#define GCC_PCIE_SLEEP_CLK					130
+#define GCC_PCIE_SLV_AXI_CLK					131
+#define GCC_PCIE_SLV_Q2A_AXI_CLK				132
+#define GCC_PCIE_TBU_CLK					133
+#define GCC_PCIE_THROTTLE_CORE_CLK				134
+#define GCC_PCIE_THROTTLE_XO_CLK				135
+#define GCC_PCIE_TILE_AXI_SYS_NOC_CLK				136
+#define GCC_PDM2_CLK						137
+#define GCC_PDM2_CLK_SRC					138
+#define GCC_PDM_AHB_CLK						139
+#define GCC_PDM_XO4_CLK						140
+#define GCC_PWM0_XO512_CLK					141
+#define GCC_QMIP_CAMERA_NRT_AHB_CLK				142
+#define GCC_QMIP_CAMERA_RT_AHB_CLK				143
+#define GCC_QMIP_DISP_AHB_CLK					144
+#define GCC_QMIP_GPU_CFG_AHB_CLK				145
+#define GCC_QMIP_PCIE_CFG_AHB_CLK				146
+#define GCC_QMIP_VIDEO_VCODEC_AHB_CLK				147
+#define GCC_QUPV3_WRAP0_CORE_2X_CLK				148
+#define GCC_QUPV3_WRAP0_CORE_CLK				149
+#define GCC_QUPV3_WRAP0_S0_CLK					150
+#define GCC_QUPV3_WRAP0_S0_CLK_SRC				151
+#define GCC_QUPV3_WRAP0_S1_CLK					152
+#define GCC_QUPV3_WRAP0_S1_CLK_SRC				153
+#define GCC_QUPV3_WRAP0_S2_CLK					154
+#define GCC_QUPV3_WRAP0_S2_CLK_SRC				155
+#define GCC_QUPV3_WRAP0_S3_CLK					156
+#define GCC_QUPV3_WRAP0_S3_CLK_SRC				157
+#define GCC_QUPV3_WRAP0_S4_CLK					158
+#define GCC_QUPV3_WRAP0_S4_CLK_SRC				159
+#define GCC_QUPV3_WRAP0_S5_CLK					160
+#define GCC_QUPV3_WRAP0_S5_CLK_SRC				161
+#define GCC_QUPV3_WRAP0_S6_CLK					162
+#define GCC_QUPV3_WRAP0_S6_CLK_SRC				163
+#define GCC_QUPV3_WRAP0_S7_CLK					164
+#define GCC_QUPV3_WRAP0_S7_CLK_SRC				165
+#define GCC_QUPV3_WRAP0_S8_CLK					166
+#define GCC_QUPV3_WRAP0_S8_CLK_SRC				167
+#define GCC_QUPV3_WRAP0_S9_CLK					168
+#define GCC_QUPV3_WRAP0_S9_CLK_SRC				169
+#define GCC_QUPV3_WRAP_0_M_AHB_CLK				170
+#define GCC_QUPV3_WRAP_0_S_AHB_CLK				171
+#define GCC_SDCC1_AHB_CLK					172
+#define GCC_SDCC1_APPS_CLK					173
+#define GCC_SDCC1_APPS_CLK_SRC					174
+#define GCC_SDCC1_ICE_CORE_CLK					175
+#define GCC_SDCC1_ICE_CORE_CLK_SRC				176
+#define GCC_SDCC2_AHB_CLK					177
+#define GCC_SDCC2_APPS_CLK					178
+#define GCC_SDCC2_APPS_CLK_SRC					179
+#define GCC_SYS_NOC_CPUSS_AHB_CLK				180
+#define GCC_SYS_NOC_USB2_PRIM_AXI_CLK				181
+#define GCC_SYS_NOC_USB3_PRIM_AXI_CLK				182
+#define GCC_TSCSS_AHB_CLK					183
+#define GCC_TSCSS_CLK_SRC					184
+#define GCC_TSCSS_CNTR_CLK					185
+#define GCC_TSCSS_ETU_CLK					186
+#define GCC_UFS_CLKREF_EN					187
+#define GCC_USB20_MASTER_CLK					188
+#define GCC_USB20_MASTER_CLK_SRC				189
+#define GCC_USB20_MOCK_UTMI_CLK					190
+#define GCC_USB20_MOCK_UTMI_CLK_SRC				191
+#define GCC_USB20_MOCK_UTMI_POSTDIV_CLK_SRC			192
+#define GCC_USB20_SLEEP_CLK					193
+#define GCC_USB30_PRIM_MASTER_CLK				194
+#define GCC_USB30_PRIM_MASTER_CLK_SRC				195
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK				196
+#define GCC_USB30_PRIM_MOCK_UTMI_CLK_SRC			197
+#define GCC_USB30_PRIM_MOCK_UTMI_POSTDIV_CLK_SRC		198
+#define GCC_USB30_PRIM_SLEEP_CLK				199
+#define GCC_USB3_PRIM_CLKREF_EN					200
+#define GCC_USB3_PRIM_PHY_AUX_CLK_SRC				201
+#define GCC_USB3_PRIM_PHY_COM_AUX_CLK				202
+#define GCC_USB3_PRIM_PHY_PIPE_CLK				203
+#define GCC_USB3_PRIM_PHY_PIPE_CLK_SRC				204
+#define GCC_VCODEC0_AXI_CLK					205
+#define GCC_VENUS_AHB_CLK					206
+#define GCC_VENUS_CTL_AXI_CLK					207
+#define GCC_VIDEO_AHB_CLK					208
+#define GCC_VIDEO_AXI0_CLK					209
+#define GCC_VIDEO_THROTTLE_CORE_CLK				210
+#define GCC_VIDEO_VCODEC0_SYS_CLK				211
+#define GCC_VIDEO_VENUS_CLK_SRC					212
+#define GCC_VIDEO_VENUS_CTL_CLK					213
+#define GCC_VIDEO_XO_CLK					214
+
+/* GCC power domains */
+#define GCC_CAMSS_TOP_GDSC					0
+#define GCC_EMAC0_GDSC						1
+#define GCC_EMAC1_GDSC						2
+#define GCC_PCIE_GDSC						3
+#define GCC_USB20_GDSC						4
+#define GCC_USB30_PRIM_GDSC					5
+#define GCC_VCODEC0_GDSC					6
+#define GCC_VENUS_GDSC						7
+
+/* GCC resets */
+#define GCC_CAMSS_OPE_BCR					0
+#define GCC_CAMSS_TFE_BCR					1
+#define GCC_CAMSS_TOP_BCR					2
+#define GCC_EMAC0_BCR						3
+#define GCC_EMAC1_BCR						4
+#define GCC_GPU_BCR						5
+#define GCC_MMSS_BCR						6
+#define GCC_PCIE_BCR						7
+#define GCC_PCIE_PHY_BCR					8
+#define GCC_PDM_BCR						9
+#define GCC_QUPV3_WRAPPER_0_BCR					10
+#define GCC_QUSB2PHY_PRIM_BCR					11
+#define GCC_QUSB2PHY_SEC_BCR					12
+#define GCC_SDCC1_BCR						13
+#define GCC_SDCC2_BCR						14
+#define GCC_TSCSS_BCR						15
+#define GCC_USB20_BCR						16
+#define GCC_USB30_PRIM_BCR					17
+#define GCC_USB3PHY_PHY_PRIM_SP0_BCR				18
+#define GCC_USB3_DP_PHY_PRIM_BCR				19
+#define GCC_USB3_PHY_PRIM_SP0_BCR				20
+#define GCC_USB_PHY_CFG_AHB2PHY_BCR				21
+#define GCC_VCODEC0_BCR						22
+#define GCC_VENUS_BCR						23
+#define GCC_VIDEO_INTERFACE_BCR					24
+
+#endif

-- 
2.34.1


