Return-Path: <netdev+bounces-165073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3265A304E1
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 08:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A93D188348B
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 07:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DAF61EE001;
	Tue, 11 Feb 2025 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pe1p6Eyg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uAMlPqdh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237B61E9B39
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 07:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739260298; cv=none; b=Soa43D50qOmPuGwyLsiAiT0wgAYoaVU4BWW/LjhW84/++tFMP8cekpQTgIVQuh/apYtDGJmeH203i2n5j/d+Euy+ALqt9WDaGr7pIyOZkAFgCJecqHy3Sppsskc0/PBlBvSlqxCB0vSLBvtzTSuPnWOJk7Mw6Icpac6UkRsJXyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739260298; c=relaxed/simple;
	bh=2bGP1hrB6J4qsfWiB8olYxuYq5YnfeGST0Yzz1M+z0s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NLbtFkHPA7jseMN3tXv8todbj/FyMGmZJzsnDt2SUBbc0uJpiGj+7ppweCWh/PcFA1f2BJZpQLb6twsVyP96pKnxu04E3HZpi7jTMPdtSPdPp6CbIDZT5Unbp49AKCXwlohLxPjNRedpY1ilgaeCwp+BHp2JaFzcuXtJqlLOqyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pe1p6Eyg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uAMlPqdh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739260293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLXdsOYBWhzYvVhUcbeV+5CfIBPzYpGWPp2aeBnUup4=;
	b=Pe1p6EygHlZgdhaPkH2BCX7qWx4UrEo45NiuSftppswCxpM2t9QHfcgFB2pYg+/pqdHdxL
	31MzEZNwfKyGDV2yN6ljrd5WpwWOq0BX0a+l6DlQJufK+duhVTD3Y9Qje9LtYRCtE6k3O3
	HcS6RXR+O9j/0U6slEwF0mvPTg0OYhp7f21SEX/3AWiIaxdjymFU/y6tY6S9ozfAeKJc4r
	KTKH2tG2erqziIIx//1hrcg6evvC1iAKZ1toS0WgmSsIjX17lZx58bliDxzH2xX6EmIgZH
	mqemjN+iPKSnjRgSEf8bo+4XQqNz5O63fE4ESglAQCAPMkdQ1ylpO3Dnj+xf6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739260293;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HLXdsOYBWhzYvVhUcbeV+5CfIBPzYpGWPp2aeBnUup4=;
	b=uAMlPqdhGqg7jnv9XQEclHQofrBqRw4ood23Pop5RSU/lPap4sG+umXU6oLalE5SKYDuNL
	j20VXXQ36KP2LxAw==
To: Joe Damato <jdamato@fastly.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] igb: Link queues to NAPI instances
In-Reply-To: <Z6pJrRRqcHYhZWss@LQ3V64L9R2>
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
 <20250210-igb_irq-v1-2-bde078cdb9df@linutronix.de>
 <Z6pJrRRqcHYhZWss@LQ3V64L9R2>
