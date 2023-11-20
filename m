Return-Path: <netdev+bounces-49134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 608397F0E20
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 09:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 912371C2110E
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 08:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B5AF4F9;
	Mon, 20 Nov 2023 08:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="W/0pELhd"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F3959F;
	Mon, 20 Nov 2023 00:50:25 -0800 (PST)
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AK8SJYa027567;
	Mon, 20 Nov 2023 08:50:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=bRhQqXUSR38rCMhKg6XOiQKLQfGqT2lEI3OV7JyNAio=;
 b=W/0pELhd2F2GNjnzKaj86R7jYdEiIx2Q1qTpPrW7Js9iLIdCAbvpXwvdETx2Rvu8AUdR
 8DEsrXJWqzyn+fb4FAANiwk/lYKPnkptAC6TgErOw1GwUIHfeKnJUbcF/MU3UGtdxGgB
 nfJPMouJQeLhD3C4W3sIAG1A7Wh6cvTO+AQGTMcey4G9jGaNFzL6kytHD2Pbf6TBLPds
 Uke3a8OWOCVq07bL9kqV/yGT66v7bJrz9zr/Ai/hFixXYmKOlS1DP27zhDxSBISZ8rGP
 l5K9zNPxu7e3Qb7aHkS0s83AvlSZpDpeJyTjiHU8dKN6zJNFcMvsNGZFRBugSPWXaDI4 YQ== 
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uem80kgkm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 08:50:06 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AK8o5EV001424
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Nov 2023 08:50:05 GMT
Received: from [10.253.8.221] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 20 Nov
 2023 00:50:01 -0800
Message-ID: <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
Date: Mon, 20 Nov 2023 16:49:59 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
To: Andrew Lunn <andrew@lunn.ch>,
        "Russell King (Oracle)"
	<linux@armlinux.org.uk>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: NaSybp2TbFDC43rnDagD-bOPEev2BA54
X-Proofpoint-ORIG-GUID: NaSybp2TbFDC43rnDagD-bOPEev2BA54
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-20_06,2023-11-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 adultscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 impostorscore=0 lowpriorityscore=0 mlxscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311200058



On 11/19/2023 4:19 AM, Andrew Lunn wrote:
>> 10G_QXGMII is defined in the Cisco USXGMII multi-port document as one
>> of several possibilities for a USXGMII-M link. The Cisco document can
>> be a little confusing beause it states that 10G_QXGMII supports 10M,
>> 100M, 1G and 2.5G, and then only talks about a 10G and 100M/1G MAC.
>>
>> For 10G_QXGMII, there are 4 MAC interfaces. These are connected to a
>> rate "adaption" through symbol replication block, and then on to a
>> clause 49 PCS block.
>>
>> There is then a port MUX and framing block, followed by the PMA
>> serdes which communicates with the remote end over a single pair of
>> transmit/receive serdes lines.
>>
>> Each interface also has its own clause 37 autoneg block.
>>
>> So, for an interface to operate in SGMII mode, it would have to be
>> muxed to a different path before being presented to the USXGMII-M
>> block since each interface does not have its own external data lane
>> - thus that's out of scope of USXGMII-M as documented by Cisco.
> 
> Hi Russell
> 
> I think it helps.
> 
> Where i'm having trouble is deciding if this is actually an interface
> mode. Interface mode is a per PHY property. Where as it seems
> 10G_QXGMII is a property of the USXGMII-M link? Should we be
> representing the package with 4 PHYs in it, and specify the package
> has a PMA which is using 10G_QXGMII over USXGMII-M? The PHY interface
> mode is then internal? Its just the link between the PHY and the MUX?
> 
> By saying the interface mode is 10G_QXGMII and not describing the PMA
> mode, are we setting ourselves up for problems in the future? Could
> there be a PMA interface which could carry different PHY interface
> modes?
> 
> If we decide we do want to use 10G_QXGMII as an interface made, i
> think the driver should be doing some validation. If asked to do
> anything else, it should return -EINVAL.
> 
> And i don't yet understand how it can also do 1000BaseX and 2500BaseX
> and SGMII?
> 
>      Andrew

Hi Andrew,
The interface mode 10G_QXGMII is a type of USXGMII-M, the other modes
such as 20G-QXGMII, 20G-OXGMII...

As for the interface mode 10G-QXGMII, there is a multiplexer for 4 PHYs,
then do 66bit/68bit encode in xpcs and pass to PMA, the link topology:
quad PHY --- multiplexer ---XPCS --- PMA.
the 10G-QXGMII interface block includes multiplexer, XPCS and PMA.

when the PHY works on SGMII mode, then there is no xpcs, the only fourth
PHY of qca8084 can work on SGMII mode, the link topology:
the fourth PHY --- PCS --- PMA, the SGMII block includes PCS and PMA.

Either 10G-QXGMII or SGMII block of qca8084 connects with the interface
block(10G-QXGMII or SGMII) in MAC side.

Here is a problem as Russell mentioned earlier, we need to know which 
PHY device is changing the link status when the 10G-QXGMII mode is used,
since there are 4 PHYs, when one of them has the link change, there is 
no PHY device information passed to the PHYLINK, so the PCS driver don't
which PHY is changing link status and 10G-QXGMII mode don't know which
channel(mapped to PHY) should be configured.

would we add a field such as (int channel) in the struct phy_device?
so we can pass this information to PCS driver when the PHY link changed.

Thanks,

