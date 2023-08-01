Return-Path: <netdev+bounces-23050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289DF76A7EF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 06:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA6191C20E21
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8E2E111A;
	Tue,  1 Aug 2023 04:41:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB2E81D
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 04:41:21 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 486CFE5C;
	Mon, 31 Jul 2023 21:41:20 -0700 (PDT)
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3714NSLe014598;
	Tue, 1 Aug 2023 04:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=date : from : to :
 cc : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=qcppdkim1; bh=NrULh4nHCxDCKZEJwHsBPzOeEYRj8Qd4Tn2IDZGMods=;
 b=bOUCXaDwiXKNHTWn7mxB4HGd6OQzK5Wbawbf/P9IDedSM3Xw27mUzn+36RQbr6l65xO9
 D/PcTW6GKXAFF/l5SGwvDhWpLGC4vGvHJ/oGvcvd0k+a9d/fv9jzonnRJHfaqbuHwNNy
 qmzQco7Rjqem4wCDJc6O7oagfaAIC029hZhoJgukGV6Bg/sXGfszm+HW11I6ke3Wa9S2
 WLsA2tUgqG4Uvmrm8BqdnflLoPWi1JUgr9opn8Nk83c+t+5ifKDa82i2YAJKa4N5vRWw
 c0S5erSNtbRPysnNagDd872/M5HQ+O4WesdGhs+oSthTjh7MneUXTbglzTVf7a2ntbAa zA== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3s6gs7h61m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Aug 2023 04:41:14 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3714fCsK013818
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 1 Aug 2023 04:41:12 GMT
Received: from hu-pkondeti-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 31 Jul 2023 21:41:08 -0700
Date: Tue, 1 Aug 2023 10:11:04 +0530
From: Pavan Kondeti <quic_pkondeti@quicinc.com>
To: Bjorn Andersson <quic_bjorande@quicinc.com>
CC: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Chris Lew <quic_clew@quicinc.com>, Alex Elder
	<elder@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski
	<kuba@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>
Subject: Re: [PATCH 2/4] soc: qcom: aoss: Add debugfs interface for sending
 messages
Message-ID: <0ec53a07-0b7d-47d1-9589-32c841cb691e@quicinc.com>
References: <20230731041013.2950307-1-quic_bjorande@quicinc.com>
 <20230731041013.2950307-3-quic_bjorande@quicinc.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230731041013.2950307-3-quic_bjorande@quicinc.com>
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 3MsnKKYdkAj5LINRduz0Jk4jJ6CFECB-
X-Proofpoint-ORIG-GUID: 3MsnKKYdkAj5LINRduz0Jk4jJ6CFECB-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-01_01,2023-07-31_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1011
 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 mlxlogscore=681 spamscore=0 impostorscore=0 mlxscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308010042
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Jul 30, 2023 at 09:10:11PM -0700, Bjorn Andersson wrote:
> From: Chris Lew <clew@codeaurora.org>
> 
> In addition to the normal runtime commands, the Always On Processor
> (AOP) provides a number of debug commands which can be used during
> system debugging for things such as preventing power collapse or placing
> floor votes for certain resources. Some of these are documented in the
> Robotics RB5 "Debug AOP ADB" linked below.
> 
> Provide a debugfs interface for the developer/tester to send these
> commands to the AOP.
> 
> Link: https://docs.qualcomm.com/bundle/publicresource/topics/80-88500-3/85_Debugging_AOP_ADB.html
> Signed-off-by: Chris Lew <clew@codeaurora.org>
> [bjorn: Dropped debugfs guards, improve error codes, rewrote commit message]
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>

Thanks Bjorn and Chris for enabling this interface. It will be very useful. 
We use this interface  in downstream kernel during throughput/suspend issues debug. 
I have tested your series with v6.4 on SM8550 and it works as expected.

Thanks,
Pavan

