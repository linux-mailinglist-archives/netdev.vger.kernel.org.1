Return-Path: <netdev+bounces-240302-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADE5C7252D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 07:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 12539353BFA
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 06:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A577E2D836A;
	Thu, 20 Nov 2025 06:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="n0aNVM+O"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3E51EF09B;
	Thu, 20 Nov 2025 06:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619625; cv=none; b=pIJxIMlXpNC1apIJIexAJnupbhY1/x8Faiuw23etIk6ejrm5XUJNcJK68qOS76UmvELLhUUo9lRrED+Syj89nTkq28ktCC69xVe2GoSkZ9E0j4NttaGrTh8E7FpXmqfC0ex3mby1T0kSOH/Ar8Zz6ISDQt/8w7DYH8whrZNK7wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619625; c=relaxed/simple;
	bh=mEJX0mb/ti38N+5S3KX+gcNyt/xC9QToaaW35evUszU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Rq+zEHvYPOSuoqazMtZcyE1OKZZguA9LcIuj8RElxrfzODdymg0YXLnjvPXgfn4X+z1a9o0tCYt0YlrsiaDXg75gD34aUxg9dkj+nyqLye2cfhbjjtIAiRkmNZsHbJxLquPX9ygycerp6CPDNZHVfBST+i7QyNEktFlEVcQPYZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=n0aNVM+O; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=q1t6ndjLSnIUqWAl9OLI/OmffwL/3m1l148/DKVocd0=; b=n0aNVM+OMuYanhO/0OG6dgpkIs
	tr91VARActRDCwhs3WVeaMPi+gyE9D8h3edVO9QaavE4h3XBDrKjCCajbAsIrMfpl/ufsn38ZGYJr
	Us8OWC3BaLAk1Wd3U7rrStwMsM/rXQN+bdeLFT65OPxZsSaZY1quP1QHw+C5e+Io2gEgLIiZxtedC
	BDuOMQTHjVCQkwLCry0VFCzQ7nUSbVZutx1fo8dU1hYdRX1SxUGgTxZdLQyZsU/MxQAQdSyvb7ZGV
	mjpF7OOFlac8tW4vF6HBDdPqxNkFXSbLh5xrXkqJXZsMDvjZpQhVf5ppejNVsujueQtvRavtw8Yba
	P+f3pfLQ==;
