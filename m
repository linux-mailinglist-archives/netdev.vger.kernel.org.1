Return-Path: <netdev+bounces-47025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7DAC7E7A4E
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 09:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 083FA1C20B13
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 08:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986B5CA73;
	Fri, 10 Nov 2023 08:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="SiEpNg1Q"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140CACA44
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 08:54:01 +0000 (UTC)
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10EDA277;
	Fri, 10 Nov 2023 00:54:00 -0800 (PST)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AA7gTfg005899;
	Fri, 10 Nov 2023 08:53:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=4LcmdEDJvQ7VFdwA8ju7LruDX+WMtBJRIlXAucQVs6c=;
 b=SiEpNg1Q7/7aNdpXYqKXZ4HGTh9/tTYfZ7gkhSi0/3NbDOCrPhm3GWTL/AbSxoPFnarn
 jxwiqt/zcD3tOlmsJjo1Nt6Zpfc+vVml/SmjJrIlXkdjJvnby4dc136QyM94ED91VRUu
 Cl4RgHyytl5jVSdIh8Za0jtNKX45RE26Z9iEhd7gIrI4Va0HHGX0jwm469BEbtr9liCp
 CHFEplPkUeQf/LSn2H7HdhaNWQpJVB10B6Ne2ZJqSd1/fl3qcm3dkvCCTY6fkjL+DM/A
 zpNiTWpovcQWJGEPkvQ3h4rcx4MvPXFiQ6zjoDWUHtMYuBF4C36wcpJ9nk4FfaGnZbwG OQ== 
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3u9g4n07bn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 08:53:46 +0000
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3AA8rjqE010864
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Nov 2023 08:53:45 GMT
Received: from [10.253.8.167] (10.80.80.8) by nasanex01c.na.qualcomm.com
 (10.45.79.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 10 Nov
 2023 00:53:43 -0800
Message-ID: <0898312d-4796-c142-6401-c9d802d19ff4@quicinc.com>
Date: Fri, 10 Nov 2023 16:53:39 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 1/3] net: phy: at803x: add QCA8084 ethernet phy support
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: <andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20231108113445.24825-1-quic_luoj@quicinc.com>
 <20231108113445.24825-2-quic_luoj@quicinc.com>
 <20231108131250.66d1c236@fedora>
 <423a3ee3-bed5-02f9-f872-7b5dba64f994@quicinc.com>
 <20231109101618.009efb45@fedora>
Content-Language: en-US
From: Jie Luo <quic_luoj@quicinc.com>
In-Reply-To: <20231109101618.009efb45@fedora>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZQ4CdfVpa1DUCHPD-ol5lFEPEejbFqeI
X-Proofpoint-GUID: ZQ4CdfVpa1DUCHPD-ol5lFEPEejbFqeI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_04,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxscore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=516
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100073



On 11/9/2023 5:16 PM, Maxime Chevallier wrote:
> Hello,
> 
> On Thu, 9 Nov 2023 16:32:36 +0800
> Jie Luo <quic_luoj@quicinc.com> wrote:
> 
> [...]
> 
>>> What I understand from this is that this PHY can be used either as a
>>> switch, in which case port 4 would be connected to the host interface
>>> at up to 2.5G, or as a quad-phy, but since it uses QUSGMII the link
>>> speed would be limited to 1G per-port, is that correct ?
>>
>> When the PHY works on the interface mode QUSGMII for quad-phy, all 4
>> PHYs can support to the max link speed 2.5G, actually the PHY can
>> support to max link speed 2.5G for all supported interface modes
>> including qusgmii and sgmii.
> 
> I'm a bit confused then, as the USGMII spec says that Quad USGMII really
> is for quad 10/100/1000 speeds, using 10b/8b encoding.
> 
> Aren't you using the USXGMII mode instead, which can convey 4 x 2.5Gbps
>   with 66b/64b encoding ?
> 
> Thanks,
> 
> Maxime

Hi Maxime,
Yes, for quad PHY mode, it is using 66b/64 encoding.

it seems that PHY_INTERFACE_MODE_USXGMII is for single port,
so i take the interface name PHY_INTERFACE_MODE_QUSGMII for
quad PHYs here.

can we apply PHY_INTERFACE_MODE_USXGMII to quad PHYs in this
case(qca8084 quad PHY mode)?

Thanks,
Jie.

