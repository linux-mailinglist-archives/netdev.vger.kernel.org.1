Return-Path: <netdev+bounces-273099-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNeDA7o1ymnn6QUAu9opvQ
	(envelope-from <netdev+bounces-273099-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:35:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E5C3573CA
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 10:35:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DD589305748A
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 08:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891873AC0D4;
	Mon, 30 Mar 2026 08:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Faml5W2T"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F94382F10
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 08:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774859303; cv=none; b=VbS5ayG1S8tvXixupEh/eJfuWBrQi2kdqUkZdP+4wiDdn12Mx2AGEFkndQ5ghhCYmebuo7U+mNJD5UtBtFhnN0KL/YwMVwfjmY5Lm3+fmA0ZFAzrF2dad6RndtGpURfqFDbtr/kfreTkU31oIzUBhKgklHAt1t9ANF32LZ3Vwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774859303; c=relaxed/simple;
	bh=bFsWfcJw1jBkpNNHPP2oTiXGqbmq3tIhTEBAYwGTUp4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q5WD80aeA/qT92XZ/DYoIfisEWnJQ2zQBk6grcegUwAmhyyzp5D377GALRu4ZF5I6petM1acggJwJwjyzNOvtPTnTyFFVLIKoZV9wCNb8p3lOpRQGIDNSnB43mptyVUSYBZV8/W9t4bM8Iv0HIzg8ic+ZM6Nztp3+Ypd/piZfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Faml5W2T; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4408610B9D7;
	Mon, 30 Mar 2026 10:28:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1774859299;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ftC+ehjxMSogwNmU6UVKxCk/uQgmyhgeYcFEUdWFBnA=;
	b=Faml5W2TmKaUScQ8a7ThjEJXqh4H/g6ooPbIBZrRGaJUBan46PKJY/SLBVKGrtc4puGc5Y
	k5K/MyBqpMlL5rgYKSv4AfJTsBuvpSrMBYLya8/p271eSRCWBnzr3oL5Svi4VA9lqUqbnE
	5BE0OLlyFToJPUvgnVUNI30TjnGX1OCw9Jqb7OofJutg/e0GCqGHGFRg7tDUjs3N0zjOpD
	eVspK76BPQn8ZXgoDwbcizNvIFTIq998xj3FGyP3EKTP+HqTN8o8Dra3mvSH4uXSc85sNS
	mkY4ZqiauGnu6pIL9twY1WT67PHDS0GKjQxx3UzKH+4+D1xRGS8q3c5C2p0Cvw==
Date: Mon, 30 Mar 2026 10:28:12 +0200
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukma@nabladev.com>
To: "Luka Gejak" <luka.gejak@linux.dev>
Cc: "Fernando Fernandez Mancera" <fmancera@suse.de>, "Fernando Fernandez
 Mancera" <ffmancera@riseup.net>, <netdev@vger.kernel.org>,
 <edumazet@google.com>, <pabeni@redhat.com>, <shannon.nelson@amd.com>,
 <horms@kernel.org>, <kuba@kernel.org>
Subject: Re: [PATCH v3 net-next] net: hsr: sync hw addr of slave2 according
 to slave1 hw addr on PRP
Message-ID: <20260330102812.214f27f4@wsk>
In-Reply-To: <DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev>
References: <20250409101911.3120-1-ffmancera@riseup.net>
	<DHFCZEM93FTT.1RWFBIE32K7OT@linux.dev>
	<856eb43a-d4d0-4e1e-895f-75fca4eec51d@suse.de>
	<d3935fd1-b990-405b-8428-219730d68a89@suse.de>
	<DHFG26KI6L23.1YCOVQ5SSYMO5@linux.dev>
Organization: Nabla
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-273099-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	HAS_ORG_HEADER(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukma@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,riseup.net:email,nabladev.com:dkim,nabladev.com:email,nabladev.com:url,denx.de:url]
X-Rspamd-Queue-Id: 60E5C3573CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Luka,

> On Sun Mar 29, 2026 at 7:22 PM CEST, Fernando Fernandez Mancera wrote:
> > On 3/29/26 6:58 PM, Fernando Fernandez Mancera wrote: =20
> >> On 3/29/26 5:07 PM, Luka Gejak wrote: =20
> >>> On Wed Apr 9, 2025 at 12:19 PM CEST, Fernando Fernandez Mancera
> >>> wrote: =20
> >>>> In order to work properly PRP requires slave1 and slave2 to
> >>>> share the same MAC address. To ease the configuration process on
> >>>> userspace tools, sync the slave2 MAC address with slave1. In
> >>>> addition, when deleting the port from the list, restore the
> >>>> original MAC address.
> >>>>
> >>>> Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
> >>>> ---
> >>>> v3: restore the original MAC address on slave removal.
> >>>> ---
> >>>> =C2=A0 net/hsr/hsr_device.c | 5 +++++
> >>>> =C2=A0 net/hsr/hsr_main.c=C2=A0=C2=A0 | 9 +++++++++
> >>>> =C2=A0 net/hsr/hsr_main.h=C2=A0=C2=A0 | 1 +
> >>>> =C2=A0 net/hsr/hsr_slave.c=C2=A0 | 2 ++
> >>>> =C2=A0 4 files changed, 17 insertions(+)
> >>>>
> >>>> diff --git a/net/hsr/hsr_device.c b/net/hsr/hsr_device.c
> >>>> index 439cfb7ad5d1..e8922e8d9398 100644
> >>>> --- a/net/hsr/hsr_device.c
> >>>> +++ b/net/hsr/hsr_device.c
> >>>> @@ -761,6 +761,11 @@ int hsr_dev_finalize(struct net_device
> >>>> *hsr_dev, struct net_device *slave[2],
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (res)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto err_unre=
gister;
> >>>> +=C2=A0=C2=A0=C2=A0 if (protocol_version =3D=3D PRP_V1) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(slave[1]=
, slave[0]->dev_addr);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_netdevice_notifiers=
(NETDEV_CHANGEADDR, slave[1]);
> >>>> +=C2=A0=C2=A0=C2=A0 }
> >>>> +
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (interlink) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D hsr_a=
dd_port(hsr, interlink, HSR_PT_INTERLINK,
> >>>> extack); if (res)
> >>>> diff --git a/net/hsr/hsr_main.c b/net/hsr/hsr_main.c
> >>>> index d7ae32473c41..192893c3f2ec 100644
> >>>> --- a/net/hsr/hsr_main.c
> >>>> +++ b/net/hsr/hsr_main.c
> >>>> @@ -78,6 +78,15 @@ static int hsr_netdev_notify(struct
> >>>> notifier_block *nb, unsigned long event,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 eth_hw_addr_set(master->dev, dev->dev_addr);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 call_netdevice_notifiers(NETDEV_CHANGEADDR,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 master->dev);
> >>>> +
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
if (hsr->prot_version =3D=3D PRP_V1) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 port =3D hsr_port_get_hsr(hsr, HSR_PT_SLAVE_B);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 if (port) {
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(port->dev,=
 dev->dev_addr);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_netdevice_notifiers(N=
ETDEV_CHANGEADDR,
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->dev);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Make sure =
we recognize frames from ourselves in=20
> >>>> hsr_rcv() */
> >>>> diff --git a/net/hsr/hsr_main.h b/net/hsr/hsr_main.h
> >>>> index 1bc47b17a296..135ec5fce019 100644
> >>>> --- a/net/hsr/hsr_main.h
> >>>> +++ b/net/hsr/hsr_main.h
> >>>> @@ -155,6 +155,7 @@ struct hsr_port {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct hsr_priv=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 *hsr;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum hsr_port_type=C2=A0=C2=A0=C2=A0 =
type;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct rcu_head=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 rcu;
> >>>> +=C2=A0=C2=A0=C2=A0 unsigned char=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 original_macaddress[ETH_ALEN];
> >>>> =C2=A0 };
> >>>> =C2=A0 struct hsr_frame_info;
> >>>> diff --git a/net/hsr/hsr_slave.c b/net/hsr/hsr_slave.c
> >>>> index 2a802a5de2ac..b87b6a6fe070 100644
> >>>> --- a/net/hsr/hsr_slave.c
> >>>> +++ b/net/hsr/hsr_slave.c
> >>>> @@ -196,6 +196,7 @@ int hsr_add_port(struct hsr_priv *hsr,
> >>>> struct net_device *dev,
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->hsr =3D hsr;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->dev =3D dev;
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 port->type =3D type;
> >>>> +=C2=A0=C2=A0=C2=A0 ether_addr_copy(port->original_macaddress, dev->=
dev_addr);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (type !=3D HSR_PT_MASTER) {
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 res =3D hsr_p=
ortdev_setup(hsr, dev, port, extack);
> >>>> @@ -232,6 +233,7 @@ void hsr_del_port(struct hsr_port *port)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (!port->hs=
r->fwd_offloaded)
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 dev_set_promiscuity(port->dev, -1);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 netdev_upper_=
dev_unlink(port->dev, master->dev);
> >>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(port->de=
v, port->original_macaddress);
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> >>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 kfree_rcu(port, rcu); =20
> >>>
> >>> Hi Fernando,
> >>>
> >>> Thanks for the patch. The logic to sync the slave2 MAC address
> >>> with slave1 for PRP is sound, but there are a few implementation
> >>> issues here that will cause hardware filtering problems and style
> >>> violations.
> >>>
> >>> 1. Hardware MAC Filtering
> >>> In your current implementation:
> >>>
> >>> =C2=A0=C2=A0 if (protocol_version =3D=3D PRP_V1) {
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 eth_hw_addr_set(slave[1], slave[=
0]->dev_addr);
> >>>
> >>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 call_netdevice_notifiers(NETDEV_=
CHANGEADDR, slave[1]);
> >>>
> >>> =C2=A0=C2=A0 }
> >>>
> >>> eth_hw_addr_set() is appropriate for virtual devices (like the
> >>> hsr_dev itself), but slave[1] is a physical net_device. By using
> >>> this helper, you are bypassing
> >>> dev->netdev_ops->ndo_set_mac_address. This means the physical
> >>> NIC's hardware MAC filter will not be programmed, and it will
> >>> silently drop unicast traffic destined for the new PRP MAC
> >>> address unless the interface happens to be in promiscuous mode.
> >>> You should use dev_set_mac_address() here instead. Note that
> >>> unlike eth_hw_addr_set(), dev_set_mac_address() can fail and
> >>> returns an error code, so you will need to check its return value
> >>> and handle the error path accordingly.
> >>>
> >>> 2. Teardown Notifiers
> >>> In hsr_del_port():
> >>>
> >>> =C2=A0=C2=A0 netdev_upper_dev_unlink(port->dev, master->dev);
> >>> =C2=A0=C2=A0 eth_hw_addr_set(port->dev, port->original_macaddress);
> >>>
> >>> You have the same issue with eth_hw_addr_set() here. Additionally,
> >>> unlike the setup paths, this version omits
> >>> call_netdevice_notifiers (NETDEV_CHANGEADDR, port->dev).
> >>> Switching to dev_set_mac_address() for the restoration will
> >>> handle both the hardware programming and the notifier chain
> >>> automatically.=20
> >>=20
> >> These points makes sense. I guess I didn't notice the that=20
> >> eth_hw_addr_set() due to my interface being set to promiscuous
> >> mode at hsr_slave.c.
> >>=20
> >> Let me research a bit more about the impact here and will get back
> >> to you either with a new patch or an reply here.
> >>  =20
> >
> > Does this actually makes sense? I am not an expert on how hardware
> > is handling offloading here. But if I am not wrong, as the
> > interface is set on promiscuous or offload enabled. For promiscuous
> > this does not matter and for the offloaded scenario shouldn't the
> > decision be handled by hardware and not depend on
> > ndo_set_mac_address()?
> >
> > Let me know if I am missing something here.
> >
> >
> > Anyway, the missing notification makes sense and should be fixed
> > for SLAVE_B.
> >
> > Thanks,
> > Fernando. =20
>=20
> Hi Fernando,
> You raise a fair point, and I should have looked more carefully at
> the existing code paths.
>=20
> You are correct that in the non-offloaded case, hsr_slave.c already=20
> sets promiscuous mode via dev_set_promiscuity(dev, 1), so the
> hardware MAC filter is bypassed and eth_hw_addr_set() is sufficient
> for frame reception.
>=20
> For the offloaded case, the comment in hsr_portdev_setup() notes that=20
> "L2 frame forward happens at the offloaded hardware" =E2=80=94 so the
> hardware is configured through its own HSR/PRP offload mechanisms,
> not through ndo_set_mac_address().
>=20
> So the practical impact of my original concern is limited to edge
> cases where promiscuous mode might be disabled or fail. The more
> important issue, which you've already acknowledged, is the missing
> notifier in hsr_del_port(). That should definitely be fixed for
> correctness.
>=20
> One additional consideration: even though promiscuous mode handles
> the receive path, dev->dev_addr is still used as the source MAC for=20
> outgoing frames. Using dev_set_mac_address() would ensure the
> software state (dev->dev_addr) and any driver-level state remain
> consistent. But I agree this is less critical than I initially
> suggested. Thanks for pushing back on this =E2=80=94 it's a good
> clarification.
>=20

Thanks for your patches - as denx.de is not operational anymore (now I
do work for nabladev.com) I've just stumbled upon your patches.

I'm very happy that PRP now also gains support :-)

> Best regards,
> Luka


--=20
Best regards,

Lukasz Majewski

--
Nabla Software Engineering GmbH
HRB 40522 Augsburg
Phone: +49 821 45592596
E-Mail: office@nabladev.com
Managing Director : Stefano Babic

