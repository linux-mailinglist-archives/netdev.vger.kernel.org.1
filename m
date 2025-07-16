Return-Path: <netdev+bounces-207463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0CB076A4
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 15:11:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FDF31890DAA
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 13:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4800A2F4304;
	Wed, 16 Jul 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="mSsRorqp"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6D7235072;
	Wed, 16 Jul 2025 13:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752671497; cv=none; b=mssk2CqFvsqPKe8B9ZFSoK4UtcNzh5mGlDj6GGB/OMU4Qj58ZlpGSS5b6JWoVibt1onlWsoodek4I/Sa9EjxNMIq0rGHAct4svJfWUh35Ln5SchSHsWK06MYiSyP0trgJDpVB77PdI96I2tOC7Fu5ZEyS1FY1r7D/BlJjVXCgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752671497; c=relaxed/simple;
	bh=hzmHkszYAoyXFUYOkAA7oNySXwfEslhstmlGJGO9cFU=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=KDOy0mjUNW3UbhrJPLLAklfp7A5bcH231R1JINdDx6YkJRd+OueXGRI/MMURcEFwhcTGz2mU5JgxMheM5JfVm/1OcapInyutK3bozCv6a9tUwRYI/fBzHUZoqeFlpeRyHtWVa0Vq9NftJ3opTDbTNJvIU14B3Dtjbx6yFRRrRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=mSsRorqp; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qCz3qkpSM0PaErwoNukZei1+0CUNeJ1oEHCchsaW8T0=; b=mSsRorqpu8GvUFSOiJ0BQI+6mh
	JPeC9IG0TZWWoUPrYxSxp/HSk4sfNrro88xvoXztLeT2sWWhWHoK/loc6rAKWyNY89ipAUNhTqnvV
	n0Qx7fc13cSny0+cZlDbSKoYb3QLub0NkXYJjToQuBVCB5iGE9euU8iEWwqbu8xz0rSFxdiN9utnh
	2xFhX0vZSoaiavvfmR+RoiFlLtv01kpcoxXHB9XtSWKWvH16wGKXPvATqawaiX79n/ZfVbymvdIy1
	4jXKo4t2Cqck/hLrZVHpm5bswdpAVoLgdFpuyA1b1px9onoRU4A9w93r0On4zBJ2gu2lMB92G5Zsk
	gtS1oukg==;
Received: from [122.175.9.182] (port=31570 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uc1uq-0000000HP1m-0wjn;
	Wed, 16 Jul 2025 09:11:20 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 5A5831784069;
	Wed, 16 Jul 2025 18:41:12 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 3F13E1784068;
	Wed, 16 Jul 2025 18:41:12 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id CYRcvNkisBKt; Wed, 16 Jul 2025 18:41:12 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id D20231781DBB;
	Wed, 16 Jul 2025 18:41:11 +0530 (IST)
Date: Wed, 16 Jul 2025 18:41:11 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: parvathi <parvathi@couthit.com>, kuba <kuba@kernel.org>
Cc: danishanwar <danishanwar@ti.com>, rogerq <rogerq@kernel.org>, 
	andrew+netdev <andrew+netdev@lunn.ch>, davem <davem@davemloft.net>, 
	edumazet <edumazet@google.com>, pabeni <pabeni@redhat.com>, 
	robh <robh@kernel.org>, krzk+dt <krzk+dt@kernel.org>, 
	conor+dt <conor+dt@kernel.org>, ssantosh <ssantosh@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	s hauer <s.hauer@pengutronix.de>, m-karicheri2 <m-karicheri2@ti.com>, 
	glaroque <glaroque@baylibre.com>, afd <afd@ti.com>, 
	saikrishnag <saikrishnag@marvell.com>, m-malladi <m-malladi@ti.com>, 
	jacob e keller <jacob.e.keller@intel.com>, 
	diogo ivo <diogo.ivo@siemens.com>, 
	javier carrasco cruz <javier.carrasco.cruz@gmail.com>, 
	horms <horms@kernel.org>, s-anna <s-anna@ti.com>, 
	basharath <basharath@couthit.com>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, 
	netdev <netdev@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	pratheesh <pratheesh@ti.com>, Prajith Jayarajan <prajith@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, praneeth <praneeth@ti.com>, 
	srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, pmohan <pmohan@couthit.com>, 
	mohan <mohan@couthit.com>
Message-ID: <1616453705.30524.1752671471644.JavaMail.zimbra@couthit.local>
In-Reply-To: <723330733.1712525.1752237188810.JavaMail.zimbra@couthit.local>
References: <20250702140633.1612269-1-parvathi@couthit.com> <20250702151756.1656470-5-parvathi@couthit.com> <20250708180107.7886ea41@kernel.org> <723330733.1712525.1752237188810.JavaMail.zimbra@couthit.local>
Subject: Re: [PATCH net-next v10 04/11] net: ti: prueth: Adds link
 detection, RX and TX support.
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds link detection, RX and TX support.
Thread-Index: frcZHpE/y/6hXxyDNRDspT8aDcWlcTdy9M2r
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

>>> +=09qid =3D icssm_prueth_get_tx_queue_id(emac->prueth, skb);
>>> +=09ret =3D icssm_prueth_tx_enqueue(emac, skb, qid);
>>> +=09if (ret) {
>>> +=09=09if (ret !=3D -ENOBUFS && netif_msg_tx_err(emac) &&
>>> +=09=09    net_ratelimit())
>>> +=09=09=09netdev_err(ndev, "packet queue failed: %d\n", ret);
>>> +=09=09goto fail_tx;
>>> +=09}
>>=20
>>> +=09if (ret =3D=3D -ENOBUFS) {
>>> +=09=09ret =3D NETDEV_TX_BUSY;
>>=20
>>=20
>> Something needs to stop the queue, right? Otherwise the stack will
>> send the frame right back to the driver.
>>=20
>=20
> Yes, we will notify upper layer with =E2=80=9Cnetif_tx_stop_queue()=E2=80=
=9D when returning
> =E2=80=9CNETDEV_TX_BUSY=E2=80=9D to not push again immediately.
>=20

We reviewed the flow and found that the reason for NETDEV_TX_BUSY being
notified to the upper layers is due lack of support for reliably detecting
the TX completion event.

In case of ICSSM PRU Ethernet, we do not have support for TX complete
notification back to the driver from firmware and its like store and
forget approach. So it will be tricky to enable back/resume the queue
if we stop it when we see busy status.

Returning NETDEV_TX_BUSY seems to be the best option so that the stack can
retry as soon as possible.


Thanks and Regards,
Parvathi.