Received: from [122.175.9.182] (port=31734 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vLy1e-00000004wtf-1oWE;
	Thu, 20 Nov 2025 01:20:14 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id B3FBE1A6819E;
	Thu, 20 Nov 2025 11:50:01 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 9A7m4F5S8Z_B; Thu, 20 Nov 2025 11:50:01 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 5F4E61A6818A;
	Thu, 20 Nov 2025 11:50:01 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id lEbrhx8hJEeW; Thu, 20 Nov 2025 11:50:01 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 3CD991A6819E;
	Thu, 20 Nov 2025 11:50:01 +0530 (IST)
Date: Thu, 20 Nov 2025 11:50:01 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Simon Horman <horms@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, pabeni <pabeni@redhat.com>, 
	danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	afd <afd@ti.com>, linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, pratheesh <pratheesh@ti.com>, 
	j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <2133501064.5283.1763619601211.JavaMail.zimbra@couthit.local>
In-Reply-To: <aRuOh-O99Xwo1nG0@horms.kernel.org>
References: <20251113101229.675141-1-parvathi@couthit.com> <20251113101229.675141-2-parvathi@couthit.com> <aRuOh-O99Xwo1nG0@horms.kernel.org>
Subject: Re: [PATCH net-next v5 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Adds helper functions to configure and maintain FDB
Thread-Index: GlMbErd+/HO1HNJ0paANEqc3gPyIGg==
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

> On Thu, Nov 13, 2025 at 03:40:21PM +0530, Parvathi Pudi wrote:
> 
> ...
> 
>> +static u16 icssm_prueth_sw_fdb_find_open_slot(struct fdb_tbl *fdb_tbl)
>> +{
>> +	u8 flags;
>> +	u16 i;
>> +
>> +	for (i = 0; i < FDB_MAC_TBL_MAX_ENTRIES; i++) {
>> +		flags = readb(&fdb_tbl->mac_tbl_a->mac_tbl_entry[i].flags);
>> +		if (!(flags & FLAG_ACTIVE))
>> +			break;
> 
> Hi Parvathi, all,
> 
> If the condition above is never met....
> 
>> +	}
>> +
>> +	return i;
> 
> Then FDB_MAC_TBL_MAX_ENTRIES will be returned here.
> Which is written to bkt_info->bucket_idx by
> icssm_prueth_sw_insert_fdb_entry()...
> 
>> +}
>> +
>> +static int
>> +icssm_prueth_sw_find_fdb_insert(struct fdb_tbl *fdb, struct prueth *prueth,
>> +				struct fdb_index_tbl_entry __iomem *bkt_info,
>> +				const u8 *mac, const u8 port)
>> +{
>> +	struct fdb_mac_tbl_array __iomem *mac_tbl = fdb->mac_tbl_a;
>> +	struct fdb_mac_tbl_entry __iomem *e;
>> +	u8 mac_from_hw[ETH_ALEN];
>> +	u16 bucket_entries;
>> +	u16 mac_tbl_idx;
>> +	int i, ret;
>> +	s8 cmp;
>> +
>> +	mac_tbl_idx = readw(&bkt_info->bucket_idx);
> 
> That value will be read here...
> 
>> +	bucket_entries = readw(&bkt_info->bucket_entries);
>> +
>> +	for (i = 0; i < bucket_entries; i++, mac_tbl_idx++) {
>> +		e = &mac_tbl->mac_tbl_entry[mac_tbl_idx];
> 
> And used here, without any bounds checking.
> 
> But if mac_tbl_idx is FDB_MAC_TBL_MAX_ENTRIES then
> the access to mac_tble_entry will overflow, as
> it only has FDB_MAC_TBL_MAX_ENTRIES elements.
> 
> This, and most of my review points for this patch set were
> flagged by Claude Code with https://github.com/masoncl/review-prompts/
> 
> ...

We have verified and this case will never hit since we have a if condition
in the very beginning of the "icssm_prueth_sw_insert_fdb_entry()" function to
return if the table is full as highlighted below and all the entries are active.

  If (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
        return -ENOMEM;

> 
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
> 
> Access to total_entries outside of icssm_prueth_sw_fdb_spin_lock.
> Seems racy here. Likewise for the similar check in
> icssm_prueth_sw_delete_fdb_entry().
> 
> Flagged by Claude Code with https://github.com/masoncl/review-prompts/

We are using icssm_prueth_sw_fdb_spin_lock() to control access between
PRU and CPU. We have kept in and around the sections where PRU writes it. 

Sure, we will review and move the spin lock to protect even the read accesses.

> 
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
>> +
>> +	err = icssm_prueth_sw_fdb_spin_lock(fdb);
>> +	if (err) {
>> +		dev_err(prueth->dev, "PRU lock timeout %d\n", ret);
>> +		return err;
>> +	}
>> +
>> +	mac_info = icssm_prueth_sw_find_free_mac(prueth, bucket_info,
>> +						 mac_tbl_idx, NULL,
>> +						 mac);
>> +	if (!mac_info) {
>> +		/* Should not happen */
>> +		dev_warn(prueth->dev, "OUT of FDB MEM\n");
> 
> This appears to leak icssm_prueth_sw_fdb_spin_lock.
> 
> Also flagged by Claude Code with https://github.com/masoncl/review-prompts/
> 

We will ensure the spin lock is properly released before returning.
This will be addressed in the next revision.


>> +		return -ENOMEM;
>> +	}
>> +
>> +	memcpy_toio(mac_info->mac, mac, ETH_ALEN);
>> +	writew(0, &mac_info->age);
>> +	writeb(emac->port_id - 1, &mac_info->port);
>> +
>> +	flags = readb(&mac_info->flags);
>> +	if (is_static)
>> +		flags |= FLAG_IS_STATIC;
>> +	else
>> +		flags &= ~FLAG_IS_STATIC;
>> +
>> +	/* bit 1 - active */
>> +	flags |= FLAG_ACTIVE;
>> +	writeb(flags, &mac_info->flags);
>> +
>> +	val = readw(&bucket_info->bucket_entries);
>> +	val++;
>> +	writew(val, &bucket_info->bucket_entries);
>> +
>> +	fdb->total_entries++;
>> +
>> +	icssm_prueth_sw_fdb_spin_unlock(fdb);
>> +
>> +	dev_dbg(prueth->dev, "added fdb: %pM port=%d total_entries=%u\n",
>> +		mac, emac->port_id, fdb->total_entries);
> 
> Less important, but I think the value of total_entries could
> be out of date as it's accessed outside of the lock.
> Perhaps it would be good to stash the value into a local variable while
> the lock is still held?
> 
> Likewise in icssm_prueth_sw_delete_fdb_entry().
> 

Sure, we will review and address this in the next version.


Thanks and Regards,
Parvathi.

