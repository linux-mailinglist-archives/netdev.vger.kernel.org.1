Return-Path: <netdev+bounces-55715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E14580C0AA
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 06:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEC7C280C72
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 05:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F921CAB3;
	Mon, 11 Dec 2023 05:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="GvFI3s8/"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E387FC3;
	Sun, 10 Dec 2023 21:24:21 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BB3T42R013989;
	Mon, 11 Dec 2023 05:24:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=BSoh5DNo4RPdGyiQXkB5TaMxmdd0nuO8yq4OLyw7zZc=; b=Gv
	FI3s8/04Wgx5X2sQ/cRny7rUx9fJebDdVCWf/HXNZUOHRQ1U6fc6nmgDbr1CezRX
	NL4/QrddtNjJfBEecbPYMHJLttgjV2gPTb16loRrwe2xGy30ftuBn1OrX0EHoAwp
	xbS7/8n58eZqp9QPXOsiAW352wzKngMnpdMokLXFbvDpTCSbP9yF8VfJ4696XjpZ
	zYvHeVAMq1tjpliY5rwoTM3Qxryjihv3Nzgl95QuUXRt35xMekzplYgbIXXFbrSA
	WJi0PdJbMeCjBCDcV6PHDAldeg8KPgKA6iMW4ijkiUXlgagjJAs82GX3FpmT3OXz
	evx06I+3ulw7JjGqXnbA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uvnk5tb5c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 05:24:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BB5O58C017881
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Dec 2023 05:24:05 GMT
Received: from [10.216.5.30] (10.80.80.8) by nalasex01b.na.qualcomm.com
 (10.47.209.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Sun, 10 Dec
 2023 21:23:54 -0800
Message-ID: <ff71793b-eab1-4dc2-b58a-fc2d34b2d0d9@quicinc.com>
Date: Mon, 11 Dec 2023 10:53:49 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: qcom,ethqos: add
 binding doc for safety IRQ for sa8775p
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Vinod Koul <vkoul@kernel.org>,
        Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu
	<joabreu@synopsys.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>, <netdev@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Prasad Sodagudi
	<psodagud@quicinc.com>,
        Andrew Halaney <ahalaney@redhat.com>
CC: <kernel@quicinc.com>
References: <cover.1701939695.git.quic_jsuraj@quicinc.com>
 <87bdedf3c752d339bf7f45a631aa8d5bf5d07763.1701939695.git.quic_jsuraj@quicinc.com>
 <0af91794-69d6-459a-8566-c8c408489f2b@linaro.org>
From: Suraj Jaiswal <quic_jsuraj@quicinc.com>
In-Reply-To: <0af91794-69d6-459a-8566-c8c408489f2b@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Os34XW_GzOcrfJPdr_qXjunD5rB5DdhM
X-Proofpoint-GUID: Os34XW_GzOcrfJPdr_qXjunD5rB5DdhM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_01,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=731
 priorityscore=1501 malwarescore=0 spamscore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 impostorscore=0
 suspectscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312110042

Sure . will expand below .


On 12/9/2023 11:17 PM, Konrad Dybcio wrote:
> On 7.12.2023 10:21, Suraj Jaiswal wrote:
>> Add binding doc for safety IRQ. The safety IRQ will be
>> triggered for ECC, DPP, FSM error.
> ECC is widely understood, but the DPP and FSM acronyms could be
> expanded..
> 
> Konrad

