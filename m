Return-Path: <netdev+bounces-256225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gMR8NDnHgWk0JwMAu9opvQ
	(envelope-from <netdev+bounces-256225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BED7D7388
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 11:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D282330138B2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E1396B74;
	Tue,  3 Feb 2026 09:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D7sKfpOq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E71393DDE;
	Tue,  3 Feb 2026 09:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770112629; cv=none; b=ij+eBuahrOxjploQx1ZG38AHVUmFhaijP3i/KS6vpEZd0245wQ82Ixs+1lNwBaqk9Yjz9HATDewvQjyxfV5rrL3TAJfCfCvet6Jr7VZVhO0xA7o/AqFbMP3PhxtNUCQhmqJmeiAp+zVhGgIswWvhNd5TsOWQrApH1AQux2ZyDQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770112629; c=relaxed/simple;
	bh=EUgy0IAJ5j0P1D+NYztYFmt88gDGQJLI+V2NPdwGXCo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fp18vXle/ol9q6vmkzzDW4hA09tGFAvgYxbhaGg4jMxf6J4719XpzUKi/e7yDdo4KtNLWxBmFuYTigw8tKaw91hi3J85kYyvdfac11Lwfci8tOETOLX9u0+dw5cHvcWnTcmc8Wl8MkANgfe0jsgCsCfQgK9MNGcS5JntRoyq8tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D7sKfpOq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 6131scWZ025324;
	Tue, 3 Feb 2026 09:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ql+DEP
	lp5fFK9lwAFt31Q1tcqhvjvE7n0PwRkg3SLOA=; b=D7sKfpOqUQ/CQRSTZfcpeB
	WLiCldmxL7MgLpV9Fmc0N5wvHgbUKrkzKbLinentD7d+GpA/I8XwLYnHTCj3w8ge
	0DdHB2181Pv2dhsvVg159/OvI3I05ykWQ7YGy8336q2tuEpU7J7RL0C8GWKW/+kN
	331B5MbuQxrzsRoqn22uNHW543Ra0Mf8Fekv2z5D3HQIGGBNB0n2TrEtlLu1v7O8
	joUAcGJ7KRjjn6zjIX83x049mXok3JzSafMf3hCkgqgDdPHMN3tSPnhzdVUB7xmV
	uhKF8THzTckTWLRs+GeJDbzC/5bsl1CZwVlp8gHxKP8lhHBiKffYv75EobK6aGMQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6cq7q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:56:53 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 6135dlOt025706;
	Tue, 3 Feb 2026 09:56:52 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4c1w2mrkhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Feb 2026 09:56:52 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6139up6628967628
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Feb 2026 09:56:52 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D2DDE58056;
	Tue,  3 Feb 2026 09:56:51 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE3E558052;
	Tue,  3 Feb 2026 09:56:48 +0000 (GMT)
Received: from [9.109.248.127] (unknown [9.109.248.127])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Feb 2026 09:56:48 +0000 (GMT)
Message-ID: <007a2100-0913-4a8f-82d3-8118664fc1a7@linux.ibm.com>
Date: Tue, 3 Feb 2026 15:26:47 +0530
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH phy] phy: enter drivers/phy/Makefile even without
 CONFIG_GENERIC_PHY
Content-Language: en-GB
To: Vladimir Oltean <vladimir.oltean@nxp.com>, linux-phy@lists.infradead.org,
        Vinod Koul <vkoul@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>, broonie@kernel.org
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
        =?UTF-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>,
        linux-kernel@vger.kernel.org,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
