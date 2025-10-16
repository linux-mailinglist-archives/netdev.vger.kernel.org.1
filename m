Return-Path: <netdev+bounces-230044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA62BBE3314
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 13:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAE05587AEF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 11:54:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39A1131BCAE;
	Thu, 16 Oct 2025 11:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="jtRDS+ue"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842922E36E9;
	Thu, 16 Oct 2025 11:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760615648; cv=none; b=Lc0fjcoy3sNslRYGGlrJFy2Oa2EmcX+LGTGRjvY/ihd60UoJDl/ZXbGEaD/7pdPFSByCyV3raEgm4MsDdxfkyyEDk/tpWPwrXnNp352wEu7yjP/jeXU4V4NsLxLzWlzkFXstIOhWC5LiNA6Jzcfvh5Qu+t1sH3FnKlM425mp4Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760615648; c=relaxed/simple;
	bh=Tep+impwxTRri/yLP6hy6505ONct1lEZxokezmlj5xQ=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=kFfN2xgjMtQj/Z0NId54sKVyrO1FnZIrozESIOH0M9ar2psQCjEAe+QJdhvQwiZm6xQBpJuZqqoxpZFaGYY5lEp4659ztfvHCc9dFMcmXzQtJ/aPX03yJPHwdzBfDgifvBeTnM4egMytLxZ7eOddLrQZSHAFYJ6lbQ5BAN7GbXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=jtRDS+ue; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=SHTD+AlE1tjHXFS7OlwtbfxpaZrYDJXVVnF6b1Dn+f8=; b=jtRDS+uenyWw30ufbo9cAMFbKx
	4o8/blA4+57TC6/tDWM2CV3tft0GHbARJ9INnI5OYKRbHtvUXg8pkLTEeScbOt7Y1d5ZAdN82scYf
	sCjbOBGrQ+7+cvnahfszt9mbo3BRbDi00AmnAFYrQo41skEeWAnZXhwIMKnDh6CEQWuWBYEU/Urog
	otAez/oWoaMk0mVePU89XUHEpZ0tAXud5MolrU714VfaDrAoPXxyGXgjhe6RIDjaXbOI7HjLZhNFY
	26FcHNjalR1h52A0q1pSFW8Q3n6NpfsvfZ/gUirXHnfu9yFe4iXXNZZclse20cnw+7ZB6eohL6EL+
	Znc/a6OQ==;
