Return-Path: <netdev+bounces-206153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA49AB01BE7
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 14:25:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E991C27F35
	for <lists+netdev@lfdr.de>; Fri, 11 Jul 2025 12:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE2D2980AC;
	Fri, 11 Jul 2025 12:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="rFglEcXq"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DE5295519;
	Fri, 11 Jul 2025 12:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752236746; cv=none; b=ed/46qzFchbPHM6Vd8irTrBXyQL4K7Svqsu7eN7wkdcTSfj0sDqGEticBLnS38MDiVIjC7cwyougcDCVIj1krLTSqVRCNpn064FXaQU+PJVQrcnJnKjsrKYY2tEKAUusSYWZITNKi1onvTGi1RITprl4TYSMdknBHGTMvI+TIqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752236746; c=relaxed/simple;
	bh=OMuD8/98Wa0jZ/HLse0m8NTh56qssmOQ10uJKDUti8w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sKZsHjYLjOGyyKn7t927uuVV0nasnxOQNTH795cEoKzs9KJcz/PbHg2Ht8Sottn/QJbwjT17WeR4TKpx5oSWNjLdZp5s1NblCJXSlgU5iAD6HgCcszjULSCTRQ5BBLNBoD1UoZrzeGsKyBYNP1P092tySQr78Ntuf11RcTBfr4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=rFglEcXq; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=U+RihokjvyPuvKH5MulYPFUcnHHoo2u+0AmNKF5bVVY=; b=rFglEcXqMxNFTAqq64EhkIlUw9
	AMGhKeNTAIqfB9pPlcxexOeudL2StxE/cE3Y5t3T6ETvpshnq+I0LhOnBQvhfyw8Xi8Cu0fXHX1rM
	ghcAwLB8pFS9HM/w7i5eZeHWa9Kz89MRF3CvXouJsnbv0kMISULddN7Wo1BZWbupDDA4WX2bPjEmS
	fzrk+Xm5M/1MlCLjLZYqIUddZ9v12552UaKRH5Uiy5kN1DBmJ6s5q168JrDk51Bh/3AGChzG4vYMu
	htL/miijg3KPCQ5sIUEZ3G5/cj3AhY/P0sFNQNhTxUHNU7S9RAtOaSyjsnOf6MlnF2sNEQAV7kyHx
	9HyEgb2g==;
Received: from [122.175.9.182] (port=21690 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1uaCos-0000000CkxB-2S48;
	Fri, 11 Jul 2025 08:25:38 -0400
Received: from zimbra.couthit.local (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTPS id C7AC91781A71;
	Fri, 11 Jul 2025 17:55:32 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id A831917820AC;
	Fri, 11 Jul 2025 17:55:32 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
	by localhost (zimbra.couthit.local [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id rXhTqoIdqvVc; Fri, 11 Jul 2025 17:55:32 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id 653241781A71;
	Fri, 11 Jul 2025 17:55:32 +0530 (IST)
Date: Fri, 11 Jul 2025 17:55:32 +0530 (IST)
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
Message-ID: <1614106230.1712453.1752236732227.JavaMail.zimbra@couthit.local>
In-Reply-To: <20250708174449.3e8744c5@kernel.org>
References: <20250702140633.1612269-1-parvathi@couthit.com> <20250702140633.1612269-3-parvathi@couthit.com> <20250708174449.3e8744c5@kernel.org>
Subject: Re: [PATCH net-next v10 02/11] net: ti: prueth: Adds ICSSM Ethernet
 driver
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - GC138 (Linux)/8.8.15_GA_3968)
Thread-Topic: prueth: Adds ICSSM Ethernet driver
Thread-Index: s1QDkc+Y2MblZ4jGceIpvmHgdXfxgQ==
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

> On Wed,  2 Jul 2025 19:36:24 +0530 Parvathi Pudi wrote:
>> +=09=09if (ret < 0) {
>> +=09=09=09dev_err(dev, "%pOF error reading port_id %d\n",
>> +=09=09=09=09eth_node, ret);
>> +=09=09}
>=20
> unnecessary parenthesis, but also did you mean to error out here?
>=20

Yes, we will address this in the next version.

>> +=09=09=09dev_err(dev, "port reg should be 0 or 1\n");
>> +=09=09=09of_node_put(eth_node);
>=20
> this error will also trigger if same port is specified multiple times
>=20

We will check and add appropriate code changes in the next version.

> +=09=09=09ret =3D PTR_ERR(prueth->pru1);
> +=09=09=09if (ret !=3D -EPROBE_DEFER)
> +=09=09=09=09dev_err(dev, "unable to get PRU1: %d\n", ret);
> +=09=09=09goto put_pru;
>=20
> dev_err_probe() ?
>=20

Sure, we will replace =E2=80=9Cdev_err()=E2=80=9D with =E2=80=9Cdev_err_pro=
be()=E2=80=9D to make it
simple.

>> +/**
>> + * struct prueth_private_data - PRU Ethernet private data
>> + * @fw_pru: firmware names to be used for PRUSS ethernet usecases
>> + * @support_lre: boolean to indicate if lre is enabled
>> + * @support_switch: boolean to indicate if switch is enabled
>=20
> Please improve or remove this, adding kdoc which doesn't explain
> anything is discouraged per kernel coding style.
>=20
> This one is actually more confusing than helpful the fields are
> called "support" but kdoc says "enabled". Maybe name the fields
> 'enabled' ?
>=20

Sure, we will address this in the next version.

>> + */
>> +struct prueth_private_data {
>> +=09const struct prueth_firmware fw_pru[PRUSS_NUM_PRUS];
>> +=09bool support_lre;
>> +=09bool support_switch;
>> +};
>> +
>> +/* data for each emac port */
>> +struct prueth_emac {
>> +=09struct prueth *prueth;
>> +=09struct net_device *ndev;
>> +
>> +=09struct rproc *pru;
>> +=09struct phy_device *phydev;
>> +
>> +=09int link;
>> +=09int speed;
>> +=09int duplex;
>> +
>> +=09enum prueth_port port_id;
>> +=09const char *phy_id;
>> +=09u8 mac_addr[6];
>> +=09phy_interface_t phy_if;
>> +=09spinlock_t lock;=09/* serialize access */
>=20
> 'serialize access' to what? Which fields does it protect?

We will update with more detailed explanation.


Thanks and Regards,
Parvathi.

