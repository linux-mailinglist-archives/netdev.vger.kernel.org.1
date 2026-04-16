Return-Path: <netdev+bounces-279091-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NWhCfoL4WnoogAAu9opvQ
	(envelope-from <netdev+bounces-279091-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:19:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB3F411920
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 18:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 604CE303B5E7
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 16:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E602B388378;
	Thu, 16 Apr 2026 16:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l7fpIzkE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JMbZNEm9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83392285CAE
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 16:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776356341; cv=none; b=GkTk6MJ8Vy5W9aD0b/4tOMfKDmJjoGnf5SoczZvjg1Jo42rcr9WinFT0HojUzZuUYvEEveNKlTUP5aghlVT5sspRgaR122sn0YVIpe5hVk2BdvhlNaTdIy/hJc3zIV1jhdvlrnfIodT2v1d1DwxzAMqam+GEi6/F132uLAQDs+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776356341; c=relaxed/simple;
	bh=6LYyvvuRQik55lFLQDg3D51Zxnf9/jJMioHwmm9Tz1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=COu9DgjiExZvxtUVBWo5LN02Frfd+2/yZKzsOfNSvI2U2zgk8/7iikrAJoUmhgrGIF2DI3FgIMlqbvqYHOSC/pd6FbLPIzBv+hzJ3QHz8e5gS0+Bz8U9qICMomhZkCFRCP2w1ntBzk8I6bzeZZZm8ImdghlHXrX2zpv5tmxC128=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l7fpIzkE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JMbZNEm9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Apr 2026 18:18:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1776356338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LYyvvuRQik55lFLQDg3D51Zxnf9/jJMioHwmm9Tz1I=;
	b=l7fpIzkE3g6sL2UC6lg4o80+qDvEpgpu52cOI36UR1aB5OREvFHrZXTHV5YKhNxk/1zEGL
	uAN1NRqh/MIkveWc/OaT6O7AjcD8lrXEG483EuBvucg5k9RAZy9hsxTPNC1TuG/aFxGcVU
	H8Y0UERc9+Le0i3krttugAcV8UOz6A+ghknHkWMp2wxmygblFTskAzp537onYp2ib/SYfR
	mFeEMBh5OqHljC4+mQF2aKGvXkRDubMtjNgogMvlwV4pP+F324Ud9qcp5qxUYyK8e9C8kQ
	ckhyUGZADiUa4JzqseEXoQ3VA2xhu7xlM6Ahjj8jl9dDMKnjKm+BVCM1s4BmGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1776356338;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LYyvvuRQik55lFLQDg3D51Zxnf9/jJMioHwmm9Tz1I=;
	b=JMbZNEm9BYHysYN7J2QFCyFPNDZKKOtld8wX7EsqFJT7gN9zaXAKxVJE+gB0LpsyIAnkNZ
	KC4bBMPwveZr7eBg==
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
	Simon Horman <horms@kernel.org>,
	"Raghavendra, Vignesh" <vigneshr@ti.com>,
	"Bajjuri, Praneeth" <praneeth@ti.com>,
	"TK, Pratheesh Gangadhar" <pratheesh@ti.com>,
	"Muralidharan, Neelima" <neelima@ti.com>
Subject: Re: [PATCH RFC net-next v2 2/2] af_packet: Add port specific
 handling for HSR
Message-ID: <20260416161856.CsL4npMH@linutronix.de>
References: <20260313092226.SscHp2zQ@linutronix.de>
 <20260313160410.LEhav8Xz@linutronix.de>
 <willemdebruijn.kernel.1fbf050c50d62@gmail.com>
 <20260317172906.eG2LxlZ7@linutronix.de>
 <willemdebruijn.kernel.17068ce38efa5@gmail.com>
 <20260319142613.KHz32I-V@linutronix.de>
 <willemdebruijn.kernel.8e323262df61@gmail.com>
 <20260324163820.p9M2z27W@linutronix.de>
 <20260402163237.EIE16Pj_@linutronix.de>
 <willemdebruijn.kernel.1f3d8356e4a5a@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <willemdebruijn.kernel.1f3d8356e4a5a@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279091-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,ti.com,davemloft.net,lunn.ch,google.com,redhat.com,kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Queue-Id: 8FB3F411920
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-04-06 10:47:56 [-0400], Willem de Bruijn wrote:
Hi Willem,

> So the requirement is for a communication path between userspace and
> the driver over packet sockets.
>=20
> Existing options that work for both rx and tx are
>=20
> - in-band: a packet header or footer
> - mark, metadata
> - maybe: vlan tags
>=20
> These require changes in the HSR driver to use them, but no changes in
> the protocol independent core logic, which includes packet sockets.
>=20
> As I mentioned before we cannot sprinkle protocol specific code
> throughout protocol independent core code. That quickly leads to an
> unmaintainable mess. PTP over HSR is a particular small niche case,
> nowhere near first in line to get an exception to this guideline.

I understand your concern. I tried to make as self contained as
possible and little runtime overhead as possible.

> One perhaps interesting Rx only option I had missed before is
> SOF_TIMESTAMPING_OPT_PKTINFO. Would that give you the original
> device ifindex today?

The upper logic expects to poll() on the fd. If I need to filter the
device based on this then breaks the expectations.
I need also to receive packets without a timestamp so I don't think this
works.

> If so, we now only have to consider the Tx path to the HSR driver
> (the Tx path directly to the other drivers do not need this metadata).
>=20
> I'm not convinced that it is hard to come up with a way to send
> a packet to the HSR driver with an optional header or footer or
> vlan data (or skb->protocol perhaps?) that cannot be
> differentiated from other traffic arriving at that ndo_start_xmit.

I've been looking to skb->protocol. Maybe if the packet has ether type
set to PTP then the HSR layer could consider everything before it (the
two MAC address fields) as internal header and the actual packet starts
after that. Reasoning would be that you shouldn't send a PTP packet over
HSR without dealing with the restrictions. So this could work.

Then the question remains how to do the filtering on RX side. For the
so_mark I did open additional two sockets=E2=80=A6

> If all this fails, we can look into a protocol independent approach
> to passing other metadata in packet sockets. to/from skb_ext or cb[],
> say.

I will try the above but it looks very hackish.
cb[] is limited to one layer. I do have a skb_ext variant working but
this requires cmsg to set it. Do you think about generic skb_ext which
is set from af_packet? But I don't think it brings much value if I can't
filter on the RX side before returning the packet to userland.

> But at this point I see enough options that do not require changes
> to packet sockets.
>=20
> To get back to the simplest approach: skb->mark. Is there any
> concrete risk that on this path that would conflict with other
> uses of that field? If packet sockets inject directly into this
> driver (possibly even with PACKET_QDISC_BYPASS)?

So I have a skb->mark variant working. I do read on the ethX interface
and write on the hsr0 interface (so I need two extra fd per interface).
The only concern here is that the mark value is hardcoded and could
collide with an existing firewall setup or so.
This field needs also be evaluated by the ethernet driver in case of
hw-offloading for HSR.
So far, this is the only working solution I have which does not touch
af_packet.

Let me try the header with the PTP hedaer type and the additional
sockets for RX.
It will not win a beauty contest but maybe I judge too harsh=E2=80=A6

Sebastian

