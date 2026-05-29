Return-Path: <netdev+bounces-292929-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I3GFQ3wGGo/pAgAu9opvQ
	(envelope-from <netdev+bounces-292929-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:46:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A19CB5FC185
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA161301AF40
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177E735DA49;
	Fri, 29 May 2026 01:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="hTAuadhE"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6456310620;
	Fri, 29 May 2026 01:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780019068; cv=none; b=aWOHVNJ2j1AFX4DgjyMkIh76f+QLiBlv2cHUOMF4MAzE0GcqpcRTbDcRexUsuzv3/89rSPGkN05qbuuM2/D3R62kZYkP5yteNjsoD7HwcUtANqjcU/mTADs28gHL9yXXWKa32wp71tYcTANDu27obRHRse6G16sIFRNDBYx1Zno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780019068; c=relaxed/simple;
	bh=mrHccfsQJdLAxkEx5+Qan6OCSIAIJSXu+uPlh0rzW54=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Mi8ptZh5PvP/cFscCCs9BQAoKNeBDxS+FWxrngPQF09EmHYuATR5mV6pSP+RHKKrSVZCArmoH822rEjcmJWhudJxsJH7Y0otfpUqSklei3oIfEK5YcefZXnRa2iPNtidQlQMxQqntRqQ4aJLWH1Cpz3+MhN8JddXCcwmW22mvPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=hTAuadhE; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1780019063;
	bh=CQK86/u3LLUm7cvQu2/HmsKR9vMG1pdZJ/k5001vO6k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hTAuadhE/ui7nE1ZoRvoKWbeSr5vCyE7X2LoGPJxMOVNdZ72tIdEo9h7OKSk2P5nr
	 nk97umZNwCAaRy/RZC+5PLiQofjvV6eVtUoyFe10EHmSiyWgb6HEKKQhQCLcqZ/54N
	 bQjokPhuA3bxzakAs/GI2HuvKEIgsJVrPJutgB3eanYVJdH8Aci7hRalE5bxaF1MBD
	 1ma7mXSxjt01dU7wORRHKdYK9vIIGABw2eE/QO4flkErv+4vk83xh68Seu/N6xkClh
	 0O/fyXvQZ7GulyyWK9/VxRm3W4zXgLkwaroJnpiKHv6ubgOCUpC5K57J6jDjR9Lalp
	 YswqMIIEEVk3g==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 22A8764798;
	Fri, 29 May 2026 09:44:22 +0800 (AWST)
Message-ID: <8c2a9e591ba22a95962c2c5f7dff5971fc5123df.camel@codeconstruct.com.au>
Subject: Re: [net-next v44] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@amperemail.onmicrosoft.com>, Paolo Abeni
	 <pabeni@redhat.com>, admiyo@os.amperecomputing.com
Cc: matt@codeconstruct.com.au, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
 Jonathan.Cameron@huawei.com, 	lihuisong@huawei.com
Date: Fri, 29 May 2026 09:44:21 +0800
In-Reply-To: <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
References: <20260522193610.234166-1-admiyo@os.amperecomputing.com>
	 <20260528084611.133703-1-pabeni@redhat.com>
	 <63aebaed-2456-457d-be70-5211d2f746df@amperemail.onmicrosoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292929-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[codeconstruct.com.au:mid,codeconstruct.com.au:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A19CB5FC185
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adam,

> > [Low]
> > The Link tag and the body of the commit message both reference
> > DSP0292_1.0.0WIP50. Is it intentional to merge an in-tree binding
> > based on a Work-In-Progress draft of the spec rather than the
> > published 1.0.0?

This is probably worth an update to reference the non-WIP spec version.

> The ACPICA code used to access the PCC region and registers is imported=
=20
> an external project, and it hard codes the values to machine, not=20
> explicitly little endian.=C2=A0 So making this little-endian only ensures=
=20
> that the ordering is correct.=C2=A0 The only machines that are going to=
=20
> support MCTP over PCC are little endian and 64 bit, so this is strictly=
=20
> speaking correct.

The configuration is less about "which machines you think might use
this", but more "what does the implementation require".

The LE condition makes sense, as the driver does not support BE. But
what is requiring 64-bit?

> > The header comment says DSP0256 but the URL and the commit message
> > both say DSP0292. DSP0256 is a different DMTF document (PLDM for
> > Monitoring and Control). Should the comment read DSP0292?
> >=20
> > [ ... ]
>=20
> The DMTF DSP0256 is the MCTP Host Interface Specification. It=20
> standardizes how Management Component Transport Protocol (MCTP) packets=
=20
> and messages are communicated between a system's host software and its=
=20
> internal management controllers (like a BMC or satellite controller).
> DSP0292 IS specific to the binding. Neither are PLDM. THis comment is
> correct

The comment is:

  Implementation of MCTP over PCC DMTF Specification DSP0256

But DSP0256 is not the "MCTP over PCC" transport binding spec. Either
mention the host interface specifically, or use the correct number for
the PCC spec. I think the latter would be best, as the host interface
spec seems less relevant here.

> > > +static void mctp_pcc_client_rx_callback(struct mbox_client *cl, void=
 *mssg)
> > > +{
> > > +	struct acpi_pcct_ext_pcc_shared_memory pcc_header;
> > > +	struct mctp_pcc_ndev *mctp_pcc_ndev;
> > > +	struct mctp_pcc_mailbox *inbox;
> > > +	struct mctp_skb_cb *cb;
> > > +	struct sk_buff *skb;
> > > +	int size;
> > > +
> > > +	mctp_pcc_ndev =3D container_of(cl, struct mctp_pcc_ndev, inbox.clie=
nt);
> > > +	inbox =3D &mctp_pcc_ndev->inbox;
> > > +	memcpy_fromio(&pcc_header, inbox->chan->shmem, sizeof(pcc_header));
> > [High]
> > Can this dereference a NULL shmem during teardown?
> >=20
> > Looking at pcc_mbox_free_channel() in drivers/mailbox/pcc.c, the
> > channel's shmem is iounmapped (and the pointer cleared) before the
> > shutdown path runs free_irq(). Until free_irq() returns, an inbound
> > doorbell on another CPU can still fire pcc_mbox_irq, which calls
> > mbox_chan_received_data(), which calls chan->cl->rx_callback (cl is
> > still set at that moment) =E2=80=94 landing here.
> >=20
> > Existing PCC clients such as drivers/acpi/acpi_pcc.c::pcc_rx_callback
> > do not touch shmem from their callback, so this driver appears to be
> > the first one to expose this ordering.
> >=20
> > Should the rx_callback bail out when inbox->chan->shmem is NULL, or
> > should the ordering in pcc_mbox_free_channel() (free_irq before
> > iounmap) be addressed in the mailbox layer first?
>=20
> That needs to be fixed in the PCC layer, and is submitted in a different=
=20
> patch.=C2=A0 When that patch is accepted, this issue will be fixed.=C2=A0=
 I do not=20
> want to hold up this driver for that issue.

Understood that there's a fix in development for this, but we can't
introduce a potential null pointer dereference in the interim.

If you want this merged before the fix, how about a guard for a valid
shmem pointer?

> Yeah, the Big Endian reference is spurious.=C2=A0 If there is another=20
> iteration I will pull it.

Sounds good.

Cheers,


Jeremy

