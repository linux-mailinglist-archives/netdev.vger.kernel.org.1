Return-Path: <netdev+bounces-263915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG3METJeqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:30:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 81BD82044A2
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9AA5F323B0EE
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D86834E74E;
	Wed,  4 Mar 2026 16:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jpe80b+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8qjQh9sq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A4634EEE6
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640780; cv=none; b=nobTP5tSSKDyYQ7OxhVZeDBf7yQjne7PTe9HAD7kMiM6223xETe6lWLVZgw9sCP2tCp7TEJKqXh6UV109U8mGtdPVj8NOstvSqfRelw+dUpPtrPyuzxNsfdRJGwzlm7OTU9sWv8hOR41IWJpUcuj/BDE5WEHx7bwJwLjgHaGOR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640780; c=relaxed/simple;
	bh=rsHp/hWLfBky2bod2rEdUSenhxUBDI4ThZQMxY0D/C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l59DyJzYbUW/uf3CFP6a+pe9Usvy0l/I7+NE0rqaqv6EBvm9DMxRByGfLXHG0epS7m/aebIb1diJ4nwQ4iwo4TVO2yLvIjzzydYCHP9jEYIMUE7enUU5hMUAH4s/LOtooe6Sqxtz0h1JDSxb/GV2b1nM5Y/V/jOlCmKZluyxem0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jpe80b+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8qjQh9sq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 4 Mar 2026 17:12:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772640777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PpzMbztFZA1/pZs42tjh+yx+ZIqVPB+IHx+8JNsO4w=;
	b=Jpe80b+V6sDOF0X/ozmuPLPpulzdbJ3DbND1u27RfYZXXeYSBeciPrJ+CD3pO1CA65SBUO
	2mNUMXYwP78EUM14bGQKOY0EqPQj+DVjJnWqCUtgRVBjaIzHoIrvpXNwVQDPoHar+dfNKP
	NdvNzMMGTDIC/C25/jea5/ldNtE4Ah/fN8YsW2GqRnw9EvFbcrSMK3QYa7IQy+O6rbHmXH
	bc3pH/gNqJBw6+wM4u09YF5uCDv4RFF6hrEDhq8OGAm7ZwznrfKsWWmC+3J2HvDOyVy3C2
	8WLFq37ulrDqQd0dPBMbYGDftHAM6ELj+nQccwPPQS2aUIIWJxnyJ9/lycufbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772640777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1PpzMbztFZA1/pZs42tjh+yx+ZIqVPB+IHx+8JNsO4w=;
	b=8qjQh9sqfspb+xhV0fibdRj79R85/ExvBHKP/VPvOYRNdAL2t/S1CCJQnMwxTZZ/KgcavU
	3f1G+Yf84cUA29Aw==
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
Message-ID: <20260304161255.VV_7vPBw@linutronix.de>
References: <20260204-hsr_ptp-v1-0-b421c69a77da@linutronix.de>
 <20260204-hsr_ptp-v1-1-b421c69a77da@linutronix.de>
 <willemdebruijn.kernel.2d4b5c08dd442@gmail.com>
 <20260304145821.TQhzhhjF@linutronix.de>
 <willemdebruijn.kernel.1d699189fce58@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.1d699189fce58@gmail.com>
X-Rspamd-Queue-Id: 81BD82044A2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263915-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 2026-03-04 10:56:16 [-0500], Willem de Bruijn wrote:
> Sebastian Andrzej Siewior wrote:
> > Would it be okay if I occupy three bits in sk_buff which look unused?
> 
> Have you looked into using skb_extensions?

Yes. I would have allocate memory via __skb_ext_alloc() and attach it to
the skb via __skb_ext_set(). That would on receive and while sending
(via af_packet).
Looking at the current allocations as of skb_ext_type_len, they all need
a bit of memory, the smallest is mctp_flow with just a pointer the other
are a fair amount larger. For the three bits, I was hoping to avoid it.

Sebastian

