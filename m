Return-Path: <netdev+bounces-50762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B08F7F7053
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 10:47:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CFEE1C20ED5
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 09:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA968171B6;
	Fri, 24 Nov 2023 09:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CKvDX34v"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CAA0D71;
	Fri, 24 Nov 2023 01:47:25 -0800 (PST)
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AO7j93Y021237;
	Fri, 24 Nov 2023 09:47:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=ZPXgpnugqVZGKoYb8pnDz47Cff9lnhLDr+ItJWa9BP0=;
 b=CKvDX34v3pYSFKvSejLvOoMkallkW6vB/ysTYKNxV66DhGomXgb2z95XAdt9TLLcoRp6
 02H3T/LP1DRi3K6kJctxQV182IJOcNfZpbo95tMKxTW+0I8euV32KSuBnYd8GGPUinSv
 ZUKIhQzW0ragJW8ddlsR68bKHIVJ1T+6R7MurZAKXTjtKUnm9B0fcQLMP1wMgDZ2i6my
 +H3Vso8D8mgfqIyIRgPkKIOUTzDjoD/0wla4e1kbVCSBRomMOtzVhbL8X6eZ0s/R2wch
 51L5mnKIOn9N4kraX0+/zTQaJiKcqPeouAY1OxLmtQ2NQ31FnhRyyTlZtPoWVIqAPK0W qA== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uj30xagya-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 09:47:11 +0000
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AO9lA2G019302
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Nov 2023 09:47:10 GMT
Received: from [10.253.33.181] (10.80.80.8) by nalasex01c.na.qualcomm.com
 (10.47.97.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 24 Nov
 2023 01:47:07 -0800
Message-ID: <1bd2f3a9-3dd1-4c95-b4e5-c9bf2274f271@quicinc.com>
Date: Fri, 24 Nov 2023 17:47:04 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/6] net: phy: at803x: add QCA8084 ethernet phy support
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
CC: Andrew Lunn <andrew@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hkallweit1@gmail.com>, <corbet@lwn.net>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>
References: <20231118062754.2453-1-quic_luoj@quicinc.com>
 <20231118062754.2453-4-quic_luoj@quicinc.com>
 <1eb60a08-f095-421a-bec6-96f39db31c09@lunn.ch>
 <ZVkRkhMHWcAR37fW@shell.armlinux.org.uk>
 <eee39816-b0b8-475c-aa4a-8500ba488a29@lunn.ch>
 <fef2ab86-ccd7-4693-8a7e-2dac2c80fd53@quicinc.com>
 <1d4d7761-6b42-48ec-af40-747cb4b84ca5@lunn.ch>
 <316fb626-4dc3-4540-9cc4-e45840e36f77@quicinc.com>
 <ZVyZ+8Q2eNfAKjO/@shell.armlinux.org.uk>
 <d2ac542c-aae3-49ae-ae2b-9defc4ca98eb@quicinc.com>
 <ZV8+/4eNzLpLzSDG@shell.armlinux.org.uk>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <ZV8+/4eNzLpLzSDG@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: aiyM4pSnaDMmdiJAqPYIRFscEDZWJEmM
X-Proofpoint-GUID: aiyM4pSnaDMmdiJAqPYIRFscEDZWJEmM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_15,2023-11-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311240076



On 11/23/2023 8:01 PM, Russell King (Oracle) wrote:
> On Thu, Nov 23, 2023 at 06:57:59PM +0800, Jie Luo wrote:
>> On 11/21/2023 7:52 PM, Russell King (Oracle) wrote:
>>> Ultimately, you will need a way to use inband signalling with Cisco
>>> SGMII for 10M/100M/1G speeds, and then switch to 2500base-X when
>>> operating at 2.5G speeds, and that is done via the PHY driver
>>> updating phydev->interface.
>>>
>>> What we do need is some way for the PHY to also tell the PCS/MAC
>>> whether inband should be used. This is something I keep bringing up
>>> and now that we have PCS drivers revised to use the value from
>>> phylink_pcs_neg_mode() _and_ a consistent implementation amongst them
>>> we can now think about signalling to PCS drivers whether inband mode
>>> needs to be turned off when switching between modes.
>>
>> Yes, we can switch the interface mode according to the current link
>> speed in the pcs driver.
>> but the issue is that the phy-mode i specified for the PHYLINK,
>> if phy-mode is sgmii, the support capability is limited to maximum
>> capability 1G during the PHYLINK setup and i can't configure it to 2.5G
>> dynamically, if the phy-mode is 2500base-x, then PHY capability will
>> be modified to only support 2.5G, other speeds can't be linked up.
> 
> So you need my patches that add "possible_interfaces" to phylib so you
> can tell phylink that you will be switching between SGMII and
> 2500base-X. Please see the RFC posting of those patches I sent
> yesterday and try them out - you will need to modify your phylib
> driver to fill in phydev->possible_interfaces.

Your patches work on my board, thanks Russell.

> 
>>> There have been patches in the past that allow inband mode to be
>>> queried from phylib, and this is another important component in
>>> properly dealing with PHYs that need to use inband signalling with
>>> Cisco SGMII, but do not support inband signalling when operating at
>>> 2.5G speeds. The problem when operating at 2.5G speed is that the
>>> base-X protocols are normally for use over fibre, which is the media,
>>> and therefore the ethtool Autoneg bit should define whether inband
>>> gets used or not. However, in the case of a PHY using 2500base-X,
>>> the Autoneg bit continues to define whether autonegotiation should
>>> be used on the media, and in this case it's the media side of the
>>> PHY rather than the 2500base-X link.
>>>
>>> So, when using a 2500base-X link to a PHY, we need to disregard the
>>> Autoneg bit, but that then raises the question about how we should
>>> configure it - and one solution to that would be to entire of phylib
>>> what the PHY wants to do. Another is to somehow ask the PCS driver
>>> whether it supports inband signalling at 2500base-X, and resolve
>>> those capabilities.
>>
>> For the qca808x PHY, when it is linked in 2.5G, the autoneg is also
>> disabled in PCS hardware, so the sgmii+ of qca808x PHY is almost
>> same as 2500base-X.
> 
> Not "almost". It _is_ the same. This is the point I've been trying
> to get across to you. Without inband signalling, 1000base-X and SGMII
> (when operating at 1G) are _identical_ and entirely compatible.
> 
> You've said that your 2.5G "SGMII" mode has inband signalling disabled,
> and thus it without inband signalling, 2500base-X and this 2.5G mode
> are again identical and entirely compatible. There's no "almost" about
> it.
> 
> 
Yes, confirmed with HW guy, they work on the same way.

