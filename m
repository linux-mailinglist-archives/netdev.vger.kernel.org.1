Return-Path: <netdev+bounces-220018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C40DCB44347
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CEB7188EDEE
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F157631DDAF;
	Thu,  4 Sep 2025 16:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cQykeKbh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9FB31E0FB
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757004003; cv=none; b=DB1vTdTfZBgQmojy0+CUB939uOp2UkO5eiUiNiborFM0UY6zbvj8i3RemCaZZ+Dmwyq3D/eRR8VM2by+f2zMq7NIAtmWAeeR+bP1lt0O1AFO6ccMlvsULKsnmLG0teE5V9dUJfyVwaw9dC+A7Cr6QB9ZUf2/seZXx50LvzSfrFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757004003; c=relaxed/simple;
	bh=Z17R4uxUgU+bBwcNXl4EOOFcTTKHC04Ru6ei0RAupaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t7nnzjjxTkWnC3uMiCU5tsVBiPKorY+6AoG3XfSZaPKsNvuqYF0xvCZxowbZklgLLtsGHP1M/6jDOAjAdpHiygr/wAXgpcAKIl5EJ68IyiBoR9J5Xcvou2zVfcCBab21mKjijRPOAFAUfNRGm+iptlcqb39fuLBgHy+ZzGO0zvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cQykeKbh; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584GV3rd018660
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ykjIJ/h7cv7PVigxcwlijPGxTqDBl4Xmlevg1Vg/7XY=; b=cQykeKbhoL0yn21P
	Y8X/m1b4TwbKZOf7eFDv/XelBpBXiwG7rnOpPr7ecnqd/c/OjGZ2spiz+Ort8Qm7
	3oOqcIPMP23f0RM7EB8F6cy9tnZtocGFKtuyZRJm9E38I7uo2QreUwLcmcwHNcio
	lRqFldMUnMj4J3LHHJyZ70GlVI5hRweA7WkUm8SBfSt/xoB1nNphYCVNZzdRCAFT
	890K9Q6FXcW07BmKd4cJMk56I9VLUKgC+cc+HlzB+kV0KhBA3l9ErhjcWovRLE8D
	WoYecHq5mMPuOLg4LPBhqUHZ1RrNKcNJGWzmGvRZtBvLxEIWxos80ui/4bx8Gz8e
	bvFZ8A==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48yebur16c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:40:01 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-b4fbe29e44bso800022a12.1
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:40:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757004000; x=1757608800;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykjIJ/h7cv7PVigxcwlijPGxTqDBl4Xmlevg1Vg/7XY=;
        b=NumCfG4w7RnFWVWOEQxVcC69aIQQr2VfeUiZToSfn1H+QSpqZ4ymBHuZawmPksVzaN
         8x2fg9vNOCeEGsJcTLHLEeRcDyusaBv+2PU5RoffhjJA8OoNGFrnpVpkmrw+ql36c3fy
         +DPwYuWJId67xVWXqpY+9GEMaY67q7wfQbC9n751rmQsbCI/1N5gomMGSpdcl11soEx6
         T3N2rIh6FlF7U4IgUMJCbbUiHPkURXPT6s+HhuqSp7ZsPFv76bD0k7+cN9QlwTVioqmi
         rsyT4als98bIXpNakjkOy6IcROJxcliAt+pRCXzgdfqJdVOVBTqhZdNmP+SsDYBuu72j
         Phiw==
X-Forwarded-Encrypted: i=1; AJvYcCUyAT7JpSl+13M8nrJ4KQSkNEdT4d7LusM9++cYaXIcigB7J4oepSw02Zbt8jS7IHbCA9u0fSU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNgpbrQKt8yEDJViFFzyyZSbB73AFVrL+ONcIOLY8EESVVGjRq
	lC7u3/o4P3E+SW7OdIfaaKbQyvMfrEnIVkQ2eTycefAD04Lm36nKFINacTBZvAkbT9644YGcZRM
	QpWtRf963/rO5n6+a3E5pzRaFARfj4/P9yfUAob5M85kcJIEjdyvWubgixCY=
