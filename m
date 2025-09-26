Return-Path: <netdev+bounces-226667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE3ABA3D5A
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 15:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40E115625D2
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 13:16:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D948C2F60C0;
	Fri, 26 Sep 2025 13:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="WUoMo0Wy"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEFC2F7ABA;
	Fri, 26 Sep 2025 13:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758892458; cv=none; b=IL7BBHr3mnvHuzFjHDn1psP2fNmgqC9stbtJBPddGBkYUFeR9ncuPcTiDH9na/7jkw0+51TjKMkMejkQSwwRcBqCZRcMI6aWvqEo7FZPIuAFdklpIRqzQAZVGIDBClon7XOl9RD5UfGucTVnOgy47ny01mSzLzTN2rfNFmqpYew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758892458; c=relaxed/simple;
	bh=a5yaaMHb4t7T/cLgdTiSiN8+DSzhvMlPfigRe16efaY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=HxE/3iKftDKTPXEzmg4VPuVSTo1WjomZax09X96XBcESD8za6JQdc020SU+3b8k4+ts9sHJZp0aRwY4tocQFO5NuL41+gYNd7lws6cOiVBP2Ifm6s/VOiH7MVZy5lZwocWldhZK54INrAR58bPGeJk+8iOW0cElWE/9GuSO6ec0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=WUoMo0Wy; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=J1+1kTUUs/RVTWqBOqpuuN8DYjuh5UTJ910VA1slb4s=; b=WUoMo0Wy+nPacAu9OKv3Ewu3Du
	yjpIMnMNRkp2HeuMut3UOgkPIeITzZgmEzsqK343DoId10dQwdfVKJiB4uw7Rv6+CtEAEm4zF9qKO
	Wro6MmVi0ePIHeyRfP2yddxFxJ9d1WF2EyT56woXjAoub2CrGXTAXWJvCsvoo9oiwEcX7kNTt3N32
	/s+qfsxPQl8/jMiTb4zb6qiVRQyMDveLiW+y/wRW9Tad/+X1IGtG+mGj1EDq7fymA13DcIxEp2Kw7
	dDYGQ2EA34HoGucTn5cUJ9vhpSZos7CVVn+6nO7SNHlg1SDJukOJvtxBqld1qOFqFDRCNqQ2V+XsP
	ui1FeEAA==;
