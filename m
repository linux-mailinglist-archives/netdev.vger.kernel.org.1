Return-Path: <netdev+bounces-186717-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D24AA080F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EDAD481970
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79CD2BEC3E;
	Tue, 29 Apr 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="Bx3WWgVL"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FC32BE7D8;
	Tue, 29 Apr 2025 10:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921218; cv=none; b=YE/8OBtAHJo2tT1SfjuG8M7yWIKdbcjKmDCI2C6JDrw8lzKdpUGZChWPULrd0I8P7GACf0NSkIXt+pXcjo5ChBi6s/M1Vb76wfwPHR01x3nybt/uQliJw9TsTvL1AkITckK5L0uErwIMECYrzT26YNYUtMN1lU7UmA6nVb7Fiug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921218; c=relaxed/simple;
	bh=39pgH4p/ZTSPv29D5o3J2WLloPQmBCsigS4c8NDb+Ng=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mCPgz4Y/4PZ8MuzCpz+9l14QXUGbz7eK41/48CRmCfXiJzSuS1QSX3x0gO76/L16arOgzQEruWH2XAfPrlBA/ju4bg3coqaXFZdXdftWkdJw6tO6hImulUmsY4CvnbdCUJD36e3L/90KpGSTads5x6slMt0/nAiDy0cu+69nuD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=Bx3WWgVL; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=pRJpXxtXspf00/o6/ugq1hIMvacha4Xn4cBWyKfWYus=; b=Bx3WWgVLQvkl4QFHw+dWoUCys4
	V8X70gKZz38WfqR9qD2N+N8vRNonmLt87sBOhMhsn7XEEDfiEhyVGGRYrs05GSejf/kv5x4KJBVew
	0fv512iiizW1yXEhqddx+osiDVy5xb0lMglMn/8rEcojA7UnmYB4T0l4oE5LMq12KO6wLbUozVjMt
	urNXDmhtMgENuVB5XU8yCZpb+JPv94Eq2N17MVYfJnuzmeKnzDU6zRg2/iZoNL932WcY74puK/zgY
	URJm2bsZfExkCW2A6Hnglp4CaFyEWSxN7L2uVNXTIaRuP2z4N12VnYVxfWJZLKOD35fy4jYCYi/W1
	GmpKZZlw==;
Received: from [122.175.9.182] (port=52071 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u9hrW-0000000005m-07gL;
	Tue, 29 Apr 2025 15:36:50 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 3793E1783FDC;
	Tue, 29 Apr 2025 15:36:44 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 0FF47178245B;
	Tue, 29 Apr 2025 15:36:44 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CbIv-kPgtkN5; Tue, 29 Apr 2025 15:36:43 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id BB52B1782431;
	Tue, 29 Apr 2025 15:36:43 +0530 (IST)
Date: Tue, 29 Apr 2025 15:36:43 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	nm <nm@ti.com>, ssantosh <ssantosh@kernel.org>, 
	tony <tony@atomide.com>, richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, horms <horms@kernel.org>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	m-malladi <m-malladi@ti.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	afd <afd@ti.com>, s-anna <s-anna@ti.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <619030056.1172946.1745921203564.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250424191741.55323f28@kernel.org>
References: <20250423060707.145166-1-parvathi@couthit.com> <20250423072356.146726-6-parvathi@couthit.com> <20250424191741.55323f28@kernel.org>
Subject: Re: [PATCH net-next v6 05/11] net: ti: prueth: Adds ethtool support
 for ICSSM PRUETH Driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds ethtool support for ICSSM PRUETH Driver
Thread-Index: aOSvrMwlP2wLYvNaXDGDtXazpxI8Zw==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.wki.vra.mybluehostin.me
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.wki.vra.mybluehostin.me: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.wki.vra.mybluehostin.me: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hi,

> On Wed, 23 Apr 2025 12:53:50 +0530 Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> Changes for enabling ethtool support for the newly added PRU Ethernet
>> interfaces. Extends the support for statistics collection from PRU internal
>> memory and displays it in the user space. Along with statistics,
>> enable/disable of features, configuring link speed etc.are now supported.
>> 
>> The firmware running on PRU maintains statistics in internal data memory.
>> When requested ethtool collects all the statistics for the specified
>> interface and displays it in the user space.
>> 
>> Makefile is updated to include ethtool support into PRUETH driver.
> 
> drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or
> struct member 'stormprev_counter_bc' not described in 'port_statistics'
> drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or
> struct member 'stormprev_counter_mc' not described in 'port_statistics'
> drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or
> struct member 'stormprev_counter_uc' not described in 'port_statistics'
> drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Function parameter or
> struct member 'cs_error' not described in 'port_statistics'
> drivers/net/ethernet/ti/icssm/icssm_prueth.h:229: warning: Excess struct member
> 'stormprev_counter' description in 'port_statistics'
> 

We will address this in the next version.

>> +static const struct {
>> +	char string[ETH_GSTRING_LEN];
>> +	u32 offset;
>> +} prueth_ethtool_stats[] = {
>> +	{"txBcast", PRUETH_STAT_OFFSET(tx_bcast)},
>> +	{"txMcast", PRUETH_STAT_OFFSET(tx_mcast)},
>> +	{"txUcast", PRUETH_STAT_OFFSET(tx_ucast)},
>> +	{"txOctets", PRUETH_STAT_OFFSET(tx_octets)},
>> +	{"rxBcast", PRUETH_STAT_OFFSET(rx_bcast)},
>> +	{"rxMcast", PRUETH_STAT_OFFSET(rx_mcast)},
>> +	{"rxUcast", PRUETH_STAT_OFFSET(rx_ucast)},
>> +	{"rxOctets", PRUETH_STAT_OFFSET(rx_octets)},
>> +
>> +	{"tx64byte", PRUETH_STAT_OFFSET(tx64byte)},
>> +	{"tx65_127byte", PRUETH_STAT_OFFSET(tx65_127byte)},
>> +	{"tx128_255byte", PRUETH_STAT_OFFSET(tx128_255byte)},
>> +	{"tx256_511byte", PRUETH_STAT_OFFSET(tx256_511byte)},
>> +	{"tx512_1023byte", PRUETH_STAT_OFFSET(tx512_1023byte)},
>> +	{"tx1024byte", PRUETH_STAT_OFFSET(tx1024byte)},
>> +	{"rx64byte", PRUETH_STAT_OFFSET(rx64byte)},
>> +	{"rx65_127byte", PRUETH_STAT_OFFSET(rx65_127byte)},
>> +	{"rx128_255byte", PRUETH_STAT_OFFSET(rx128_255byte)},
>> +	{"rx256_511byte", PRUETH_STAT_OFFSET(rx256_511byte)},
>> +	{"rx512_1023byte", PRUETH_STAT_OFFSET(rx512_1023byte)},
>> +	{"rx1024byte", PRUETH_STAT_OFFSET(rx1024byte)},
>> +
>> +	{"lateColl", PRUETH_STAT_OFFSET(late_coll)},
>> +	{"singleColl", PRUETH_STAT_OFFSET(single_coll)},
>> +	{"multiColl", PRUETH_STAT_OFFSET(multi_coll)},
>> +	{"excessColl", PRUETH_STAT_OFFSET(excess_coll)},
> 
> Do not dump into ethtool -S what's reported via standard stats.

This is to align with firmware internal statistics layout. We will
review and address this in the next version.


Thanks and Regards,
Parvathi.

