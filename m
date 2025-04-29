Return-Path: <netdev+bounces-186715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B251EAA07F0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 12:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F045516D406
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 10:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02F12BE7A8;
	Tue, 29 Apr 2025 10:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="0fKUcyOo"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E77270ECF;
	Tue, 29 Apr 2025 10:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745921046; cv=none; b=gmlXC49rkRqNtU5JDQA4V9JjWoE3yyEFUDFNxyCTQc7h8xGswfT/zwmCMuLS3h2v2J03Q2T+rbcfPxe4TMqdLiYVGgCV1Ed+kyarWrFgJ3DEDM8t0L0eS3PNSqcgkSeGH2Wnf/bifOrajK+AJPq0WQC0zdvXOuSJHQdSRXbtTd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745921046; c=relaxed/simple;
	bh=RF6o8GHfj1ttEiwuBJivOFM9iu0SmwBpRTbAzQir5Hw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=AnUKFSYK5yeqCtcLF3LwGQzfG6i9xQ47tdDsA40Zq+3a0Fsf2ZUbQw19dI5pTvNnxj6t6lTHf8Yq0s8mPN+9ozU/FJ2/YH150KR72X4gvfdBDDsAf68vcBB6oPVzMw+FpbH+TvKSpJHzOLffyDe7gAYKHCa0o9njoXzJxhqb/08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=0fKUcyOo; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=UMcULxUbcMjQJ66Cg9wMoxO/ZD9NbgZNU7gRtsbDIj8=; b=0fKUcyOocXqLlYVibtRCQmj/Y0
	MZupjRZEn+QJ3q29KzxFTb8mgttNr6sWZfz08u+r/H3mO1QYspyV6exnz6uyXZaYwrZa6dgNA2SiW
	QNIw4CSCVViUbilfAcfjvGWSJe24/QUHibOb9rZqCJ1gjVJ3Ctk/7v2ou6UFCmh61E0IiaYfh/tXC
	X0H35EfvdU2gND1BE1OolJg96IGZ0GB8Kxhk0euJD9s7I7bfeVOuCxax95SIKCnTyxuk2KknQThPE
	oaoAooVeB82AQhdcz0zWLu9t7fuHoOJzknKIveu+TCsLDc0a1WRrsupSD6h+uJPOtOnZ9+NzVxl6D
	iR4goHcQ==;
Received: from [122.175.9.182] (port=6139 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1u9hob-000000008Sv-3slT;
	Tue, 29 Apr 2025 15:33:50 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 991321782431;
	Tue, 29 Apr 2025 15:33:41 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 75066178245B;
	Tue, 29 Apr 2025 15:33:41 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id HxMW6xCJqpGW; Tue, 29 Apr 2025 15:33:41 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 185171782431;
	Tue, 29 Apr 2025 15:33:41 +0530 (IST)
Date: Tue, 29 Apr 2025 15:33:40 +0530 (IST)
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
Message-ID: <772474665.1172924.1745921020429.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250424191350.7bf69fdb@kernel.org>
References: <20250423060707.145166-1-parvathi@couthit.com> <20250423072356.146726-5-parvathi@couthit.com> <20250424191350.7bf69fdb@kernel.org>
Subject: Re: [PATCH net-next v6 04/11] net: ti: prueth: Adds link detection,
 RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF113 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: e9vQTHb25dOlfaA340zfiKRfwAC3Tg==
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

> On Wed, 23 Apr 2025 12:53:49 +0530 Parvathi Pudi wrote:
>> +static inline void icssm_prueth_write_reg(struct prueth *prueth,
>> +					  enum prueth_mem region,
>> +					  unsigned int reg, u32 val)
>> +{
>> +	writel_relaxed(val, prueth->mem[region].va + reg);
>> +}
> 
> Please don't use "inline" unnecessarily.
> The compiler will inline a single-line static function.


Understood. We will address this in the next version.

Thanks and Regards,
Parvathi.

