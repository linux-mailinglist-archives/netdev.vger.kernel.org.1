Return-Path: <netdev+bounces-59175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 506E7819A82
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B8581F21712
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 08:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B817A1BDD6;
	Wed, 20 Dec 2023 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="iLcEpYrg"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071FD1CABE
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3BK5HEqn021006;
	Wed, 20 Dec 2023 08:30:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=5h3YNvOImzMOpYmbZgkkNX5ev5WlgZMPMQcjORS+nX0=; b=iL
	cEpYrg3W9XLIFEcWVzVrTN66Nnuhx8QJbHeBU2HYznwuKqDAZmyCdM02SKs5asus
	yQ2LIduTbDTX3JXVVh0VSw8WeGoVP9scR2QwU3DYXQZUv/pzUkjLgVELK8CAxApi
	QyFYkbcu447gIKd0cRKJxLa2ed+KupIK6G6ey91Q8OJ5kSq6be86BNB0Fe0jn4aB
	zOjHm3eV4Td98bCR4c3yUnbvDHZB4+7pwCZxDRz+JV+aD7fuPqfWeLtY9orUxo9u
	r8BCNZX9PyC83rbwN1F6srS/E8wq25VBqM5M0XvKJChdzT2/QsaF+HA+DcDRXjqH
	2RFDqYFezFcm53vve4Sg==
Received: from nasanppmta03.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3v37vxtym9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:30:14 +0000 (GMT)
Received: from nasanex01a.na.qualcomm.com (nasanex01a.na.qualcomm.com [10.52.223.231])
	by NASANPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3BK8UDjq019722
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Dec 2023 08:30:13 GMT
Received: from [10.253.69.179] (10.80.80.8) by nasanex01a.na.qualcomm.com
 (10.52.223.231) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 20 Dec
 2023 00:30:11 -0800
Message-ID: <78b23ab0-f05b-49e4-8ca5-60b16a1cb8ea@quicinc.com>
Date: Wed, 20 Dec 2023 16:30:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: sfp: fix PHY discovery for FS SFP-10G-T
 module
Content-Language: en-US
To: =?UTF-8?Q?Marek_Beh=C3=BAn?= <kabel@kernel.org>, <netdev@vger.kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
CC: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew@lunn.ch>
References: <20231219162415.29409-1-kabel@kernel.org>
From: Lei Wei <quic_leiwei@quicinc.com>
In-Reply-To: <20231219162415.29409-1-kabel@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01a.na.qualcomm.com (10.52.223.231)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 26ekXVBH_503jp8uhJxpUoy6innW3yy0
X-Proofpoint-GUID: 26ekXVBH_503jp8uhJxpUoy6innW3yy0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1011 mlxscore=0 adultscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311290000 definitions=main-2312200058



On 12/20/2023 12:24 AM, Marek Behún wrote:
> Commit 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
> changed the long wait before accessing RollBall / FS modules into
> probing for PHY every 1 second, and trying 25 times.
> 
> Wei Lei reports that this does not work correctly on FS modules: when
> initializing, they may report values different from 0xffff in PHY ID
> registers for some MMDs, causing get_phy_c45_ids() to find some bogus
> MMD.
> 
> Fix this by adding the module_t_wait member back, and setting it to 4
> seconds for FS modules.
> 
> Fixes: 2f3ce7a56c6e ("net: sfp: rework the RollBall PHY waiting code")
> Reported-by: Wei Lei <quic_leiwei@quicinc.com>
> Signed-off-by: Marek Behún <kabel@kernel.org>
Tested-by: Lei Wei <quic_leiwei@quicinc.com>

Regards,
Lei Wei
> ---
> Lei, could you please test this and send a Tested-by tag?
Marek, verified it is working, thank you for the fix.
> ---
>   drivers/net/phy/sfp.c | 17 +++++++++++++----
>   1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 3780a96d2caa..f75c9eb3958e 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -274,6 +274,7 @@ struct sfp {
>   	struct sfp_eeprom_id id;
>   	unsigned int module_power_mW;
>   	unsigned int module_t_start_up;
> +	unsigned int module_t_wait;
>   	unsigned int phy_t_retry;
>   
>   	unsigned int rate_kbd;
> @@ -388,6 +389,12 @@ static void sfp_fixup_fs_10gt(struct sfp *sfp)
>   {
>   	sfp_fixup_10gbaset_30m(sfp);
>   	sfp_fixup_rollball(sfp);
> +
> +	/* The RollBall fixup is not enough for FS modules, the AQR chip inside
> +	 * them does not return 0xffff for PHY ID registers in all MMDs for the
> +	 * while initializing. They need a 4 second wait before accessing PHY.
> +	 */
> +	sfp->module_t_wait = msecs_to_jiffies(4000);
>   }
>   
>   static void sfp_fixup_halny_gsfp(struct sfp *sfp)
> @@ -2329,6 +2336,7 @@ static int sfp_sm_mod_probe(struct sfp *sfp, bool report)
>   		mask |= SFP_F_RS1;
>   
>   	sfp->module_t_start_up = T_START_UP;
> +	sfp->module_t_wait = T_WAIT;
>   	sfp->phy_t_retry = T_PHY_RETRY;
>   
>   	sfp->state_ignore_mask = 0;
> @@ -2566,9 +2574,10 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
>   
>   		/* We need to check the TX_FAULT state, which is not defined
>   		 * while TX_DISABLE is asserted. The earliest we want to do
> -		 * anything (such as probe for a PHY) is 50ms.
> +		 * anything (such as probe for a PHY) is 50ms (or more on
> +		 * specific modules).
>   		 */
> -		sfp_sm_next(sfp, SFP_S_WAIT, T_WAIT);
> +		sfp_sm_next(sfp, SFP_S_WAIT, sfp->module_t_wait);
>   		break;
>   
>   	case SFP_S_WAIT:
> @@ -2582,8 +2591,8 @@ static void sfp_sm_main(struct sfp *sfp, unsigned int event)
>   			 * deasserting.
>   			 */
>   			timeout = sfp->module_t_start_up;
> -			if (timeout > T_WAIT)
> -				timeout -= T_WAIT;
> +			if (timeout > sfp->module_t_wait)
> +				timeout -= sfp->module_t_wait;
>   			else
>   				timeout = 1;
>   

