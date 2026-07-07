Return-Path: <netdev+bounces-305424-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id aKMrHmLnTGpKrwEAu9opvQ
	(envelope-from <netdev+bounces-305424-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:47:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E102571B17B
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 13:47:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=KfLafiFe;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=fLyrryiW;
	dmarc=pass (policy=none) header.from=linutronix.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305424-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-305424-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 706C5303C4CA
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 11:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379F83FAE1F;
	Tue,  7 Jul 2026 11:42:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B48B33FA5D5;
	Tue,  7 Jul 2026 11:42:29 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424551; cv=none; b=Yn3eCpc+rjSYku9BQphUyewLYHbQhvt/JHDOStA/5TF1i2VMb1kAN2pl5c9w9hh5tXTqe9f7QSq8r6Q89k7QzkB2X+N/UrfUyRokjOx5Xym0C7YeGhMPxAlXnbonmc4bqcu5JQLKHhfLE3FhfKXB2isp0y1Tc/qkizqh/0Mapk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424551; c=relaxed/simple;
	bh=4glglTyW3qyL7O1yhIb1nwsOJbb7BW/7rcrYVxnBEo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DU/Ui1k8JVAuk7omFlTueWw9CZvZF7A3nfL2Vb8kRWBza8lGAAufTiLS1Qbvw7WMoD79auZALNqY/HEIH7BTIWoIZrHywyIIsdUqNq4E/yV8H0SiT0d+T/oxPUrIVK3SnHXgeZlE5hto1d3/VRwpP/PNI5IfCo78DRU6ycXdLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KfLafiFe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fLyrryiW; arc=none smtp.client-ip=193.142.43.55
Date: Tue, 7 Jul 2026 13:42:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783424547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4glglTyW3qyL7O1yhIb1nwsOJbb7BW/7rcrYVxnBEo4=;
	b=KfLafiFeXkQkwS+mYl0a44pW9V/TYpLzuFZgHVdtCJK9wt2Fi1jv8K16Z5sYwlxjozEC9q
	3ig9PuN8HExa4m34WHw/PVzD7Qsjl0ADVDW+pDC6Qw3DPFurO28lbcZyS5spm+VxL6eW5c
	jAHE5kIxw0L7KghSsq+7rbHiYyUkyLuJ/tabwlTCer/ce2srRyu/ga1vqGh0+d/ZhzQRQw
	44iuWgKOgYb6yOWpib63UAZlou9C7HcyBIX5I4cUnwMHJ1OPOH+47tZxE9Z2bwUj/SoOcK
	+qbB2jHD9qnD9DF+0/RV+GfrKXIXyezWIa/W/3AT6Wxe02EYJkEjQpgNfXNaBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783424547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4glglTyW3qyL7O1yhIb1nwsOJbb7BW/7rcrYVxnBEo4=;
	b=fLyrryiWQsCyIVEl/rHvA7nvOrlW7+A2P2WVJzEwQdQkWX9O8VXdOIq8tpQDWkK/qNW2fZ
	c0PTEMKeqKXELSBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Nam Cao <namcao@linutronix.de>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, sashiko-reviews@lists.linux.dev,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH 1/2] af_unix: Do not wait for garbage collector in
 sendmsg()
Message-ID: <20260707114225.4oj9SF_0@linutronix.de>
References: <cover.1782922354.git.namcao@linutronix.de>
 <e663a83195f3d9f6d7ad4907c37ae3e45c151062.1782922354.git.namcao@linutronix.de>
 <20260702163608.0207A1F00A3A@smtp.kernel.org>
 <87mrw8sjo3.fsf@yellow.woof>
 <CAAVpQUB+LDxRrF66=NKwLAdLN8kt+Hssm_KBc2oc_q6FTJF0VA@mail.gmail.com>
 <87wlvbmgtv.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87wlvbmgtv.fsf@yellow.woof>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305424-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:namcao@linutronix.de,m:kuniyu@google.com,m:sashiko-reviews@lists.linux.dev,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E102571B17B

On 2026-07-04 08:03:56 [+0200], Nam Cao wrote:
> Kuniyuki Iwashima <kuniyu@google.com> writes:
> > your patch makes it much easier to abuse.
> > UNIX_INFLIGHT_SANE_USER is usually much smaller than
> > RLIMIT_NOFILE.
> >
> > unix_schedule_gc() in sendmsg() is to self-regulate malicious users,
> > otherwise GC relies on unrelated AF_UNIX socket's close() and could
> > be triggered too late since GC is system-wide.
>=20
> About the abuse, the scenario where inflight sockets bypass
> UNIX_INFLIGHT_SANE_USER and delay GC until an unrelated AF_UNIX socket
> closes actually exists today.

We don't bypass the limit for an ordinary user. That one gets blocked in
too_many_unix_fds(). But for the CAP_SYS_RESOURCE + CAP_SYS_ADMIN it is
a different story.
In that case we cross the UNIX_INFLIGHT_SANE_USER and schedule the GC,
it is not delayed. The worker is triggered regularity and the thread
waits for its completion it is just the GC worker does not clean up
anything so it continues to increase. The only thing that actually
limits the sender is if it runs out of socket memory and needs to wait.
So it kind of works for a single thread.

=E2=80=A6
> To address this properly, we can schedule the GC at task exit. I can
> include that patch in my series, if that sounds good to you.

task exit or closing the socket?
Either way, in your PoC it hardly makes any sense to schedule the worker
over and over and wait for it since it does not do anything. Sure it is
the system as a whole so triggering might make sense but I'm not sure
about waiting for its completion.

Side note: gc_in_progress is redundant since you can't schedule a worker
twice and work_pending(&unix_gc_work) would provide the same
information. The only difference is that you avoid scheduling the worker
while it is running but I don't think this is a problem.

> Nam

Sebastian

