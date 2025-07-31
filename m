Return-Path: <netdev+bounces-211213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA052B172DA
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 16:09:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D884E3AB5A8
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 14:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B81B92D0C61;
	Thu, 31 Jul 2025 14:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="Z7R0qlob"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BACFB2C1592;
	Thu, 31 Jul 2025 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753970935; cv=none; b=FbPnuYPZwFI/DfmQ9kS8dL9JLid93hS9mlMWa6c1GfTejbZruSMVPJv7tDGRYfr9lMgquIH65kmTXj/fhmZ4UGkUU/jQQ7HOq/js9O2AdzefvfAxqo59Gl8pS0fRdBxkXhiV9M1CKwt+1t0LWTv1Qbn2G3bURtMnJ2YvNQCcFBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753970935; c=relaxed/simple;
	bh=IhazWnX0Ie2A7nq7YZMU15l1oja3fKapcv94+Ewg6/Q=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=C2ytEt3H1sFB9OAqlwCi1qZE9cUrbe3nzugl4qhS4eQ9xEL6xY8cozrR00LUXFbxoJXAIS95nXhrqM3ja/5FuwR84+2+/UVA5jFKOxHxE5Qdb2UUPEqPJeiZyFF7eqOgUFAhVFogTjc8+uX1CApgUJAym2ReI4ftGfSVeBMBYZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Z7R0qlob; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AEYszsMZ3+ElcqGm4ka7SjfhYKXmqGiGIARsMrr7wZE=; b=Z7R0qlobHPqcaH7XSk/3mlL4L8
	LSo1tDA8vZlnV5pNvbq/V7PuDp50b3/PLIx4C6K6aLYRLjG8eo4zSy2iq6AzNtjO/ZN1RHmzPoluE
	v8mdrKmniRV3RShGzFP9EejDsK7oVgvdc3zIznNYyMdYvYV0b+Uq39DsmcFHLlknv0ETr4d26zXvn
	jO28sEV1tXLyyiHhv7juBA3rnPokLfteUH5frKOmT0F5lp9xRvrqUQkaXbrpi0V+dH2TvYZCY+fhN
	ZSbwqlRVBznv7vdKmKGCxngYapV2i2ftdGyLQjfn47SYTlXK/9+kXBU5UDBc8o8G6Eypt310Nqeuy
	i9SvQ38A==;
