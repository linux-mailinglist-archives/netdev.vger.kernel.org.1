Return-Path: <netdev+bounces-220744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF6A6B486CF
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B2E3A2407
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F6F2FC88B;
	Mon,  8 Sep 2025 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Ghv8pI1J"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1962FB0AD
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319675; cv=none; b=lrVtZS9SnJrtDMpeUbl7fzO3wcOmixEyy31HCjfGF+3BgKG/8kJdatL1Df+b7/tb7kARjBKvpzJXgXTz4OmxOi4e6/hhvRHQMd1CLKScXhimBWrk1Kbncd5ormO9MfIu2WYOCLXLywv5NyExrhoX05ifsAYRqOXid2p69QRn078=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319675; c=relaxed/simple;
	bh=ynWWfmuOZH738K5h1hVDK+fLyCGdjyFsLL3ly6nUHqo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KxCH0KbHqOeIiHF6XlqdyiOxAcy79sTk5Nawr17QozWmzkIti+1pvjLrrBiBwyHxtm9PAbTRiw48gE+hUhFqukOGJ1U+sA6MlYH+KDXm7rzER+ZFxdrF1NB75WTt3Hydq2pqs0vqfe4TN7NY2fCiCXJE+Ew2+0YnTjE8sjQQw/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Ghv8pI1J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5880Uqc0007130
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:21:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kUehLoxPYFguIke0YZr7WflOvoeqoE8uy3ntTtXR3EY=; b=Ghv8pI1J01x6qXlw
	EDFuRbumT1PoHo+5KtQGm86gkFXXo66O9ee6HrQNcwLjLIaVUU1v1lEdZeLDNU9M
	b7vCz2hsWH573BT+aBipWZYL3e1WccaB+kOyRitLKR0pT6Qk422BG4M6F+QsLha1
	pVFwVmmVPsiVdmiTCljagLT3vMbWSG2lEPPeObUDOucaYgfwpNPv61qLjnUAYvr8
	neR2DO2tu6asW5qJBHLVw9Biy49s6UDyvnaJFDwwRSEpXMHhOMei5a0p3kuLV6Fy
	r2NY5BwpYEL4EigavpcrkqZuBpoajtCITuwJN3r/BhS1scKN45ewzrFtg//nbObx
	3reN9g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490e8a3pbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:21:11 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-b4fc06ba4c1so3193386a12.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:21:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319671; x=1757924471;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kUehLoxPYFguIke0YZr7WflOvoeqoE8uy3ntTtXR3EY=;
        b=Tca+RECLXgXZA3jnludn98Zrkp8aV6k/rBFPItqxvyX6QVdqtrbxHyAl4bjfcESNlL
         FzAHmBLRUVpkGc/LoVuv3Fcw1w2kVhW9JLNbmPWxwG/yYmG9XWgAY1xplpIvZGmb6mpA
         kYEI9MliTjI8aPrUp2OVJgVwHxaijIu+rJ3ZxyvWwUWIq7XmXbpcr0M73g9tjZK9RfZS
         oQArA2ZMGZbJnVqw9BAgk/b1A/hd/zgRMh9l6KYeStSVszMJDWL2pA/66ODjU5UVSH6W
         p+7Spq8YnnImhLrtjNxoQQkLn9Rh5EexRDh9bseml9YGiRRY1IoCrluZlOgFqkSiEayw
         EkAA==
X-Forwarded-Encrypted: i=1; AJvYcCWEePn3oZbKG9ymB4WT6jZOsJP5sAJt51f6MIA3V8vbFScx+HEH2zI1s/xiCd1KeI9ZOiwhNao=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnw5WDDLlAPf0MLbvIxhB2eeaLTcmWckPnmi4mNtb8KP3fnZk8
	GQLajlWFzqftjftOoxmyLr5c4tjiSijIi1TDh4t34ZSVQkINOrqrCwPspBASIlhrE8h4uUrUqO2
	aL5aX/N1trJGzaNiFyqMDJzKflHzl4NgOux0IT0v9AR5HYIk37J/sgG2+eTo=
X-Gm-Gg: ASbGnctbhZo7Ol2nDe9WUY6JyR7QuwjCPpcpQUtjjofIwePfAHJOi4fH5aIAR/AVJas
	cpJgjYnqE3I8hed9HW2d8vnRRIvESYYzAx3G122Ka4FhCdS7c8u1QdOE5OVgzyye/TLGwo0NGzi
	cNVcAuvf/D8wGZFyAqYtQuXFnYoXtiIF/+TBQcHNDQy8kIQVcApmIJtXElFY3EUU+dplpIhr8uW
	XC+BCHFVYE/q+kU0O8i1BeV1dTJbK/sFoCmOkIszVk1seQisJiVTsr3WfrVVzw3BM/ST9k5cd/L
	1nboo+5EZ9Qg3HJxYhyLxLeQJaG099es5tFKmruDSj1gxp+C7/WeeTUPoxGKkH/BmoeS
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr90918725ad.29.1757319670780;
        Mon, 08 Sep 2025 01:21:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGUtcSUkOkO+dTfuatcYwsPYrubU+qI8Lp/5D/7A6MAMWz8SmZSETwtGcwyZVbO8TqpPMEBRw==
X-Received: by 2002:a17:902:e5d0:b0:24b:2b07:5fa5 with SMTP id d9443c01a7336-25172291ab5mr90918415ad.29.1757319670296;
        Mon, 08 Sep 2025 01:21:10 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:21:09 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:50:02 +0530
Subject: [PATCH v4 12/14] arm64: dts: qcom: lemans-evk: Enable 2.5G
 Ethernet interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-12-5c319c696a7d@oss.qualcomm.com>
