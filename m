Return-Path: <netdev+bounces-17120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35D9F75060A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E522D280E6E
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 11:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF2727730;
	Wed, 12 Jul 2023 11:27:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9328B27707
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 11:27:38 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7608F;
	Wed, 12 Jul 2023 04:27:36 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CAUs0p030726;
	Wed, 12 Jul 2023 11:27:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=qcppdkim1;
 bh=Q/LYQEP/seOsiwDhh79aHPlIPS2WT+AlGOt++dLgaSw=;
 b=OBzXQH78WovVtQ2nRuEFJrft+6a3aiiR8kfH/zm6C89lIoqK5kJjrlNg8ulH40Uvt4q4
 u//1hfJGy4ezDemYS4OadkFTgwlXVuyBWnu/iCrWdNTl9Kzrig1kkcBr1mhp5ceEsvZ2
 26vh3Wy5UrYX66bRwbnnPyEImsaELJ442Tige+MfXQdLgz9RV0LgYz4NJdULZkCm5eId
 3/NRXuupcJbmNatCtruwWNqAhLYV1BrSEcZ02eqdFGYocvg6nzwMItshKBzufXHN7S5m
 APY2kpqGDs0mEiXNsfAkjmispNPhGXWqISI8MPQSbUPbS+ON12W16AVmikzlINckoJ25 5g== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rsf51ha33-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 11:27:27 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36CBRQNl005639
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Jul 2023 11:27:26 GMT
Received: from hu-viswanat-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Wed, 12 Jul 2023 04:26:51 -0700
From: Vignesh Viswanathan <quic_viswanat@quicinc.com>
To: <mani@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>,
        <linux-arm-msm@vger.kernel.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <quic_srichara@quicinc.com>, <quic_clew@quicinc.com>,
        Vignesh Viswanathan
	<quic_viswanat@quicinc.com>
Subject: [PATCH net-next 0/3] net: qrtr: Few fixes in QRTR
Date: Wed, 12 Jul 2023 16:56:28 +0530
Message-ID: <20230712112631.3461793-1-quic_viswanat@quicinc.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5cwDYg0KuKG6o0HZxRzCVK1WaIcPY4tD
X-Proofpoint-GUID: 5cwDYg0KuKG6o0HZxRzCVK1WaIcPY4tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_06,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxlogscore=426 impostorscore=0 spamscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2307120102
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add fixes in QRTR ns to change server and nodes radix tree to xarray to
avoid a use-after-free while iterating through the server or nodes
radix tree.

Also fix the destination port value for IPCR control buffer on older
targets.

Vignesh Viswanathan (3):
  net: qrtr: ns: Change servers radix tree to xarray
  net: qrtr: ns: Change nodes radix tree to xarray
  net: qrtr: Handle IPCR control port format of older targets

 net/qrtr/af_qrtr.c |   5 ++
 net/qrtr/ns.c      | 139 +++++++++------------------------------------
 2 files changed, 32 insertions(+), 112 deletions(-)

-- 
2.41.0