Received: from [122.175.9.182] (port=62890 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v9MYV-000000079bj-3GHn;
	Thu, 16 Oct 2025 07:54:04 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 26A381783FF9;
	Thu, 16 Oct 2025 17:24:00 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 12A381783FF4;
	Thu, 16 Oct 2025 17:24:00 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id VIlxZ_53cVMX; Thu, 16 Oct 2025 17:23:59 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id DAF701781C72;
	Thu, 16 Oct 2025 17:23:59 +0530 (IST)
Date: Thu, 16 Oct 2025 17:23:59 +0530 (IST)
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
Message-ID: <1336430040.1005.1760615639799.JavaMail.zimbra@couthit.local>
In-Reply-To: <ff651c3d-108b-48f8-b69b-fb0b522edd4e@lunn.ch>
References: <20251014124018.1596900-1-parvathi@couthit.com> <20251014124018.1596900-2-parvathi@couthit.com> <ff651c3d-108b-48f8-b69b-fb0b522edd4e@lunn.ch>
Subject: Re: [PATCH net-next v3 1/3] net: ti: icssm-prueth: Adds helper
 functions to configure and maintain FDB
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: icssm-prueth: Adds helper functions to configure and maintain FDB
Thread-Index: n9boZ3kHorfViJim7wqUTYIC+ep2RA==
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

>> +void icssm_prueth_sw_fdb_tbl_init(struct prueth *prueth)
>> +{
>> +=09struct fdb_tbl *t =3D prueth->fdb_tbl;
>> +
>> +=09t->index_a =3D (struct fdb_index_array_t *)((__force const void *)
>> +=09=09=09prueth->mem[V2_1_FDB_TBL_LOC].va +
>> +=09=09=09V2_1_FDB_TBL_OFFSET);
>=20
> We have
>=20
>> +#define V2_1_FDB_TBL_LOC          PRUETH_MEM_SHARED_RAM
>=20
> and existing code like:
>=20
> void __iomem *sram_base =3D prueth->mem[PRUETH_MEM_SHARED_RAM].va;
>=20
> so it seems like
>=20
> t->index_a =3D sram_base + V2_1_FDB_TBL_OFFSET;
>=20
> with no needs for any casts, since sram_base is a void * so can be
> assigned to any pointer type.
>=20
> And there are lots of cascading defines like:
>=20
> /* 4 queue descriptors for port 0 (host receive). 32 bytes */
> #define HOST_QUEUE_DESC_OFFSET          (HOST_QUEUE_SIZE_ADDR + 16)
>=20
> /* table offset for queue size:
> * 3 ports * 4 Queues * 1 byte offset =3D 12 bytes
> */
> #define HOST_QUEUE_SIZE_ADDR            (HOST_QUEUE_OFFSET_ADDR + 8)
> /* table offset for queue:
> * 4 Queues * 2 byte offset =3D 8 bytes
> */
> #define HOST_QUEUE_OFFSET_ADDR          (HOST_QUEUE_DESCRIPTOR_OFFSET_ADD=
R + 8)
> /* table offset for Host queue descriptors:
> * 1 ports * 4 Queues * 2 byte offset =3D 8 bytes
> */
> #define HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR       (HOST_Q4_RX_CONTEXT_OFFSE=
T + 8)
>=20
> allowing code like:
>=20
>=09sram =3D sram_base + HOST_QUEUE_SIZE_ADDR;
>=09sram =3D sram_base + HOST_Q1_RX_CONTEXT_OFFSET;
>=09sram =3D sram_base + HOST_QUEUE_OFFSET_ADDR;
>=09sram =3D sram_base + HOST_QUEUE_DESCRIPTOR_OFFSET_ADDR;
>=09sram =3D sram_base + HOST_QUEUE_DESC_OFFSET;
>=20

Sure, we will check the feasibility and come back.


>> +=09t->mac_tbl_a =3D (struct fdb_mac_tbl_array_t *)((__force const void =
*)
>> +=09=09=09t->index_a + FDB_INDEX_TBL_MAX_ENTRIES *
>> +=09=09=09sizeof(struct fdb_index_tbl_entry_t));
>=20
> So i think this could follow the same pattern, also allowing some of
> these casts to be removed.
>=20
> I just don't like casts, they suggest bad design.
>=20

Sure, we will check the feasibility and come back.