Date: Tue, 11 Feb 2025 08:51:31 +0100
Message-ID: <871pw4q5q4.fsf@kurt.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon Feb 10 2025, Joe Damato wrote:
> On Mon, Feb 10, 2025 at 10:19:36AM +0100, Kurt Kanzenbach wrote:
>> Link queues to NAPI instances via netdev-genl API. This is required to u=
se
>> XDP/ZC busy polling. See commit 5ef44b3cb43b ("xsk: Bring back busy poll=
ing
>> support") for details.
>>=20
>> This also allows users to query the info with netlink:
>>=20
>> |$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netde=
v.yaml \
>> |                               --dump queue-get --json=3D'{"ifindex": 2=
}'
>> |[{'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'rx'},
>> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'rx'},
>> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'rx'},
>> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'rx'},
>> | {'id': 0, 'ifindex': 2, 'napi-id': 8201, 'type': 'tx'},
>> | {'id': 1, 'ifindex': 2, 'napi-id': 8202, 'type': 'tx'},
>> | {'id': 2, 'ifindex': 2, 'napi-id': 8203, 'type': 'tx'},
>> | {'id': 3, 'ifindex': 2, 'napi-id': 8204, 'type': 'tx'}]
>>=20
>> While at __igb_open() use RCT coding style.
>>=20
>> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
>> ---
>>  drivers/net/ethernet/intel/igb/igb.h      |  2 ++
>>  drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++++++++++++++=
++-----
>>  drivers/net/ethernet/intel/igb/igb_xsk.c  |  2 ++
>>  3 files changed, 34 insertions(+), 5 deletions(-)
>>=20
>> diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet=
/intel/igb/igb.h
>> index 02f340280d20a6f7e32bbd3dfcbb9c1c7b4c6662..79eca385a751bfdafdf38492=
8b6cc1b350b22560 100644
>> --- a/drivers/net/ethernet/intel/igb/igb.h
>> +++ b/drivers/net/ethernet/intel/igb/igb.h
>> @@ -722,6 +722,8 @@ enum igb_boards {
>>=20=20
>>  extern char igb_driver_name[];
>>=20=20
>> +void igb_set_queue_napi(struct igb_adapter *adapter, int q_idx,
>> +			struct napi_struct *napi);
>>  int igb_xmit_xdp_ring(struct igb_adapter *adapter,
>>  		      struct igb_ring *ring,
>>  		      struct xdp_frame *xdpf);
>> diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/eth=
ernet/intel/igb/igb_main.c
>> index d4128d19cc08f62f95682069bb5ed9b8bbbf10cb..8e964484f4c9854e4e3e0b4f=
3e8785fe93bd1207 100644
>> --- a/drivers/net/ethernet/intel/igb/igb_main.c
>> +++ b/drivers/net/ethernet/intel/igb/igb_main.c
>> @@ -2099,6 +2099,22 @@ static void igb_check_swap_media(struct igb_adapt=
er *adapter)
>>  	wr32(E1000_CTRL_EXT, ctrl_ext);
>>  }
>>=20=20
>> +void igb_set_queue_napi(struct igb_adapter *adapter, int vector,
>> +			struct napi_struct *napi)
>> +{
>> +	struct igb_q_vector *q_vector =3D adapter->q_vector[vector];
>> +
>> +	if (q_vector->rx.ring)
>> +		netif_queue_set_napi(adapter->netdev,
>> +				     q_vector->rx.ring->queue_index,
>> +				     NETDEV_QUEUE_TYPE_RX, napi);
>> +
>> +	if (q_vector->tx.ring)
>> +		netif_queue_set_napi(adapter->netdev,
>> +				     q_vector->tx.ring->queue_index,
>> +				     NETDEV_QUEUE_TYPE_TX, napi);
>> +}
>> +
>>  /**
>>   *  igb_up - Open the interface and prepare it to handle traffic
>>   *  @adapter: board private structure
>> @@ -2106,6 +2122,7 @@ static void igb_check_swap_media(struct igb_adapte=
r *adapter)
>>  int igb_up(struct igb_adapter *adapter)
>>  {
>>  	struct e1000_hw *hw =3D &adapter->hw;
>> +	struct napi_struct *napi;
>>  	int i;
>>=20=20
>>  	/* hardware has been reset, we need to reload some things */
>> @@ -2113,8 +2130,11 @@ int igb_up(struct igb_adapter *adapter)
>>=20=20
>>  	clear_bit(__IGB_DOWN, &adapter->state);
>>=20=20
>> -	for (i =3D 0; i < adapter->num_q_vectors; i++)
>> -		napi_enable(&(adapter->q_vector[i]->napi));
>> +	for (i =3D 0; i < adapter->num_q_vectors; i++) {
>> +		napi =3D &adapter->q_vector[i]->napi;
>> +		napi_enable(napi);
>> +		igb_set_queue_napi(adapter, i, napi);
>> +	}
>
> It looks like igb_ub is called from igb_io_resume (struct
> pci_error_handlers). I don't know if RTNL is held in that path. If
> its not, this could trip the ASSERT_RTNL in netif_queue_set_napi.
>
> Can you check and see if this is an issue for that path?

AFAICS the PCI error handlers are called in drivers/pci/pcie/err.c
without RTNL lock held. These function take only the device_lock().

I'll add the missing rtnl_lock()/unlock() calls to igb_io_resume() and
igb_io_error_detected(). Thanks.

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJHBAEBCgAxFiEEvLm/ssjDfdPf21mSwZPR8qpGc4IFAmerAYQTHGt1cnRAbGlu
dXRyb25peC5kZQAKCRDBk9HyqkZzgoMeEACiGABB2qc3+IdFTlYYyXNh/nuujdG8
o9fIlHBPwgxt1xwBwdWWjxlVaraR7mGbrbdD4UxYqBsAv3+txzaP5QLOXcOUiHh/
uq7ezUsVMWmo6YRoW2PMhcq5c6oxqc6Nu+pM+84ElbSZlJQ5ECnjb2URqy5/rOOM
b5724jqnFBhJBpuNfeeBrobg3/ebYl/1JC7IvPfPlPnDCAUWaGqSm8Pi6T7ASOPh
xHDaX719bQiDKe6EGzmvamLka7dSqe34gUXq7c5W38nmluR4GhSCjyxC8GLAMz8c
+SGT5Ewc30Sr8IB0HtdHpXYdu8Gm+Pb/A+0R9DQ9PeoUWQZ6WJwvOg8DHX7fDQMh
aOTo4G/xLgiNnYznftCY0QRc5seV1tVDcPP4cUydEoaE7xKcViPbQF6t1lFiV7OC
KU10tlyxiHSfVFD+3bUxkz8qvMCa+RR3wAEdqtgDndat/2Rp6/YVDPCYxSOvFqdF
6q66axQ73JqEoGCbY2F5pPc0Alz8temx0+rb/VLGRkhnVfIRCozDkS8Sc5e+/CVu
XxwS2xE0c4b6an8IO+vBpmR6dslqkVf5w7z1G69bhzSe+cN5cg8iBud85a0MEUPu
O81nPI9B+g+VX2mRl2HwL6NsVqDRLdMeBJuNiCeg20f6JeK/Nz54vNHHphbRmvIA
acuz3oYTy2Sn2A==
=05zk
-----END PGP SIGNATURE-----
--=-=-=--