X-Gm-Gg: ASbGncuE0LUZiCV6rdI8WDG352UUFIWLsbJKOsZA+R6CbWlKBRyTO6h24xBNLn3P8wx
	SY6lhWeIrmPm+pAI0cfFJS2q89h9u1uGFKbXWyuR1Bnnpbs02pNDinZrazE+y1kCec9yJ57e3FJ
	bltEPNb+T+Sxh0LxZejRVcu2QrcW6MM51jPNgG4tqQgi1jQMrK2o64boXtdFxvFNgJ1UmklHpLT
	waocQPbrYqtcL8ySiEhkt9gS+ikbBZrkfmlGXFmpHDBhqU8Jh1Eln4lo2Grv1T64HWw1c9Y8j0Z
	cRu8OJb92SorEXF8oVNbZNoM+aXbW27lGpXhGlgX5I1dlLqjkm94fUQCljLR6mE+rSZ1
X-Received: by 2002:a05:6a20:38a0:b0:245:fbee:52e2 with SMTP id adf61e73a8af0-245fbee5703mr12170874637.36.1757003999963;
        Thu, 04 Sep 2025 09:39:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3yfPjFoXT4zW9IB0D+yJDheXIOMZ6xE5nc9ficLH7236+y8wL6rRb8AwET6KzJXDdeLk4+w==
X-Received: by 2002:a05:6a20:38a0:b0:245:fbee:52e2 with SMTP id adf61e73a8af0-245fbee5703mr12170806637.36.1757003998820;
        Thu, 04 Sep 2025 09:39:58 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:58 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:09:04 +0530
Subject: [PATCH v3 08/14] arm64: dts: qcom: lemans-evk: Enable remoteproc
 subsystems
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-8-8bbaac1f25e8@oss.qualcomm.com>
References: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
In-Reply-To: <20250904-lemans-evk-bu-v3-0-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1181;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=Z17R4uxUgU+bBwcNXl4EOOFcTTKHC04Ru6ei0RAupaI=;
 b=6wJJPLyeumdxPLCldgh1JOuob6GxTwr8kMoGGD6GLMkZW8vNN/3nshAnmnbA3DbR+4Ey8ngm9
 kyFXXI26djnAJbLFGIm4NztHyRSyViW35R1jwZLpy2wWw1zo5nKNT6O
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: Y7O-3UeDKcObVbK2HQUcJaTm_eqHXS05
X-Authority-Analysis: v=2.4 cv=X+ZSKHTe c=1 sm=1 tr=0 ts=68b9c0e1 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=EUspDBNiAAAA:8 a=08pr6S3s0jzPFaFj3AwA:9
 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA0MDE2MyBTYWx0ZWRfX3whKIM82HYlx
 /b92yGyIZ7WZZzqh+41NZXZXjqA6BjycLaGAaZm9UE3c1sGpmmZQwIDKZ/NZa9YGWkyCZD8cy6J
 dOBFkY8iMZshE436Q9lu/7ZabP573dm2xbquO3jt9WXWYfn5T9zEMzx8Y6wSu4li4nLmCfI/Z1S
 mBtD68B4Azj4fKaa+2/A4Hmf/TzGGh4DFMexneETDshnV080M/jKLyBLn/5IMVFK1mZB+LOknDC
 XA5sL55iPLhXGxSQec4cRSPf8+i5jWCTF2A0cfRe77Ayb/UY2CtIARubNibSQ0hMOwh/HB3oRQ1
 +AdON8Muy94jTm/UrhgvP+9EleNzbwlaqA1RIhIt0aXfaolPGSam7FLp6vRF3LRJZN2u9UIUVUV
 s7+avrIz
X-Proofpoint-ORIG-GUID: Y7O-3UeDKcObVbK2HQUcJaTm_eqHXS05
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509040163

Enable remoteproc subsystems for supported DSPs such as Audio DSP,
Compute DSP-0/1 and Generic DSP-0/1, along with their corresponding
firmware.

Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 17ba3ee99494..1ae3a2a0f6d9 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -425,6 +425,36 @@ &qupv3_id_2 {
 	status = "okay";
 };
 
+&remoteproc_adsp {
+	firmware-name = "qcom/sa8775p/adsp.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp0 {
+	firmware-name = "qcom/sa8775p/cdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_cdsp1 {
+	firmware-name = "qcom/sa8775p/cdsp1.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp0 {
+	firmware-name = "qcom/sa8775p/gpdsp0.mbn";
+
+	status = "okay";
+};
+
+&remoteproc_gpdsp1 {
+	firmware-name = "qcom/sa8775p/gpdsp1.mbn";
+
+	status = "okay";
+};
+
 &sleep_clk {
 	clock-frequency = <32768>;
 };

-- 
2.51.0