References: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
From: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
In-Reply-To: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dqa0YwJcz00rU6QBJE95XkQcdrf1Hdkl
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=6981c665 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=8AirrxEcAAAA:8 a=N9vyIDjvMmDcvu0NZNMA:9
 a=QEXdDO2ut3YA:10 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: dqa0YwJcz00rU6QBJE95XkQcdrf1Hdkl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDA3OCBTYWx0ZWRfX5lxuQZobrzF0
 eCbpusseL/0WmoRcWzBXw0b9wgfu+DrEZYxUbQMcwhzIh72nyCuO8+w/L6zpQ2IAdL41X4tr4Tt
 rx0RNESdpRuEYRV5AnrEn3mTLNXTYQGAzI8QEpHPB9gteM7B/0Sham54pW+odQowOeNEiSvqv/a
 PTuj90gCFHOs05pqBAIK+NIsh7zNniuOmaR8Pk1yDbZoeurgva6RJi1dN2tDYRvqnmwyL04l6Ym
 TguoaMDOQTG7MPGHabgXUFT3QaRn9ZoHhGILhuisWnbmz5hU5QTIwZhdZy3RFMDKLpNi1hgWe9W
 Zvgx0+7lkS3JdiOInCvo3Yv+rUXZrmtwVZt9zoMZl4tPkETM5A8u5wiINoRAgB7VipHT3AdSS9D
 O7MiyIiELy2l17h+bOmiGJJ+rn5cghn3vZfN0nU8U0Y6OILBb62Mnp5Jzg3eoV4vkvhZs3Z2dYQ
 YItHZLY9pE84wyqZFhA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_03,2026-02-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602030078
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ibm.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[ibm.com:s=pp1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[ibm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256225-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.ibm.com:mid,nxp.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NEQ_ENVFROM(0.00)[venkat88@linux.ibm.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 1BED7D7388
X-Rspamd-Action: no action


On 23/01/26 4:36 pm, Vladimir Oltean wrote:
> Kconfig option CONFIG_PHY_COMMON_PROPS, which builds
> drivers/phy/phy-common-props.c, was intended to be selectable
> independently of CONFIG_GENERIC_PHY. Yet it lives in drivers/phy/, which
> is entered by the Makefile only if CONFIG_GENERIC_PHY is set.
>
> Allow the Makefile to enter one level deeper, but stop at drivers/phy/
> if CONFIG_GENERIC_PHY is unselected (i.e. do not enter vendor folders).
> The other stuff from drivers/phy/Makefile except for CONFIG_PHY_COMMON_PROPS,
> like CONFIG_PHY_NXP_PTN3222, all depends on CONFIG_GENERIC_PHY.
>
> Fixes: e7556b59ba65 ("phy: add phy_get_rx_polarity() and phy_get_tx_polarity()")
> Closes: https://lore.kernel.org/lkml/43ea0202-891d-4582-980b-5cb557b41114@linux.ibm.com/
> Reported-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
> Debugged-by: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
>   drivers/Makefile     | 2 +-
>   drivers/phy/Makefile | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/Makefile b/drivers/Makefile
> index ccc05f1eae3e..53fbd2e0acdd 100644
> --- a/drivers/Makefile
> +++ b/drivers/Makefile
> @@ -10,7 +10,7 @@ obj-y				+= cache/
>   obj-y				+= irqchip/
>   obj-y				+= bus/
>   
> -obj-$(CONFIG_GENERIC_PHY)	+= phy/
> +obj-y				+= phy/
>   
>   # GPIO must come after pinctrl as gpios may need to mux pins etc
>   obj-$(CONFIG_PINCTRL)		+= pinctrl/
> diff --git a/drivers/phy/Makefile b/drivers/phy/Makefile
> index 30b150d68de7..93715ea0d010 100644
> --- a/drivers/phy/Makefile
> +++ b/drivers/phy/Makefile
> @@ -15,7 +15,7 @@ obj-$(CONFIG_PHY_SNPS_EUSB2)		+= phy-snps-eusb2.o
>   obj-$(CONFIG_USB_LGM_PHY)		+= phy-lgm-usb.o
>   obj-$(CONFIG_PHY_AIROHA_PCIE)		+= phy-airoha-pcie.o
>   obj-$(CONFIG_PHY_NXP_PTN3222)		+= phy-nxp-ptn3222.o
> -obj-y					+= allwinner/	\
> +obj-$(CONFIG_GENERIC_PHY)		+= allwinner/	\
>   					   amlogic/	\
>   					   broadcom/	\
>   					   cadence/	\


I still see linux-next build failures with next-20260202. Can we please 
have this patch merged.


Mark, can you please pull this one.


Regards,

Venkat.


