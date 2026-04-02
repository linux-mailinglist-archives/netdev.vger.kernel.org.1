Return-Path: <netdev+bounces-274321-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BYrBaHRzWnVhwYAu9opvQ
	(envelope-from <netdev+bounces-274321-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:17:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 81C6E382909
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 04:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4AD0130499A0
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 02:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5CF311C1D;
	Thu,  2 Apr 2026 02:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="Qf9VgoQM"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A1640DFC1;
	Thu,  2 Apr 2026 02:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775096217; cv=none; b=Ki7YGDhZ+TXvXAILO1IK8vEOIAAntDuYLmBi26CocZpmj6OUcOtBfsrTGpj/P6CCZJlzCFohCdIRW6OlkY7tbjv8x11X4l6NIXNBMhbUZQcjDflBPvBP/+bt0YgO31LtezrzsvF7Yu25IezU4etO44aF7mTCNGB5wWnXu5/P37s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775096217; c=relaxed/simple;
	bh=tyANVjxPFVukk47Zl2mvbDzbLyFHvRYqd7MZpQoUpVs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oIDmcO5bXnhsIjUY4gT/n9FYe9Dfqa8IaYqXhmfeCJdV/7vzK7fCU9DWo2Iv++R0G4ei7o3gzUUGCRKoIS+25iqUnZBG0s/aqFiYu5qLSZt+cP6QwO+/fAvXr22zuGY0BUO+RPnCPig5/CJKU76iqMqCKbOP3nXcl+mdzvaf9j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=Qf9VgoQM; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1775096213;
	bh=PAzynjd2G6tB5jMYeTv2Cc7H8uzM03y9pywIRIkjmnA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Qf9VgoQMGTFog4CgtshzPC9u95qlclVkdIpJCBIHEIkthpl8Xwo0BOuo6euhmRIgp
	 DyIhxgb/q7iG3ZLASMUV1OfK+7/0pUEZb+7P7LENXE12LNokUQs1kKj9SAF7Dz8LQw
	 JbrPOYa1tjemZh01QpZLu/p+phuDxmfkiFMRVgdoNviQn+fzUUJ50oiEKBoFjzoXl0
	 km2DvGdroPhp9EmdtUdJH4uRDnYoUZ/kYdGS5To7O4a8WIXqQycCYQdN7MOP9+jTQM
	 piMJPPjd+xq4tJi00iIosgJnrW5RmiHF1ZbkHR4EZ9OgZe0aigJ6D6vZLrv70xCqIj
	 q9z+SJ8t+707w==
Received: from [192.168.72.167] (210-10-213-150.per.static-ipl.aapt.com.au [210.10.213.150])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id A19266506C;
	Thu,  2 Apr 2026 10:16:51 +0800 (AWST)
Message-ID: <4349e9f1668e443f49f193e1ab69cef669941c61.camel@codeconstruct.com.au>
Subject: Re: [net-next v36] mctp pcc: Implement MCTP over PCC Transport
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Adam Young <admiyo@os.amperecomputing.com>, Matt Johnston
 <matt@codeconstruct.com.au>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Sudeep Holla
	 <sudeep.holla@arm.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
	Huisong Li <lihuisong@huawei.com>
Date: Thu, 02 Apr 2026 10:16:51 +0800
In-Reply-To: <20260330175455.1189845-1-admiyo@os.amperecomputing.com>
References: <20260330175455.1189845-1-admiyo@os.amperecomputing.com>
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274321-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amperecomputing.com:email,dmtf.org:url,codeconstruct.com.au:dkim,codeconstruct.com.au:mid]
X-Rspamd-Queue-Id: 81C6E382909
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Adam,

