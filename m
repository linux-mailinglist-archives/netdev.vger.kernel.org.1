Return-Path: <netdev+bounces-183263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00D21A8B80F
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 13:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FF6175EE7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 11:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873F924729E;
	Wed, 16 Apr 2025 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="TFJXzkSX"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4153243947;
	Wed, 16 Apr 2025 11:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744804772; cv=none; b=cVevKldSuc2d2fl4D/QPlRUIfEOIfOH4iBxyQke4pwNpNOUu2RTu4yzodDVkPevAKwfstiWZH9V+tmvIenxUpqWB2s9xLYjJusFya6Sw8LULTFW/agUEcq/f2RKHYnuf5bR/GZO/yWs1Jf+Uf/RL92WYwuTwmpcM3AXo/nGqPYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744804772; c=relaxed/simple;
	bh=0S1TuGfoaihaP6GM7Hh8LwcX9IT6mQyo/HUSvfpb9WE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=O5tzkIH/0lX6l+yIWY5UT4iLMMNq68hbL4U2x/i8z7nWlogiq1ndz72W6sEBzZkmjiNaVgpCzKbbZfeasO73WrcAu9QCoc9CDH/SJzoEQFQnnksbYUFXGbUBrhyMXAMaon5rad0sMVt2gQ/0SuBpbyWut/uvVidgNb1WFFGux6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=TFJXzkSX; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=3XF1ouON7r19OevKldtRbjX0yHgsiXwfPXmVLBz5tEU=; b=TFJXzkSXznU2jJl8JPOsr2VVRp
	DjP8dl//vWxLNxcq+iTwxTVjJmlfe9KhHZyS7mQhY9ZSBYLmVk5XN+eRikwxZ6rZn+vYddIUEgVk3
	0GUMusS7Ydxjta7FsBpm8dUOBnCszM2Yidtr0UVThJt3yLaHU79vBOCWYoT3J6vuSmgq/CYZIB0Gg
	0RYbx8XIv0vrZYslVgm3PyM4xGB7di1mPpocCSqyrn4yV5hsEeag2gnsXxwqV1lNnWjm4ElBbOfKf
	xCE28OtPn9mcvIEfqe4Ec0+pCDLCckTePJSIB6EjX737yZyktIA7cs96ow6SFoWS7s18z8hx/CgyC
	2gB3Te2g==;
Received: from [122.175.9.182] (port=57370 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u51QB-000000006nZ-2HHQ;
	Wed, 16 Apr 2025 17:29:15 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id D1FBE1781A82;
	Wed, 16 Apr 2025 17:29:03 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id B22C7178247C;
	Wed, 16 Apr 2025 17:29:03 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id KVGCnqemXVdZ; Wed, 16 Apr 2025 17:29:03 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 759F31781A82;
	Wed, 16 Apr 2025 17:29:03 +0530 (IST)
Date: Wed, 16 Apr 2025 17:29:03 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <1593029669.1081007.1744804743217.JavaMail.zimbra@couthit.local>
In-Reply-To: <5e394736-00c6-4671-a55e-6019ce245b01@lunn.ch>
References: <20250414113458.1913823-1-parvathi@couthit.com> <20250414130237.1915448-6-parvathi@couthit.com> <5e394736-00c6-4671-a55e-6019ce245b01@lunn.ch>
Subject: Re: [PATCH net-next v5 05/11] net: ti: prueth: Adds ethtool support
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
Thread-Index: PiT+QqjjmPdkikvvwOrwQ08G5r5VPQ==
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

>> +static int icssm_emac_get_link_ksettings(struct net_device *ndev,
>> +					 struct ethtool_link_ksettings *ecmd)
>> +{
>> +	return phy_ethtool_get_link_ksettings(ndev, ecmd);
>> +}
>> +
> 
>> +static int
>> +icssm_emac_set_link_ksettings(struct net_device *ndev,
>> +			      const struct ethtool_link_ksettings *ecmd)
>> +{
>> +	return phy_ethtool_set_link_ksettings(ndev, ecmd);
>> +}
> 
>> +/* Ethtool support for EMAC adapter */
>> +const struct ethtool_ops emac_ethtool_ops = {
>> +	.get_drvinfo = icssm_emac_get_drvinfo,
>> +	.get_link_ksettings = icssm_emac_get_link_ksettings,
>> +	.set_link_ksettings = icssm_emac_set_link_ksettings,
> 
> The wrappers don't do anything, so why not just use
> phy_ethtool_get_link_ksettings() and phy_ethtool_set_link_ksettings()
> directly?
> 
> 	Andrew

Yes, the wrapper API does the same. We will clean this in the next version.


Thanks and Regards,
Parvathi.

