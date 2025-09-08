Return-Path: <netdev+bounces-220738-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C323B486A6
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7894E3C1320
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA032F39CD;
	Mon,  8 Sep 2025 08:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="SC1xmNvQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5382F069D
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319643; cv=none; b=VB7kjQIENvO5Irbdy4VLKKLYi1QCG7pJnDU1YJVAXR+EcyjNThZvFvgVrAxUe23TWJV81A+MU9Xwm/5AKkD7lBhMUaPrhkmEJ4Fr8Dl33qQBGuJcyMnoxo8I885wMB0IT7SUFKJmhjRxVRCGZvYUg4bkiMEy8chs0BOXko47gAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319643; c=relaxed/simple;
	bh=GtMkvJtKpN0l4S/TYqIWBJap6HQ5JYL7CkanzzfgJnY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TD7LZix2WKj4+cBCL1kOOpg9E1YZYbAcmtABzat8qylNiu7PLmo9CFgp8Xnfkps1jeXiyvInGTKF9U2X0FfRGg9QcrxW84UHXGF7kj68ywLiz0w0o+LlpJki31ZYKp6Y6enu+8sIjR/sjjRz+KhIK86ksbEgWWt90eJL46e9asg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=SC1xmNvQ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587NR1ai014735
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	EmVDnxU98TqnYzCFaSxLfvmX5Q/ll7vp8vhzU+iN+og=; b=SC1xmNvQPJOQXL+0
	KSFWtgUk+HOakDpWUhgtKeIQc1WWgPeoTD0DH8XVtGOsn6ZOKgJ3reo8fS9CGEaa
	MudiCDNRo0GDcVRBb5hDHDV5gNJxwzEQ70jGkWENpXcabvE4yeSWbecIN7Cf+ul2
	esivIyOlzlNmomMLmcjwhMOIN0pHargebHuA4S8mlDYJlb2ZtIDqj8y/SnpG4nWz
	vuRYTe8+ccToH9p8ECQh8XMXfqgizfTtBKUo4DlCd4PbbovKg85VsJ/lTxE1DKYR
	qavvradENblror0n/dCYyVuBrCkJG0/pB/DrOtKrwR65cAowq/0RbQanm7PpqiPy
	Kzb2cQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490dqfuq4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:20:41 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-24ae30bd2d0so39157105ad.3
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:20:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319640; x=1757924440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EmVDnxU98TqnYzCFaSxLfvmX5Q/ll7vp8vhzU+iN+og=;
        b=uTVhkaeJxrUKAVONNnXQUBpjVr07UkdRcudICpEbdfX9YMqPFKvwJNhzv0/hPY0AY6
         WNePRG0xh+NeThvSNEYAvo0zaNtm0qH7WaGQRhLwSBQvZ4YR7C457S8aERs2ZAqxY87c
         PDkrLrksvjYMP2cx5hwwAEZ8oyRrqOeEzxQysjldZx2w7HqvbkpawemAJEMSeVkzxpWH
         4mdSe/elWQHYiCNeMJGhY+nJjy+5XCLyambftBbFeBMh02dshaosretAgeWn5wZrQE5N
         913IYSulsOaxUgNp71zfk4A9gYGYdnuB0jukFT6g6A23a8tM80nFVW3TgiRHNnoaG279
         TgbA==
X-Forwarded-Encrypted: i=1; AJvYcCWSGuYuEf4gsk3BQSnd9pjJ+Fkw7wglO26nRCXVYuJOqLkQkwJlrL9mIEJCZkvmkNjcv7729uI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqKOkaDhtiWsBBgYENXRkoJr1UEXMLX3yegAQr16sKdan+DSL6
	/3+LUoh265eVUNA/rByM+esBwZ3qyPF8yOCk1cvfCIviPci3orGn0xMwJmVF6TOedBqnyKqYIXe
	I/DSvTzHUe3XMpZWQkEDo8rlQLtYnyIo99auTb8egZ2ZtudduTkjCN3UhwU0=
