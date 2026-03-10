Return-Path: <netdev+bounces-266013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIOhJf75r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:01:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC74D249E1A
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 12:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55EE2313AFB8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198D37E308;
	Tue, 10 Mar 2026 10:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wqml7Ljy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdEpPrdQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C737FF67
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140148; cv=none; b=imwcUXwq01Zdj6WV1EPmUgwoeKXQ0wMafkLENZa/ykz5l0uROMLscbxAPozVGTn270RLfn/oa5AeVWjAbHtoiTAB8MNzUpGu2H0vO+Ehqoslu05L7NkPSGSv8Om2/e3oDVeTW89p2e5B2MuG20bR999ZATPlMbFtbLLNR4sHz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140148; c=relaxed/simple;
	bh=+gA4hJjsCk5vCj3+1I43O/U9/YcOwnpWipkXPNX30wY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nGVqrzZIhs+9jsOc2LvMnZy5jc9kp566XOem6LlyqRE1slPVZhGyOlbZkFU8yzGdwtd63hg+0N40CsmSIWyuZQdixvev+13/6vxPlD+CUCYyG83xP+2U5qMK1IFVfUM4sjklhd2MZzaCHjsPAbXCCUBpq+a6jwB1q9Eu/EG3eMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wqml7Ljy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdEpPrdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Mar 2026 11:55:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1773140145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBqZjPA2o9w4N++nzgjodvxykmBmUxb6gs1kOvcVuFY=;
	b=wqml7LjyIBYKbQ/Kh4seDPdJ7FLqjg1djWS3ZzPmh7tmc9dLYhswqZsZrGsjKzjkfiXNTH
	5GZ/9aN8jZ7toBRZNI4bovpP6MnrNhCWSi92EBGn2YT3rg1Brtjr/DCIoIKDnM8UPgQjNK
	YqWjS1lj9Pa8c6fRVHY3kIgnYpzkUFhGHsb17XfMnnRi7AkRbF1SrNMhNdizaGyBLlzy61
	eldrMM012BN7RRkCvg4OdoDCAqJ0qE1822dQmxNkOkpxs792Ke0SWzmIBwJ2Inhs4Mq/d4
	OuITQsjK9caw9fHWsYzuSu885CidC4iuojYCVmxX0OhitWgNKKow44Skbalzvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1773140145;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tBqZjPA2o9w4N++nzgjodvxykmBmUxb6gs1kOvcVuFY=;
	b=RdEpPrdQUZe3lh5vctEPA/5KI3czoGloVQ1AvdZIQTb0BgF6eATxkTsLtDb43rBOZbwPMi
	7PImvFBSlObvlKBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, "(JC), Jayachandran" <j-rameshbabu@ti.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Chintan Vankar <c-vankar@ti.com>, Danish Anwar <danishanwar@ti.com>,
	Daolin Qiu <d-qiu@ti.com>, Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260310105544.EVXIekwG@linutronix.de>
References: <20260309-hsr_ptp-v2-0-798262aad3a4@linutronix.de>
 <20260309-hsr_ptp-v2-2-798262aad3a4@linutronix.de>
 <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.3b7b5294c6434@gmail.com>
X-Rspamd-Queue-Id: EC74D249E1A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266013-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Action: no action

On 2026-03-09 21:38:33 [-0400], Willem de Bruijn wrote:
> The same point about adding per protocol state to sk_buff applies
> to a slightly lesser extent to PF_PACKET.
>=20
> Adding this much HSR + PTP specific code there is a non-starter.

It looked like a little and is hidden behind a static branch so it is
just a nop as long as there is no one using the socket bind. And without
CONFIG_HSR there is not even that.

> I should have said this in v1. This likely makes my skb_extensions
> suggestion a non-starter sorry.

I need something to share between two layers I think so that
skb_extensions wasn't that bad.

> We need to find a different way to
>=20
> Rx: get the port info from the slave device to userspace.
> Tx: send out the intended slave device.
>=20
> Let's separate the two challenges (and patches).
>=20
> On Rx, could your process just attach the PF_PACKET socket to the
> slave devices and filter on HSR PTP packets? Then separately drop
> these packets in hsr_handle_frame (as already done?) or TC ingress, so
> that they only arrive in userspace?

I could listen directly on eth0/ eth1 as a PF_PACKET. That would give me
all I need including a timestamp, yes. I wouldn't just be able to use it
for TX but lets go on.

> On Tx, can you share a bit more why there are two cases, one where the
> master has to add the header, but also one where it does not (so
> userspace has presumably inserted it).

PTP + HSR. Lets assume the following setup:

         =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=95=AE   =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=95=AE              =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AE  =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE   =20
     =E2=95=94=E2=95=90=E2=95=90=E2=95=90=E2=94=82 Node X =E2=94=82=E2=95=
