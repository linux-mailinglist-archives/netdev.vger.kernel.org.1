Return-Path: <netdev+bounces-255955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MH7jDsjagGnMBwMAu9opvQ
	(envelope-from <netdev+bounces-255955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:11:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6DCF69E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 18:11:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7E2B3019538
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:11:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78C9C37F748;
	Mon,  2 Feb 2026 17:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kXdbngpt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tp0fZXrQ"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A85223705
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770052288; cv=none; b=gRMyiaYa0pRpKqYByVvkb58qgdkbgwA/FFtyXrmuB/Tdj3nxDI7Pdb00fTvsVDlq5KmY281AyTZj1brxSlhlK/uEagXeD2fskTWcEQdR/kWIG6bvWgrmV44uKDQPoiiDA6LrcukSQfi35bosqHk2jlIDW4bG8oueepukwHP8tvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770052288; c=relaxed/simple;
	bh=8qEr4+1VWnQSWbxPPevstOON1lzFS4aCMI7EJNXyQ9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CFHFDTO4+Atpm43KN7c0unR/OYtYBWcoaMT6jYLdb9vE+V8q4HWrcuFVxA2wwvA6qHpcjBL2DRKdxS9VDk7BtTQLjnZy7IU4x7uw7zWIFurEyykt+IFS5CaLY2C3V8wat+D+BQoM3WK2uaoIDMzuEMGInvFBO9jCw0uWc0V2ks0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kXdbngpt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tp0fZXrQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Feb 2026 18:11:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770052285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLdsYJbOnOhJ2Z0r76q/Y+OjJwnvYYdSVfTg6jw2pWg=;
	b=kXdbngpt53lh1dqzrfwIPZv0gnSn4Sg5OC6zzAha6Me5VUojOCcbLcTFg25Ap/oSQ8vlBa
	PwtNu/RWhGZ5YrIXENkfFQA2Bs1t7P8215BhLilSA88pPEAg3kb7GggcQMEOKQuVxjfMDR
	wTDXIl27nAY1+5GeRjkmNtXdM6TT2sct4XNuai59aA0ROBAT7C191b+sopnoUBIekSxhlz
	XGr9MCIweBrSOnmnUvoDCdUuIJvxZuouVmx6sj4BVkkX5jTRQUf7eXnxuFzY98k/x38md3
	z9B9OEjRKsdsVqqgfeadwSGJ5e15gN0yBzRU55XDmitkuHIhkDXbYArFj4Fgwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770052285;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JLdsYJbOnOhJ2Z0r76q/Y+OjJwnvYYdSVfTg6jw2pWg=;
	b=Tp0fZXrQEkxV/iq/OvjMbeMt6Eq3uebtGgxUuCdH71aacH9x5MzvO26y6BqzH3yrvh1Z3T
	PfWdlVfXpAaeK0CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <20260202171123.LkzpiAMv@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <aXuIAFJ_m6gMUFFO@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,linutronix.de,oracle.com,nvidia.com,openvpn.net,smile.fr];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 87D6DCF69E
X-Rspamd-Action: no action

On 2026-01-29 17:17:04 [+0100], Felix Maurer wrote:
> About the interlink: that's the interface where you attach devices that
> know nothing about HSR, i.e., when we are a RedBox. I consider it very
> similar to the master port, it's our responsibility to de-duplicate what
> we send out there.

Right. It should contain the same "seen" values as the master port.

> I was thinking about exactly this while working on the patch as well and
> I came to each conclusion (A,B are needed vs. are not needed) at least
> once. In the end, I think we will need it. It's right that a well
> behaving node in the ring should not forward "frames for which the node
> is the unique destination" (5.3.2.1). But there could be frames that
> have no unique destination in the ring at all: multicast frames or
> frames addressed to a non-existing MAC address. We should not forward
> such frames either to prevent them from looping forever.

But multicast and non-existing destination frames do one round in the
circle, reach the sender which will remove them from the ring and not
forward.

> Now, such frames should probably only reach back to us, if we sent them
> (either from our stack or from the interlink port). We could track
> sequence numbers sent to master and interlink (for de-duplication) and
> sent by master and interlink (for loop prevention) for more clarity, but
> then we're back at four bitmaps again.

I think we could avoid tracking A/ B. The packets that we receive from
A/ B and forward to the master after de-duplication should be the same
as those that are forwarded to the interlink port.

> I agree that we can and should optimize the HW-offloaded case. I'd
> suggest to do that in a separate patchset, though, partly because I
> don't have access to a hardware with HSR offload at the moment.

Sure.

> > I know you preserve what is already here but what is this even used for?
> > | ip -d link show dev hsr0
> >
> > does not show these numbers. It shows the sequence number of the hsr0
> > interface which I understand.
> > But then it is also possible to show the last received sequence number
> > of any node on either of the two interfaces?
>=20
> This is only exposed through the HSR_C_GET_NODE_STATUS netlink command
> for the "HSR" (sic!) netlink family. I'm not aware of a userspace tool
> that actually shows this data. It's unclear if it is of any real use.

hehe. Great.

> I assume that the two sequence numbers are reported because they would
> in theory allow to detect a broken ring: if one of the numbers stops
> increasing or the numbers generally diverge, some link in the ring is
> broken. If we have traffic from multiple nodes, we could even detect
> where the ring is broken. That's likely also the reason for the weird
> cross-assinment of B->1, A->2. What we send out on B has to have arrived
> on port A resp. 1 before.
>=20
> We can discuss removing this stuff in the future, but I'd prefer not to
> touch userspace at this time.

Sure. I was just looking who is using this and this netlink interface
was the only user. It looks like debug code.

> > > +}
> > > +
> > >  int hsr_get_node_data(struct hsr_priv *hsr,
> > >  		      const unsigned char *addr,
> > >  		      unsigned char addr_b[ETH_ALEN],
> > =E2=80=A6
> > > --- a/net/hsr/hsr_framereg.h
> > > +++ b/net/hsr/hsr_framereg.h
> > > @@ -82,15 +82,18 @@ int prp_register_frame_out(struct hsr_port *port,=
 struct hsr_frame_info *frame);
> > >  #define hsr_seq_block_index(sequence_nr) ((sequence_nr) >> HSR_SEQ_B=
LOCK_SHIFT)
> > >  #define hsr_seq_block_bit(sequence_nr) ((sequence_nr) & HSR_SEQ_BLOC=
K_MASK)
> > >
> > > +#define DECLARE_BITMAP_FLEX_ARRAY(name, bits) \
> > > +	unsigned long name[][BITS_TO_LONGS(bits)]
> > > +
> > >  struct hsr_seq_block {
> > >  	unsigned long		time;
> > >  	u16			block_idx;
> > > -	DECLARE_BITMAP(seq_nrs, HSR_SEQ_BLOCK_SIZE);
> > > +	DECLARE_BITMAP_FLEX_ARRAY(seq_nrs, HSR_SEQ_BLOCK_SIZE);
> >
> > is there a story behind DECLARE_BITMAP_FLEX_ARRAY()? We have just this
> > one user.
>=20
> I've added it this way to make it obvious that almost all of it is the
> same as DECLARE_BITMAP(). But probably it's better to get rid of the
> macro, add the definition directly to the struct, and maybe add a
> comment that it's supposed to be similar to what DECLARE_BITMAP()
> produces. What do you think?

I would get rid of it. There the "official" DECLARE_BITMAP(). If this
doesn't work just open code it avoiding the macro.

> Thanks for your comments,
>    Felix

Sebastian

