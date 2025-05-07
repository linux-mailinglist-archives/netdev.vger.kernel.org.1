Return-Path: <netdev+bounces-188627-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1545AADFDA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 14:56:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6BB1717D6
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 12:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A01326D4EA;
	Wed,  7 May 2025 12:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="SZQ/qUqG"
X-Original-To: netdev@vger.kernel.org
Received: from server.wki.vra.mybluehostin.me (server.wki.vra.mybluehostin.me [162.240.238.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5619972635;
	Wed,  7 May 2025 12:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.238.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746622586; cv=none; b=ulF17THrlaO5LAL+l0aFXyaATJUhWgW5amh4LAXGSRb547StBq565G+AFRip+cqaC1Ob9CHfGA0nvgWGUfDfIH08Oxd51OJABFdt4nH1yJ3KyPPYNzr4QBIin+w57vyZCDdc7aOggEVr7ZctYyTaSkJUYaxxlOtqpFvxXcj819g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746622586; c=relaxed/simple;
	bh=e+KbzQH4g+FY0XrajAnoZjNDb6VWzk8lnDHWDRvx1tM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=camcCnANmOkXc9jqC87UDLXWfquoViixkUZ0u/cD9D6en24YfE1PaVHE1ABYYLK0yf57AWAKndbhI2pL1RL83mUa5z7OnPA2GC/TfUI122WyFgGq9H+Z1tngLT//VCCbFK53T370TxmWqTaBRq/5nwTUc+7hORXsnDq7MWhf3QI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=SZQ/qUqG; arc=none smtp.client-ip=162.240.238.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2gTucvQbJ8GVWGtpPTGszF2AAa2auKQNBW/SjILr374=; b=SZQ/qUqGsxZiV8NAzLkeiIQ29O
	iiJq0WqtLc873MoKOpRjCjvc4DCbrrDAbP+odpVPOcMcr8ATV43UROcDdv4vwyrFv7s01iqvVGvl4
	Fi+XWO4ihOEMpukM6PVjzlkJ0CYwDCv0ea3FD/k1DG7kx7dDezzT2ALnTmmpMS04AJExDeXU+NyBD
	kUxSfkmpbd/UPbKxhhkafl7G4LHzj76WRdEEDSbdC+ldavKkvXQC3RGnpG9phS769vcbpC1UwM4Vc
	qxTdapSgTM3csySTqflmlXFuGrhbN2Ln0Ry8rYkttmGiRJMuQSV8puvrD3t3I5FrswFmSWLIdnFkt
	dDFYl6DQ==;
Received: from [122.175.9.182] (port=34909 helo=zimbra.couthit.local)
	by server.wki.vra.mybluehostin.me with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uCeJl-000000000Vk-1tYs;
	Wed, 07 May 2025 18:26:09 +0530
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 9F3661784153;
	Wed,  7 May 2025 18:26:02 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 7A93317820EC;
	Wed,  7 May 2025 18:26:02 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id O1H80hbzATvn; Wed,  7 May 2025 18:26:02 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 196861784150;
	Wed,  7 May 2025 18:26:02 +0530 (IST)
Date: Wed, 7 May 2025 18:26:01 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: pabeni <pabeni@redhat.com>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, kuba <kuba@kernel.org>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
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
	parvathi <parvathi@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <139244603.1233564.1746622561934.JavaMail.zimbra@couthit.local>
In-Reply-To: <19f4f38b-9962-41d6-97b7-e254db3c6dee@redhat.com>
References: <20250503121107.1973888-1-parvathi@couthit.com> <20250503121107.1973888-4-parvathi@couthit.com> <19f4f38b-9962-41d6-97b7-e254db3c6dee@redhat.com>
Subject: Re: [PATCH net-next v7 03/11] net: ti: prueth: Adds PRUETH HW and
 SW configuration
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC135 (Mac)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds PRUETH HW and SW configuration
Thread-Index: AosoBOCbs5p6H60d7E7sxq4c13PHCQ==
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

> On 5/3/25 2:10 PM, Parvathi Pudi wrote:
>> +static int icssm_prueth_emac_config(struct prueth_emac *emac)
>> +{
>> +	struct prueth *prueth = emac->prueth;
>> +
>> +	/* PRU needs local shared RAM address for C28 */
>> +	u32 sharedramaddr = ICSS_LOCAL_SHARED_RAM;
>> +
>> +	/* PRU needs real global OCMC address for C30*/
>> +	u32 ocmcaddr = (u32)prueth->mem[PRUETH_MEM_OCMC].pa;
>> +	void __iomem *dram_base;
>> +	void __iomem *mac_addr;
>> +	void __iomem *dram;
> 
> Minor nit: please respect the reverse christmas tree order above.
> 
> /P

We will address this in the next version.


Thanks and Regards,
Parvathi.

