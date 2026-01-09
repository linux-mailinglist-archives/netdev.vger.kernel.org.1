Return-Path: <netdev+bounces-248507-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEA01D0A75C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3D9B8303897F
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD0335CB7C;
	Fri,  9 Jan 2026 13:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="YjCoA/u+"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1301D3596F1;
	Fri,  9 Jan 2026 13:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965785; cv=none; b=pdfqyVPgy193pU+84sIH5+HYjdFZDup4IkIylsoNhccouDK2k4iUwQJdJpP0r9/9VFmhf4TUJMNmfMOsvJEw4vUVTyVHhAu8f+k3PSq8W/XO3+xw/bfozMM8WDlZV7qOdFKXRl03KrW7AwHQjT/GfjohVEF64PQZEkT++y0Z3RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965785; c=relaxed/simple;
	bh=NL9/oVNOtR0tmrLgPA0iqJBtmbt3otl8c220tMUZosA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=f6z/aorPvTKSe5iKHd5cxmX+QKG/5WxUUj1h92+C/hYNA2ne3n7ybXddzsYOZE131S68FjpLt/1pG0rhlr0ebwVo3MeBYZy5cDVPY47znekJlRD7pB23mgVMp7Z3mIjFAesRE9yk6K4swsMWv23h7aGlEHEwzO/2OQLkoR/0rEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=YjCoA/u+; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=u/kJpxN9PiPj+IMSQa1C3nUsrmKHrwSRiEZFJGsQeNE=; b=YjCoA/u+NZfLnuF8nFd9ayP426
	sAYPHlaFUCq7BOQGXUGTuwn0hLFiLTHTGq0XR7jW80PRofTPMq6UXAL0rDzbPzxGB+L4wfxpTuCmo
	H/JiEtR1SK3o9S3N7jY2mntPJUe8tmIWGxG6vuJUTYBWW1Ohbg08hGHvY9YGlDP3jHwlrL4qAHV5m
	8wNzhFMAFQbw9AZ0CeqPLt4lCi1reQH5pEPRNkSJ1b3LsFRuftLjzdaNLNDqrCYyyAq5EwDjUl9Pv
	XkZ609QYucIuvpUghwarEHSZ80uldOhM92UjG4ebBS2gqLkhjdebAfX5cnhz81v55VQp5y632yA+y
	xoyoKsqQ==;
