Return-Path: <netdev+bounces-256268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLJdHtbmgWl0LwMAu9opvQ
	(envelope-from <netdev+bounces-256268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:15:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A010AD8DED
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1E77530F3932
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:09:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DE4433DEC9;
	Tue,  3 Feb 2026 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHtjoUFh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlOLPP0q"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4482B3382F0
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 12:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770120574; cv=none; b=J9nLqnSCIVYXvo0bMw8Q3xPbK9/HcQt5jxnnnbugSpzcFw4WbGzBB0JMnlXcbus8I8uREPs51xCUNmZOOzVns0Mu6o8YwM3/GEmm3hfB0UzFXcZSViX4iOoCLBxu32l/4sg4bit5SJDH+PDmUU5QcNmX7ceCUCD1bmMbkxI9gKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770120574; c=relaxed/simple;
	bh=o9WdklMmUjU6rzAt1Lr+DDa0Tn56ukclRhC4gKXEbIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPtciW1cGRERAAfIFaAD08N9lwczFgBfsJL6TJK9wQlNfK2GFYfr0Rff49SzkHlLfiRwKjzJB28GwHsu9g24wCgJZMNmkinUL6VPrygGZVkRqP25yyJnDsaiGzwLPs6KC06PYDcGNfSpXJv2cKOUFtw3JmtUAvyE1h60n1W5uk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHtjoUFh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlOLPP0q; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 3 Feb 2026 13:09:30 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770120571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8wiLi93h7s5nrhIswwZYAfTTdER68dWwImPGQeIWAU=;
	b=jHtjoUFhfRmZAJSEpHEMFw7lEGy+1McDWLnRRqzVIEI6OrRzX5tLg01pubX7I/Hw+j1ZUi
	hLY0QI8DKEiEua/A/JbgzaCFIiazzis0KcRWc1v/iyP/qftMHIDlkoOzZ12CpKA32fnshA
	k5bZZMH6fubtUsHaHm0feDAgh5BCXZahpj65oBx4dj6EmoXqLFx3yDoEUyOHQSU/ReCAhh
	3VEOClsaFNt7ntOMGRT+cX9m85HjtC4S6/FJjwITLUil898TF+eDS6MoDshpuDi2WO+dKE
	ld4Z7MKsPJuH8UVga4uoQ2K51Rt+n++YmCQaN6JG7qFpQhwYEeka3oyzIwE3Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770120571;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=o8wiLi93h7s5nrhIswwZYAfTTdER68dWwImPGQeIWAU=;
	b=AlOLPP0qaWbhjKN77AjJ21+JTFa5LppiZI1veMMefptE770NBl9ldgZ5s9tXoWoEqTpCes
	/NfkSPCqAZf0sQCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Felix Maurer <fmaurer@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
	jkarrenpalo@gmail.com, tglx@linutronix.de, mingo@kernel.org,
	allison.henderson@oracle.com, petrm@nvidia.com, antonio@openvpn.net,
	Yoann Congal <yoann.congal@smile.fr>
Subject: Re: [PATCH net-next v2 6/9] hsr: Implement more robust duplicate
 discard for HSR
Message-ID: <20260203120930.JjaLfGMy@linutronix.de>
References: <cover.1769093335.git.fmaurer@redhat.com>
 <07b90a435ed7d3450c1949e3a21910916d8538de.1769093335.git.fmaurer@redhat.com>
 <20260129144348.CIs44m-d@linutronix.de>
 <aXuIAFJ_m6gMUFFO@thinkpad>
 <20260202171123.LkzpiAMv@linutronix.de>
 <aYHXN1RvUoX6TGXM@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aYHXN1RvUoX6TGXM@thinkpad>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256268-lists,netdev=lfdr.de];
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
X-Rspamd-Queue-Id: A010AD8DED
X-Rspamd-Action: no action

On 2026-02-03 12:08:39 [+0100], Felix Maurer wrote:
> > I would get rid of it. There the "official" DECLARE_BITMAP(). If this
> > doesn't work just open code it avoiding the macro.
> 
> Alright, I did that in the v3 [1] I sent yesterday. Sorry for not
> waiting with that until the end of every discussion. I understood your
> reply to 0/9 as a "go" for sending a new version addressing the small
> issues (without touching the A/B tracking).

Don't worry, I planned to reply earlier but didn't manage. Hope to
continue today with your v3.

> Thanks,
>    Felix

Sebastian

