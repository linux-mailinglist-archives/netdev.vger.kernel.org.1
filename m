Return-Path: <netdev+bounces-255972-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8I4jA2XmgGleCAMAu9opvQ
	(envelope-from <netdev+bounces-255972-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:01:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CCF7CFDFC
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:01:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E07300C916
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 17:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2241389458;
	Mon,  2 Feb 2026 17:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R/qUZXeo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ax3CJWmc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B77C38944C
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 17:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770054796; cv=none; b=gkQKr388y4Z+2ms4006p43Vz0zkmXFWl/iA9Bksevnj3rLNnuWewdeaPwsIKtYQtpLs0rkGNE4+5jyy1TQca1G+wrKtWCK6qpinsQ59WI0X0jJXWdqb7e1cnCDRCP5DDxHmlBIYDaLJ7beaLYlbfPnhYWe+NemLfo0vBNrKGiHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770054796; c=relaxed/simple;
	bh=ZUCB+LpycsZKHXVaQiVA5dvSCiWqPUge+/Ph4dvFeGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hf2di/e/cir3KG3G4qw6TZS4JPrEzQc+JPkZB1CepBhE3HCid874dlLpicNkfBlY7nARAFKvn3dHNuXh3jjbQcG+q9nuXqIzHXSeyOZOSEANGK6YZ9WJZIY7xp/9ZXqy8r9wv2wVhI2Ht5bzn/4/sQfAmSyUWF9FDB17IwKgfDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R/qUZXeo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ax3CJWmc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 2 Feb 2026 18:53:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770054793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsYaxiJ7pUInLkmjViQvaY++X9xDIRfk/eCBPZD4ZkU=;
	b=R/qUZXeoqoTOV2eyV52ZXzivpa1II6UFbbq1ifMmKsP10zOySKMUT//VDAJ0RgkQmghOfa
	zQBbUBvI8EnY+Gk4WsX5s5RniqtL5JwHnj+2a7j58Hhp/UVvu7WkSq+j8g50tNqRbamO4J
	PVOXk6fAzcIMKhQIfwpWIot80GlIfy2v6mnUmDYdlvi1uBMq7uwpH8yj6HVILzHhfALe5i
	9jJk2sOak3M77iLlR/h29IW/nMYQrTD3bMKnJM2A5B0J/Di0U6PREg+nfcww4D0njpUarJ
	Wshrvqwwn/nk9df4ul33/O/xaj7ZWNWvLXgmUjQCgsbdL4yBWyYBWLCAWw7AwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770054793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XsYaxiJ7pUInLkmjViQvaY++X9xDIRfk/eCBPZD4ZkU=;
	b=Ax3CJWmcXhqnIAjyxNgYz5A70ujx1iLTnmKTcGaio/bv5q/QJDui6Z6dnSyxcAKEmHFg62
	D6hINZeA3Pd8YhCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <20260202175311.m2Qu8pEp@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
 <aXugXpSajp6jzG1o@thinkpad>
 <aXyJTzwJ3x34B-xR@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXyJTzwJ3x34B-xR@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255972-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:mid,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CCF7CFDFC
X-Rspamd-Action: no action

On 2026-01-30 11:34:55 [+0100], Felix Maurer wrote:
> I took another look at this. I think the IEC 62439-3:2021 is not super
> clear on this (it often refers to "duplicate frames" without being exact
> about in which domain they are duplicates). But the section on HSR Modes
> (5.3.2.1) is quite telling when all modes are read in combination.
> 
> First, there is the mode H, which is the default and mandatory to
> implement. In this mode, a node should forward all frames "except for
> frames sent by the node itself, duplicate frames and frames for which
> the node is the unique destination". Note that "duplicate frame" is not
> further specified here. As we don't implement different modes, we should
> follow mode H in our implementation.
> 
> In contrast, there is also mode X (sometimes referred to as "traffic
> reduction").  It is supposed to work like mode H, but without sending
> "counter-duplicates", i.e., frames that are "a duplicate of a frame that
> it received [...] from the opposite direction."
> 
> To me, this means two things for mode H, i.e., what we should be doing:
> - For a frame with one sequence number coming from one node, we should
>   be forwarding the frame once in each direction.
> - There could be duplicates of these frames in either direction that we
>   should not forward. This is also hinted at in other parts of the
>   standard, that there could be multiple duplicates, especially when HSR
>   rings are coupled.
> 
> Therefore, I think it is correct to do the duplicate tracking once for
> each port, especially separately for port A and port B.

I will not argue with you here.
But. :)
If you track duplicates for A and B and see a duplicate on port A then
this indicates that the sender of this packet did not remove it from the
ring once it received it back. This looks like a failure.
If you track duplicates for A and B in a single "bitmap" then this would
mode X.

I nag here a bit because you allocate 16 + (128 / 8) * 4 * 64 = 4112
bytes for this bitmap per node. That is a bit over 4kib. Then adding and
removing sequences got a bit more expensive. Anyway. There is table
F.19+ specifying HSR tests and don't find "forwarding duplicate over
port A". So lets keep it.

> Thanks,
>    Felix

Sebastian

