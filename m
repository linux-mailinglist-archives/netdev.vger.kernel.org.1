Return-Path: <netdev+bounces-48276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1ED7EDEBB
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 11:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8EB051C209AD
	for <lists+netdev@lfdr.de>; Thu, 16 Nov 2023 10:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9405C156C6;
	Thu, 16 Nov 2023 10:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EJrx+9Cc"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6119118B;
	Thu, 16 Nov 2023 02:44:45 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AG8Vakx004901;
	Thu, 16 Nov 2023 10:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D1svzL+K4mX38CebFwfuvfAb54VtCzK1NOI55/OaP1w=;
 b=EJrx+9CctyeAF0U2Sq28VpTjQIduRpRZHsS9oEBP6M8lURbSpsR88+ZlwvkZRzyMkTIm
 Bck56GTPURRmDZz2KICOsce6FtRnOLOqJIiyXR2pSI4uMwj8lwbqOAbEo82epofV+vO+
 Rg80ms/wFz918EnctIvik+mtQezNX8Mo4pTiqz3DJKt+1EhLzjq08VF4AK17eie5WqCO
 LkJ2GpQCq/y0lRoLvucPqjgvOZKbwfP8eWW0KzUUlt+dG9YJh5M7yJ/9F/+DFd9XFNdy
 lvqh2b+k5HHuYpOIaH6jNmFwNaOt+KTiGHLtCWFW5en6rdvwrCpXyLFqyfCoFUehhv1R hg== 
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ucuac32ct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 10:44:28 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AGAiLm2023401
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Nov 2023 10:44:21 GMT
Received: from [10.253.72.184] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Thu, 16 Nov
 2023 02:44:17 -0800
Message-ID: <8608e88e-e379-4e08-b376-86d9f25d2270@quicinc.com>
Date: Thu, 16 Nov 2023 18:44:14 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 8/9] net: mdio: ipq4019: add qca8084 configurations
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>, Andrew Lunn <andrew@lunn.ch>
CC: <agross@kernel.org>, <andersson@kernel.org>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <robert.marko@sartura.hr>, <linux-arm-msm@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_srichara@quicinc.com>
References: <20231115032515.4249-1-quic_luoj@quicinc.com>
 <20231115032515.4249-9-quic_luoj@quicinc.com>
 <a1954855-f82d-434b-afd1-aa05c7a1b39b@lunn.ch>
 <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <cb4131d1-534d-4412-a562-fb26edfea0d1@linaro.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aO_XPBb_fBjY-CpFbSBD2d8e64uf5W3x
X-Proofpoint-GUID: aO_XPBb_fBjY-CpFbSBD2d8e64uf5W3x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_09,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=450
 spamscore=0 malwarescore=0 mlxscore=0 bulkscore=0 clxscore=1015
 adultscore=0 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311160086



On 11/16/2023 1:01 AM, Konrad Dybcio wrote:
> 
> 
> On 11/15/23 17:20, Andrew Lunn wrote:
>> On Wed, Nov 15, 2023 at 11:25:14AM +0800, Luo Jie wrote:
>>> The PHY & PCS clocks need to be enabled and the reset
>>> sequence needs to be completed to make qca8084 PHY
>>> probeable by MDIO bus.
>>
>> Is all this guaranteed to be the same between different boards?
> No, this looks like a total subsystem overreach, these should be
> taken care of from within clk framework and consumed with the clk
> APIs.
> 
> Konrad

Hi Konrad,
As Robert shared the link of the clock provider driver, which is
registered as MDIO device and not available until to the qca8084
initializations completed done here, so i need to do raw read/write
the clock registers in this patch.

