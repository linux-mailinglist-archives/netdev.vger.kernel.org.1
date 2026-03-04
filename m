Return-Path: <netdev+bounces-263847-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAWYNNtNqGmvsgAAu9opvQ
	(envelope-from <netdev+bounces-263847-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:20:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC5D202833
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 16:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52C423136798
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 15:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E38983BED05;
	Wed,  4 Mar 2026 14:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gO3Gwf6b";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bioPkuVA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905A23BE169
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 14:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772636306; cv=none; b=X3dIU4nbQLU9jI9MOvKoJHzXumigilLvcuMTIaPLQEsybr3alCQxyV3tXWz1p2snEuV4SstfjdQjo/+HwW33zw/M5wJqX40qbDaVQmjMIjHMU1L+yPydhX6Xz9MR5w4RFy2YUlc6VIQIq18ObMOAJqWBnAD6TQjwpiZUMDSK4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772636306; c=relaxed/simple;
	bh=kJ0jHVfSY4rzfD5nXjR6HqMH1FoZNuONagn+vinay+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWt978CwyhQupyp6CtsrrPdWtrgi8TK7B032WDp4ysVRJC2iAwdT69E8MPIeu7LgjWeDpKmxm82qzDX8qBWJsUfr5PIQw9NewRdTIE7hIw/TMtqfvUBGAvtGvBFrpJL5zEwXyzl1/byr0ZZ75+RyEIcjmEM+Zz3jZZ9VX7MfOxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gO3Gwf6b; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bioPkuVA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Mar 2026 15:58:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772636303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcEONRe9qJeZI31qG9ERdgCZQR8uEyuuevenX1qMEqk=;
	b=gO3Gwf6bGeo0jLEf11Gmc+tOAJa9T4XHFkQcEbXcoFwbqtQmIWhtd0qCFVKSDz/u3nyHlX
	lzUZkkrlImEp6AiytKunxIR2ixFN/CBEnndpLEYF20I3f5RWfCaKAMzHwA2hr78aIkUYoz
	6Jw+Y6md7kZtOolrjt9vDUjepwdmeniFPMm9VD7For/geIPdBbIRUtNIYhKR3IiZ8mC+H7
	fc879dU6HziKNekMS2cd6gGCVSU4c9F5IlPCCcnshE1RHLpzkcAjrNCPFi2w1QSG8nXJmg
	YGO5K/5i4eORW+8EPN91VZvMfOXW5CcsrMn31WpekU763T9jwAJs9Djp/DBKqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772636303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wcEONRe9qJeZI31qG9ERdgCZQR8uEyuuevenX1qMEqk=;
	b=bioPkuVAEkGHO7xnRAimonaXw0U9UVWV2n2RpWJ8K/QztLgLfTMzWS4LdfSk2Zjaa8jfQi
	1kdHm5K/iUCgIgBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Felix Maurer <fmaurer@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [PATCH RFC net-next 1/2] hsr: Allow to send a specific port and
 with HSR header
Message-ID: <20260304145821.TQhzhhjF@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
X-Rspamd-Queue-Id: CEC5D202833
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263847-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linutronix.de:dkim,linutronix.de:mid]
X-Rspamd-Action: no action

On 2026-02-04 12:30:47 [-0500], Willem de Bruijn wrote:
> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -605,6 +605,7 @@ struct skb_shared_info {
> >  	};
> >  	unsigned int	gso_type;
> >  	u32		tskey;
> > +	u32		hsr_ptp;
> 
> skb_shared_info cannot easily be expanded.
> 
> This is too specific a use-case to warrant fields in every packet.
> 
> I'm not super familiar with High-availability Seamless Redundancy
> (HSR). Perhaps you can use either an skb_extension. Or the skb->cb[]
> field if this data is only needed within the HSR protocol logic, so
> can be assured to not be overwritten by other users of the control
> block.

skb->cb does not work because I need share it between the HSR stack
and AF_PACKET so it gets overwritten (as it is no meant to be shared
between layers).
I need actually three bits: HAVE_HEADER and PORT_NUMBER which 0-2.
Would it work if I add a :1 and :2 member to struct sk_buff into the
header group after unreadable? In my config there is a 6bit + 1 byte
hole. Worst case (all ifdefs enabled) it sums to 30 bits so I would have
just 2 left. Exceeding it by one bit in this case would extend create a
7bit + 1 byte hole and shift shifts tc_index + alloc_cpu. However there
is a two byte hole between alloc_cpu before csum which is removed then.

Would it be okay if I occupy three bits in sk_buff which look unused?

Sebastian