X-Gm-Gg: ASbGnctYkZ2S5mvJ0lZnbWKgtkS/EJfXCGrVbNnBpLjGjLzanNtjuOODFwbfrutWfX4
	i/kXxbwDWUNfxzKSdpzNgXRPlbuzOOCLcBId5gHbrGILhFmLCUcjO8GSN8i0Sk9F3VtLnxYdwi1
	8AznWW1dsu41XgA4gZCbdofqYDQRSsLQxRuSMp2sfWe0/WgELFWf4XC1n+X8rYlCgxNqd/1ao3n
	ra9h6JEHI4p3GUe9imFssNprP5P4P0e0VkjhPUunVISXZ6Z4989FFm+2i42fIqXab4nmNFwLIUm
	rmPOurCvpQTX4uMbBu20KhQAfCKrhjbVXP56aCptelaQHJ2bzf6QjGX350aARWq3zCvg
X-Received: by 2002:a17:902:d541:b0:24c:d717:71a8 with SMTP id d9443c01a7336-25172b49a1amr104521505ad.48.1757319640395;
        Mon, 08 Sep 2025 01:20:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnIkxO2hRnmTHM8DY8Yy8QL6Z8w8e2IIYZlJagoO9krVL6mQcBPeRZhU0urfOAZkEARU5PCw==
X-Received: by 2002:a17:902:d541:b0:24c:d717:71a8 with SMTP id d9443c01a7336-25172b49a1amr104521045ad.48.1757319639802;
        Mon, 08 Sep 2025 01:20:39 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:39 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:56 +0530
Subject: [PATCH v4 06/14] arm64: dts: qcom: lemans-evk: Add EEPROM and
 nvmem layout
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-6-5c319c696a7d@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1155;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=sXiH/sPxber/1Cxwi07raIsGtdfiI2L0RlmvNjYR4nE=;
 b=6ROCwfQG4lnnOWSQCa+v+ZMjsd41mzsfZOmBlGk/2/AadvqTkIzN/CxqN0DAlkXCADt4coT9l
 Zllg710W+kMD7f775FVbJZ3PLh2hrSa1tbx7YlHJ7SSXWuJZQFIj4Av
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-ORIG-GUID: Ad9svk_nhuKYKjECPuHIAPYvWWaLrOS1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAzNSBTYWx0ZWRfX2VuIKN2LfOvQ
 8JPlloXxGVKUDzJSh2ImHV8M8jiWHBHo33eZrLJOGL2RWT36dUJs87iVHJr1Np1NujrsTuYDmpn
 7/EhLVBSOFz9e2lUhiN85MhWIWUsCiu1js5jHy2KC6KavPIjbgA4Q9P8sQDT5NYwl2rCQ6or2Nt
 kozLQR2/fWMKW8obUPW1RInpLgdKNSsEZ9EC8qXJ2tG6JUXJe654XaGFwbuGgL4Pza9evVCeLrT
 2bwnpTUoS5D+AqcSrqmU+0gNUgoFMSnDK7uDDOEo8gtVUojP+z+mT79fDfeLAffUBRUM1m0DJDT
 BJYWvtIaTfEN2XnIdZAU16aFUPTX9KiPDSdj0nhX1dNf3ucE7uxyfmDrihAC8ac6KeB8ALBQVsW
 TUnYWw50
X-Proofpoint-GUID: Ad9svk_nhuKYKjECPuHIAPYvWWaLrOS1
X-Authority-Analysis: v=2.4 cv=N8UpF39B c=1 sm=1 tr=0 ts=68be91d9 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=cq19zQBcvAJi0RM8MkQA:9 a=QEXdDO2ut3YA:10 a=uG9DUKGECoFWVXl0Dc02:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060035

From: Monish Chunara <quic_mchunara@quicinc.com>

Integrate the GT24C256C EEPROM via I2C to enable access to
board-specific non-volatile data.

Also, define an nvmem-layout to expose structured regions within the
EEPROM, allowing consumers to retrieve configuration data such as
Ethernet MAC addresses via the nvmem subsystem.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index c48cb4267b72..30c3e5bead07 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -319,6 +319,18 @@ expander3: gpio@3b {
 		#gpio-cells = <2>;
 		gpio-controller;
 	};
+
+	eeprom@50 {
+		compatible = "giantec,gt24c256c", "atmel,24c256";
+		reg = <0x50>;
+		pagesize = <64>;
+
+		nvmem-layout {
+			compatible = "fixed-layout";
+			#address-cells = <1>;
+			#size-cells = <1>;
+		};
+	};
 };
 
 &mdss0 {

-- 
2.51.0


