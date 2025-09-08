Return-Path: <netdev+bounces-220736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18AE1B4869B
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 10:22:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A8E2165A12
	for <lists+netdev@lfdr.de>; Mon,  8 Sep 2025 08:21:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F2602EE616;
	Mon,  8 Sep 2025 08:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="See+D8Ax"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD0F82ECD10
	for <netdev@vger.kernel.org>; Mon,  8 Sep 2025 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757319634; cv=none; b=rtuZO6V94DHrDv2aMCS9uIqBSDDKjEaY9OdYanJuzYd4mpDTKUVFf2QWVfwNtuw34Ka8LJC26ZYH1bi2m73cJytsz583dJCCpQ9OIXZ0yYxWt+mRbyVTYR91IHDxIMoXKEzJehxjM8mppYfAzKRBfsAfOauKv27PT9QLn7WqXhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757319634; c=relaxed/simple;
	bh=ud3TuPggLahDGChDQ1o7XXbj4HVsLOYi90l9y4PcyNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z3Hf3PjTrOUT6eOmTqlMT2G4IThyAQLvaqIWQA6kTz8UOn9K5vXLeFAF6ukU5myCfRl9Hw2ON2Unbq61/EUWUfn/jrOOKbfKkgkffq+ms+4yuJMEXopD6TjOQwDa4HgdxCGjTsFD/p2JL7BSvv5mSTFDqD2fFaCYiKvJJkHYQ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=See+D8Ax; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 587MPdbg029630
	for <netdev@vger.kernel.org>; Mon, 8 Sep 2025 08:20:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Y7cNk6IecMVebr618FdTJPAEvTMA8XqQdB5/864dCQc=; b=See+D8AxF84ZaO7f
	VjLUDEfJwHPDwXoWn7kbdFH6yNWdgY7uBKAYMRKR/5giDJ7Hh02DnxtR0AFadNH7
	mz5og+gmKz/p0xruK63mZ+yhzZOmT7OCOuOzwODv7xxUHPgbcjuv6z7Df1cyApQ/
	njq5sUJP8tC+aY8K/oT1DYmXPZyrJyItgMF72IPzM/N9K2+guC65Q85+T2V+uIC2
	omzJZpL96xJaruQfltqUT2zX0bPhK8r0rJP1UyMRGSOaNYjl+BR1WVXc7U8IQZEn
	pt66e7ySgCaYUB6fLMvF9hPKhWkNpCUqFUYb3k2ujmjK3nBmQpeKSwnf1loA16L/
	vQSpmg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 490c9j3unp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 08:20:31 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-24ca417fb41so49298405ad.1
        for <netdev@vger.kernel.org>; Mon, 08 Sep 2025 01:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757319630; x=1757924430;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7cNk6IecMVebr618FdTJPAEvTMA8XqQdB5/864dCQc=;
        b=oTygeKZhZElAJ7lsoo0w5nuNh/8x6rOkqjCl9UaYgChhWIn+zVmg2e/EemFPRCGZSJ
         PSj8GLLmT8iSUUsEhSAAoRVXkp/lfdfRymW+Z7kOPgumvUJzGjW34w0Df8bDmh+8JnZw
         z+pon+P3TRAoduB7pcQlKepPfxFEM6qQsDttRcRMl5jnXEyQVlffaxLelX3ynbTQWYt6
         3n+yBOXCNMRgKB+xFrs3WqRi6HF23jUyWe4uPSbyWYlyLURNT8IT6XRU1nLC/Whvmm3o
         MP3Nf9HR4rKLHjkfOfL1gc4PGLTnYPx3BeVGjmksfM8xfx9uKQOcsnjynu4JDQlSm/Ac
         Ne0g==
X-Forwarded-Encrypted: i=1; AJvYcCVC/AI6kdVwyZksiq0ceaurP198/AhhZEUb1tGldYnufa6T9uEHB+5nQ717Tm/pKqakVbRQUM0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGtxNKyvO1QlCREeM62wTYnvtMqg4NxtthBrijREMAeUyxcIL+
	t8TfOm5NVGjZ7wdu7L0vFhFYdu07LuUzWgv6CWWVd5U6floHlEliMPfOXZurRdZh32PazRVQPeW
	o+1pIAU/1wDeCAZg/ieZkIVAWfP7x/EOlcyzqNdrX0y6hm2Msa0fYWNzZwmSvWIsZRNI=
