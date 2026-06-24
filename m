Return-Path: <netdev+bounces-301596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Q5yFAxanO2pwawgAu9opvQ
	(envelope-from <netdev+bounces-301596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:44:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7CD6BD0A1
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 11:44:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linutronix.de header.s=2020 header.b=0iS0Cxrx;
	dkim=pass header.d=linutronix.de header.s=2020e header.b=8CBA0aa0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301596-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linutronix.de;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BB6D310784C
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 09:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80956233949;
	Wed, 24 Jun 2026 09:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4330E23815B;
	Wed, 24 Jun 2026 09:39:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782293964; cv=none; b=g3RjpqPP5rUdn8pswqXhYKmIM6iVG6SXOuauSwmFxDWUA7gAAGQrKxzIju4uuOfDtJj1gOn1rpP0T4pMVF3yCPRjTiAOceYvc/bDPyrbpJQ7RlDITRmII9j6ZMKODpH1DgR8TYOcq8rx4HwyBuitxQfu8ZvPVzNGUIy8fTLeUEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782293964; c=relaxed/simple;
	bh=vOTvwVulRxzYt4pJiWJT8uuVRGIL0GjAtpSv1uilZX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b2elrKTMu7JOWnZuIbprUOtMFZ1hE8KVHwwG0M0wpzyFmTpDqxuDsvNhooqrIM5QwtcCLTK7mCJsTAYseQd8ddOPg8bDr/tuMs2XwbRBj3L42shMMXO6Hw4l5UBa0YK1PSi0e0tORE2W/3CizbKGMU+59UCqWAQT7n3buUxq8UM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0iS0Cxrx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8CBA0aa0; arc=none smtp.client-ip=193.142.43.55
Date: Wed, 24 Jun 2026 11:39:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1782293961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOTvwVulRxzYt4pJiWJT8uuVRGIL0GjAtpSv1uilZX0=;
	b=0iS0CxrxVody7d4GXpG9RD6hlS1cHCPhfdk1bFx35M+hb9YLRQvBx4LyGDXQB+OiGHACvP
	4xZe+INU8cHsqw+DtTj6VqtHJzTNAQLvp5U7Fxpyy4369S7Rz7OxUAMQaTiLf6jyJumbe3
	V9cW8RCuTcYhcoBJPPSyKFLSVdvLpOz3rTx04yLxvvidqajTGTJWOxq/tDx+cy7IaR8Nwr
	/Er7auypB/acWL+aG++aKtZLFtzUskiCbEDBpQvv2FqD/PzXO/ul9G/qXyd1p4Ub5BrqhT
	vBGPglf1bXi7QueFLrIseei2oSUUHMtOlYqae+jDOG1qr/7LdBX7mKItquDnAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1782293961;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vOTvwVulRxzYt4pJiWJT8uuVRGIL0GjAtpSv1uilZX0=;
	b=8CBA0aa05Lqy0+IoShQgIyYD0FNeW7MyCbPtnaZo0/ZHtb4iCJZWWAwnZ0PmkUhhZwECx8
	h3AIftttXxXXeJBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Yun Zhou <yun.zhou@windriver.com>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	clrkwllms@kernel.org, rostedt@goodmis.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v4] net: mvneta: re-enable percpu interrupt on resume
Message-ID: <20260624093920.qvtBsCMJ@linutronix.de>
References: <20260622074350.1666290-1-yun.zhou@windriver.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260622074350.1666290-1-yun.zhou@windriver.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301596-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:yun.zhou@windriver.com,m:marcin.s.wojtas@gmail.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:clrkwllms@kernel.org,m:rostedt@goodmis.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-rt-devel@lists.linux.dev,m:marcinswojtas@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,goodmis.org,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bigeasy@linutronix.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,linutronix.de:email,linutronix.de:mid,linutronix.de:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,windriver.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4B7CD6BD0A1

On 2026-06-22 15:43:50 [+0800], Yun Zhou wrote:
> On Marvell MPIC platforms (Armada 370/XP/38x), mvneta uses a percpu
=E2=80=A6
> Fix by calling on_each_cpu(mvneta_percpu_enable) in the resume path
> to unconditionally unmask the MPIC per-CPU interrupt regardless of
> pre-suspend state.
>=20
> Fixes: 12bb03b436da ("net: mvneta: Handle per-cpu interrupts")
> Signed-off-by: Yun Zhou <yun.zhou@windriver.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Sebastian

