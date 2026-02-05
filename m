Return-Path: <netdev+bounces-257114-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPcVLH52hGkX3AMAu9opvQ
	(envelope-from <netdev+bounces-257114-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:52:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4D6F17B8
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 11:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0AB28300B3E7
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 10:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D520D3A961E;
	Thu,  5 Feb 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bfVJPYvj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zOpymhHq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899F336E495;
	Thu,  5 Feb 2026 10:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770288763; cv=none; b=Wra6k53RR9c6oiu6xs+0wkHrN2kYwi6W3Z7tGpyKvSMRCBke04t1tN8Rk7iKn5WOd9X+lOBawXS3Rqv2YeFZoSuUhCmQX6EF/Tw8VX8iI7Iw1BXIxG8wBDa/wmqCKwMa/c3/6BMANeAeIayGu7QTT8Q132mEyY2n1ky0Xl0YX6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770288763; c=relaxed/simple;
	bh=0+MmCJFYVBz1A0YEOlwD9rJtyzLagCLD74yjbZeTMuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t9JKcLq6DW6vwOU/4wcUHCHGhE3jxbvQPjOt8HafPJwUWY2eQTNyMhkgmAjjfgbRjKQ2CPZ0E3SAN1w6CA2KpToIWxxoF93byREXddbLsbRG7spisiCaB6AkIw3btWHTuzimiQjAtlVGUwRhbDewcDlQP0hdMd88oFK/WvpASn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bfVJPYvj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zOpymhHq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 5 Feb 2026 11:52:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770288760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9mUfxcwOmqfbj1N448pyLfXB42fAzpjDFw1aR2+RSg=;
	b=bfVJPYvjUXQ/r0ZyHM4BTyUwhJPPOUcYJwQ8QHRDBGd/91dmsP2Zh69NJVwxsoYcTrlhZT
	eR/Vab82tAUeAW8ES+G9qtqz0QsYKcUP5j76YjjHNyQkSqPMdWEPuD3ijft/sSy0ae/zxR
	jrQx8dH3nUaPhBZ/914E073UsK9B7/vL1pW+ZVQG0bReEik+4ye+IW+f+49ux6Tt8BSGZs
	DGJKi0+bGpS72HdNGu2gxc8hDRZEBlUUdvd/8ZyeTGYVkNZHa21Uq2YQ+vHbdwZv+K31Iv
	G69xrvSioMYNemgOm0GFnWyyKypjolG4R2nEBs3IUFD7nBeklyopkAuifOAopg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770288760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x9mUfxcwOmqfbj1N448pyLfXB42fAzpjDFw1aR2+RSg=;
	b=zOpymhHqUVPBJHUcRdZZu++eE6xbYv9/KOO+KW5rrDdUqKB75Af5dw+3lC6pNAjxLx231t
	yMsHbcO2LoAJwvDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	"Gomes, Vinicius" <vinicius.gomes@intel.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"Keller, Jacob E" <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: RE: RE: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
Message-ID: <20260205105238.e8F64peo@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257114-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_CC(0.00)[linutronix.de,intel.com,molgen.mpg.de,linux.dev,vger.kernel.org,gmail.com,lunn.ch,google.com,lists.osuosl.org,kernel.org,redhat.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B4D6F17B8
X-Rspamd-Action: no action

On 2026-02-05 10:37:05 [+0000], Loktionov, Aleksandr wrote:
> > 
> > How or where can it sleep?
> > 
> > Sebastian
> 
> igb_ptp_tx_hwtstamp() -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_tstamp_tx -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/__skb_complete_tx_timestamp -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/sock_queue_err_skb -> https://elixir.bootlin.com/linux/v6.19-rc5/C/ident/skb_queue_tail -> https://elixir.bootlin.com/linux/v6.19-rc5/source/net/core/skbuff.c#L4075 

Would you please quote an actual call chain that can be looked up and
not this where a line crosses 300 characters?

> spin_lock_irqsave(&wq_head->lock, flags);  <- RT mutex can sleep

Okay. So you are concerned about this spinlock_t, I see.
igb_tsync_interrupt() also invokes ptp_clock_event() which acquires
pps_event_time::tsevqs_lock. Why is this not a problem?

Sebastian

