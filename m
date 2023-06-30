Return-Path: <netdev+bounces-14721-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9473743530
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 08:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50CF1280F98
	for <lists+netdev@lfdr.de>; Fri, 30 Jun 2023 06:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F5D522E;
	Fri, 30 Jun 2023 06:39:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5267B3207
	for <netdev@vger.kernel.org>; Fri, 30 Jun 2023 06:39:45 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8D0A1FD7;
	Thu, 29 Jun 2023 23:39:43 -0700 (PDT)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35U6AqvS027983;
	Fri, 30 Jun 2023 06:39:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=TSfRHAww6esW5IXcPBRSVAEqhmtQ2ujUpdB0plvGKtg=;
 b=IziP2UdXu2EfVD88x7pQsanDDd3nvbdS+nWT+42dprso8i3EVo4Tz3COMbcRiYz2aiZ/
 0p1x72ChGeBEvPin1YZ/nUz/W4/BAHTJf3CX0ed2VNxunoprolIfc7mngofatsG3Lng8
 xRxp+GGhrobuPm2B3AYQZOhzL0ndo5kbkvPTBjFrHmrjq7dpmTymzQJV3vC6fXpgKcQC
 0yOTvm9Xb3yDiKIqv0MAUXbGaglUVg+3MTLFDZKjVvdEhWTQCj07Lcs88AMkEi9dXGEn
 QxJBvkDgcu2br9F2ap2sqR9hK3zaEUctqJJNa9weFBNyq4GDwTkWCLc+K0NkBn0YtFo3 yQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rh7aetbbn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jun 2023 06:39:22 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 35U6dLkv025992
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 30 Jun 2023 06:39:21 GMT
Received: from [10.253.74.51] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Thu, 29 Jun
 2023 23:39:19 -0700
Message-ID: <b735b442-8818-c66e-5498-9faa2e4984f2@quicinc.com>
Date: Fri, 30 Jun 2023 14:39:06 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/3] net: phy: at803x: support qca8081 1G chip type
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux@armlinux.org.uk>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-2-quic_luoj@quicinc.com>
 <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <48e41540-6857-4f61-bcc5-4d0a6dbb9ec1@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FFxeLG7G2LaAcvB6U5BfG3KUuWBQ61Zm
X-Proofpoint-ORIG-GUID: FFxeLG7G2LaAcvB6U5BfG3KUuWBQ61Zm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-30_03,2023-06-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=417
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2305260000
 definitions=main-2306300056
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/29/2023 9:14 PM, Andrew Lunn wrote:
> On Thu, Jun 29, 2023 at 11:48:44AM +0800, Luo Jie wrote:
>> The qca8081 1G chip version does not support 2.5 capability, which
>> is distinguished from qca8081 2.5G chip according to the bit0 of
>> register mmd7.0x901d.
>>
>> The fast retrain and master slave seed configs are only needed when
>> the 2.5G capability is supported.
> 
> Does genphy_c45_pma_read_abilities() work on these devices?
> 
>       Andrew

Hi Andrew,
yes, genphy_c45_pma_read_abilities works on both normal qca8081 2.5G 
chip and qca8081 1G version chip, even the PHY ID is same, the only 
difference between qca8081 1G and 2.5G chip is the 2.5G capability 
removed on 1G version chip.

