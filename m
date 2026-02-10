Return-Path: <netdev+bounces-258073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aNLyJ6Mgi2lBQQAAu9opvQ
	(envelope-from <netdev+bounces-258073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:12:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF3A11A93E
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 13:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E18D53006D6D
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 12:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6BF5328608;
	Tue, 10 Feb 2026 12:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4cBXjqmE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h7rNchUa"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0122FD681;
	Tue, 10 Feb 2026 12:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770725532; cv=none; b=ZPTbcI4Ywc8x/5eQYc/25wzLQBmw6x/WdeWN6hbApLuNtZCb8HXm/CGMhxrgtmEQHzK/WyF95tLK7ePve/zwbEbHkW49+zxUBMTVQ3oJWou0jk0JJJcUfvNfQrYLtS5R2zVg1LThxBNvZpcrZGtdCAnrFaT2vVBZuZv/No94Mb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770725532; c=relaxed/simple;
	bh=YEHIyopgdQer4seco09ruDn2+u3dsQTOmV7CfsMHkD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0AoqEu0PkTLh9oY2oUVoU+5xaWxLYhVVPKIpLJ8OHSxvFGLkZMOZ4kUTI648SjlNpxqBVLUmqq4/LqxdMuiKhUQuw1mUYQu+9ZmdQg+HtOshE9PRpdSGK0KQKCsaqHqS0VkWqjO4p3BuD2bDr3w0U9bZJq569CGIapviQ5qyTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4cBXjqmE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h7rNchUa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Feb 2026 13:12:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770725529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tI8rachHCW1YrsKlENUN2dkik2zbYzc6d1Scl8Q1OUA=;
	b=4cBXjqmEwfbym2UMalBRUx1DCMtvXGMDsMYZ5QihD2VOdj3vY9K2+Q5Hn4feWU3tHsNT3H
	6XQvAOjUmW61/f8pQGN0jxgsi/IrNPmrcUlnBLrnX4eSWqv23C2S+9J+sHbxEeqmhvgVRD
	XNjLA/LpqpJ8NILOhwHvgtPGpKaixCUIxcBfSxAT9p42zaoN99orCG5MoWo7rsR2BdCrYV
	xctRhc2Irim8DAKSgDA2B5PA/2Og/97rlrOyPRxI4tpsBGQiwGBqZ+Pqg1lzES9NasmLec
	1Mb2wVE7EcbLKoBysM9sDYPPSvFlKFq5cmP4h4j19zxkbnSAG5pthDp5gIHHHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770725529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=tI8rachHCW1YrsKlENUN2dkik2zbYzc6d1Scl8Q1OUA=;
	b=h7rNchUaqkwxuTXB6Jov+Fu/QIRlWJljNkNAJuX5BAyfCpviifZupK2Dl9CuYm8nIOYQe+
	t8OpHnTnnOkMirAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx timestamp
 directly from interrupt for i210
Message-ID: <20260210121207.9kLHroS0@linutronix.de>
References: <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
 <601f0c4b-52d8-4b60-96bf-f2d65f8073d8@linux.dev>
 <willemdebruijn.kernel.bbdefedfb87e@gmail.com>
 <20260209090621.GiZqTiMJ@linutronix.de>
 <8e762437-69f9-40d7-bb75-3a45bef1d5d6@linux.dev>
 <20260209114836.GPU-vnnh@linutronix.de>
 <78e2af2c-40e6-43f1-9471-42f350e69389@linux.dev>
 <willemdebruijn.kernel.2e6213a98660b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2e6213a98660b@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258073-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.dev,google.com,kernel.org,redhat.com,davemloft.net,intel.com,linutronix.de,molgen.mpg.de,vger.kernel.org,gmail.com,lunn.ch,lists.osuosl.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BAF3A11A93E
X-Rspamd-Action: no action

On 2026-02-09 07:46:01 [-0500], Willem de Bruijn wrote:
> > > Yeah, but what is the legacy user here? If you enable HW-timestamps but
> > > never set OPT_TSONLY and the sysctl is also 0 then you reply on the
> > > CAP_NET_RAW later on. Right?
> > 
> > Legacy users here means users of HW TX timestamps expecting full skb to 
> > be returned back with the TX timestamp. Legacy here means that skb will 
> > be returned with headers modified by stack, which is kind of exposure of
> > data, which requires CAP_NET_RAW...

Ah okay. I assumed the err-queue was the standard way of receiving
timestamps.

> > > I just try to justify the CAP_NET_RAW check and if it is required to
> > > move it earlier (where HW timestamps are enabled). And if the sysctl
> > > check is enough then maybe it is not needed.
> > 
> > Capabilities should not change during lifetime of the process, should be
> > fine to move. On the other, sysctl can be changed system-wide which may 
> > affect users.
> 
> Ignore the hardware configuration. That is entirely optional. Some
> devices will timestamp every packet.
> 
> The capability check here is per-socket, independent from the system
> hardware configuration.
> 
> I don't see how it could be moved.
> 
> Before OPT_TSONLY was introduced packets were always queued with their
> payload. The sysctl check was added to optionally disallow this. The
> check could arguably be moved earlier in the socket lifecycle and the
> decision cached in the socket. But then flipping the sysctl would not
> affect existing sockets, so that is a change in ABI behavior.

You could cache only the part under sk_callback_lock.
Any other suggestions?
The access from IRQ is quick and avoids any detours.
The alternative would be to move the whole routine into an aux_worker.
For every driver doing it from the IRQ handler.

Sebastian