Received: from [122.175.9.182] (port=13399 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uhTxX-0000000EGTY-3yKC;
	Thu, 31 Jul 2025 10:08:40 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id DFBE91781F30;
	Thu, 31 Jul 2025 19:38:29 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id BCB3E1783F55;
	Thu, 31 Jul 2025 19:38:29 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 6AURxpk8PQ31; Thu, 31 Jul 2025 19:38:29 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 676801781F30;
	Thu, 31 Jul 2025 19:38:29 +0530 (IST)
Date: Thu, 31 Jul 2025 19:38:29 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	kory maincent <kory.maincent@bootlin.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1271782907.78002.1753970909117.JavaMail.zimbra@couthit.local>
In-Reply-To: <3502ed81-7d97-4a01-806f-5c5ae307b6af@oracle.com>
References: <20250724072535.3062604-1-parvathi@couthit.com> <20250724091122.3064350-6-parvathi@couthit.com> <3502ed81-7d97-4a01-806f-5c5ae307b6af@oracle.com>
Subject: Re: [PATCH net-next v12 5/5] net: ti: prueth: Adds IEP support for
 PRUETH on AM33x, AM43x and AM57x SOCs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds IEP support for PRUETH on AM33x, AM43x and AM57x SOCs
Thread-Index: a5kfM/1JYdqAkU1Z+JlX9yQuLFXrSQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On 7/24/2025 2:40 PM, Parvathi Pudi wrote:
>> Added API hooks for IEP module (legacy 32-bit model) to support
>> timestamping requests from application.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
>> ---
>>   drivers/net/ethernet/ti/icssg/icss_iep.c      | 103 ++++++++++++++++++
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.c  |  72 +++++++++++-
>>   drivers/net/ethernet/ti/icssm/icssm_prueth.h  |   2 +
>>   .../net/ethernet/ti/icssm/icssm_prueth_ptp.h  |  85 +++++++++++++++
>>   4 files changed, 260 insertions(+), 2 deletions(-)
>>   create mode 100644 drivers/net/ethernet/ti/icssm/icssm_prueth_ptp.h
>> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> index 2a1c43316f46..59aca63e2fe5 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.c
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.c
>> @@ -968,11 +968,114 @@ static const struct icss_iep_plat_data
>> am654_icss_iep_plat_data = {
>>   	.config = &am654_icss_iep_regmap_config,
>>   };
>>   
>> +static const struct icss_iep_plat_data am57xx_icss_iep_plat_data = {
>> +	.flags = ICSS_IEP_64BIT_COUNTER_SUPPORT |
>> +		 ICSS_IEP_SLOW_COMPEN_REG_SUPPORT,
>> +	.reg_offs = {
>> +		[ICSS_IEP_GLOBAL_CFG_REG] = 0x00,
>> +		[ICSS_IEP_COMPEN_REG] = 0x08,
>> +		[ICSS_IEP_SLOW_COMPEN_REG] = 0x0C,
> 
> using both uppercase and lowercase hex
> 

Sure, We will check and address this.

>> +		[ICSS_IEP_COUNT_REG0] = 0x10,
>> +		[ICSS_IEP_COUNT_REG1] = 0x14,
>> +		[ICSS_IEP_CAPTURE_CFG_REG] = 0x18,
>> +		[ICSS_IEP_CAPTURE_STAT_REG] = 0x1c,
>> +
>> +		[ICSS_IEP_CAP6_RISE_REG0] = 0x50,
>> +		[ICSS_IEP_CAP6_RISE_REG1] = 0x54,
>> +
>> +		[ICSS_IEP_CAP7_RISE_REG0] = 0x60,
>> +		[ICSS_IEP_CAP7_RISE_REG1] = 0x64,
>> +
>> +		[ICSS_IEP_CMP_CFG_REG] = 0x70,
>> +		[ICSS_IEP_CMP_STAT_REG] = 0x74,
>> +		[ICSS_IEP_CMP0_REG0] = 0x78,
>> +		[ICSS_IEP_CMP0_REG1] = 0x7c,
>> +		[ICSS_IEP_CMP1_REG0] = 0x80,
>> +		[ICSS_IEP_CMP1_REG1] = 0x84,
>> +
>> +		[ICSS_IEP_CMP8_REG0] = 0xc0,
>> +		[ICSS_IEP_CMP8_REG1] = 0xc4,
>> +		[ICSS_IEP_SYNC_CTRL_REG] = 0x180,
>> +		[ICSS_IEP_SYNC0_STAT_REG] = 0x188,
>> +		[ICSS_IEP_SYNC1_STAT_REG] = 0x18c,
>> +		[ICSS_IEP_SYNC_PWIDTH_REG] = 0x190,
>> +		[ICSS_IEP_SYNC0_PERIOD_REG] = 0x194,
>> +		[ICSS_IEP_SYNC1_DELAY_REG] = 0x198,
>> +		[ICSS_IEP_SYNC_START_REG] = 0x19c,
>> +	},
>> +	.config = &am654_icss_iep_regmap_config,
>> +};
>> +
>> +static bool am335x_icss_iep_valid_reg(struct device *dev, unsigned int reg)
>> +{
>> +	switch (reg) {
>> +	case ICSS_IEP_GLOBAL_CFG_REG ... ICSS_IEP_CAPTURE_STAT_REG:
>> +	case ICSS_IEP_CAP6_RISE_REG0:
>> +	case ICSS_IEP_CMP_CFG_REG ... ICSS_IEP_CMP0_REG0:
>> +	case ICSS_IEP_CMP8_REG0 ... ICSS_IEP_SYNC_START_REG:
>> +		return true;
>> +	default:
>> +		return false;
>> +	}
>> +
>> +	return false;
> 
> Redundant code after default return
> 

Sure, We will address this.

>> +}
>> +
> [clip]
>>   
>> @@ -1434,12 +1490,19 @@ static int icssm_prueth_probe(struct platform_device
>> *pdev)
>>   		}
>>   	}
>>   
>> +	prueth->iep = icss_iep_get(np);
>> +	if (IS_ERR(prueth->iep)) {
>> +		ret = PTR_ERR(prueth->iep);
>> +		dev_err(dev, "unable to get IEP\n");
>> +		goto netdev_exit;
>> +	}
>> +
>>   	/* register the network devices */
>>   	if (eth0_node) {
>>   		ret = register_netdev(prueth->emac[PRUETH_MAC0]->ndev);
>>   		if (ret) {
>>   			dev_err(dev, "can't register netdev for port MII0");
>> -			goto netdev_exit;
>> +			goto iep_put;
>>   		}
>>   
>>   		prueth->registered_netdevs[PRUETH_MAC0] =
>> @@ -1473,6 +1536,9 @@ static int icssm_prueth_probe(struct platform_device
>> *pdev)
>>   		unregister_netdev(prueth->registered_netdevs[i]);
>>   	}
>>   
>> +iep_put:
>> +	icss_iep_put(prueth->iep);
> 
> prueth->iep = NULL; avoid potential use-after-free
> 

Sure, We will check and address this.


Thanks and Regards,
Parvathi.

