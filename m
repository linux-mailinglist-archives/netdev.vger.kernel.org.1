Return-Path: <netdev+bounces-260468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDk2MIaKnWnsQQQAu9opvQ
	(envelope-from <netdev+bounces-260468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:24:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD2D1862F7
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:24:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D08503040FC5
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469A737C0ED;
	Tue, 24 Feb 2026 11:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BFjlqVSj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mFBQfMmi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AD23793D4
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771932291; cv=none; b=Z6Aexf/3b+JtVUepCyR0uOjsGJWNOzvK1qi6BJYzNVSFCBdjTNtVwg3ltCsMuFwG4z5QZvc8xXqveCndAqHoGLBu1sPDLkL0vqtCBQB0cBeCepZzJVTBMMzl93X9iPYYhTpUgxI77vBJi6lpcpfHyE6MxG12r88j1uoghF43MjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771932291; c=relaxed/simple;
	bh=y03Xr9m4xwtwaUB084R1d8d59eQ4iw+fLjrA3S7CdG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2lsFLM6OrE0CiTc5N7y2sCt8huhV8byG4tKYGEg2+ibJWC/CrRqzT5YkurHZJmtgxzlcjhAugflP/cEWlpLZbHEF8/QC4+fgdQrYjhwdfC/lSKuuU2+kWmsuU6CeIslLcPSEXM1Uc4QBM/BFPafY0srSq1vsDqUDrycaYFrRf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BFjlqVSj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mFBQfMmi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 12:24:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771932288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6CMW/IVJbm+IOUBlrd6j7F232TvXrMWDIUSbwu7I8jE=;
	b=BFjlqVSj7vExmfRwLeo/VkdmKRf8jqurw3He2405X5G0fc1aVnLeuxSrGyB7v2wD8MX3tM
	wCqtY5uVV7Zxio4xMVTDE/kHX/ZPZqQSoaEKBfu+DwusCPLUs31+cfWc257zUayiTl7A70
	r7A+dM+DGCzosZuX8cKnLfw0Gw7oAmx7FCADWViF2FffE6dtD147g3eS1IHlTwP0bAmt4Y
	BCtfNAKPlG3O/RAk+Qg4TXypmDx9FHJohTccxUksYVq8FzQqLgsFbM3UoDW9nAFK0AXSkk
	ZhoniUD4WN37fwD9NyG2a9jrC0Z25g7k1Z0BWZOSxQh+Ydj5j0i4Y0WDW1rJlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771932288;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6CMW/IVJbm+IOUBlrd6j7F232TvXrMWDIUSbwu7I8jE=;
	b=mFBQfMmipfl3DzUzcIWdia5qxWsZeRl10FYqoNt06k01dTzIS+ORy+EQCmOC6p9Vs9GsfQ
	SRYpcXiPbuRng2CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH RFC net-next 0/2] hsr: Add additional info to send/
 receive skbs
Message-ID: <20260224112447.ppskFxhW@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <aZNBfh81p1zBvbi2@thinkpad>
 <20260217161053.XMFBwFXg@linutronix.de>
 <aZYSvY8nUKhpLZhv@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aZYSvY8nUKhpLZhv@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-260468-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linutronix.de:mid,linutronix.de:dkim]
X-Rspamd-Queue-Id: 6DD2D1862F7
X-Rspamd-Action: no action

On 2026-02-18 20:28:36 [+0100], Felix Maurer wrote:
> > Yes. Point 3b needs to be extended by
> >   " + or does not contain a HSR/PRP header and requires one by the
> >   system."
> 
> Ah, I missed that! Thanks for pointing it out, that seems to be the
> tricky part to me. Just be sure, you refer to the Pdelay_{Req,Resp}
> messages? Or are there any other messages?

These and the SYNC+FOLLOW_UP if the node is master.

> > > If I understand your patch 2 correctly, you will be maintaining two
> > > sockets in userspace (one bound to each of the ports A and B through the
> > > HSR interface using PACKET_HSR_BIND_PORT). Binding through the HSR
> > > interface to port A/B has the very special meaning of making a socket
> > > only receive a very small subset of the packets, that is PTP traffic at
> > > the moment. This seems like a somewhat hidden property of the bound
> > > sockets and should at least be very explicit.
> >
> > Technically four sockets (two for A and two for B) but in general yes.
> > What you mean by hidden property/ very explicit? Document
> > PACKET_HSR_BIND_PORT in packet(7) or something else?
> 
> Yes, at least that. Maybe also make it more clear in the name that this
> kind of binding means that you will not receive all packets from this
> port but just some (atm, PTP).

Right. That happens implicit because they are not tagged. Extending the
present documentation would be something I consider once we do align on
something.

> > However if we
> > ignore this detail and can receive on interface A and send on interface
> > B over XDP and get timestamps right then we have the same as the packet
> > interface on the two eth devices. What is missing is sending with HSR/
> > PRP header.
> 
> You wrote in another reply, and I agree with it, that sending with the
> system HSR header and sequence number must go through the hsr device.
> Frames that already have a header, such as Sync an FollowUp that are
> forwarded, could just directly go through the slave interfaces.
> 
> I think the cases should be handled independently: to send a frame with
> a full header (i.e., the forward case), we already have the AF_PACKET
> socket on the slave interfaces as an option. For sending a frame just in
> one direction in the HSR ring through the hsr interface, we have to come
> up with something, but IMHO just for that.
> 
> I like the idea of putting the port hint in the ancillary data of the
> message, but I'm not sure where to put in the skb then / how to pass it
> to the hsr interface. Willem's suggestions are worth exploring I think.

Good. I will try to come up with something. Willem had something, I will
look into this.

> Thanks,
>    Felix

Sebastian

