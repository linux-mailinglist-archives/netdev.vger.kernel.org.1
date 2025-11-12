Return-Path: <netdev+bounces-237980-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E30C52641
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 14:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36F11189F90A
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 13:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABF9933859A;
	Wed, 12 Nov 2025 13:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="12Ug5jif"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5599338586;
	Wed, 12 Nov 2025 13:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952903; cv=none; b=JiLFBWAjWDvda53t3VZjXYgF/FxNZs5wAAjj7iNyZWtL2qm/sfFB2IjENY9IZ6789n6yVK8uL59lxEOlq/HgqDCSfMpFyFNsTquiwm6ZUM+3ea1lJv/hxeYwYrY3tPdsSIFEzI2YEkFPTtMcvZoCSzB4aIyQyeIixjxghntoB+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952903; c=relaxed/simple;
	bh=EBXnt/vZg0J5/1rLP2hcelCt/wXUC+JcRZCc5yg5rk4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=VfDNLi6pctybLvbv89uLK/0LHN9wbFIBhdGWdHF8tip104ZaJXydAr14yI0m5fiWBU1h3Pyxu7+b4/UObjGJo11KOOHl1F5Vg+u2ZUPp26be/G4Gc+GORmuBA1pkoLHwARyKPAS71sDmkuffvdvsXfnRHzCcE7Pi/jZKcVqZgc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=12Ug5jif; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=HvvE9WtcjHoTZVjSJYj4iXnVgOEsxF/6OfDNJ2uRNxg=; b=12Ug5jifwKRDravl3MVuc8Khb0
	zSYZRFC5hAilUZhi8TUztAdeB7ycICRFykWuE4PjNgQrw429SxwEGklPRG2FxGe2qEAUutLSLkmE2
	j79MOlJirKQle8emeYrahQohQ0/wgr+6IdVxsrKQvLYH7hO2mMNIlzGGWutJuddLVmeC4pyWv/MmK
	5ZPg86sYC4yWBv9ufJManpACltCFYHY1oFeoriO56PJQOaqrxC5FHO7L/C7JsZmXk9Tu7tOwrgDYv
	RplyLdhvj19vsVpZZiTEDK6Xe1RCpRJUe/ELTKQ+AQzWZjS/NHjSxdCs1ZKgf4gcsZSxsrNn7d9kF
	sBHPlVhw==;
Received: from [122.175.9.182] (port=6520 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vJAa5-0000000Fnh7-2Yzi;
	Wed, 12 Nov 2025 08:08:13 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 215811A6489B;
	Wed, 12 Nov 2025 18:38:01 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id FRgP7a_hUyVw; Wed, 12 Nov 2025 18:37:59 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id B590A1A6489A;
	Wed, 12 Nov 2025 18:37:59 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id WxatnibBDCKn; Wed, 12 Nov 2025 18:37:59 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 8D3BD1A6489B;
	Wed, 12 Nov 2025 18:37:59 +0530 (IST)
Date: Wed, 12 Nov 2025 18:37:59 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <482294584.44920.1762952879480.JavaMail.zimbra@couthit.local>
In-Reply-To: <a29c40ff-7209-4b60-a17f-2aab09318dc1@oracle.com>
References: <20251110125539.31052-1-parvathi@couthit.com> <20251110125539.31052-2-parvathi@couthit.com> <a29c40ff-7209-4b60-a17f-2aab09318dc1@oracle.com>
Subject: Re: [External] : [PATCH net-next v4 1/3] net: ti: icssm-prueth:
 Adds helper functions to configure and maintain FDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: : [PATCH net-next v4 1/3] net: ti: icssm-prueth: Adds helper functions to configure and maintain FDB
Thread-Index: V0LWKQ7E4ab9hK965b5QamKIOHDnsg==
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

>> +static int icssm_prueth_sw_insert_fdb_entry(struct prueth_emac *emac,
>> +					    const u8 *mac, u8 is_static)
>> +{
>> +	struct fdb_index_tbl_entry __iomem *bucket_info;
>> +	struct fdb_mac_tbl_entry __iomem *mac_info;
>> +	struct prueth *prueth = emac->prueth;
>> +	struct prueth_emac *other_emac;
>> +	enum prueth_port other_port_id;
>> +	u8 hash_val, mac_tbl_idx;
>> +	struct fdb_tbl *fdb;
>> +	u8 flags;
>> +	u16 val;
>> +	s16 ret;
>> +	int err;
>> +
>> +	fdb = prueth->fdb_tbl;
>> +	other_port_id = (emac->port_id == PRUETH_PORT_MII0) ?
>> +			 PRUETH_PORT_MII1 : PRUETH_PORT_MII0;
>> +
>> +	other_emac = prueth->emac[other_port_id - 1];
>> +
>> +	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
>> +		return -ENOMEM;
>> +
>> +	if (ether_addr_equal(mac, emac->mac_addr) ||
>> +	    ether_addr_equal(mac, other_emac->mac_addr)) {
>> +		/* Don't insert fdb of own mac addr */
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* Get the bucket that the mac belongs to */
>> +	hash_val = icssm_prueth_sw_fdb_hash(mac);
>> +	bucket_info = FDB_IDX_TBL_ENTRY(hash_val);
>> +
>> +	if (!readw(&bucket_info->bucket_entries)) {
>> +		mac_tbl_idx = icssm_prueth_sw_fdb_find_open_slot(fdb);
>> +		writew(mac_tbl_idx, &bucket_info->bucket_idx);
>> +	}
>> +
>> +	ret = icssm_prueth_sw_find_fdb_insert(fdb, prueth, bucket_info, mac,
>> +					      emac->port_id - 1);
>> +	if (ret < 0)
>> +		/* mac is already in fdb table */
>> +		return 0;
>> +
>> +	mac_tbl_idx = ret;
> 
> If ret == -1 mac_tbl_idx wraps to 255 silently.
> 

Thanks. Theoretically, assigning -1 to an unsigned variable would
result in 255 due to signed-to-unsigned conversion. However, in
this case, the above code already checks if (ret < 0) and returns early,
so the assignment to mac_tbl_idx never happens when ret is negative. 

>> +
>> +	err = icssm_prueth_sw_fdb_spin_lock(fdb);
>> +	if (err) {
>> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
> 
> wrong var ret print.
> return ret or err here ?
> 

We will address this in the next version.


Thanks and Regards,
Parvathi.

