Return-Path: <netdev+bounces-14943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC0F27447DD
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 10:04:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20AB91C20BE1
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 08:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA6441B;
	Sat,  1 Jul 2023 08:04:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C840115A7
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 08:04:41 +0000 (UTC)
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F331F199;
	Sat,  1 Jul 2023 01:04:39 -0700 (PDT)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3617o5r7015948;
	Sat, 1 Jul 2023 08:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=MS5CIDx1MWEkurYsT3/3Q/wJyBuayl6mQcGoOBHnq0U=;
 b=duioDlccW/0/yXqWjehFi7vQgcr7aPdQHuYP63ron4ncxZGUwenlPOa2NX71Rz7K0LDj
 R0C70njLtpYnP7l5ryf9XreSLCzkyce9TV+Fp3tCbRBAhRRojplZ5BJyq+IJbnbd3/5S
 BVwVgIeu+qjA+KcQVVJrMXUvIwlHjMj8R1ReekRe37+LuI9KgbqwwZRJUadmSumK3CfV
 dxkRTaDC0xhRxhhB1T5GEPYU7d7R4OOlodbAuUpXrRsIfRzOIDchfc5i8SdPpdSWfhUw
 IKrakSoFq8rD9JPEoedgaGJ+ROHq7V9ahAwbrIcFCP7j0z+Fux22XxnYDtnUqK4ua7Ge eQ== 
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rj9umgn0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 01 Jul 2023 08:04:25 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 36184PHU005241
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 1 Jul 2023 08:04:25 GMT
Received: from [10.253.13.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sat, 1 Jul 2023
 01:04:17 -0700
Message-ID: <7144731c-f4ae-99b6-d32a-1d0e39bc9ee7@quicinc.com>
Date: Sat, 1 Jul 2023 16:04:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 3/3] net: phy: at803x: add qca8081 fifo reset on the link
 down
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
CC: <hkallweit1@gmail.com>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <linux@armlinux.org.uk>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230629034846.30600-1-quic_luoj@quicinc.com>
 <20230629034846.30600-4-quic_luoj@quicinc.com>
 <e1cf3666-fecc-4272-b91b-5921ada45ade@lunn.ch>
 <0f3990de-7c72-99d8-5a93-3b7eaa066e49@quicinc.com>
 <924ebd8b-2e1f-4060-8c66-4f4746e88696@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <924ebd8b-2e1f-4060-8c66-4f4746e88696@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: jL09s1ySArYGVPXMxy2JKVpkt77Em51c
X-Proofpoint-ORIG-GUID: jL09s1ySArYGVPXMxy2JKVpkt77Em51c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-01_06,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 malwarescore=0
 mlxlogscore=461 adultscore=0 mlxscore=0 impostorscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307010075
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 6/30/2023 9:21 PM, Andrew Lunn wrote:
>> SERDES device is the block converts data between serial data and parallel
>> interfaces in each direction, which is the SGMII interface in qca8081 PHY,
>> it's address is always the PHY address added by 1 in qca8081 PHY.
> 
> What other registers does this block have? What behaviour can be
> configured? Does it have any support for Clause 73? Is there an open
> datasheet for it?
> 
> 	    Andrew

Hi Andrew,
This block includes MII and MMD1 registers, which mainly configure the 
PLL clocks, reset and calibration of the interface sgmii, there is no 
related Clause 73 control register in this block.

Normally it is the hardware behavior, driver do not need to configure 
these registers, adding this interface fifo reset is for avoiding the 
packet block issue in some corner case.

it seems there is no open datasheet after searching the internet, but 
you can get the basic information of qca8081 from the following link.
https://www.qualcomm.com/products/internet-of-things/networking/wi-fi-networks/qca8081

Thanks,
Jie