=90=E2=95=90=E2=95=90=E2=94=82Port A=E2=94=9C=E2=94=85=E2=94=85=E2=94=85=E2=
=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=
=85=E2=94=85=E2=94=85=E2=94=A4Port A=E2=94=82=E2=95=90=E2=95=90=E2=94=82 No=
de Y =E2=94=82=E2=95=90=E2=95=90=E2=95=90=E2=95=90=E2=95=97
     =E2=95=91   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=95=AF   =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=
=94=80=E2=94=80=E2=94=80=E2=95=AF              =E2=95=B0=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF  =E2=95=B0=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF    =E2=95=91
     =E2=95=91                                                             =
 =E2=95=91
     =E2=95=91                                                             =
 =E2=95=91
  =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AE =
           =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=95=AE  =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=95=AE  =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=95=AE            =E2=95=AD=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AE
  =E2=94=82Port B=E2=94=9C=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=
=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=A4Port B=
=E2=94=82=E2=95=90=E2=95=90=E2=94=82 Node Z =E2=94=82=E2=95=90=E2=95=90=E2=
=94=82Port A=E2=94=9C=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=
=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=85=E2=94=A4Port B=E2=94=
=82
  =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=95=AF =
           =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=95=AF  =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=95=AF  =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=95=AF            =E2=95=B0=E2=94=80=E2=94=80=E2=94=80=
=E2=94=80=E2=94=80=E2=94=80=E2=95=AF

Node X has direct connection to Y and Z, each node has two ports. You
could add more nodes but it always remains a ring.
Lets say node X sends a packet (say TCP/IP) with the destination MAC of
node Z assuming a "normal port 443" request. This packet gets a HSR
header prepended and is sent on X-A and X-B. This happens transparently
as hsr0 is the device with an IP address assigned and port A and B are
just two device which are up with no IP address assigned. These are the
physical devices forwarding the traffic.

Y-A receives it, is not the target, forwards it over Y-B.
Z-B receives it, it is the target, sends to its master port which
removes the HSR header and the packet arrives in the IP stack. After the
master port, it forwards it also on Z-A.
Z-A receives it (the copy from Y-B) identifies it as a duplicate based
on the HSR-sequence number (does not inject into the master port) and
forwards it on Z-B.
At the end Node X receives two copies of the packet it sent and removes
them from the ring (node X was the sender identified by the SRC MAC and
does not forward it).

This is how HSR works in general. Now lets add PTP to this as specified.
The target MAC is always a multicast MAC and the ether type is PTP
0x88f7.

Use case 1: A PDELAY_REQ packet. This packet travels only between two
neighbours. That means X-A sends it to Y-A and Y must not forward it
over Y-B but needs to answer (send a PDELAY_RESP). These packets are
sent as PTP frames and the HSR stack needs to prepend a HSR header with
a valid sequence number. X-B gets its own request. Userland needs to
track time/ state information on per port basis.

Use case 2: A SYNC packet. This packet is sent from X-A to Y-A. Again a
HSR header needs to be prepended by the stack on X. Y-A receives that
packet. It injects it into the master port where user land can consume
it. This is the same as the previous case.
Here comes the different part: This packet needs to be forwarded by Y
over Y-B. As in the previous case the HSR stack does not forward it on
its own but this part is done by userland. So userland sends a packet,
only on Y-B and this packet already contains the HSR header from X and
it needs to be preserved.
The forwarded SYNC packet got its timing information updated based on
the delay within the stack (so it is not identical as received).

That is why the HSR stack must not forwarded the packets on the other
port as it would normally do (breaks PTP time information), why user
land needs to know on which port the packet was received and why it
needs to send a packet only on one port with or without the HSR header.

> The second case is simpler: can just write directly the whole packet
> to the intended slave device.

Yes. This has been suggested and was indeed used in my v1 of linuxptp
but the problem was sending with system's HSR header.

> For the first case, could skb->mark be used as port selector when
> writing from a packet socket to the master device? That already works
> with sock_cmsg_send.

We would have to specify that SO_MARK 1 and 2 denotes the port on which
a packet is sent. This kind of burns the usage for everything else on
HSR so it feels misused. And then we would need an additional bit to
specify whether the HSR header is there or not. Unless I open additional
socket on the ethernet device just for sending and dropping everything
incoming.
And we would have to filter/ distinguish the RX port based on it.
Userland has a cBPF filter to filter everything out and receive only PTP
frames. If the PTP packet is forwarded to both sockets (A and B) then
userland would have to throw one copy away and go to sleep again. This
sort of breaks currently linuxptp logic. It would probably require
either eBPF to filter also so_mark or deal with "no packet despite the
wakeup" but so far I tried minimal impact on both sides (kernel and
user).

Sebastian