Received: from [122.175.9.182] (port=32198 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1v28H7-00000006Z08-3jh8;
	Fri, 26 Sep 2025 09:14:13 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 0CDCB1783FF9;
	Fri, 26 Sep 2025 18:44:10 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id E95871783FF3;
	Fri, 26 Sep 2025 18:44:09 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id JJ8fP1ec6_8K; Fri, 26 Sep 2025 18:44:09 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B5C521781C3D;
	Fri, 26 Sep 2025 18:44:09 +0530 (IST)
Date: Fri, 26 Sep 2025 18:44:09 +0530 (IST)
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
Message-ID: <464535038.433548.1758892449616.JavaMail.zimbra@couthit.local>
In-Reply-To: <02f2c50f-31f6-4d4a-9cbe-5f77d1d60706@lunn.ch>
References: <20250925141246.3433603-1-parvathi@couthit.com> <20250925141246.3433603-2-parvathi@couthit.com> <02f2c50f-31f6-4d4a-9cbe-5f77d1d60706@lunn.ch>
Subject: Re: [PATCH net-next 1/3] net: ti: icssm-prueth: Adds helper
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
Thread-Index: f16IARbcZW1mlifyPMb+ZjnZ1I30tw==
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

>> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth_fdb_tbl.h
>> @@ -0,0 +1,66 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/* Copyright (C) 2019-2021 Texas Instruments Incorporated - https://www=
.ti.com
>> */
>> +#ifndef __NET_TI_PRUSS_FDB_TBL_H
>> +#define __NET_TI_PRUSS_FDB_TBL_H
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/debugfs.h>
>> +#include "icssm_prueth.h"
>> +
>> +#define ETHER_ADDR_LEN 6
>=20
> Please use ETH_ALEN everywhere.
>

Sure, we will address this in the next version.

>> +static void icssm_prueth_sw_fdb_spin_lock(struct fdb_tbl *fdb_tbl)
>> +{
>> +=09/* Take the host lock */
>> +=09writeb(1, (u8 __iomem *)&fdb_tbl->locks->host_lock);
>> +
>> +=09/* Wait for the PRUs to release their locks */
>> +=09while (readb((u8 __iomem *)&fdb_tbl->locks->pru_locks))
>> +=09=09;
>=20
> Don't use endless loops. What happens if the firmware crashed. Please
> use something from iopoll.h and handle -ETIMEDOUT.
>=20

Sure, we will replace the while loop with =E2=80=9Cread_poll_timeout()=E2=
=80=9D API from
iopoll.h and handle the return value appropriately in the next version.

>> +static void icssm_mac_copy(u8 *dst, const u8 *src)
>> +{
>> +=09u8 i;
>> +
>> +=09for (i =3D 0; i < ETHER_ADDR_LEN; i++) {
>> +=09=09*(dst) =3D *(src);
>> +=09=09dst++;
>> +=09=09src++;
>> +=09}
>> +}
>=20
> There is a kernel helper for this.
>=20

We will use the =E2=80=9Cether_addr_copy()=E2=80=9D API where ever it is ap=
plicable.

>> +
>> +static s8 icssm_mac_cmp(const u8 *mac_a, const u8 *mac_b)
>> +{
>> +=09s8  ret =3D 0, i;
>> +
>> +=09for (i =3D 0; i < ETHER_ADDR_LEN; i++) {
>> +=09=09if (mac_a[i] =3D=3D mac_b[i])
>> +=09=09=09continue;
>> +
>> +=09=09ret =3D mac_a[i] < mac_b[i] ? -1 : 1;
>> +=09=09break;
>> +=09}
>> +
>> +=09return ret;
>> +}
>=20
> I suspect there is also a helper for this. Please don't reinvent what
> the kernel already has.
>=20

Sure, we will check and address this as well.

>> +static s16
>> +icssm_prueth_sw_fdb_find_bucket_insert_point(struct fdb_tbl *fdb,
>> +=09=09=09=09=09     struct fdb_index_tbl_entry_t
>> +=09=09=09=09=09     *bkt_info,
>> +=09=09=09=09=09     const u8 *mac, const u8 port)
>> +{
>> +=09struct fdb_mac_tbl_array_t *mac_tbl =3D fdb->mac_tbl_a;
>> +=09struct fdb_mac_tbl_entry_t *e;
>> +=09u8 mac_tbl_idx;
>> +=09s8 cmp;
>> +=09int i;
>> +
>> +=09mac_tbl_idx =3D bkt_info->bucket_idx;
>> +
>> +=09for (i =3D 0; i < bkt_info->bucket_entries; i++, mac_tbl_idx++) {
>> +=09=09e =3D &mac_tbl->mac_tbl_entry[mac_tbl_idx];
>> +=09=09cmp =3D icssm_mac_cmp(mac, e->mac);
>> +=09=09if (cmp < 0) {
>> +=09=09=09return mac_tbl_idx;
>> +=09=09} else if (cmp =3D=3D 0) {
>> +=09=09=09if (e->port !=3D port) {
>> +=09=09=09=09/* MAC is already in FDB, only port is
>> +=09=09=09=09 * different. So just update the port.
>> +=09=09=09=09 * Note: total_entries and bucket_entries
>> +=09=09=09=09 * remain the same.
>> +=09=09=09=09 */
>> +=09=09=09=09icssm_prueth_sw_fdb_spin_lock(fdb);
>> +=09=09=09=09e->port =3D port;
>> +=09=09=09=09icssm_prueth_sw_fdb_spin_unlock(fdb);
>> +=09=09=09}
>> +
>> +=09=09=09/* MAC and port are the same, touch the fdb */
>> +=09=09=09e->age =3D 0;
>> +=09=09=09return -1;
>=20
> Returning values like this can result in bugs. It is better to use a
> real error code, just in case this ever makes it way back to
> userspace.
>=20
> =09Andrew

Sure, we will check and address this in the next version.


Thanks and Regards,
Parvathi.

