Return-Path: <netdev+bounces-18079-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E41B75497C
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 16:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5374B1C209FB
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 14:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F39255255;
	Sat, 15 Jul 2023 14:50:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E711C1C32
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 14:50:00 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F439D3;
	Sat, 15 Jul 2023 07:49:59 -0700 (PDT)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36FEnWiB004407;
	Sat, 15 Jul 2023 14:49:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=y6H8wvRPU+GPvdAQ9c7stcLqTtvnoplmtEHnbbR+Sug=;
 b=JN2EzJ0SMMYdcZjihj97+NpVtp3REVGWSOJTJyldBsFPE4TZ7YXB9cGzgAqkIrKVvswH
 kwVniZkRmuk07cB7lOxBQE7yDHTHqX7R+zqod8JgQEGfl8fN2JHbAtnmU18/0IDXsxQP
 oin9ePrJiMLEHms6X4YZoKGOEcvAawSSHfMNfBEd9OFOnj+s8+6Dzat69QZ03iVDcn5X
 c88FEMuM+6fxNZzq1y98GpulPraGUjttPH+B/ibrHxOD3hlp6Qp4kACxaJwLzsJHLQ/A
 EmDIHcnLd1U3gNt8Cn1uC8xCXd+4LnwKGwxs2taPLVwBGfFo5uHZAQPMUiis6qZS5HKH 1w== 
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3run0erfb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jul 2023 14:49:32 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36FEnVsb010187
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Jul 2023 14:49:31 GMT
Received: from [10.253.38.208] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Sat, 15 Jul
 2023 07:49:29 -0700
Message-ID: <4200ab7b-59a6-c35f-ee58-c857671e0305@quicinc.com>
Date: Sat, 15 Jul 2023 22:49:26 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/6] net: phy: at803x: support qca8081
 genphy_c45_pma_read_abilities
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230714063136.21368-1-quic_luoj@quicinc.com>
 <20230714063136.21368-2-quic_luoj@quicinc.com>
 <ZLEnGOLWsIVsAIx8@shell.armlinux.org.uk>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZLEnGOLWsIVsAIx8@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: BSd08UBYdTgjjTvbQ6mzyYtddbqcY2tD
X-Proofpoint-ORIG-GUID: BSd08UBYdTgjjTvbQ6mzyYtddbqcY2tD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-15_08,2023-07-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 mlxscore=0 impostorscore=0 adultscore=0 spamscore=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0 mlxlogscore=594
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307150140
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/14/2023 6:44 PM, Russell King (Oracle) wrote:
> On Fri, Jul 14, 2023 at 02:31:31PM +0800, Luo Jie wrote:
>> qca8081 PHY supports to use genphy_c45_pma_read_abilities for
>> getting the PHY features supported except for the autoneg ability
>>
>> but autoneg ability exists in MII_BMSR instead of MMD7.1, add it
> 
> When talking about clause 45 PHYs, they don't have a BMSR. The
> correct definition is MDIO_STAT1, or "status 1 register".
> 
> Apart from that,
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Thanks!
> 

Thanks Russell for the review, i will update this comment in the next 
patch set.

