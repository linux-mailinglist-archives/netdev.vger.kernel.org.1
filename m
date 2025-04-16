Return-Path: <netdev+bounces-183266-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A36DA8B838
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 14:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC63719059BA
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 12:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCD4924A057;
	Wed, 16 Apr 2025 12:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="S0yXEdAx"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB0A238179;
	Wed, 16 Apr 2025 12:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744805046; cv=none; b=aYiYE45YPJJShL6wqvZwEIT2taSnatFo78uCkPpCDwJ7gpZvxgjT6x+rx4ALD6+RukrTfXWGHdly/v81+2IlsEqzbfjOplIPGIh9p6cMxszSb2tXBbIABoM0Iq/i3D0Q/pKdt+YyVbm3Z1v3gW5eNyXu+cAkvzH1cECN2cCwKP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744805046; c=relaxed/simple;
	bh=PFGhtR7a+Zp8eMU6Syuc2ZJohDPwScExVH8rQ3xxB48=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=N3w4Kx3WeQzt/IDKbkqzqzgPDl6ItJzuDiXYGk19ATL9EtCfT8T6Rd8Fr89VTXVeiLppiuUN4UVb3r2fO/4byizDycBMON8wJBFcGF2n6ZCZ/y2npAU+Xwadn3dL+HwAkyzZpgf4HD8qHlgniPzdO63ucFTrxQux5A2xWLOTQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=S0yXEdAx; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=C+BUdbNu2ogqSwBdGvb9VogReaCcne2HM3cP2/uSto4=; b=S0yXEdAx0AP0GBpAOdQQlzocSe
	SvaO2kc48XVnolknlLgy5oAUdFWGtCIrYMLcY6JpXIJX1N8TyNE6RpUTnGDwfm63v2rw4HcLdFjvk
	GT5vbmVIaebvybTuLeHWhHyvZYLIc8xqwGGbw4KeDPwEk8ibctxSBv3UpU/TMTxQRBRkfOj16GAfO
	yKk6BAG5HDRvLX3thFqAgMQKGU6MhqaoL7WudEOrl86zpMYyGmJoLNqUxpX+cMMZxGsvB8vA4ebpz
	5y11F7gEhtldOhFmU8112tT7pQLmkWkphdhE0KrC9F4cW0TrIvbWZtOADnf2rE0e6khKH9KUX+/XN
	4YYz+/xQ==;
Received: from [122.175.9.182] (port=43055 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u51Uk-000000006vU-2zvY;
	Wed, 16 Apr 2025 17:33:59 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 5A4611781A82;
	Wed, 16 Apr 2025 17:33:51 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 3A604178247C;
	Wed, 16 Apr 2025 17:33:51 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hCcSTaFJEKlc; Wed, 16 Apr 2025 17:33:51 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 0520E1781A82;
	Wed, 16 Apr 2025 17:33:51 +0530 (IST)
Date: Wed, 16 Apr 2025 17:33:50 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: horms <horms@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, nm <nm@ti.com>, 
	ssantosh <ssantosh@kernel.org>, tony <tony@atomide.com>, 
	richardcochran <richardcochran@gmail.com>, 
	glaroque <glaroque@baylibre.com>, schnelle <schnelle@linux.ibm.com>, 
	m-karicheri2 <m-karicheri2@ti.com>, s hauer <s.hauer@pengutronix.de>, 
	rdunlap <rdunlap@infradead.org>, diogo ivo <diogo.ivo@siemens.com>, 
	basharath <basharath@couthit.com>, 
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
Message-ID: <2114025245.1081083.1744805030927.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250415201552.GJ395307@horms.kernel.org>
References: <20250414113458.1913823-1-parvathi@couthit.com> <20250414140751.1916719-12-parvathi@couthit.com> <20250415201552.GJ395307@horms.kernel.org>
Subject: Re: [PATCH net-next v5 11/11] net: ti: prueth: Adds PTP OC Support
 for AM335x and AM437x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds PTP OC Support for AM335x and AM437x
Thread-Index: nmUgxGmbBkjbq4ZS0FAvjySn6J19/A==
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

> On Mon, Apr 14, 2025 at 07:37:51PM +0530, Parvathi Pudi wrote:
>> From: Roger Quadros <rogerq@ti.com>
>> 
>> PRU-ICSS IEP module, which is capable of timestamping RX and
>> TX packets at HW level, is used for time synchronization by PTP4L.
>> 
>> This change includes interaction between firmware/driver and user
>> application (ptp4l) with required packet timestamps.
>> 
>> RX SOF timestamp comes along with packet and firmware will rise
>> interrupt with TX SOF timestamp after pushing the packet on to the wire.
>> 
>> IEP driver available in upstream linux as part of ICSSG assumes 64-bit
>> timestamp value from firmware.
>> 
>> Enhanced the IEP driver to support the legacy 32-bit timestamp
>> conversion to 64-bit timestamp by using 2 fields as below:
>> - 32-bit HW timestamp from SOF event in ns
>> - Seconds value maintained in driver.
>> 
>> Currently ordinary clock (OC) configuration has been validated with
>> Linux ptp4l.
>> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> Signed-off-by: Andrew F. Davis <afd@ti.com>
>> Signed-off-by: Basharath Hussain Khaja <basharath@couthit.com>
>> Signed-off-by: Parvathi Pudi <parvathi@couthit.com>
> 
> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icss_iep.h
>> b/drivers/net/ethernet/ti/icssg/icss_iep.h
>> index 0bdca0155abd..437153350197 100644
>> --- a/drivers/net/ethernet/ti/icssg/icss_iep.h
>> +++ b/drivers/net/ethernet/ti/icssg/icss_iep.h
>> @@ -47,6 +47,11 @@ enum {
>>  	ICSS_IEP_MAX_REGS,
>>  };
>>  
>> +enum iep_revision {
>> +	IEP_REV_V1_0 = 0,
>> +	IEP_REV_V2_1
>> +};
>> +
>>  /**
>>   * struct icss_iep_plat_data - Plat data to handle SoC variants
>>   * @config: Regmap configuration data
>> @@ -57,11 +62,13 @@ struct icss_iep_plat_data {
>>  	const struct regmap_config *config;
>>  	u32 reg_offs[ICSS_IEP_MAX_REGS];
>>  	u32 flags;
>> +	enum iep_revision iep_rev;
>>  };
> 
> Please add iep_rev to the Kernel doc for struct icss_iep_plat_data.
> 
> Flagged by ./scripts/kernel-doc -none
> 

Sure, we will update the documentation in the next version.

> ...
> 
>> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.h
>> b/drivers/net/ethernet/ti/icssm/icssm_prueth.h
> 
> ...
> 
>> @@ -337,6 +343,7 @@ enum pruss_device {
>>  struct prueth_private_data {
>>  	enum pruss_device driver_data;
>>  	const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
>> +	enum fw_revision fw_rev;
>>  	bool support_lre;
>>  	bool support_switch;
>>  };
> 
> And, likewise, please add fw_rev to the Kernel doc for struct
> prueth_private_data.
> 

Sure, we will add fw_rev to the Kernel doc in the next version.


Thanks and Regards,
Parvathi.

