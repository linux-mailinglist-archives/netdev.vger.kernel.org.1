Return-Path: <netdev+bounces-300289-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yVSdEjBJM2pQ/AUAu9opvQ
	(envelope-from <netdev+bounces-300289-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:26:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3722469D006
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 03:26:07 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=edji6ohfindvvaar3ohyzfy2dy.protonmail header.b=YeUMjgq5;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300289-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300289-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47708301D521
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 01:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27D9253B73;
	Thu, 18 Jun 2026 01:26:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-08.mail-europe.com (mail-08.mail-europe.com [57.129.93.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A340527A123;
	Thu, 18 Jun 2026 01:25:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781745960; cv=none; b=Ud9OzcBIoRMty9BNFim+OR3Z3dTtxUzoKoZ8Lw0uRK9mjyxZ7QS5kFjuPZqbjA+vqM5bpv44j3wXlfXouL5nXwEzF5D2ZV3mZPDO/lu4HfiuKag1AE1vQKXy7ePFSua8enS8Ta5OZI6rns+Z6h/LOPFgrEZLyqImBp/A+G0fR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781745960; c=relaxed/simple;
	bh=O7p1A7X5x41GXGfzPlhDFe+3UIbQXqLuJwmu7r/FXcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r3iTQb74IQ0ShYHSJ3c/e9qVfdxcARKox/74VYLxDvZLq0tpEF4OHQpQac60R1qQ1Nvpi9eYq5nOke39nTHQkiD57AZsvQIN5ihPqdQJqBvAOg2LGAHjYrREsJ7izi7tJM90Fi9UTJAGzFEaCnRfunWcLLlshucCpnsYYkhU520=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YeUMjgq5; arc=none smtp.client-ip=57.129.93.249
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=edji6ohfindvvaar3ohyzfy2dy.protonmail; t=1781745941; x=1782005141;
	bh=O7p1A7X5x41GXGfzPlhDFe+3UIbQXqLuJwmu7r/FXcw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=YeUMjgq5RCVdTetuI5yb34xTm4SMkHOuDClbFAfs5Ia6sDybWU4ryD+E3fJfzyyzs
	 IvMClPTp/YWHfFU5HTpTVf/3jQKYWRwaiTLsEBdmZW7B/UVqm44mJLznK4LqYm5wLm
	 KTq3KpaOk1F2d5bHhXZBzowUcbN1XKo1k4YsZqFvyD+Nm+QtXsG8E6NvbBnRiG79WL
	 AgvC8HDQa8bbquptr+yIj7f4RWbjWioZg/Kdi2L2ZA+o+G5736Ee6iCGRKO8s2iKQ4
	 TIxSV2Mv7SU6q59mBtbNbA0PLtJJCZgsRBW/tSW6Y0yjIUSFSKmcMbanyyJeM8xWk3
	 lQ3cFAKuVSKtw==
Date: Thu, 18 Jun 2026 01:25:33 +0000
To: Matthieu Buffet <matthieu@buffet.re>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260618012527.34964-1-hexlabsecurity@proton.me>
In-Reply-To: <20260617180526.15627-2-matthieu@buffet.re>
References: <20260617.eemahv8ui7Ee@digikod.net> <20260617180526.15627-1-matthieu@buffet.re> <20260617180526.15627-2-matthieu@buffet.re>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: 578dcb4dea7ac936c800840fb4f141f9fbb80230
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[proton.me,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=edji6ohfindvvaar3ohyzfy2dy.protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300289-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:matthieu@buffet.re,m:mic@digikod.net,m:gnoack@google.com,m:ivanov.mikhail1@huawei-partners.com,m:paul@paul-moore.com,m:edumazet@google.com,m:ncardwell@google.com,m:linux-security-module@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hexlabsecurity@proton.me,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[proton.me:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,proton.me:dkim,proton.me:email,proton.me:mid,proton.me:from_mime,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3722469D006

Thanks Matthieu, your #41, so no competing patch from me. I built your v0
(Landlock + MPTCP) and ran an A/B: without it, a confined task with CONNECT=
_TCP
denied still reaches the port via sendto(MSG_FASTOPEN); with it, that path =
is now
denied too, on IPv4 and IPv6.

Tested-by: Bryam Vargas <hexlabsecurity@proton.me>

One scope note, since you mention MPTCP: an MPTCP socket isn't covered.
sk_is_tcp() is false for the mptcp parent (sk_protocol is IPPROTO_MPTCP), s=
o
neither the new sendmsg hook nor the existing socket_connect one mediates i=
t. On
the patched kernel my MPTCP arm still reaches the blocked port via both con=
nect()
and MSG_FASTOPEN. If MPTCP is meant to be in scope for CONNECT_TCP, the gua=
rd
wants `|| sk->sk_protocol =3D=3D IPPROTO_MPTCP` (not sk_is_mptcp(), which i=
s the
subflow flag).

Bryam


