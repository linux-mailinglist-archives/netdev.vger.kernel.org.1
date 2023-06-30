Return-Path: <netdev+bounces-14816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7ECE743FA9
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 18:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 560CA281124
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 16:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73415168AD;
	Fri, 30 Jun 2023 16:26:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63510168A4
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 16:26:50 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 918512D63;
	Fri, 30 Jun 2023 09:26:48 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35UCJhj9027665;
	Fri, 30 Jun 2023 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=qcppdkim1;
 bh=HVgO9pwXzH88UJHGckJ318FwIPR+eZertMTYlbFFkGs=;
 b=lq9i/VOE6WUC4raTnX5gsNpUHVP0DvPgrQT+CGmvz1BlxmheejVxSXgFNOWdlx9bdgiB
 mw+gD1UZyMq5QlaaAKo3qqyGvYFSj/tPTdJ3R4UxXRMJ6HWpOSSX2Ley0EYBtaeH+MdW
 FwEF83zV7vDyRPti79XF3mByqzuIXwiE0Mc+Zk8kCMIIHbgObUHZHMnuoa66ysTpd/da
 7YQDj7hyp8cG8TkXCdLoi8MlMQdEigD/dQRy+FNdbDMFVSVL88J9164PnNjRTte7nJPO
 Hb4SrSI0vrzA62c39y5d/laJdXWRi+3MY6Wnkrof2J5vNPj19yrXJcM1x4lIEvL0Lm72 sw== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rgy1tmc5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jun 2023 16:26:39 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35UGQdYC010420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jun 2023 16:26:39 GMT
Received: from subashab-lnx.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.7; Fri, 30 Jun 2023 09:26:38 -0700
From: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <andersson@kernel.org>,
        <quic_jhugo@quicinc.com>, <simon.horman@corigine.com>
CC: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>,
        "Sean
 Tranchetti" <quic_stranche@quicinc.com>
Subject: [PATCH net v3] docs: networking: Update codeaurora references for rmnet
Date: Fri, 30 Jun 2023 10:26:17 -0600
Message-ID: <1688142377-20749-1-git-send-email-quic_subashab@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M8W419WUsFhPLkYRTfetGFLZ8r1m47Yw
X-Proofpoint-GUID: M8W419WUsFhPLkYRTfetGFLZ8r1m47Yw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 bulkscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306300141
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

source.codeaurora.org is no longer accessible and so the reference link
in the documentation is not useful. Use iproute2 instead as it has a
rmnet module for configuration.

Fixes: ceed73a2cf4a ("drivers: net: ethernet: qualcomm: rmnet: Initial implementation")
Signed-off-by: Sean Tranchetti <quic_stranche@quicinc.com>
Signed-off-by: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
---
v2->v3: Add back newline as mentioned by Jakub
v1->v2: Use iproute2 link instead of codelinaro

 .../networking/device_drivers/cellular/qualcomm/rmnet.rst          | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
index 4118384..289c146 100644
--- a/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
+++ b/Documentation/networking/device_drivers/cellular/qualcomm/rmnet.rst
@@ -190,8 +190,7 @@ MAP header|IP Packet|Optional padding|MAP header|Command Packet|Optional pad...
 3. Userspace configuration
 ==========================
 
-rmnet userspace configuration is done through netlink library librmnetctl
-and command line utility rmnetcli. Utility is hosted in codeaurora forum git.
-The driver uses rtnl_link_ops for communication.
+rmnet userspace configuration is done through netlink using iproute2
+https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/
 
-https://source.codeaurora.org/quic/la/platform/vendor/qcom-opensource/dataservices/tree/rmnetctl
+The driver uses rtnl_link_ops for communication.
-- 
2.7.4


