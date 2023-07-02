Return-Path: <netdev+bounces-14985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFDD744D27
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 12:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D78280D84
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 10:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1037617ED;
	Sun,  2 Jul 2023 10:01:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CD017D3
	for <netdev@vger.kernel.org>; Sun,  2 Jul 2023 10:01:06 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7061612A;
	Sun,  2 Jul 2023 03:01:05 -0700 (PDT)
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 362A0htD025062;
	Sun, 2 Jul 2023 10:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=5NmKF6Dtx0WFynYD1yu40PVvG4JCk6q71/bw+brbYBQ=;
 b=InBenrzxEFA2ymyHsGBsP/PdrU4oMr75nYfwf3+iyT1UP31Kf4cXDSqlVVwUnAtxdduq
 eDKCcnNfAAD3g+n6qfQNS2FHdnOSPiD879YZxjo+tLARMm2MK7VhvJ7AOBGpRBG+x2mb
 vxiDYUbZf1nJ++cSGg0IIe/meDEkRlJYkxedwey4NrmbwdoDyIHVtToQhdZUnBdC15HN
 koU+ryVVDC8fhDxWZVgwthQNQ9oilyMRVjq6RfOxoJIRWl56dgV/WDyrbsENRHhQRepn
 /BSx4YQ7VELIRtv1XUkV49mUK+OGPeMsuevBv1NYtes0I8pdNk0Tjl+GOdQOXZqXhqnM oA== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3rjbfqj17y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 02 Jul 2023 10:00:42 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 362A0fR8023359
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 2 Jul 2023 10:00:41 GMT
Received: from [10.253.13.42] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.7; Sun, 2 Jul 2023
 03:00:39 -0700
Message-ID: <a5929836-2da4-af9b-7310-73bdc05c8e83@quicinc.com>
Date: Sun, 2 Jul 2023 18:00:36 +0800
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
 <7144731c-f4ae-99b6-d32a-1d0e39bc9ee7@quicinc.com>
 <d4043e1f-d683-48c2-af79-9fea14ab7cc1@lunn.ch>
 <49f8ca40-e079-ad00-256e-08a61ffced22@quicinc.com>
 <34ef466e-df95-4be4-8366-64baf5f04cca@lunn.ch>
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <34ef466e-df95-4be4-8366-64baf5f04cca@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wgnCkkoHbDD_nWmzAIDnJ0jGv4qPCOrR
X-Proofpoint-ORIG-GUID: wgnCkkoHbDD_nWmzAIDnJ0jGv4qPCOrR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-02_08,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 bulkscore=0
 mlxlogscore=661 phishscore=0 clxscore=1015 impostorscore=0 mlxscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307020093
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 7/2/2023 12:21 AM, Andrew Lunn wrote:
>> Hi Andrew,
>> it is the PLL related registers, there is no PHY ID existed in MII register
>> 2, 3 of this block, so it can't be instantiated as the generic PHY device.
> 
> Well, phylib is going to scan those ID registers, and if it finds
> something other than 0xffff 0xffff in those two ID registers it is
> going to think a PHY is there. And then if there is no driver using
> that ID, it will instantiate a generic PHY.
> 
> You might be able to see this in /sys/bus/mdio_bus, especially if you
> don't have a DT node representing the MDIO bus.
> 
>        Andrew
Okay, understand it. thanks Andrew for pointing this.
i will check it.

