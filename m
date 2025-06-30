Return-Path: <netdev+bounces-202317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD47FAED37D
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 06:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E12537A5E26
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 04:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C079190072;
	Mon, 30 Jun 2025 04:37:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9B91EB5B
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751258232; cv=none; b=XPPXkfxIHsqfx1gJ7aswaBAsdWsIB8VsDXh60UtQHRjUi7XNL4W+XFhqM4oUolp44Zbf0ulxGOqMt4180/wAV1XfKs/ZY+re1JrB9Wf2I3xKAmF5++rlzPe9wKd6x6McBTZZHoxRVV18IYhfAz06KOEsTWiGRbZ235Vt4RvNtJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751258232; c=relaxed/simple;
	bh=vIzD1F4zPJvdMagV/NHycGdQJSNbu9VtrrRLgEZDLt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MIQR6FoGJBI8fIYgYsggjCTpcwdauYDwD1umtCsjzuipKhh/skFyL0GDS9z7iOFUVG3Tvmfxc+g7zBhmA4cjQD8i6tGFqvZ921UN9jYDcsRkYvMKcaR+DV4lqz9EAv8Z5sKAg88MfKc0Qp//2l7sKeTPJv6yklfIu3WazbboP0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1uW6GH-0008EU-Qe; Mon, 30 Jun 2025 06:36:57 +0200
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uW6GG-0062sb-1N;
	Mon, 30 Jun 2025 06:36:56 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1uW6GG-009Lrl-0t;
	Mon, 30 Jun 2025 06:36:56 +0200
Date: Mon, 30 Jun 2025 06:36:56 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Vladimir Oltean <olteanv@gmail.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Tristram.Ha@microchip.com, Christian Eggers <ceggers@arri.de>
Subject: Re: [PTP][KSZ9477][p2p1step] Questions for PTP support on KSZ9477
 device
Message-ID: <aGIUaMs23YXoWVwP@pengutronix.de>
References: <20250616172501.00ea80c4@wsk>
 <aFD8VDUgRaZ3OZZd@pengutronix.de>
 <b4f057ea-5e48-478d-999b-0b5faebc774c@linux.dev>
 <aFJJlGzu4DrmqH3P@hoboy.vegasvil.org>
 <aFJcP74s0xprhWLz@pengutronix.de>
 <20250626233325.559e48a6@wsk>
 <20250627215804.mcqsav2x6gbngkib@skbuf>
 <20250629112830.79975f4a@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250629112830.79975f4a@wsk>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

On Sun, Jun 29, 2025 at 11:28:30AM +0200, Lukasz Majewski wrote:
> Hi Vladimir,
> 
> > On Thu, Jun 26, 2025 at 11:33:25PM +0200, Lukasz Majewski wrote:
> > > The second problem which I've found after some debugging:
> > > - One device is selected as grandmaster clock. Another one tries to
> > >   synchronize (for the simpler setup I've used two the same boards
> > > with identical kernel and KSZ9477 setup).
> > > 
> > > - tshark from host on which we do have grandmaster running:
> > >   IEEEI&MS_00:00:00 PTPv2 58 Sync Message
> > >   LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
> > >   IEEEI&MS_00:00:00 PTPv2 58 Sync Message
> > >   LLDP_Multicast PTPv2 68 Peer_Delay_Req Message
> > > 
> > > So the SYNC is send, then the "slave" responds correctly with
> > > Peer_Delay_Req_Message.  
> > 
> > Peer delay measurement is an independent process, not a response to
> > Sync messages.
> > 
> > > But then the "grandmaster" is NOT replying with PER_DELAY_RESPONSE.
> > > 
> > > After some digging into the code it turned out that
> > > dsa_skb_defer_rx_timestamp() (from net/dsa/tag.c) calls
> > > ptp_classify_raw(skb), which is a bpf program.
> > > 
> > > Instead of returning 0x42 I do receive "PTP_CLASS_NONE" and the
> > > frame is dropped.
> > > 
> > > That is why grandmaster cannot send reply and finish the PTP clock
> > > adjustment process.
> > > 
> > > The CONFIG_NET_PTP_CLASSIFY=y.
> > > 
> > > Any hints on how to proceed? If this would help - I'm using linux
> > > kernel with PREEMPT_RT applied to it.  
> > 
> > Which frame is classified as PTP_CLASS_NONE? The peer delay request?
> > That doesn't sound convincing, can you place a call to skb_dump() and
> > show the contents of the PTP packets that don't pass this BPF filter?
> > Notably, the filter matches for event messages and doesn't match for
> > general messages, maybe that confused your debugging process in some
> > way.
> 
> It looks like PER_DELAY_REQ goes from one KSZ9477 device (with DA:
> 01:80:C2:00:00:0E) and then it is not visible (i.e. is dropped) in the
> tshark output on the other KSZ9477 device.
> 
> From what I've read on the Internet - those multicast frames are
> dropped by default by switches, but I'm using KSZ9477 ports in
> stand alone mode - i.e. bridge is not created).
> 
> On the other hand - the frames with DA: 01:16:19:00:00:00 (other
> multicast "set" of address) are delivered correctly (so the grandmaster
> clock is elected).
> 
> This is under further investigation.
> (setting KSZ9477 lan3s as promisc doesn't help).

Hm, if I remember it correctly, there was some HW filters:
https://patchwork.ozlabs.org/project/devicetree-bindings/cover/20201118203013.5077-1-ceggers@arri.de/#2589089
"
When master mode is on Delay_Resp will not be forwarded to the host
port.
When master mode is off Delay_Req will not be forwarded to the host
port.
"

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