References: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
In-Reply-To: <20250908-lemans-evk-bu-v4-0-5c319c696a7d@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc: kernel@oss.qualcomm.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
        linux-i2c@vger.kernel.org,
        Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=3663;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=T8ZZhZAuKSNtjHcghH+T9PxS/Yw/QtH5Z1v/0Byz0pg=;
 b=Me+SBvge5FuSQ1h8JklnOvj+EWfveHntHOtpm/71ellh1kiesdCWibSliFZA3LDIZIkIId9KS
 GCSUJXHdIjIDvfCH1de1UK++8Mbfu+gi1CF2V632Znhm1E0jw896p39
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Authority-Analysis: v=2.4 cv=H7Dbw/Yi c=1 sm=1 tr=0 ts=68be91f7 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=z9nD9lg9_nmlpaFE3BIA:9 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: 6EdfbZ1_vnGbnbupk_finTbyeNSxFjdF
X-Proofpoint-ORIG-GUID: 6EdfbZ1_vnGbnbupk_finTbyeNSxFjdF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzOSBTYWx0ZWRfXzTo7c/z0sZrV
 oz6sQaN8qVUb0zXENjxhlme01IENFrizUh3wezAXd9bxFPnSTCq7BaPhAs/qtqs8XDXryrJHNOt
 sq5wHRDFgvNLBZE6Iz7fynB07ZcT8PEokfSxeAIuGDhXxE9sG3/iUyTDBXmPcHkHcwH67IDEwem
 CsmncHq+1/foYjZTAKPTFBhenHh21HuFvBLWrano3Ea2LF/BLFsiSg9igsPjZfIDjSHTBOnQT5u
 wIQB/jo1YGPHKivcqnMxznTXVOK+WEJY1Hb2AJrGwvpRwszVSWODsJ5fP9hKx6pPXIz5cYxkOu+
 G2WAU1mGDauc16DTr3pqhwtRnqc10/Xi1nSoADXSy/CbwkwYZvPP2qiSzwn/S6zll8Xgo/kZy3D
 irAfZTAt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0 phishscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060039

From: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>

Enable the QCA8081 2.5G Ethernet PHY on port 0. Add MDC and MDIO pin
functions for ethernet0, and enable the internal SGMII/SerDes PHY node.
Additionally, support fetching the MAC address from EEPROM via an nvmem
cell.

Signed-off-by: Mohd Ayaan Anwar <quic_mohdayaa@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 115 ++++++++++++++++++++++++++++++++
 1 file changed, 115 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 60e365a13da3..3e91ac928fa5 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -16,6 +16,7 @@ / {
 	compatible = "qcom,lemans-evk", "qcom,qcs9100", "qcom,sa8775p";
 
 	aliases {
+		ethernet0 = &ethernet0;
 		mmc1 = &sdhc;
 		serial0 = &uart10;
 	};
@@ -300,6 +301,94 @@ vreg_l8e: ldo8 {
 	};
 };
 
+&ethernet0 {
+	phy-handle = <&hsgmii_phy0>;
+	phy-mode = "2500base-x";
+
+	pinctrl-0 = <&ethernet0_default>;
+	pinctrl-names = "default";
+
+	snps,mtl-rx-config = <&mtl_rx_setup>;
+	snps,mtl-tx-config = <&mtl_tx_setup>;
+
+	nvmem-cells = <&mac_addr0>;
+	nvmem-cell-names = "mac-address";
+
+	status = "okay";
+
+	mdio {
+		compatible = "snps,dwmac-mdio";
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		hsgmii_phy0: ethernet-phy@1c {
+			compatible = "ethernet-phy-id004d.d101";
+			reg = <0x1c>;
+			reset-gpios = <&pmm8654au_2_gpios 8 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
+	};
+
+	mtl_rx_setup: rx-queues-config {
+		snps,rx-queues-to-use = <4>;
+		snps,rx-sched-sp;
+
+		queue0 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x0>;
+			snps,route-up;
+			snps,priority = <0x1>;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+			snps,map-to-dma-channel = <0x1>;
+			snps,route-ptp;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x2>;
+			snps,route-avcp;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,map-to-dma-channel = <0x3>;
+			snps,priority = <0xc>;
+		};
+	};
+
+	mtl_tx_setup: tx-queues-config {
+		snps,tx-queues-to-use = <4>;
+
+		queue0 {
+			snps,dcb-algorithm;
+		};
+
+		queue1 {
+			snps,dcb-algorithm;
+		};
+
+		queue2 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+
+		queue3 {
+			snps,avb-algorithm;
+			snps,send_slope = <0x1000>;
+			snps,idle_slope = <0x1000>;
+			snps,high_credit = <0x3e800>;
+			snps,low_credit = <0xffc18000>;
+		};
+	};
+};
+
 &gpi_dma0 {
 	status = "okay";
 };
@@ -352,6 +441,10 @@ nvmem-layout {
 			compatible = "fixed-layout";
 			#address-cells = <1>;
 			#size-cells = <1>;
+
+			mac_addr0: mac-addr@0 {
+				reg = <0x0 0x6>;
+			};
 		};
 	};
 };
@@ -500,11 +593,33 @@ &sdhc {
 	status = "okay";
 };
 
+&serdes0 {
+	phy-supply = <&vreg_l5a>;
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };
 
 &tlmm {
+	ethernet0_default: ethernet0-default-state {
+		ethernet0_mdc: ethernet0-mdc-pins {
+			pins = "gpio8";
+			function = "emac0_mdc";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+
+		ethernet0_mdio: ethernet0-mdio-pins {
+			pins = "gpio9";
+			function = "emac0_mdio";
+			drive-strength = <16>;
+			bias-pull-up;
+		};
+	};
+
 	pcie0_default_state: pcie0-default-state {
 		clkreq-pins {
 			pins = "gpio1";

-- 
2.51.0


