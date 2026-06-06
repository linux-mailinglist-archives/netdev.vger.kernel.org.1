Return-Path: <netdev+bounces-296031-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M0kHGRKDI2ppuwEAu9opvQ
	(envelope-from <netdev+bounces-296031-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:16:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C142964C34C
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 04:16:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=TU08cqTE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296031-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296031-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5388A30154BF
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 02:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22472566F7;
	Sat,  6 Jun 2026 02:16:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E7E218845
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 02:16:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780712185; cv=none; b=QJqTceQYrH2I2QQvE88Ncm0Th9rdCRw4oa6dSRnWuEPnJhdxgLiCQAQbNmRRH3mKXNM4/Oq48aGzNEGIPKN/4TtJEBn/3ytVDzaH64oXZ5l+iQAAcW/t02wUh7W40TM/q76sIN32BKkyHzZ1mU1xMto8Y/iOzNhstEqnbyJoRk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780712185; c=relaxed/simple;
	bh=EXpPvVhvO3srh5GbHRveHQxvFa1MgTtnfaRQPVy3fME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WnuG7UoerAi9XC3Ozv5Sda88pRUiLa8scjTE1W9Ns8ZKqFCTD4KRYkuos+eTjrrPN9H1RwG9aqKGkoSEEdw3ddI5RTboGmVA6G/DYshDX6+AdejWs7IWgCtKJ1BrpGjOzIm7iY/9YN7eAJcsQlRk55Qxi2wEfaMRHYffdqIPId0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TU08cqTE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4A51F00893;
	Sat,  6 Jun 2026 02:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780712184;
	bh=0dSmYx/stJatlZe4sWmdbEc/TJ2dGZOT2yA1DONA9fE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=TU08cqTEV+pIdvhDyim0lbPqiC1Z7Hd4bvqTCTJ0jFy0u8RCdqEKvSrJl4L4dz+1N
	 8JkheMCwgZdYyLUJFKCVx5X6Dcn6yhsSBVBwKHfM+kQFOXBboQVJFAXulU7Yg6smw4
	 t2jpGkX731V9XrspcwhcITYQu7uuxFUWnZLzsnTyJIcSgaRuKG2VNqkMMy2uT/Bbgz
	 X0mB84K5ZUA2a95sGYK8/c2vxKb6uF7mY6bevqXaBPEJHz8ph35GIrXc/aZUgBY6xd
	 ucf3DU00Gf2pRC3OtaKn5m63UXWIQxlTpAa+4azTgUJ9CZyPwWUew/eV2uLtJLyI3W
	 ujPAE00xW2IDw==
Date: Fri, 5 Jun 2026 19:16:22 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Wang <weibunny.kernel@gmail.com>
Cc: netdev@vger.kernel.org, Daniel Zahka <daniel.zahka@gmail.com>, Willem de
 Bruijn <willemdebruijn.kernel@gmail.com>, David Wei <dw@davidwei.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Wei Wang
 <weibunny@fb.com>
Subject: Re: [PATCH v15 net-next 00/11] psp: Add support for
 dev-assoc/disassoc
Message-ID: <20260605191622.72699c06@kernel.org>
In-Reply-To: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
References: <20260603235947.2986110-1-weibunny.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-296031-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:weibunny.kernel@gmail.com,m:netdev@vger.kernel.org,m:daniel.zahka@gmail.com,m:willemdebruijn.kernel@gmail.com,m:dw@davidwei.uk,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:weibunny@fb.com,m:weibunnykernel@gmail.com,m:danielzahka@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,fb.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C142964C34C

On Wed,  3 Jun 2026 16:59:29 -0700 Wei Wang wrote:
> Subject: [PATCH v15 net-next 00/11] psp: Add support for dev-assoc/disassoc

Applying: psp: add admin/non-admin version of psp_device_get_locked
Applying: psp: add new netlink cmd for dev-assoc and dev-disassoc
Applying: psp: add a new netdev event for dev unregister
Applying: selftests/net: psp: refactor test builders to use ksft_variants
Applying: selftests/net: add _find_bpf_obj() to search hw/ for BPF objects
Applying: selftests/net: rename _nk_host_ifname to nk_host_ifname
error: patch failed: tools/testing/selftests/drivers/net/lib/py/env.py:339
error: tools/testing/selftests/drivers/net/lib/py/env.py: patch does not apply
Patch failed at 0006 selftests/net: rename _nk_host_ifname to nk_host_ifname

:(

