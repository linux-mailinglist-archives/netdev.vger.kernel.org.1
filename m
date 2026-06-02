Return-Path: <netdev+bounces-294006-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKQsBkZfHmo/iwkAu9opvQ
	(envelope-from <netdev+bounces-294006-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:42:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C869628279
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:42:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 610A530074BD
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7475D2DA759;
	Tue,  2 Jun 2026 04:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GbLiTLtN"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AF81A681B;
	Tue,  2 Jun 2026 04:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780375363; cv=none; b=D0rKUaOo2c7Iq/S0JaBmh4eH8+yWQs+rBU3jG6Emx+Uz7Hs+Nnhj3VHDBGGfFtYSOftKLoNNxX9fgGmyHlqD41yMLa2lLDUL2SWygUcjJ3pIZ1MIfLNFK0BvhGTRQZYsjQ3yemYCopnAORP4dbQD7BQTd+PmlvEtlARezT+FDa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780375363; c=relaxed/simple;
	bh=EoDGM05HXWjuTq3h2T/ekMFwXsbC68N2TZ/7J2Uojj4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fjwBs/JkbI5hztPyIP+GvgeZR+CEBHUYKRbvrt0PrIW1zdRep/GjvMJDfQBPnRUal9TQCk53Yl7Cw7wJOzgbSSXbjSKlgk5Y/kg1oKPsdPt5aai5vjk3c+uTT0h1FTE7ZOUXK8yNqPU6KG22vQ5Fl/rxzCi/BBruQYIwVOBAb04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GbLiTLtN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780375353;
	bh=EoDGM05HXWjuTq3h2T/ekMFwXsbC68N2TZ/7J2Uojj4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GbLiTLtNS+D3650iDlcyxvyCkEbcuABSIpionpaj5tRMv0vkpSbI1HzNeXi2wVMKG
	 qBMDGfs3EX8phWilgcIaO4yGR9FlH8B6ftqLCwftCk8LAQ2/b6tyXXXp1A82tQdgZO
	 IM+Cfy6e1wCmIj6DSUFC2k4Pp1MjNw9TtCAJuIj+2uFtylcG/G3yRvcsX+K5L5w0/6
	 v2gA7jyMARgDLPvfuTr3k7M80nFHyIS8wjABcpfKJI+xMrAdXWFJ3/glbHDShfbmR3
	 NTO/r3ts4DgPxCkmVW5j5v721wMyFHBoKGviN0sLsrkmEPbCTgRomVRmdlrQpMyudy
	 pQ76EaszVP0IA==
Received: from [192.168.72.161] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 7FA526024D;
	Tue,  2 Jun 2026 12:42:31 +0800 (AWST)
Message-ID: <068cd5ffb49aac3bfd2184df7289093cbcd524ee.camel@codeconstruct.com.au>
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Paolo Abeni
	 <pabeni@redhat.com>, admiyo@os.amperecomputing.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 Jonathan.Cameron@huawei.com,  lihuisong@huawei.com
Date: Tue, 02 Jun 2026 12:42:30 +0800
In-Reply-To: <4fabc99f-52c1-422e-9513-69e2190bc91a@amperemail.onmicrosoft.com>
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
	 <20260528084611.133703-1-pabeni@redhat.com>
	 <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
	 <8c2a9e591ba22a95962c2c5f7dff5971fc5123df.camel@codeconstruct.com.au>
	 <4fabc99f-52c1-422e-9513-69e2190bc91a@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-294006-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 9C869628279
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adam,

> > The LE condition makes sense, as the driver does not support BE. But
> > what is requiring 64-bit?
> The code itself will not, as written, work on a 32 Bit system, as there=
=20
> are 64 bit specific code.

Yeah, that was more my question - what is 64-bit specific about the
code?

> > The comment is:
> >=20
> > =C2=A0=C2=A0 Implementation of MCTP over PCC DMTF Specification DSP0256
> >=20
> > But DSP0256 is not the "MCTP over PCC" transport binding spec. Either
> > mention the host interface specifically, or use the correct number for
> > the PCC spec. I think the latter would be best, as the host interface
> > spec seems less relevant here.
>=20
> Yeah, just going to drop that line as it is redundant with other info in=
=20
> the header.

OK.

> > > > > +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, =
void *mssg)
> > > > > +{
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct acpi_pcct_ext_p=
cc_shared_memory pcc_header;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_ndev *=
mctp_pcc_ndev;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_mailbo=
x *inbox;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_skb_cb *cb=
;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct sk_buff *skb;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int size;
> > > > > +
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_ndev =3D cont=
ainer_of(cl, struct mctp_pcc_ndev, inbox.client);
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0inbox =3D &mctp_pcc_nd=
ev->inbox;
> > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memcpy_fromio(&pcc_hea=
der, inbox->chan->shmem, sizeof(pcc_header));
> > > > [High]
> > > > Can this dereference a NULL shmem during teardown?
> > > >=20
> > > > Looking at pcc_mbox_free_channel() in drivers/mailbox/pcc.c, the
> > > > channel's shmem is iounmapped (and the pointer cleared) before the
> > > > shutdown path runs free_irq(). Until free_irq() returns, an inbound
> > > > doorbell on another CPU can still fire pcc_mbox_irq, which calls
> > > > mbox_chan_received_data(), which calls chan->cl->rx_callback (cl is
> > > > still set at that moment) =E2=80=94 landing here.
> > > >=20
> > > > Existing PCC clients such as drivers/acpi/acpi_pcc.c::pcc_rx_callba=
ck
> > > > do not touch shmem from their callback, so this driver appears to b=
e
> > > > the first one to expose this ordering.
> > > >=20
> > > > Should the rx_callback bail out when inbox->chan->shmem is NULL, or
> > > > should the ordering in pcc_mbox_free_channel() (free_irq before
> > > > iounmap) be addressed in the mailbox layer first?
> > > That needs to be fixed in the PCC layer, and is submitted in a differ=
ent
> > > patch.=C2=A0 When that patch is accepted, this issue will be fixed.=
=C2=A0 I do not
> > > want to hold up this driver for that issue.
> > Understood that there's a fix in development for this, but we can't
> > introduce a potential null pointer dereference in the interim.
> >=20
> > If you want this merged before the fix, how about a guard for a valid
> > shmem pointer?
>=20
> The mutux used to control access to the create-teardown path is static=
=20
> to drivers/mailbox/mailbox.c

You can't acquire that mutex here anyway, you're in atomic context.

> I could run mincore

No, that wouldn't work (and would be moderately horrific)

Since you did not answer the guard question, are you implying that the
shmem pointer may be unstable *during* the rx_complete call? (ie.,
rather than being invalidated before the call, and so a simple `if
(chan->shmem)` guard would not suffice?)

The Sashiko review seems to be incorrect in that you are not the first
user of the shmem data; there are other uses of chan->shmem that do not
seem to have any intrinsic exclusion between the rx callback and the
free_channel() paths, nor check the validity of shmem in their rx
callback.

However, the closest existing use - the xgene i2c driver - seems like it
can not free the pcc mailbox while a rx irq might occur, with the i2c
locking in place. You could do something similar here, possibly via a
spinlock acquired in both the ndo_stop handler, and the rx callback.

But if your proposed change to the iounmap() ordering works, that would
be a neater solution here.

> The patch that this gates on is:
>=20
> https://lore.kernel.org/lkml/20260522205220.237355-1-admiyo@os.amperecomp=
uting.com/
>=20
> Please comment on that one to move it along.

As you can probably tell, the pcc mailbox interface is definitely not my
area of expertise.

Cheers,


Jeremy