>> +static u8 icssm_pru_lock_done(struct fdb_tbl *fdb_tbl)
>> +{
>> +=09return readb((u8 __iomem *)&fdb_tbl->locks->pru_locks);
>=20
> And maybe the __iomem attribute can be added to struct, either per
> member, or at the top level? It is all iomem, so we want sparse to be
> able to check all accesses.
>=20

Sure, we will check the feasibility and come back.

>> +static int icssm_prueth_sw_fdb_spin_lock(struct fdb_tbl *fdb_tbl)
>> +{
>> +=09u8 done;
>> +=09int ret;
>> +
>> +=09/* Take the host lock */
>> +=09writeb(1, (u8 __iomem *)&fdb_tbl->locks->host_lock);
>> +
>> +=09/* Wait for the PRUs to release their locks */
>> +=09ret =3D read_poll_timeout(icssm_pru_lock_done, done, done =3D=3D 0,
>> +=09=09=09=091, 10, false, fdb_tbl);
>> +=09if (ret)
>> +=09=09return -ETIMEDOUT;
>> +
>> +=09return 0;
>=20
> Documentation says:
>=20
> * Returns: 0 on success and -ETIMEDOUT upon a timeout.
>=20
> So no need for the if statement.
>=20
>=20

Sure, we will address this in the next version.

>> +static s16
>> +icssm_prueth_sw_fdb_search(struct fdb_mac_tbl_array_t *mac_tbl,
>> +=09=09=09   struct fdb_index_tbl_entry_t *bucket_info,
>> +=09=09=09   const u8 *mac)
>> +{
>> +=09u8 mac_tbl_idx =3D bucket_info->bucket_idx;
>> +=09int i;
>> +
>> +=09for (i =3D 0; i < bucket_info->bucket_entries; i++, mac_tbl_idx++) {
>> +=09=09if (ether_addr_equal(mac,
>> +=09=09=09=09     mac_tbl->mac_tbl_entry[mac_tbl_idx].mac))
>> +=09=09=09return mac_tbl_idx;
>> +=09}
>> +
>> +=09return -ENODATA;
>=20
> It is traditional to return errno in an int. But i don't see why a s16
> cannot be used.
>=20

For now we will modify the return type to integer at all applicable places.


>> +icssm_prueth_sw_fdb_find_bucket_insert_point(struct fdb_tbl *fdb,
>> +=09=09=09=09=09     struct fdb_index_tbl_entry_t
>> +=09=09=09=09=09     *bkt_info,
>> +=09=09=09=09=09     const u8 *mac, const u8 port)
>> +{
>> +=09struct fdb_mac_tbl_array_t *mac_tbl =3D fdb->mac_tbl_a;
>> +=09struct fdb_mac_tbl_entry_t *e;
>> +=09u8 mac_tbl_idx;
>> +=09int i, ret;
>> +=09s8 cmp;
>> +
>> +=09mac_tbl_idx =3D bkt_info->bucket_idx;
>> +
>> +=09for (i =3D 0; i < bkt_info->bucket_entries; i++, mac_tbl_idx++) {
>> +=09=09e =3D &mac_tbl->mac_tbl_entry[mac_tbl_idx];
>> +=09=09cmp =3D memcmp(mac, e->mac, ETH_ALEN);
>> +=09=09if (cmp < 0) {
>> +=09=09=09return mac_tbl_idx;
>> +=09=09} else if (cmp =3D=3D 0) {
>> +=09=09=09if (e->port !=3D port) {
>> +=09=09=09=09/* MAC is already in FDB, only port is
>> +=09=09=09=09 * different. So just update the port.
>> +=09=09=09=09 * Note: total_entries and bucket_entries
>> +=09=09=09=09 * remain the same.
>> +=09=09=09=09 */
>> +=09=09=09=09ret =3D icssm_prueth_sw_fdb_spin_lock(fdb);
>> +=09=09=09=09if (ret) {
>> +=09=09=09=09=09pr_err("PRU lock timeout\n");
>> +=09=09=09=09=09return -ETIMEDOUT;
>> +=09=09=09=09}
>=20
> icssm_prueth_sw_fdb_spin_lock() returns an errno. Don't replace it.
>=20
> Also, pr_err() is bad practice and probably checkpatch is telling you
> this. Ideally you want to indicate which device has an error, so you
> should be using dev_err(), or maybe netdev_err().
>=20

We=E2=80=99ll return the =E2=80=9Cret=E2=80=9D value and replace the pr_err=
() with netdev_err()
so the message shows which device had the error.

>> +=09if (left > 0) {
>> +=09=09hash_prev =3D
>> +=09=09=09icssm_prueth_sw_fdb_hash
>> +=09=09=09(FDB_MAC_TBL_ENTRY(left - 1)->mac);
>> +=09}
>=20
>> +=09=09empty_slot_idx =3D
>> +=09=09=09icssm_prueth_sw_fdb_check_empty_slot_right(mt, mti);
>=20
> There are a couple of odd indentations like this. I wounder if it
> makes sense to shorten the prefix? Do you really need all of
> icssm_prueth_sw_fdb_ ?
>=20
> =09Andrew

The long prefix is to keep the functions names clear, but we will shorten
it and fix the indentations.


Thanks and Regards,
Parvathi.

