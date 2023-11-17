Return-Path: <netdev+bounces-48606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73CD07EEF24
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 10:46:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F2C92811E5
	for <lists+netdev@lfdr.de>; Fri, 17 Nov 2023 09:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C75D171A8;
	Fri, 17 Nov 2023 09:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BbHo7e+K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51CE2135;
	Fri, 17 Nov 2023 01:45:52 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AH9Nppq022684;
	Fri, 17 Nov 2023 09:45:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=Wnmg8HFqo4zblBGw7uhKOxVMxoPMpQNE5mJ176EA0kg=;
 b=BbHo7e+KsH0+19ZETk+r+G0sVpqFzdnb6Tma0pXwpHdcfOtJcXx6cprORu6BPEi33h85
 OhQrZKq2Wf6r+LO41v8aDJIrl3NUaHQMAZ1c/0r7gqXMvC5XRZu/jOkDLTNGUlrKAzxC
 w+LjMrYNRR+S4i+YfYWZI5uuhX9KCdsq5R03mpDlBAfFEnM4YTHdZAgKNPzd4Z/flbrW
 H7hkZOSiXTP8xMytSbWpESKdFcezJgUJMXHnRMOAax3LBTVdb983sacLbqN66CCT17Y/
 8J2R9QXLQpQr/hAPlX2ZiVaMeWpILnX4TybmzzTHz8ds6vuNWeguXeA7e5gHhV23WnS6 Aw== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3udmw42ak7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 09:45:40 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AH9jdpR009346
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 17 Nov 2023 09:45:39 GMT
Received: from [10.253.8.81] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 17 Nov
 2023 01:45:35 -0800
Message-ID: <c574b621-aa18-460a-b5ed-49e9f143ecf4@quicinc.com>
Date: Fri, 17 Nov 2023 17:45:35 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/6] dt-bindings: net: ethernet-controller: add
 10g-qxgmii mode
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>, Conor Dooley <conor@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231116112437.10578-1-quic_luoj@quicinc.com>
 <20231116112437.10578-3-quic_luoj@quicinc.com>
 <20231116-flier-washed-eb1a45481323@squawk>
 <739c89ec-739e-4c5d-8e42-88ed9a89979b@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <739c89ec-739e-4c5d-8e42-88ed9a89979b@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: KQWvbExLaIrKlJFmLKkscZdKQOStzyVh
X-Proofpoint-ORIG-GUID: KQWvbExLaIrKlJFmLKkscZdKQOStzyVh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-17_07,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=678
 clxscore=1015 suspectscore=0 mlxscore=0 malwarescore=0 bulkscore=0
 priorityscore=1501 adultscore=0 lowpriorityscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311170071



On 11/17/2023 2:12 AM, Andrew Lunn wrote:
> On Thu, Nov 16, 2023 at 02:22:41PM +0000, Conor Dooley wrote:
>> On Thu, Nov 16, 2023 at 07:24:33PM +0800, Luo Jie wrote:
>>> Add the new interface mode 10g-qxgmii, which is similar to
>>> usxgmii but extend to 4 channels to support maximum of 4
>>> ports with the link speed 10M/100M/1G/2.5G.
>>>
>>
>>> This patch is separated from Vladimir Oltean's previous patch
>>> <net: phy: introduce core support for phy-mode = "10g-qxgmii">.
>>
>> This belongs in the changelog under the --- line.
>>
>>>
>>> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
>>
>> Are you missing a from: line in this patch?
> 
> You probably need to use git commit --am --author=<author> to fix
> this.
> 
> 	Andrew

will update this in the next patch set, thanks for this instruction.

