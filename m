Return-Path: <netdev+bounces-51105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D38997F918E
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 07:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10FE91C20C9B
	for <lists+netdev@lfdr.de>; Sun, 26 Nov 2023 06:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 070801376;
	Sun, 26 Nov 2023 06:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="eh1spQAw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F08DE;
	Sat, 25 Nov 2023 22:08:40 -0800 (PST)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AQ67jjn009595;
	Sun, 26 Nov 2023 06:08:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=qcppdkim1;
 bh=SGKuNtLiEI9lSbymQ62ComQ7nNr0WmS8+Wf4Jy0hCRg=;
 b=eh1spQAweqI37kmXNfYOFCeS7FZIj1MPnkLFl9HW6W0EkkydD4zXG2q7p5dK3xrc0Kw/
 L1BpKdepRPCSBXSFZ3Ql1Gf1DANmOL9Lz9vy1jKX3mgwKn8PLADHQfogWLdhq+HyFQzT
 vCUzREc1VW4Uuj3E3NhJklCkmXsJ6Xr1xH/jr6gDKA9LPmrCJRCLNR0EtSY7XwPFcWri
 PQXjnZ+ql5PlUHAFcLyPLEhUByiyx+dLIBAocygNQVOgYn5e1CYMuH6goJpeMCD2CK5T
 +6OOg7uL4IbFRuSah2eg3EY8nKsr/ah0EKQ/0UH92YRNDVSQLkTDHHqIPM+xuJLkvgz/ jw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uk8h8hsk4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 06:08:23 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AQ68Mlj006641
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 26 Nov 2023 06:08:22 GMT
Received: from akronite-sh-dev02.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Sat, 25 Nov 2023 22:08:18 -0800
From: Luo Jie <quic_luoj@quicinc.com>
To: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v6 4/6] net: phy: at803x: add the function phydev_id_is_qca808x
Date: Sun, 26 Nov 2023 14:07:30 +0800
Message-ID: <20231126060732.31764-5-quic_luoj@quicinc.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231126060732.31764-1-quic_luoj@quicinc.com>
References: <20231126060732.31764-1-quic_luoj@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cTnyKzJXl3URHROzeOo-6W9ZWhq2LkVj
X-Proofpoint-GUID: cTnyKzJXl3URHROzeOo-6W9ZWhq2LkVj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-26_04,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 impostorscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 adultscore=0 clxscore=1015
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311260042

The function phydev_id_is_qca808x is applicable to the
PHY qca8081 and qca8084.

Signed-off-by: Luo Jie <quic_luoj@quicinc.com>
---
 drivers/net/phy/at803x.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/at803x.c b/drivers/net/phy/at803x.c
index f376d794d170..430547f304f7 100644
--- a/drivers/net/phy/at803x.c
+++ b/drivers/net/phy/at803x.c
@@ -1165,6 +1165,12 @@ static void at803x_link_change_notify(struct phy_device *phydev)
 	}
 }
 
+static bool phydev_id_is_qca808x(struct phy_device *phydev)
+{
+	return phydev_id_compare(phydev, QCA8081_PHY_ID) ||
+		phydev_id_compare(phydev, QCA8084_PHY_ID);
+}
+
 static int at803x_read_specific_status(struct phy_device *phydev)
 {
 	int ss;
@@ -1184,8 +1190,8 @@ static int at803x_read_specific_status(struct phy_device *phydev)
 		if (sfc < 0)
 			return sfc;
 
-		/* qca8081 takes the different bits for speed value from at803x */
-		if (phydev->drv->phy_id == QCA8081_PHY_ID)
+		/* qca808x takes the different bits for speed value from at803x */
+		if (phydev_id_is_qca808x(phydev))
 			speed = FIELD_GET(QCA808X_SS_SPEED_MASK, ss);
 		else
 			speed = FIELD_GET(AT803X_SS_SPEED_MASK, ss);
@@ -1316,7 +1322,7 @@ static int at803x_config_aneg(struct phy_device *phydev)
 	 */
 	ret = 0;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID) {
+	if (phydev_id_is_qca808x(phydev)) {
 		int phy_ctrl = 0;
 
 		/* The reg MII_BMCR also needs to be configured for force mode, the
@@ -1470,8 +1476,8 @@ static int at803x_cdt_start(struct phy_device *phydev, int pair)
 {
 	u16 cdt;
 
-	/* qca8081 takes the different bit 15 to enable CDT test */
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
+	/* qca808x takes the different bit 15 to enable CDT test */
+	if (phydev_id_is_qca808x(phydev))
 		cdt = QCA808X_CDT_ENABLE_TEST |
 			QCA808X_CDT_LENGTH_UNIT |
 			QCA808X_CDT_INTER_CHECK_DIS;
@@ -1487,7 +1493,7 @@ static int at803x_cdt_wait_for_completion(struct phy_device *phydev)
 	int val, ret;
 	u16 cdt_en;
 
-	if (phydev->drv->phy_id == QCA8081_PHY_ID)
+	if (phydev_id_is_qca808x(phydev))
 		cdt_en = QCA808X_CDT_ENABLE_TEST;
 	else
 		cdt_en = AT803X_CDT_ENABLE_TEST;
-- 
2.42.0


