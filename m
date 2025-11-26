Return-Path: <netdev+bounces-241789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C75CDC883CB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9691B4E3378
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00ACA219E8D;
	Wed, 26 Nov 2025 06:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="2l2h4cR5"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135D523D7F3;
	Wed, 26 Nov 2025 06:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764137842; cv=none; b=ITG/8qMKmj+zwMMUvl+sloqEZJKzg2+rLaOdttOKjiarcNrbxQljejvKHF7xFYgdAgC7u/qglavir0FBEfhwzR1rz2kc6hwbMXDTsxgmDTk6WcAjDDPKFX6eYR1eOjcueRHHyIrkw8rwV2NXwFmfzJ3lOiERUsYIsVtGaLq8YW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764137842; c=relaxed/simple;
	bh=gWbGjD0ZLoSFc3VJobXoxW5AX6uTrYBRvZa3LX2Fo74=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=W7GoJJQUZVZNCZOVqrOOK1gIAtpyhIF3XSFVLPEnPaBWGNGJgAANXFO98XfmLTmoEqZBqFsvu+/hcV3Jt9GnBXFKx5knxw3OIwSnNFPl2o/qTIeW8Tbs2WIOOvrmkrbqEmYpF9THT2pee4pBCw0WxaOw91BHNz6GCZfBQI2JHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=2l2h4cR5; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=njRL/wp1iCkqO69EYYorLtrNKLXhDungO1SZ8XuDZA4=; b=2l2h4cR5ky5UT9XKYNwy6qYVCs
	EdUZbSUh33sqPEbmFDUcMNYEuBH57fiRShFcqlYAybcHXehJ0zKE0JMofbMDm8AXPFIQjG0VxhSYY
	uPtjR7jqeSlw9InYP2ZwLOceL2BsOYajBJBn75xe7E+Rmg9gSdOWPdgeiSVXQKOjBB3nbHXDMAFh3
	SYnLiJBt0D48nISo0G6xN8TFviRGHu+XKASW/5n8u0oijbSCwNSNiqyDd6D+VxbYyEe9MHUDjJWob
	chj/IQmppUdrs66AdVGGY99JQmJMn+DyW2kcuQttfgyimLcl3B1pKhLGvvKkkRzkvRoYndO7MlaHo
	FeTR4p+g==;
Received: from [122.175.9.182] (port=41747 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vO8pz-0000000CBjb-49pf;
	Wed, 26 Nov 2025 01:17:12 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 762FE1A820EA;
	Wed, 26 Nov 2025 11:47:04 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 1-IdLgzFHwXl; Wed, 26 Nov 2025 11:47:04 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 21E931A820E7;
	Wed, 26 Nov 2025 11:47:04 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id qG9HVHOSzlBM; Wed, 26 Nov 2025 11:47:04 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id F405A1A820EA;
	Wed, 26 Nov 2025 11:47:03 +0530 (IST)
Date: Wed, 26 Nov 2025 11:47:03 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Parvathi Pudi <parvathi@couthit.com>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, danishanwar <danishanwar@ti.com>, 
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
Message-ID: <1268174479.21081.1764137823922.JavaMail.zimbra@couthit.local>
In-Reply-To: <20251124200322.615773bb@kernel.org>
References: <20251124135800.2219431-1-parvathi@couthit.com> <20251124135800.2219431-3-parvathi@couthit.com> <20251124200322.615773bb@kernel.org>
Subject: Re: [PATCH net-next v6 2/3] net: ti: icssm-prueth: Adds switchdev
 support for icssm_prueth driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: icssm-prueth: Adds switchdev support for icssm_prueth driver
Thread-Index: MhmPbhazM+vc1QgT/0XqLnqRaUMf+A==
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

> On Mon, 24 Nov 2025 19:25:11 +0530 Parvathi Pudi wrote:
>> Subject: [PATCH net-next v6 2/3] net: ti: icssm-prueth: Adds switchdev s=
upport
>> for icssm_prueth driver
>=20
> Adds -> Add
>=20
>> This patch adds support for offloading the RSTP switch feature to the
>=20
> s/This patch adds/Add/
>=20
> imperative mood, please..
>=20

Sure, we will address this in the next version.

>> +static void icssm_prueth_sw_fdb_work(struct work_struct *work)
>> +{
>> +=09struct icssm_prueth_sw_fdb_work *fdb_work =3D
>> +=09=09container_of(work, struct icssm_prueth_sw_fdb_work, work);
>> +=09struct prueth_emac *emac =3D fdb_work->emac;
>> +
>> +=09rtnl_lock();
>> +
>> +=09/* Interface is not up */
>> +=09if (!emac->prueth->fdb_tbl)
>> +=09=09goto free;
>> +
>> +=09switch (fdb_work->event) {
>> +=09case FDB_LEARN:
>> +=09=09icssm_prueth_sw_insert_fdb_entry(emac, fdb_work->addr, 0);
>> +=09=09break;
>> +=09case FDB_PURGE:
>> +=09=09icssm_prueth_sw_do_purge_fdb(emac);
>> +=09=09break;
>> +=09default:
>> +=09=09break;
>> +=09}
>> +
>> +free:
>> +=09rtnl_unlock();
>> +=09kfree(fdb_work);
>> +=09dev_put(emac->ndev);
>=20
> please use netdev_put() and a netdev tracker
>=20

We will replace dev_put() with netdev_put() as shown below and
add a netdevice_tracker to the icssm_prueth_sw_fdb_work struct.

"netdev_put(emac->ndev, &fdb_work=E2=86=92ndev_tracker);"

We will address this in the next version.

>> +}
>> +
>> +int icssm_prueth_sw_learn_fdb(struct prueth_emac *emac, u8 *src_mac)
>> +{
>> +=09struct icssm_prueth_sw_fdb_work *fdb_work;
>> +
>> +=09fdb_work =3D kzalloc(sizeof(*fdb_work), GFP_ATOMIC);
>> +=09if (WARN_ON(!fdb_work))
>> +=09=09return -ENOMEM;
>> +
>> +=09INIT_WORK(&fdb_work->work, icssm_prueth_sw_fdb_work);
>> +
>> +=09fdb_work->event =3D FDB_LEARN;
>> +=09fdb_work->emac  =3D emac;
>> +=09ether_addr_copy(fdb_work->addr, src_mac);
>> +
>> +=09dev_hold(emac->ndev);
>=20
> same here.
>=20
> This significantly helps debugging in case some code leaks a reference.
> --
> pw-bot: cr


Here as well, we will replace dev_hold() with netdev_hold() as shown below
and will address this in next version.

"netdev_hold(emac->ndev, &fdb_work->ndev_tracker, GFP_ATOMIC);"


Thanks and Regards,
Parvathi.