Received: from [122.175.9.182] (port=6128 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1veCey-00000000yhB-3PSb;
	Fri, 09 Jan 2026 08:36:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 8704F1A87DF3;
	Fri,  9 Jan 2026 19:06:04 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id bc5d2Qlm8PaD; Fri,  9 Jan 2026 19:06:04 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 326941A87DB6;
	Fri,  9 Jan 2026 19:06:04 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id nFJYEkXO4hX4; Fri,  9 Jan 2026 19:06:04 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 0DA5A1A87DF3;
	Fri,  9 Jan 2026 19:06:04 +0530 (IST)
Date: Fri, 9 Jan 2026 19:06:04 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	kuba <kuba@kernel.org>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, pmohan <pmohan@couthit.com>, 
	basharath <basharath@couthit.com>, afd <afd@ti.com>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	ALOK TIWARI <alok.a.tiwari@oracle.com>, horms <horms@kernel.org>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>
Message-ID: <780606794.101004.1767965764041.JavaMail.zimbra@couthit.local>
In-Reply-To: <40be3195-62e0-483a-9448-cf8a342d95f6@redhat.com>
References: <20260105122549.1808390-1-parvathi@couthit.com> <20260105122549.1808390-2-parvathi@couthit.com> <40be3195-62e0-483a-9448-cf8a342d95f6@redhat.com>
Subject: Re: [PATCH net-next v11 1/3] net: ti: icssm-prueth: Add helper
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
Thread-Topic: icssm-prueth: Add helper functions to configure and maintain FDB
Thread-Index: iWvoOkEigFHA0/dVf3pbWBmqQy86YA==
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

> On 1/5/26 1:23 PM, Parvathi Pudi wrote:
>> +static void icssm_prueth_sw_fdb_update_index_tbl(struct prueth *prueth,
>> +						 u16 left, u16 right)
>> +{
>> +	unsigned int hash, hash_prev;
>> +	u8 mac[ETH_ALEN];
>> +	unsigned int i;
>> +
>> +	/* To ensure we don't improperly update the
>> +	 * bucket index, initialize with an invalid
>> +	 * hash in case we are in leftmost slot
>> +	 */
>> +	hash_prev = 0xff;
> 
> Why 0xff is an invalid index if the hash table size is 256?
> 

Although the hash table has 256 entries, valid indices are in the range of 0-255,
and 0xff(255) is never used as a previous index reference in this context.

Initializing the hash_prev to 0xff allows the code to detect the leftmost slot
case and avoid incorrectly updating the bucket index when no valid previous
entry exists.

>> +
>> +	if (left > 0) {
>> +		memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(left - 1)->mac, ETH_ALEN);
>> +		hash_prev = icssm_prueth_sw_fdb_hash(mac);
>> +	}
>> +
>> +	/* For each moved element, update the bucket index */
>> +	for (i = left; i <= right; i++) {
>> +		memcpy_fromio(mac, FDB_MAC_TBL_ENTRY(i)->mac, ETH_ALEN);
>> +		hash = icssm_prueth_sw_fdb_hash(mac);
>> +
>> +		/* Only need to update buckets once */
>> +		if (hash != hash_prev)
>> +			writew(i, &FDB_IDX_TBL_ENTRY(hash)->bucket_idx);
>> +
>> +		hash_prev = hash;
>> +	}
>> +}
>> +
>> +static struct fdb_mac_tbl_entry __iomem *
>> +icssm_prueth_sw_find_free_mac(struct prueth *prueth, struct fdb_index_tbl_entry
>> +			      __iomem *bucket_info, u8 suggested_mac_tbl_idx,
>> +			      bool *update_indexes, const u8 *mac)
>> +{
>> +	s16 empty_slot_idx = 0, left = 0, right = 0;
>> +	unsigned int mti = suggested_mac_tbl_idx;
>> +	struct fdb_mac_tbl_array __iomem *mt;
>> +	struct fdb_tbl *fdb;
>> +	u8 flags;
>> +
>> +	fdb = prueth->fdb_tbl;
>> +	mt = fdb->mac_tbl_a;
>> +
>> +	flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
>> +	if (!(flags & FLAG_ACTIVE)) {
>> +		/* Claim the entry */
>> +		flags |= FLAG_ACTIVE;
>> +		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
>> +
>> +		return FDB_MAC_TBL_ENTRY(mti);
>> +	}
>> +
>> +	if (fdb->total_entries == FDB_MAC_TBL_MAX_ENTRIES)
>> +		return NULL;
>> +
>> +	empty_slot_idx = icssm_prueth_sw_fdb_empty_slot_left(mt, mti);
>> +	if (empty_slot_idx == -1) {
>> +		/* Nothing available on the left. But table isn't full
>> +		 * so there must be space to the right,
>> +		 */
>> +		empty_slot_idx = icssm_prueth_sw_fdb_empty_slot_right(mt, mti);
>> +
>> +		/* Shift right */
>> +		left = mti;
>> +		right = empty_slot_idx;
>> +		icssm_prueth_sw_fdb_move_range_right(prueth, left, right);
>> +
>> +		/* Claim the entry */
>> +		flags = readb(&FDB_MAC_TBL_ENTRY(mti)->flags);
>> +		flags |= FLAG_ACTIVE;
>> +		writeb(flags, &FDB_MAC_TBL_ENTRY(mti)->flags);
>> +
>> +		memcpy_toio(FDB_MAC_TBL_ENTRY(mti)->mac, mac, ETH_ALEN);
>> +
>> +		/* There is a chance we moved something in a
>> +		 * different bucket, update index table
>> +		 */
>> +		icssm_prueth_sw_fdb_update_index_tbl(prueth, left, right);
>> +
>> +		return FDB_MAC_TBL_ENTRY(mti);
> 
> AI review found what looks like a valid issue above:
> 
> """
> In this branch, FLAG_ACTIVE is set on FDB_MAC_TBL_ENTRY(mti) but the
> function returns FDB_MAC_TBL_ENTRY(empty_slot_idx). The caller in
> icssm_prueth_sw_insert_fdb_entry() then writes the MAC address to the
> returned entry (empty_slot_idx), leaving entry mti marked active with
> stale data.
> 
> Should FLAG_ACTIVE be set on empty_slot_idx instead? For comparison,
> the other paths in this function (lines 270-277, 294-306, and 330-342)
> all set FLAG_ACTIVE on the same entry they return and write MAC data to.
> """
> 

This looks valid, we will address this in the next version.

> Generally speaking the hash table handling looks complex and error
> prone. Is keeping the collided entries sorted really a win? I guess that
> always head-inserting would simplify the code a bit.
> 
> /P

Thanks and Regards,
Parvathi.

