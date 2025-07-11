Return-Path: <netdev+bounces-206157-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B010B01C18
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242AE16D39A
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DDC2980CD;
	Fri, 11 Jul 2025 12:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="bja6yI4b"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5914A24;
	Fri, 11 Jul 2025 12:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752237201; cv=none; b=VW8U1tPSnb+Qr9bOS/A64oHhbHOjQ/efcIkr7qSeB4WrChHR1njnpArGIQELlXcHbjejQCGu0ShWWf5rilMczNU+colRrKzxV34YZM0tW9tG9M4+02y5v58IwlFD4GXqIGUakVyRU3+eH2XNcI74T1gWOEFNw9VeZgUzQ/ynjRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752237201; c=relaxed/simple;
	bh=WYWKVt6dUPJaMiGKNZZnN/uJcyMEGDqbOYOvPwKRwbo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Qo4snAcKQQMhEKWce10Ct5aQSR/gxuN//5577UmKbfVcs1iN3eFgAuDNzB4E3ITyc+vl9peppeTtUs8az9fBlPq4O7dRqPBiQj0ZGlBcDAnCbrhMvlAeKxFrOZTJs9TJnBqIM3GiYkzuc/eztQABhXAeZetYcIdFGoqYwrDjydA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=bja6yI4b; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=AJW9cOBCmrxXxZqHEQ8adQkukE2W2AgflGt7EU89058=; b=bja6yI4bhC5Up2flT2VGnPrBJi
	AI9jYvgSAP3+3hJEpZz9uckqmm/D/4jscytgnNi9jXJOlZregJWSUc4jnwX3txw3D69KK6igl+Aya
	dV0jotGglD6S4CUsOKbD0R6kbgWNNts/4dX3kfMR1kGHO5z9qc8GeyQoxqErzFirVVN5NhoovO1q1
	4NiBqtG/0W1JNj16URhLgFOjUZsWyUUyL2ir3EQyKrbxx7tWq4WUwbIlmebiF8WtR41+QcoQ3XF87
	yIPufMuzKE2gnaMtF9nqKb2rJHTw1NxY/nuFkZ0fJkl0LktfLSo2THBWYv+cncQsHSuAbC7orQM09
	BOPVLmBA==;
Received: from [122.175.9.182] (port=12257 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uaCwE-0000000Cl5L-2uHd;
	Fri, 11 Jul 2025 08:33:15 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id 4D7A017820AC;
	Fri, 11 Jul 2025 18:03:09 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 2E52517820F5;
	Fri, 11 Jul 2025 18:03:09 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id hCs-qG7o16wZ; Fri, 11 Jul 2025 18:03:09 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id DD32117820AC;
	Fri, 11 Jul 2025 18:03:08 +0530 (IST)
Date: Fri, 11 Jul 2025 18:03:08 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: kuba <kuba@kernel.org>
Cc: parvathi <parvathi@couthit.com>, danishanwar <danishanwar@ti.com>, 
	rogerq <rogerq@kernel.org>, andrew+netdev <andrew+netdev@lunn.ch>, 
	davem <davem@davemloft.net>, edumazet <edumazet@google.com>, 
	pabeni <pabeni@redhat.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	ssantosh <ssantosh@kernel.org>, 
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
Message-ID: <723330733.1712525.1752237188810.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250708180107.7886ea41@kernel.org>
References: <20250702140633.1612269-1-parvathi@couthit.com> <20250702151756.1656470-5-parvathi@couthit.com> <20250708180107.7886ea41@kernel.org>
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
Thread-Index: frcZHpE/y/6hXxyDNRDspT8aDcWlcQ==
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

> On Wed,  2 Jul 2025 20:47:49 +0530 Parvathi Pudi wrote:
>> +=09=09=09if (emac->port_id) {
>> +=09=09=09=09regmap_update_bits
>> +=09=09=09=09=09(prueth->mii_rt,
>> +=09=09=09=09=09 PRUSS_MII_RT_TXCFG1,
>> +=09=09=09=09=09 PRUSS_MII_RT_TXCFG_TX_CLK_DELAY_MASK,
>> +=09=09=09=09=09 delay);
>=20
> Instead of breaking the lines up like this you should factor the code
> out or find some other way to reduce the indentation.
>=20

Sure, we will address this in the next version.

>> +=09qid =3D icssm_prueth_get_tx_queue_id(emac->prueth, skb);
>> +=09ret =3D icssm_prueth_tx_enqueue(emac, skb, qid);
>> +=09if (ret) {
>> +=09=09if (ret !=3D -ENOBUFS && netif_msg_tx_err(emac) &&
>> +=09=09    net_ratelimit())
>> +=09=09=09netdev_err(ndev, "packet queue failed: %d\n", ret);
>> +=09=09goto fail_tx;
>> +=09}
>=20
>> +=09if (ret =3D=3D -ENOBUFS) {
>> +=09=09ret =3D NETDEV_TX_BUSY;
>=20
>=20
> Something needs to stop the queue, right? Otherwise the stack will
> send the frame right back to the driver.
>=20

Yes, we will notify upper layer with =E2=80=9Cnetif_tx_stop_queue()=E2=80=
=9D when returning
=E2=80=9CNETDEV_TX_BUSY=E2=80=9D to not push again immediately.

>> +static inline void icssm_emac_finish_napi(struct prueth_emac *emac,
>> +=09=09=09=09=09  struct napi_struct *napi,
>> +=09=09=09=09=09  int irq)
>> +{
>> +=09napi_complete(napi);
>> +=09enable_irq(irq);
>=20
> This helper has a single caller, just put the two lines of code directly
> there. And use napi_complete_done(), please.

We will address this in the next version.

Thanks and Regards,
Parvathi.

