Return-Path: <netdev+bounces-220011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A708B4431A
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 18:40:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439191887475
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 16:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A697D2D47EB;
	Thu,  4 Sep 2025 16:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UKd0cMjd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EF3303C9E
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 16:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757003969; cv=none; b=YPjPATXGbXixQSXQxzK6F/jYCa1NkFXM3HgjORaeMF73R7gJBfNzzzTQ8OkesSDEc8TNpZKEMmynBSah9ExCjW2KWgGD1unNePBEXqyYAwiaoVMpZHMiw+ovsiIzQ2l1ET/hNjFw7owjzN0nPrxSvCSwxDi7/DMEnJFdr+umH9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757003969; c=relaxed/simple;
	bh=3BT/6suhK8eSmSdIpvmvry+itcjPvXCIyXUxFeuJLYU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MT7UAqHxkXyhYgFs/WrrYhY5jHB6DRXTG2BQpQlI3tFPpAnPF7QSp5ojOsDOTbjZVSxk4SlgxQL8bGA7jC9yCT+M/zR01W2O+Hu5J0AQtBjn3XvZlKSFZmBMTQWHmQf5GryXsLFjHKTgmKa8keI+076eJkFOyGGbMA2htf579ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UKd0cMjd; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5849X8E9022162
	for <netdev@vger.kernel.org>; Thu, 4 Sep 2025 16:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=; b=UKd0cMjd164/BbZ8
	HNbEVGUdupqCPi+kgq9f5KQ3243KNWrjqAGcZMgH7U7xlTxalBoMek7zG2Wps/8j
	FYZK2LW5PTU6saOXPwYg0Nqfh37cHYr7ya0tFReFTx563LWIN5vu1CWBTKFgho75
	YKEcLWaRPYRNrarwX4Lj5UXKHeRDKUkznQ4C7I8wrOybvQidVUGSkU36Aj3LhQZC
	i0MMlqKmsv8cHxBRMPzoRlDAsOJskmUYH7llehYV6cWW/K9A4yweZmxPIvGsHEWI
	UVVKzDavkZ2uXuh+GQqauG/Mp66oTDal/yXABXWDIC7YsE9yjuX4/Tdjb8YFinNk
	gp4fxQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48utk981d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 16:39:27 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-32bbacf651cso149478a91.0
        for <netdev@vger.kernel.org>; Thu, 04 Sep 2025 09:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757003966; x=1757608766;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2CWTa+iMUq/YNjoKRpUPGDy30w7e4E4JjtRdeNVcgm4=;
        b=nkIPbkAOXTJVcv/Eh8pt4pC2El7mFGc2J7LCCLgIOZM2Xb6Z8pbKnsvCTZn7Geh0R9
         CeSFxWJwj83YfQ4Jq6xRRhjfVbl8t/3qS87okQ0vqmEC9tQSz70jVzPhnE6EP0tmQGah
         pgJgdyEAg8cGV7jJ3WIST34wD/Sdz21aKRJ6vRHBjrHrIsU4kaV+Fca4CpTgf7eg6IlH
         HOxuv6dLi6IQkgcpM4ry4dGDsifCni9vOsafWgwMd1vSm1wqlzyXxgJP+f2ay8SafFbt
         vIjk9EiPH0p5uLL+GPwRHPl6bdiKijVG1//sL37IlDv/I3y+a81f0IOTFxsdToS2am95
         hRHw==
X-Forwarded-Encrypted: i=1; AJvYcCU2slDd1eBtjblyNivhWdYVRYB3BEuxv4WcgVqir+mh4fXlstd3WY5OgCj33dKexeX3NCMFsX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeNIdsYwKx4De+6JzFNbZ6JEqTmBoRfDepnIE1eMCupulfluYS
	yfHJatigf2Y73Sj5ut9ekR452xg/Wj9u/eIuwFHGAfz4bGRVBREWFN9r9YqK5rUYUPkkIcQFAK5
	YPSdnBcagbdaTJa8vRfHm3Dy7v43O6wZiVwwzFmGrQa7jk8j0LIlZJfempu6JXB3jeTo=
X-Gm-Gg: ASbGncvdFvfZkQsIn1gk3w/rSRz4UEubL2bfqqIUtm+/GAzxX1kTuWvW9vV8bv6vaY1
	mr5XxX3cPK04NeclOXJWtFPIDgCHoh8hcTgdcxUY12xHlBD5oUJD5DS6VwAfNx2I375kxA/oNOu
	DaXfy5660AnnpO7W8HoOPn6jmUE4bX0A74EKl0qK4mhaUEzS6n0b+uctvN2V1LmhbEej2o48Pyv
	fmtf3E/KrLZonTxF3z+osi/q8fRhwsfCX4+vINKA3hWMhce7QuDkMDnPVif3ddmWcqCFHlulIjo
	cWGGGvradtnidUlfrnEb+qsipQmJpLQbYRmjSQAkkoEcoQYaU+NRIqQBLh7wQWiLcH0/
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr293533a91.2.1757003965998;
        Thu, 04 Sep 2025 09:39:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDysS+g0JZmVZmToh9tFIcpTJv8ha6RIvIwKxET4j1oDI7WQvl3Edcqg5NJKS5BBiqkUPp4w==
