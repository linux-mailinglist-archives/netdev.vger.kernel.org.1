Return-Path: <netdev+bounces-240303-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCDAC72572
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 07:28:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFBCB4E664D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 06:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D582FB094;
	Thu, 20 Nov 2025 06:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="h3LFlK7W"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F292C2F1FCA;
	Thu, 20 Nov 2025 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763619776; cv=none; b=uHMEJ8q2VwqdE1fnsRysSfKm0Z6lwrseEJjEUWWF5ddnU/rxztDfnMG7OJPMGc76ofrVjBiPxY3T5yv5bQRi1UrpeALGe6tuIUwmaRRDB1viUZeljbEqIW0SoRTECuN7iY1Hp4S/g9AtXXy6TbO6xsTS7wiF3cq5Yf85l350Cd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763619776; c=relaxed/simple;
	bh=e4Mq5hTcQOeYggd4DZZgCz9iSGDzS8vwWFcgK9JrZ5g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=IqhNV5hZmFDrwLGYp9HgfuD0VXSBe/731dHXTjHVO7atCie3vOqvpFgnbx1DFOGFkoJge4qyRrLu2cCiX2R1zBS/9l/ezOt9/E4oFJhkCIJ+u+4putNk1UUC6kJov/SJoyCkjlAfnt3Io4IHOMrqUuJsHxPc1YJWuwua33T22GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=h3LFlK7W; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=uKZodm+ReYNusY2xVVSFiAlOsTVc6bMMlqux5zRbruQ=; b=h3LFlK7Wtmag9cy54MP7LldHv0
	UnEGkpirnMoMHP7tGCIkA/m2YuWUpHPS7P/73KIrEKIK/16xg/QXA/I4zkZ0VxiFysuxDshAsY4bF
	uHpXDfqmGc9IOamajZPyc7tJtXoabNFcg5m0M06gq+d1Mq1clll7aoLX8IdnAM8u9Lb6VjD2jxRrd
	AE32+R8VUBbFhz6hS+0qDGGn08EZmMKXnfshIX5BkuDRmYMw25jg1dmkORYjD8pDpCl0s0DV+Va6j
	LQdcP5pZ/kPlk35c9GzHjADvc56VR/vh6GCMPZMyUv5XkfXLvNnM5lBM4WDn+EIHAm4pq5ZclGNzR
	Xe61u8vg==;
Received: from [122.175.9.182] (port=22234 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vLy4B-00000004wxM-05Sy;
	Thu, 20 Nov 2025 01:22:51 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 078A21A681A3;
	Thu, 20 Nov 2025 11:52:38 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id DuUOaIeWS9qg; Thu, 20 Nov 2025 11:52:37 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id D46A71A6818A;
	Thu, 20 Nov 2025 11:52:37 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id AirGp5UpjfKQ; Thu, 20 Nov 2025 11:52:37 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B10181A681A3;
	Thu, 20 Nov 2025 11:52:37 +0530 (IST)
Date: Thu, 20 Nov 2025 11:52:37 +0530 (IST)
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
Message-ID: <1902810966.5288.1763619757671.JavaMail.zimbra@couthit.local>
In-Reply-To: <aRuOzelPTiwaoNop@horms.kernel.org>
References: <20251113101229.675141-1-parvathi@couthit.com> <20251113101229.675141-3-parvathi@couthit.com> <aRuOzelPTiwaoNop@horms.kernel.org>
Subject: Re: [PATCH net-next v5 2/3] net: ti: icssm-prueth: Adds switchdev
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
Thread-Index: yIyBbZf/3F6Je9h5CgJpEDaQYsxTKA==
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

> On Thu, Nov 13, 2025 at 03:40:22PM +0530, Parvathi Pudi wrote:
>=20
> ...
>=20
>> @@ -222,12 +229,14 @@ struct prueth_emac {
>>  =09const char *phy_id;
>>  =09u32 msg_enable;
>>  =09u8 mac_addr[6];
>> +=09unsigned char mc_filter_mask[ETH_ALEN]; /* for multicast filtering *=
/
>>  =09phy_interface_t phy_if;
>> =20
>>  =09/* spin lock used to protect
>>  =09 * during link configuration
>>  =09 */
>>  =09spinlock_t lock;
>> +=09spinlock_t addr_lock;   /* serialize access to VLAN/MC filter table =
*/
>=20
> addr_lock does not appear to be initialised anywhere.
>=20
> ...
>=20

Sure, we will address this in next version.


>> +static int icssm_prueth_switchdev_obj_del(struct net_device *ndev,
>> +=09=09=09=09=09  const void *ctx,
>> +=09=09=09=09=09  const struct switchdev_obj *obj)
>> +{
>> +=09struct switchdev_obj_port_mdb *mdb =3D SWITCHDEV_OBJ_PORT_MDB(obj);
>> +=09struct prueth_emac *emac =3D netdev_priv(ndev);
>> +=09struct prueth *prueth =3D emac->prueth;
>> +=09struct netdev_hw_addr *ha;
>> +=09u8 hash, tmp_hash;
>> +=09int ret =3D 0;
>> +
>> +=09switch (obj->id) {
>> +=09case SWITCHDEV_OBJ_ID_HOST_MDB:
>> +=09=09dev_dbg(prueth->dev, "MDB del: %s: vid %u:%pM  port: %x\n",
>> +=09=09=09ndev->name, mdb->vid, mdb->addr, emac->port_id);
>> +=09=09hash =3D icssm_emac_get_mc_hash(mdb->addr, emac->mc_filter_mask);
>> +=09=09netdev_for_each_mc_addr(ha, prueth->hw_bridge_dev) {
>=20
> Is there anything stopping this event from occurring when
> the port is not the lower device of a bridge - before being added
> or after being removed?
>=20
> If not, then passing prueth->hw_bridge_dev to netdev_for_each_mc_addr()
> will result in a null pointer dereference.
>=20
> ...

Sure, we=E2=80=99ll verify the code and add the appropriate conditional
checks to ensure "prueth->hw_bridge_dev" is valid before using it.
This will be addressed in the next version.

Thanks and Regards,
Parvathi.


