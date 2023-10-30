Return-Path: <netdev+bounces-45204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 076A67DB66C
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 10:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39C581C20A3B
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90647DDC1;
	Mon, 30 Oct 2023 09:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lRovHzCI"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12ACDF63;
	Mon, 30 Oct 2023 09:47:56 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9344B103;
	Mon, 30 Oct 2023 02:47:54 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39U70hNN026890;
	Mon, 30 Oct 2023 09:47:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : date :
 subject : mime-version : content-type : content-transfer-encoding :
 message-id : references : in-reply-to : to : cc; s=qcppdkim1;
 bh=6Uy1lHvNkZbFXTw54nBi6xD71h6W0UhVX/V3hiEankg=;
 b=lRovHzCI6gIUNv+GjVUoTBQegV9IhNs3ZNDK941nW+TopDjZ5V6A79rzUyTm+LavxJoQ
 ejz8JsC6yKx0EsvGw78/Zkv7SQ+AeqR53GekKFdlFUzI7W2Zeh/NR7bm4PTZVgyZPdmp
 BpxTVVjNQyp//wffdPkL9Z5MtveH1JANzype0ZbySPz19aurSv3+boSHqDzXu/bnkeVp
 vnCvsKwKrA+01sFU2Iph8zXF2HYsv2RaX6yDvRQtKOQQcOvbnWv1cPcK9821rFzZJM42
 6oYg37eD2P7DdFoD4Olz3AxQUTsKWBzJXPPGIxwOJcDuRFQg7dsv50G1jDAh5m472/bO 1A== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u0tphue0p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Oct 2023 09:47:42 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 39U9leNC031294
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 30 Oct 2023 09:47:41 GMT
Received: from hu-kathirav-blr.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Mon, 30 Oct 2023 02:47:35 -0700
From: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
Date: Mon, 30 Oct 2023 15:17:17 +0530
Subject: [PATCH 2/8] dt-bindings: clock: ipq5332: drop the few nss clocks
 definition
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20231030-ipq5332-nsscc-v1-2-6162a2c65f0a@quicinc.com>
References: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
In-Reply-To: <20231030-ipq5332-nsscc-v1-0-6162a2c65f0a@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette
	<mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring
	<robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        "Kathiravan
 Thirumoorthy" <quic_kathirav@quicinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698659244; l=1324;
 i=quic_kathirav@quicinc.com; s=20230906; h=from:subject:message-id;
 bh=5t1crxdnVdF/q1ZP8avNT9Pk+9XUyieoSwwl5zLjqhY=;
 b=y6+m37yrQZAmeu84hHC9nSBmPpLl2tjh+iHq6kVChz1yQbr04XPntyMPFufyc/CaUB5scs0BX
 iRPqH1NCCeOAYsGB+zvZQxokNrbJ1rGOwuh0LswAOzJwXOb8nevVadx
X-Developer-Key: i=quic_kathirav@quicinc.com; a=ed25519;
 pk=xWsR7pL6ch+vdZ9MoFGEaP61JUaRf0XaZYWztbQsIiM=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Ec0Ovi4UWC_cZBJjT0P-pDkOxxIu8AK5
X-Proofpoint-GUID: Ec0Ovi4UWC_cZBJjT0P-pDkOxxIu8AK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-30_08,2023-10-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=764
 spamscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0 clxscore=1015
 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2310240000
 definitions=main-2310300074

gcc_snoc_nssnoc_clk, gcc_snoc_nssnoc_1_clk, gcc_nssnoc_nsscc_clk are
enabled by default and it's RCG is properly configured by bootloader.

Some of the NSS clocks needs these clocks to be enabled. To avoid
these clocks being disabled by clock framework, drop these entries.

Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
---
 include/dt-bindings/clock/qcom,ipq5332-gcc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/dt-bindings/clock/qcom,ipq5332-gcc.h b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
index 8a405a0a96d0..4649026da332 100644
--- a/include/dt-bindings/clock/qcom,ipq5332-gcc.h
+++ b/include/dt-bindings/clock/qcom,ipq5332-gcc.h
@@ -55,7 +55,6 @@
 #define GCC_NSSCC_CLK					46
 #define GCC_NSSCFG_CLK					47
 #define GCC_NSSNOC_ATB_CLK				48
-#define GCC_NSSNOC_NSSCC_CLK				49
 #define GCC_NSSNOC_QOSGEN_REF_CLK			50
 #define GCC_NSSNOC_SNOC_1_CLK				51
 #define GCC_NSSNOC_SNOC_CLK				52
@@ -124,8 +123,6 @@
 #define GCC_SDCC1_APPS_CLK_SRC				115
 #define GCC_SLEEP_CLK_SRC				116
 #define GCC_SNOC_LPASS_CFG_CLK				117
-#define GCC_SNOC_NSSNOC_1_CLK				118
-#define GCC_SNOC_NSSNOC_CLK				119
 #define GCC_SNOC_PCIE3_1LANE_1_M_CLK			120
 #define GCC_SNOC_PCIE3_1LANE_1_S_CLK			121
 #define GCC_SNOC_PCIE3_1LANE_M_CLK			122

-- 
2.34.1