X-Gm-Gg: ASbGncsWb6EfLG0+w024eIOoQzXVnZ0bKs9i2J0q3F10ryE/MkKmCh4l1hxOHbAfkMx
	7Gew6iMZfQ+BWJ5nxxrkX6c0TBKcQSqZOXfAbuOIhFfQWuO7BVc+Ei2Y1gK3DL0+uJYZj8hVBdp
	Tfn1WJDQIRqVvqLkOezWDZbnKHNBRA5R5j6ne7/S7rWTDyOfpCx0ZtTDtiEamnhPIiA4m8q1h2v
	h5ZM2njguR4n3sUnPQsRttfzuysXrehCZG/m/g3pMWSx3AB2G3wKhbkYxziecSYMnCvCwNd5xIx
	S0JM2Ko+X88MMzlcuQVu0KfMzkGnGmN6c+eMry6gOxiS60LiJhg4ik4ldJ5UAB01WKTQ
X-Received: by 2002:a17:902:ce8b:b0:24a:d582:fbaa with SMTP id d9443c01a7336-2516f04ee0cmr106344155ad.12.1757319630239;
        Mon, 08 Sep 2025 01:20:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEU2+Pn3pFEGWPMZXwcqWfe38DfVXT0Rgjw4TxXRkh6HKMpHekVGqpZgUJunuzabHm2j/OvPg==
X-Received: by 2002:a17:902:ce8b:b0:24a:d582:fbaa with SMTP id d9443c01a7336-2516f04ee0cmr106343655ad.12.1757319629581;
        Mon, 08 Sep 2025 01:20:29 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24ccfc7f988sm104852845ad.144.2025.09.08.01.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 01:20:29 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Mon, 08 Sep 2025 13:49:54 +0530
Subject: [PATCH v4 04/14] arm64: dts: qcom: lemans-evk: Add TCA9534 I/O
 expander
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250908-lemans-evk-bu-v4-4-5c319c696a7d@oss.qualcomm.com>
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
        Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757319602; l=1307;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=jewA1ZuLrE/ryGMwa1gffJep1WWzoOZkukzHH7TucfM=;
 b=i9UWS6iq/NvrnGVeENKuHD5pzIRUYthJoB6yM1Eyw7sVIHrJwjlTu8pkSBmTCXd9ZbMx/WCOa
 JV0jF+D6AGnDzZ94UZQCW6n+UQmZrlDbSo4PlLz3htX5eUNiirnba07
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA2MDAyMiBTYWx0ZWRfX5hK5a++WJXLw
 Yl2Bs7LePSmJ9Ho55MvuJpPmI2iHyHgqVTQ9CdPFg4pCMLgwM/DLPNO43ptDTTI7qV2bTMNsfIG
 ddp+2LzYDvjw3SRxzeTZw5Aeb4KF6YzF4/kPSkJBhGv+AgfwzdnJzsUgWjL5iZyTrEAg0YoS5Qn
 ybZ15IUNM2JFvT43hrshZaE8FGXNaw1Ai56miDoNuZyKmSRAzGo8B2COOSiMUEFcYG91GV6Zm7E
 mS+mQYFA7dA5o+oAcx89Oc3w9Q14YcFL4H6AeKSy0MSLaPk4CK+wG6+TUSwKuuATa1H5ovlsT/J
 Sdw4MkxZni4BdeUO0anTH0i3LIM7mkMMFjTJ0aXzlKGJNq0UawsFLcPJK/khCar1Jh4E2wptd6Q
 KCF6uA5a
X-Proofpoint-ORIG-GUID: aE7Ox3hZbahR8UXouNhlCCQcxkMsIhV0
X-Authority-Analysis: v=2.4 cv=PpOTbxM3 c=1 sm=1 tr=0 ts=68be91cf cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=itmwO_cg3X_j9a1xKB8A:9 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: aE7Ox3hZbahR8UXouNhlCCQcxkMsIhV0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_02,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 spamscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509060022

From: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>

Integrate the TCA9534 I/O expander via I2C to provide 8 additional
GPIO lines for extended I/O functionality.

Signed-off-by: Nirmesh Kumar Singh <quic_nkumarsi@quicinc.com>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 arch/arm64/boot/dts/qcom/lemans-evk.dts | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/lemans-evk.dts b/arch/arm64/boot/dts/qcom/lemans-evk.dts
index 56aaad39bb59..c48cb4267b72 100644
--- a/arch/arm64/boot/dts/qcom/lemans-evk.dts
+++ b/arch/arm64/boot/dts/qcom/lemans-evk.dts
@@ -289,6 +289,38 @@ &gpi_dma2 {
 	status = "okay";
 };
 
+&i2c18 {
+	status = "okay";
+
+	expander0: gpio@38 {
+		compatible = "ti,tca9538";
+		reg = <0x38>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander1: gpio@39 {
+		compatible = "ti,tca9538";
+		reg = <0x39>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander2: gpio@3a {
+		compatible = "ti,tca9538";
+		reg = <0x3a>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+
+	expander3: gpio@3b {
+		compatible = "ti,tca9538";
+		reg = <0x3b>;
+		#gpio-cells = <2>;
+		gpio-controller;
+	};
+};
+
 &mdss0 {
 	status = "okay";
 };

-- 
2.51.0


