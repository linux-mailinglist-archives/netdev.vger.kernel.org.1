Return-Path: <netdev+bounces-234696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9CF5C2635D
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 17:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 331C86206E4
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 16:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C85FF280023;
	Fri, 31 Oct 2025 16:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TQ4qSkCz"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454FB1E9B3D
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 16:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761927387; cv=none; b=uO1fDkAEn2F4xDm6gOXdo2vID4tRd2HTmdtYYAq/nmhwm8bY1QdpAkArhwFx340mIEQ/rQNgg52h4dna8LpjAXZK0cMEoiCvnCyyBLzMGfd7OD3q1MPLAPxx+vugLl0Q6vSC2qiq5+DGvQCXBiGMFVMzEf+RoY6BDJpPed15Cw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761927387; c=relaxed/simple;
	bh=SPNuguJDN+jJ6C+8gkkc6gja3M6sivEDyxIukzDqEIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jv7AW1V87x0OeE4rOkjEw9bjo8MDoKcERVDZMHNzBMUJVY2Yza1i7DA0vCb5nL9UAbh1bFBg1kUhjDASCvfyBviSlX33PZ6EI7jE2ahZkk7wzbgT3uScsFbIfwVPBThiQ5UvWVscg/Jwr1DBchjlRP8FubS7aoD3yCtbs2BsD+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TQ4qSkCz; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59VG9UfP029983;
	Fri, 31 Oct 2025 16:16:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=WZbIds+C46GU1Taa7L0qcuxJcBPOs
	hq2TEqtO7ZiYWU=; b=TQ4qSkCzwf8YcYPZMAYcRetYO2wpkUrjFXOGVT4+r86Ap
	3YS2tHGqB3PNblOkzjFUvG49pMWqkjBytxcpNVF+OnBY3LhSrCDRsI0P728whQU7
	zBjWBT9ye5TdmQ8Eghy9xLY97w3ud172pL2jRPZVL267WjO9rfwDFbWI2LuXn+ai
	bgYabWq8iI4tDv9W7cSC4kXm9vvXw2mJxahmqaPH8Gp4OiK/ld9yPXNkRS3RMbB3
	YovaOSX6M0fVUWOFWzq+O0MunF8A4P6RiOGjSA/zrVevpLP6cm/+zP0wD5PKHOh7
	wq++ziePklb6NKEhjsbjUXDilbmFuXQTXI8frmpwA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a50csr0ty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 16:16:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59VEh5rA004161;
	Fri, 31 Oct 2025 16:16:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wp7672-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Oct 2025 16:16:11 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59VGGA24001516;
	Fri, 31 Oct 2025 16:16:10 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a33wp765r-1;
	Fri, 31 Oct 2025 16:16:10 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: ansuelsmth@gmail.com, hkallweit1@gmail.com, andrew@lunn.ch,
        kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
        alok.a.tiwari@oracle.com
Cc: alok.a.tiwarilinux@gmail.com
Subject: [PATCH net] net: mdio: Check regmap pointer returned by device_node_to_regmap()
Date: Fri, 31 Oct 2025 09:15:53 -0700
Message-ID: <20251031161607.58581-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-31_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510310146
X-Authority-Analysis: v=2.4 cv=HOjO14tv c=1 sm=1 tr=0 ts=6904e0cb cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=cqcMqKjCEZ1L1SYY5_oA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: aeSucHbmcODTFaPR2CNevlHOPhh_5rMO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMxMDE0NSBTYWx0ZWRfX2U7xA3SaGTek
 8BqZNObvqRCQPYQBPtttYT3eR7NbaHGTaK6HPpmx5KbPB5Lll1RivPhaCHr1muzTePd180LFCBJ
 N1O2AdTPGLrX7tG3OfTDFPmWL2V8b5cOYgEm/AJudt2trJdS1KOr+XKGsu4MS9kY0sfnFB/rysC
 UlsVVFjEvY4UQuNVkvCO/uMCx+QF1dLk9VzrqORMk51xl4JByMetRWtlreAV6Etk0HB+ynpGQoF
 NiDkSagxEkqMLp4/pIIDIwNldbO288mIw+mG92NlmvsAzUc7EvRbHhigjmaUyeUzKmGVcep4Jmd
 Pbftn7QK6S9dMXxGqzagGkjBlaindJySbKjwGxYO/xez0gIMEP5Es/nlk/IDdIZ1StXBplayo0D
 tJ9emTXMfuyfzTEEQQ1TGgb2sqvhVg==
X-Proofpoint-ORIG-GUID: aeSucHbmcODTFaPR2CNevlHOPhh_5rMO

The call to device_node_to_regmap() in airoha_mdio_probe() can return
an ERR_PTR() if regmap initialization fails. Currently, the driver
stores the pointer without validation, which could lead to a crash
if it is later dereferenced.

Add an IS_ERR() check and return the corresponding error code to make
the probe path more robust.

Fixes: 67e3ba978361 ("net: mdio: Add MDIO bus controller for Airoha AN7583")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/mdio/mdio-airoha.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mdio/mdio-airoha.c b/drivers/net/mdio/mdio-airoha.c
index 1dc9939c8d7d..52e7475121ea 100644
--- a/drivers/net/mdio/mdio-airoha.c
+++ b/drivers/net/mdio/mdio-airoha.c
@@ -219,6 +219,8 @@ static int airoha_mdio_probe(struct platform_device *pdev)
 	priv = bus->priv;
 	priv->base_addr = addr;
 	priv->regmap = device_node_to_regmap(dev->parent->of_node);
+	if (IS_ERR(priv->regmap))
+		return PTR_ERR(priv->regmap);
 
 	priv->clk = devm_clk_get_enabled(dev, NULL);
 	if (IS_ERR(priv->clk))
-- 
2.50.1