X-Received: by 2002:a17:90b:2d8d:b0:32b:baaa:2a93 with SMTP id 98e67ed59e1d1-32bbcb945e0mr293495a91.2.1757003965494;
        Thu, 04 Sep 2025 09:39:25 -0700 (PDT)
Received: from hu-wasimn-hyd.qualcomm.com ([202.46.22.19])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4cd006e2c6sm17346371a12.2.2025.09.04.09.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 09:39:24 -0700 (PDT)
From: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
Date: Thu, 04 Sep 2025 22:08:57 +0530
Subject: [PATCH v3 01/14] dt-bindings: mmc: sdhci-msm: Document the Lemans
 compatible
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-lemans-evk-bu-v3-1-8bbaac1f25e8@oss.qualcomm.com>
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
        linux-i2c@vger.kernel.org, Monish Chunara <quic_mchunara@quicinc.com>,
        Wasim Nazir <wasim.nazir@oss.qualcomm.com>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757003953; l=1190;
 i=wasim.nazir@oss.qualcomm.com; s=20250807; h=from:subject:message-id;
 bh=z9TI86piqLkEr60N8aHlg5lL/hJiHyO8LgOhxGhTRpk=;
 b=0/sdwS0aEk7K/4iQNj2K6mKUxiyzvbZtRvG2f1VMV2jqu9zimljBsho2c4cnPjvLldMuPOcCn
 oEvvjp4y5DfDAvsR59uCDcgwrwr22Cuau1UH1lvAcXiJstwFS893Dct
X-Developer-Key: i=wasim.nazir@oss.qualcomm.com; a=ed25519;
 pk=4ymqwKogZUOQnbcvSUHyO19kcEVTLEk3Qc4u795hiZM=
X-Proofpoint-GUID: yFll4fCjSs_3j-JFNIkHlRKiJJ385Oi-
X-Proofpoint-ORIG-GUID: yFll4fCjSs_3j-JFNIkHlRKiJJ385Oi-
X-Authority-Analysis: v=2.4 cv=ccnSrmDM c=1 sm=1 tr=0 ts=68b9c0bf cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=fChuTYTh2wq5r3m49p7fHw==:17
 a=IkcTkHD0fZMA:10 a=yJojWOMRYYMA:10 a=COk6AnOGAAAA:8 a=EUspDBNiAAAA:8
 a=oyqPBBxx3V5-Y59TF94A:9 a=QEXdDO2ut3YA:10 a=rl5im9kqc5Lf4LNbBjHf:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDA0MiBTYWx0ZWRfXwLS/p2Y1injL
 DKLR1E9+OZnM8CExqhi1RPUvOZvXISkaLpVNCSa5Kt/okRNLdu0VwcNttUn1GpyNgnVDdyv4Udp
 sW5R68R3fvD97EfgWEKqT6i2UZQS86bn/oJtqf3C8YOh077xdfs4/2vyMDLz/j3EO3d3HFNgE5z
 vu07jUlExd3qiGpQvxpMJ66VQhGZzcKBA9egWIlCpx0nkrb9yzZ8SEdEjF4/75PmpZhg0hjmPAp
 04y/udUDrdLbcPmPrk76VYLfRXZcD/XtO9JNeWjp7lFkF0U14X8ReZ697KJ42Sc1ii5X4ZHZGyS
 heJj03C7qhrJLN0XcjPPw2toa+Jww+1gPSFhrrMrZlTu5PDFqvJCqRQCJ2/V5Y0c9JbAUykc8l6
 vyJIUnuZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_06,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 spamscore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300042

From: Monish Chunara <quic_mchunara@quicinc.com>

Add the MSM SDHCI compatible name to support both eMMC and SD card for
Lemans, which uses 'sa8775p' as the fallback SoC. Ensure the new
compatible string matches existing Lemans-compatible formats without
introducing a new naming convention.

The SDHCI controller on Lemans is based on MSM SDHCI v5 IP. Hence,
document the compatible with "qcom,sdhci-msm-v5" as the fallback.

Signed-off-by: Monish Chunara <quic_mchunara@quicinc.com>
Signed-off-by: Wasim Nazir <wasim.nazir@oss.qualcomm.com>
---
 Documentation/devicetree/bindings/mmc/sdhci-msm.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
index 22d1f50c3fd1..594bd174ff21 100644
--- a/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
+++ b/Documentation/devicetree/bindings/mmc/sdhci-msm.yaml
@@ -48,6 +48,7 @@ properties:
               - qcom,qcs615-sdhci
               - qcom,qcs8300-sdhci
               - qcom,qdu1000-sdhci
+              - qcom,sa8775p-sdhci
               - qcom,sar2130p-sdhci
               - qcom,sc7180-sdhci
               - qcom,sc7280-sdhci

-- 
2.51.0


