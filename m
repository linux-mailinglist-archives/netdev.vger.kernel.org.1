Return-Path: <netdev+bounces-230035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F24EBE31E5
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F18D4E8A2D
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA223195F0;
	Thu, 16 Oct 2025 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="ZPwtWfVf"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC8732861A;
	Thu, 16 Oct 2025 11:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760614826; cv=none; b=nBd1F2SEKo8hk38CTV0Vqrf+/1SmfZ8+wjITA1rm4GbSkU5MpPcYIpgOzKUXw84L39dDAl7vidcL6juAxEqPPupy4Cusx+Fceyrft//nhULEKg5rdIKOCGcNaj4HZVXX58o7kIcffMArvxVZ6Ct/25iUycXyhjpoeMHuGl7YlL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760614826; c=relaxed/simple;
	bh=KO19B0tKkIkkoYaO00XtSpVGB9fo75GeJpItH1g+Ieo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=BxTzWFhRQwXg2souh5JloTbw0s4/QQSPSKwfhg4LWduzlTgqaCQvUL2bM/yexirCKDTy86jmx1UcAyijNPFceXTalKMV6DC7c+/fiNCvAyyfb7OvZrXt1XT1iNgAo4i16n1Qmrgb6p4KsKNpMmSx7Q44NLfyHra1AAVE7I+azlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=ZPwtWfVf; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=XvYgm2ZiEhdQinQKcxWC99AV37HjB6EYaQCw2NitFgg=; b=ZPwtWfVfmH1BgOVMa3L70j0efc
	qqsLU2dGGGukihkkq+42UZcMLx8PX2kIvKq2VQScwsWmV3FqzlCOiWcaZ4II38HfGvqEPfD21HNRL
	kGzjp+NyLq+iH5rvz+NxDEejWy0YpC00XxoIDmHg/USbd8xKEjHt5J4OfvJ8i+676WT2bwZRuWC6p
	YFdnvdOUsNfsVD476lUnekQErRuvNNG71r6S9nrYXVddVMJqVz1YyY2tMYuSdbeDxui9CS22iAZde
	8xt8vJRlx4MbKGvSkc1tSeDJaZ9xYanDHGWDeViZI0601YhoSyL46ivOsN10QOcTh8XKpl4WlFCIX
	NPckYhlA==;
Received: from [122.175.9.182] (port=17170 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v9MLE-000000079MT-1SRX;
	Thu, 16 Oct 2025 07:40:20 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id E724F1783FF9;
	Thu, 16 Oct 2025 17:10:15 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D12ED1783FF4;
	Thu, 16 Oct 2025 17:10:15 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id GzU_cDNcWiqS; Thu, 16 Oct 2025 17:10:15 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id A72EF1781C72;
	Thu, 16 Oct 2025 17:10:15 +0530 (IST)
Date: Thu, 16 Oct 2025 17:10:15 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: parvathi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <1633385931.433.1760614815573.JavaMail.zimbra@couthit.local>
In-Reply-To: <1e16ab86-ccc1-433a-a482-76d9ba567fb9@lunn.ch>
References: <20251014124018.1596900-1-parvathi@couthit.com> <20251014124018.1596900-2-parvathi@couthit.com> <1e16ab86-ccc1-433a-a482-76d9ba567fb9@lunn.ch>
Subject: Re: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: icssm-prueth: Adds helper functions to configure and maintain FDB
Thread-Index: XlOBMErJ6hpwpJMWg3cXMXchYoQRVA==
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

>> +/* 4 bytes */
>> +struct fdb_index_tbl_entry_t {
>> +	/* Bucket Table index of first Bucket with this MAC address */
>> +	u16 bucket_idx;
>> +	u16 bucket_entries; /* Number of entries in this bucket */
>> +};
> 
> Please drop the _t. That is normally used to indicate a type, but this
> is actually a struct
>

Sure. We will remove _t from the struct definitions.

>> +void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
>> +{
>> +	struct fdb_tbl *t = prueth->fdb_tbl;
>> +
>> +	t->index_a = (struct fdb_index_array_t *)((__force const void *)
>> +			prueth->mem[V2_1_FDB_TBL_LOC].va +
>> +			V2_1_FDB_TBL_OFFSET);
> 
> You cast it to a const void * and then a non-const fdb_index_array_t *?

We will address this and remove the double casting completely.

Thanks and Regards,
Parvathi.

