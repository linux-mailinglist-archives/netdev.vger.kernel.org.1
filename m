Return-Path: <netdev+bounces-49137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B76B27F0E40
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:56:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56F03B215AA
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB51D101C8;
	Mon, 20 Nov 2023 08:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nFVfJ0y2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CB8E5;
	Mon, 20 Nov 2023 00:56:47 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK6liql012344;
	Mon, 20 Nov 2023 08:56:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=D4A/arbgjFpt5LCFWy/ik54raTHB95VyINVPvCRPRks=;
 b=nFVfJ0y2e6MWwFzf2VH5XUovPjX5J19sLyHHKPyODJwSRuUS+3BGh4pWwFFCXnBTvZ/C
 po8XjgVl2O/z/wbj7aV5v3W6a/BtpvPZQtXoTcB4DTIF3XGFLDqwKw5DhRmRNRIiuD8Y
 6XHDmfoZW3mNVPSwLb8cqH+oDJUkENfYg42ipvT6vWsJaEBoWxUMr00keSEnahnzH2Yf
 A9HtTazPaayFKXvxuLIdxrNKpA8lLoAvtt7CtDcWz25esYF3oql6+dnliN4jQY/UMA6d
 40PbKO8gGDmKP7vOgPdVQbgpbc3wUaFOEZ1pX7HiIpeCyAE1BRJRpugl+mkqq23/A01r wQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uejmuunmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 08:56:37 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK8uaiN011988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 08:56:36 GMT
Received: from [10.253.8.221] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 00:56:32 -0800
Message-ID: <3a7675cc-ffe5-4156-9f45-0a31c42456d7@quicinc.com>
Date: Mon, 20 Nov 2023 16:56:32 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/6] net: phy: at803x: add the function
 phydev_id_is_qca808x
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <corbet@lwn.net>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-5-quic_luoj@quicinc.com>
 <20231118162214.7093d46c@kernel.org>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231118162214.7093d46c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: kqN3toiCxN9nuC-MmhU5LbzvbgSKlasx
X-Proofpoint-ORIG-GUID: kqN3toiCxN9nuC-MmhU5LbzvbgSKlasx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_06,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=422
 impostorscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200058



On 11/19/2023 8:22 AM, Jakub Kicinski wrote:
> On Sat, 18 Nov 2023 14:27:52 +0800 Luo Jie wrote:
>> +static inline bool phydev_id_is_qca808x(struct phy_device *phydev)
> 
> Please drop the "inline" keyword. The compiler will decide what's best.

OK, will remove the "inline" in the next patch.

