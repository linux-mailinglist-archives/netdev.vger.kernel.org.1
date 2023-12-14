Return-Path: <netdev+bounces-57289-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A05812C11
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 10:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36342829A1
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 09:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC87381C0;
	Thu, 14 Dec 2023 09:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hOlAVQCO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C56E1AA;
	Thu, 14 Dec 2023 01:49:14 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BE5VDxc031722;
	Thu, 14 Dec 2023 09:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=t69PPg+jCem4K6Eo0WgGA6QNG+KxgQaYrvmj24AWmE8=; b=hO
	lAVQCOeP0+EFAlSzjzj63U3VKPaLC+rgRgf6hehkLrPxbNPKAlWBKRSmL4sWf4fA
	qLtquyAMT1/eD3X5jhVK2zxK03B9ToLujcoUmRzM0TMw/yJ65BJBO8JKFi3ycTQL
	C1FIbZ7rN/jw2EzkLmaP+mCWvhMGLE+E7GEqgvrep8SJwWnqltoFMFSiEmXCwWPK
	zZ7lYVBt5oPtTIHJuRBrIBiMR4QLfpGrBSRxtiPVns2NeISRqTrs1ThcJTxetIaf
	cc4mV3K3pWks1RNDgNVCGHfmAXNopoGVkRIsD69Y5QZUTz4jCtgaMxCVLbQgjcDc
	M9NTc2QHdaHa0rSoBrKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uyqgt0x70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:48:59 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BE9mx25024099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Dec 2023 09:48:59 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 01:48:54 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <p.zabel@pengutronix.de>, <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v7 07/14] net: phy: at803x: add the possible_interfaces
Date: Thu, 14 Dec 2023 17:48:06 +0800
Message-ID: <20231214094813.24690-8-quic_luoj@quicinc.com>
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
X-Proofpoint-GUID: enyKgFTJ0Q4_IgOjsAA-INSrHrCZby5p
X-Proofpoint-ORIG-GUID: enyKgFTJ0Q4_IgOjsAA-INSrHrCZby5p
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=954 mlxscore=0 clxscore=1015
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312140065

When qca808x works on the interface mode sgmii or
2500base-x, the interface mode can be switched according
to the PHY link speed.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index b6b41b1a4352..c186ef8e798f 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -2101,10 +2101,22 @@ static void qca808x_link_change_notify(struct phy_device *phydev)
 			QCA8081_PHY_FIFO_RSTN, phydev->link ? QCA8081_PHY_FIFO_RSTN : 0);
 }
 
+static void qca808x_fill_possible_interfaces(struct phy_device *phydev)
+{
+	unsigned long *possible = phydev->possible_interfaces;
+
+	if (phydev->interface != PHY_INTERFACE_MODE_10G_QXGMII) {
+		__set_bit(PHY_INTERFACE_MODE_2500BASEX, possible);
+		__set_bit(PHY_INTERFACE_MODE_SGMII, possible);
+	}
+}
+
 static int qca8084_config_init(struct phy_device *phydev)
 {
 	int ret;
 
+	qca808x_fill_possible_interfaces(phydev);
+
 	/* Invert ADC clock edge */
 	ret = at803x_debug_reg_mask(phydev, QCA8084_ADC_CLK_SEL,
 				    QCA8084_ADC_CLK_SEL_ACLK,
-- 
2.42.0


