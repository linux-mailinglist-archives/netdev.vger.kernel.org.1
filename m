Return-Path: <netdev+bounces-206154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 95362B01C01
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3453418856A0
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3F2980CD;
	Fri, 11 Jul 2025 12:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="KdzVv9fJ"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4A24A24;
	Fri, 11 Jul 2025 12:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236939; cv=none; b=sSMVmb7oZISFiFB2TqDG7/qyRe3a6N5Ky0N4btCm2a/stjXhxnn01HW2iJAHXnBBDuHmnTCYdyrXQWROMzglRQf4Mqjd2eQp57eZCFc5e26TLYR7ryFVmgxx0fgRFynJmTPm4jjNPfOdxImkSYyYDmnAI60DnoagBGNfMXReSBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236939; c=relaxed/simple;
	bh=qmzq1pOQM0ypSqmAdWUTgIxlGajH4PTjlJPXxq9LSBk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=hxWTkTt+wLSMSnG6fhNXA18TrBd8I8z1STd6sDLxnFWI8/E4vp71fH1pB/KEldr2hFF9RYXNH2Nhs3aNU5NVHHizxceKD6g3QGc5Sse+0QxGtZQFIW1Lz6ffBqcYG/7Eoqq69IOTnYu3abYJHP8OBJf456xmeOXzWD3bYyQtjBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=KdzVv9fJ; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9CQ37NQ7OuN9s6t6lsJ/sx9p8s2M7suKYbs3UhLaa68=; b=KdzVv9fJDf1XQb1jdC6biZosKz
	lhUsKc4Ozz7nrtcgc6s/SI5EEfw4iRs+htJe8XA15k9mVD2Qk2UefELYDwZMUtlWO+pq8bXpgYtgZ
	y8nFX+orCZl78nU9/vjraMiBO0jyYZUnPfYDHhX0J8LDx9cySJ3uMU0C6HU0Coz4clcvdDU1A6Ryu
	nFJcUWkVNZRKGgOuzjdYffIwmFGcY9hThz7zkqkCRMeux7i4wDSpgy5vC32r/I5/oYvRUTfe1BHMs
	WxnApWPSItDydhXJsM4hynyg9aaae/dRwMlGoLpaV17h45/vn9ExI5zwFfJpmZ7Lg3kUyopb5gArl
	rruzo1Jw==;
Received: from [122.175.9.182] (port=2219 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uaCs0-0000000CkzW-2aDI;
	Fri, 11 Jul 2025 08:28:53 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 04F771783F55;
	Fri, 11 Jul 2025 17:58:47 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id DF13117820AC;
	Fri, 11 Jul 2025 17:58:46 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Zb1_7GMlzRER; Fri, 11 Jul 2025 17:58:46 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 9F2B61781A71;
	Fri, 11 Jul 2025 17:58:46 +0530 (IST)
Date: Fri, 11 Jul 2025 17:58:46 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
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
Message-ID: <1955816878.1712472.1752236926517.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250708175301.599c82b8@kernel.org>
References: <20250702140633.1612269-1-parvathi@couthit.com> <20250702140633.1612269-4-parvathi@couthit.com> <20250708175301.599c82b8@kernel.org>
Subject: Re: [PATCH net-next v10 03/11] net: ti: prueth: Adds PRUETH HW and
 SW configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds PRUETH HW and SW configuration
Thread-Index: X8jfoHwLggsJP12Hu9W5PyGLi3G3FQ==
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

> On Wed,  2 Jul 2025 19:36:25 +0530 Parvathi Pudi wrote:
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> index aed5cdc402b5..f52858da89d4 100644
>> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
>> +	txcfg = PRUSS_MII_RT_TXCFG_TX_ENABLE |
>> +		PRUSS_MII_RT_TXCFG_TX_AUTO_PREAMBLE |
>> +		PRUSS_MII_RT_TXCFG_TX_32_MODE_EN |
>> +		(TX_START_DELAY << PRUSS_MII_RT_TXCFG_TX_START_DELAY_SHIFT) |
>> +		(TX_CLK_DELAY_100M << PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_SHIFT);
> 
>> +	/* Min frame length should be set to 64 to allow receive of standard
>> +	 * Ethernet frames such as PTP, LLDP that will not have the tag/rct.
>> +	 * Actual size written to register is size - 1 per TRM. This also
>> +	 * includes CRC/FCS.
>> +	 */
>> +	txcfg = (((PRUSS_MII_RT_RX_FRMS_MIN_FRM - 1) <<
>> +			PRUSS_MII_RT_RX_FRMS_MIN_FRM_SHIFT) &
>> +			PRUSS_MII_RT_RX_FRMS_MIN_FRM_MASK);
> 
> Please use FIELD_PREP() instead of defining separate _MASK and _SHIFT
> values.
> 

Sure, we will use FIELD_PREP() to align with kernel bit-field handling.

>> +	/* For EMAC, set Max frame size to 1528 i.e size with VLAN.
>> +	 * Actual size written to register is size - 1 as per TRM.
>> +	 * Since driver support run time change of protocol, driver
>> +	 * must overwrite the values based on Ethernet type.
>> +	 */
>> +	txcfg |= (((PRUSS_MII_RT_RX_FRMS_MAX_SUPPORT_EMAC - 1) <<
>> +			   PRUSS_MII_RT_RX_FRMS_MAX_FRM_SHIFT)	&
>> +			   PRUSS_MII_RT_RX_FRMS_MAX_FRM_MASK);
> 
>> +struct prueth_queue_desc {
>> +	u16 rd_ptr;
>> +	u16 wr_ptr;
>> +	u8 busy_s;
>> +	u8 status;
>> +	u8 max_fill_level;
>> +	u8 overflow_cnt;
>> +} __packed;
> 
> Please don't use __packed if the struct will be packed anyway based on
> C packing rules.

We will address this in the next version.

Thanks and Regards,
Parvathi.

