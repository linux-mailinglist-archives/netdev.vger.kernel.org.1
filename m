Return-Path: <netdev+bounces-280912-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF4ZAl3M6mk9DwAAu9opvQ
	(envelope-from <netdev+bounces-280912-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:50:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BF4458EB3
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 03:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7363011844
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 01:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE0331A238F;
	Fri, 24 Apr 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eodu5Kzw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9964C29408;
	Fri, 24 Apr 2026 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776995416; cv=none; b=gQq/s4i/WboDph5weIH92r9yyRep/b9gpXNJ9yIXuwDybAmOGbuYDkCCE+Xtph9KBtwqvlckMDNJZNstazk/9oiv693piPASedRkGxPKMU6uDdPrwDl2aC5VobS6uDsbvTbSdsCn/RjmP+ULPmfISymIdiklRwxCPOtCb3lnGuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776995416; c=relaxed/simple;
	bh=NqQJUWg6MeJhp2hZx7RFEH6fe4/+NDf4XYr3D6rCkys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Zd7xx8Vs6DfM/NLv+gCWFl0MMYS1v9yUFxO2/vtagMO/ZxGIQRJ1ERBrfUTWAwqc9FxulhkITNO8My1PC05cxMvZrykrs9qihM1Ks8AN8qnXcsya1cEGH0U+T8HHtzIoijt443NqC0EoLdnFuU3cVKEm9f0QWib7JJLX29rxwyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eodu5Kzw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E8BC2BCAF;
	Fri, 24 Apr 2026 01:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776995416;
	bh=NqQJUWg6MeJhp2hZx7RFEH6fe4/+NDf4XYr3D6rCkys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eodu5KzwC1ajS+t41D1oAPQqSV0y+uVt2qX8clcBM1dQ/aa3NDyQVqeo1n1StgRwK
	 wfmmQyub+BK8F3eul+fOV7UUahSmx3+55q2ZErVAd7vlnFZspmEsfA7PGV8OUkBQMi
	 DwyMPDHJQZgowszbPMoU+GHMPnYeeLyqnEM9nUWBlp8DysI4ZXSf4LWY/9Uo97HMrx
	 K+quHtcAGJbwm/md3mmQ8wO03UySAzx6NcqNvfHyMBI82p09Dv1SV5V5M5zJIlEyr0
	 SUxp3m2vt58OfYyO/Gkuac33c9kwX+k0gXKKq6pfA4vpsFsvKg2ZBkdwGyitm8uQJb
	 yCSUoZfkRDXtA==
Date: Thu, 23 Apr 2026 18:50:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Kees Cook
 <kees@kernel.org>, Feng Yang <yangfeng@kylinos.cn>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] netlink: clean up failed initial dump-start
 state
Message-ID: <20260423185014.08269f73@kernel.org>
In-Reply-To: <20260423212827.1177552-1-michael.bommarito@gmail.com>
References: <20260420162734.854587-1-michael.bommarito@gmail.com>
	<20260423212827.1177552-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 62BF4458EB3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280912-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Thu, 23 Apr 2026 17:28:27 -0400 Michael Bommarito wrote:
> __netlink_dump_start() installs cb->skb, takes the module reference,
> and sets cb_running before calling netlink_dump(sk, true). If that
> first call returns via errout_skb the callback state is left behind:
> cb_running stays set, module_put() and consume_skb(cb->skb) are
> deferred until recvmsg() drives the dump back through the success
> path, or netlink_release() on close runs the catch-all cleanup. On
> sustained alloc failure neither fires.
> 
> Factor the teardown into netlink_dump_cleanup(nlk, drop) shared by
> the dump success path, the lock_taken=true errout_skb path, and
> netlink_release(). The @drop flag preserves the existing split:
> consume_skb() on normal completion, kfree_skb() on abort.
> 
> Validation on a UML guest: an unprivileged task opens NETLINK_ROUTE,
> preloads sk_rmem_alloc, then issues RTM_GETLINK | NLM_F_DUMP. Stock
> kernel leaves cb_running stuck at 1 until recvmsg() or close()
> drives it. Patched kernel clears cb_running immediately on the
> lock_taken=true failure; the recvmsg continuation path is unchanged.
> 
> At scale: 3500 wedged sockets in a 256M guest show about 3.8-3.9
> MiB of extra unreclaimable slab (~1.1 KiB/sock) on stock vs zero on
> patched. RLIMIT_NOFILE bounds the test before OOM, so this is a
> local availability cleanup rather than an exhaustion primitive.
> 
> Fixes: 16b304f3404f ("netlink: Eliminate kmalloc in netlink dump operation.")

Looks like this changes existing behavior :( 
The tools/testing/selftests/net/netlink-dumps.c test used to always 
see a NLMSG_DONE now it doesn't. Maybe this change is more risk
than reward?

process nit: please don't post new versions in reply to previous