> Implementation of network driver for
> Management Component Transport Protocol(MCTP)
> over Platform Communication Channel(PCC)
>=20
> DMTF DSP:0292
> Link: https://www.dmtf.org/sites/default/files/standards/documents/DSP029=
2_1.0.0WIP50.pdf
>=20
> The transport mechanism is called Platform Communication Channels (PCC)
> is part of the ACPI spec:
>=20
> Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/14_Platform_Communica=
tions_Channel/Platform_Comm_Channel.html
>=20
> The PCC mechanism is managed via a mailbox implemented at
> drivers/mailbox/pcc.c
>=20
> MCTP devices are specified via ACPI by entries in DSDT/SSDT and
> reference channels specified in the PCCT. Messages are sent on a type
> 3 and received on a type 4 channel.=C2=A0 Communication with other device=
s
> use the PCC based doorbell mechanism; a shared memory segment with a
> corresponding interrupt and a memory register used to trigger remote
> interrupts.
>=20
> The shared buffer must be at least 68 bytes long as that is the minimum
> MTU as defined by the MCTP specification.
>=20
> Unlike the existing PCC Type 2 based drivers, the mssg parameter to
> mbox_send_msg is actively used. The data section of the struct sk_buff
> that contains the outgoing packet is sent to the mailbox, already
> properly formatted as a PCC exctended message.
>=20
> If the mailbox ring buffer is full, the driver stops the incoming
> packet queues until a message has been sent, freeing space in the
> ring buffer.
>=20
> When the Type 3 channel outbox receives a txdone response interrupt,
> it consumes the outgoing sk_buff, allowing it to be freed.
>=20
> Bringing up an interface creates the channel between the network driver
> and the mailbox driver. This enables communication with the remote
> endpoint, to include the receipt of new messages. Bringing down an
> interface removes the channel, and no new messages can be delivered.
> Stopping the interface will leave any packets that are cached in the
> mailbox ringbuffer. They cannot safely be freed until the PCC mailbox
> attempts to deliver them and has removed them from the ring buffer.
>=20
> PCC is based on a shared buffer and a set of I/O mapped memory locations
> that the Spec calls registers.=C2=A0 This mechanism exists regardless of =
the
> existence of the driver. If the user has the ability to map these
> physical location to virtual locations, they have the ability to drive th=
e
> hardware.=C2=A0 Thus, there is a security aspect to this mechanism that e=
xtends
> beyond the responsibilities of the operating system.
>=20
> If the hardware does not expose the PCC in the ACPI table, this device
> will never be enabled. Thus it is only an issue on hardware that does
> support PCC. In that case, it is up to the remote controller to sanitize
> communication; MCTP will be exposed as a socket interface, and userland
> can send any crafted packet it wants. It would also be incumbent on
> the hardware manufacturer to allow the end user to disable MCTP over PCC
> communication if they did not want to expose it.
>=20
> Signed-off-by: Adam Young <admiyo@os.amperecomputing.com>

No changelogs anymore? This makes things more difficult to review. Just
to be clear, when I mentioned changing to a single-patch series, that
did not mean to throw out the changelog - it's still a key part of
review.

So, for v36, it looks like you have

 * added the CONFIG_PCC dependency
 * altered the RX min length check to include at least the command and
   a MCTP header
 * added a RX max-length check
 * added a minimum MTU check
 * altered the commit message to reflect PCC mailbox free behaviour.

On the latter, could you expand on what happens on close? Does the PCC
channel end up calling tx_done() on each pending TX during the channel
free? I'm not familiar with the PCC paths, but it doesn't look like it
(or the mailbox core) has a case to deal with this on free.

Maybe I am missing something, but could this leak skbs?

[...]

> +static int initialize_MTU(struct net_device *ndev)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_ndev *mctp_pcc=
_ndev;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct mctp_pcc_mailbox *outbo=
x;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0struct pcc_mbox_chan *pchan;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0int mctp_pcc_mtu;
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_mtu =3D MCTP_MIN_MTU;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0mctp_pcc_ndev =3D netdev_priv(=
ndev);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0outbox =3D &mctp_pcc_ndev->out=
box;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0pchan =3D pcc_mbox_request_cha=
nnel(&outbox->client, outbox->index);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (IS_ERR(pchan))
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -1;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (pchan->shmem_size < MCTP_M=
IN_MTU)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -1;

Looks like this would leak the channel? You may want to shift this check
to after the free_channel().

(but also, should this check also include the size of the pcc header?)

Cheers,


Jeremy

