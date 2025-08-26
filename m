Return-Path: <netdev+bounces-217076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D980FB3748F
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 23:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08E751B2712C
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 21:51:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E674D284678;
	Tue, 26 Aug 2025 21:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HMkYVmT+"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAF430CD91
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 21:51:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756245094; cv=none; b=sUwiYPnG6jKG4JkI/ZGjM/gUC3m1ap4jV3keUqWJSuwEQUt4n5H+kTM7uH0tMVt+XqHfps1wzxTAoRLnWdcTZhiSdDwZIQRydAeMNHDK9pzJ8YxiDn7PxYgQ0eSqXFoxbckyL7Vcr65apzmw5+b0vM5IwRVOUt6xCH6I4Fhwg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756245094; c=relaxed/simple;
	bh=+WZfAppP5EdPTH/m75UWXwXzqlXjDLyIMNMUcPcZhDU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tOFUfCTp/Whv1QM9sP7sb9E/r4XEWHhatFZMQX2YAm6q8rTopLCYMo35/UA8GN5k3e/biChFU3QuNSlob1J8Z0G0KAkvK3n+MK9BIo5xnuEo3DyHCLZ8VljbihZk2gAGXgtXQAq1Ld+MFA4RKp4yCdmEva0ElXLKGE/NoB7TTvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HMkYVmT+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QKrXAK004580;
	Tue, 26 Aug 2025 21:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=k53dMA/VpV1qwXI/AmvEm4osx56FzjOfeEX
	sxcZvoKg=; b=HMkYVmT+XgsK9UGhUEcIhuv4BeV/YwUmX/NgSxxplsVqQ8JfjAK
	6YHH/RJ0GqQGlX5rdGGMKaKJSENji00K60K1iOYgbn8FU+3Eg19MKCdr/G6Hp+xk
	aNcabKagF+Kl4M0w438nmnn04uwCZFnn7xvkrUbDz2Y+GcyyUeIXizP6AeHPJhq1
	x5dHl4Q9nawVG5D7HO0b4bphjGXrnvW96j8sU+KTJc/Aw1vOMRFE9codMdvstmFi
	b4dmzRsCG6T9wxLMDVDl8X4dW4XlxI3GxLSz7uUfdxk+92QawXB3hvBaaroB10n6
	KubIB3NLqvtYgo4+NC2UZrQCbsS4DYYfeGQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 48q5umakgq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 21:51:26 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 57QLpPnQ000930;
	Tue, 26 Aug 2025 21:51:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 48sktprk00-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 21:51:25 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57QLpPwp000924;
	Tue, 26 Aug 2025 21:51:25 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-subashab-lv.qualcomm.com [10.81.24.15])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 57QLpP3O000923
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 21:51:25 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 212624)
	id E7EE85B4; Tue, 26 Aug 2025 14:51:24 -0700 (PDT)
From: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
        Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Subject: [PATCH net] MAINTAINERS: rmnet: Update email addresses
Date: Tue, 26 Aug 2025 14:50:46 -0700
Message-Id: <20250826215046.865530-1-subash.a.kasiviswanathan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Authority-Analysis: v=2.4 cv=VtIjA/2n c=1 sm=1 tr=0 ts=68ae2c5e cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=2OwXVqhp2XgA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=VwQbUJbxAAAA:8
 a=4VVcHpUFlTeZ-k0x__MA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMiBTYWx0ZWRfX+tLgtNVryyY2
 aeNvF9bcrM2HsAfpJjLvFHVjnlYk40P4s3/vkuQjs09Z74/XT2wAuNxuaIw9hldHruoOOyk3Udc
 01YZEs55jO1nuOkKJGUYjqjQz5LD3aJbIhpJjBMiqXmKhqJg3iyVZzfjstY8OLDngZ0q2Fb68Xc
 m7zXG3DyvfAQURRDHwGQnV3o6BbrPfFA6UgX03Y54NsPl+Z4tAuGm/GoQTXva1d7S2slhwZ6V2E
 J+W9v6fy4sOslO5HchhjK/Kvz1Cc/tP4UXRwf913DFu4uRSBkALpXvKUxsXWccZhjpE5evAuEtP
 CJ/Tw1KRyk0Ait08M5Gelp7Y2Nxk8HZ/9e1MwRJxVNAD/D+R4eorxbqNZhWcod7tWs0T1Bt9/K1
 PIziugtJ
X-Proofpoint-GUID: lWFjk5UnvwTD0otJw1zN2iOROPvnL1eY
X-Proofpoint-ORIG-GUID: lWFjk5UnvwTD0otJw1zN2iOROPvnL1eY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 spamscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230032

Switch to oss.qualcomm.com ids.

Signed-off-by: Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
---
 MAINTAINERS | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index fed6cd812d79..20f80340d249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20878,8 +20878,8 @@ S:	Maintained
 F:	drivers/firmware/qcom/qcom_qseecom_uefisecapp.c
 
 QUALCOMM RMNET DRIVER
-M:	Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
-M:	Sean Tranchetti <quic_stranche@quicinc.com>
+M:	Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>
+M:	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
-- 
2.34.1


