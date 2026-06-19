Return-Path: <netdev+bounces-300580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wzivFdCdNGrjcwYAu9opvQ
	(envelope-from <netdev+bounces-300580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:39:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E50936A3907
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 03:39:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=proton.me header.s=protonmail header.b=iA3yi0IO;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300580-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-300580-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=proton.me;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26CCC30247C6
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 01:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1BE232B12A;
	Fri, 19 Jun 2026 01:39:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E996D31195B;
	Fri, 19 Jun 2026 01:39:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781833162; cv=none; b=BxtPiahBEAJQyM6wVlZafIHuy/liSzQ5Nfit6M06m2nO3nlhw8ZoD+pylA5qtc/tg97Ywe9QnTT65XBy8B38bbwNbB9sF7W/2GzMeMULPAPe2TLMXfAtyM0TWqKNrXWm/0gFQ+IkKFveQeXPV4G2Y77H8Cw7/K8+fetY8sc69D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781833162; c=relaxed/simple;
	bh=skH6q7yCeGepBg9gyZSMv38ZtnJ0sf0vdmglUYutVYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWyhW/lBtSSy0jw05aEf1GfM6M6vDEKEXbAlt8VBBdLfnoHK/v0tqInDqdCxczlkPfbLpcnmK+Keo0lfS75TgOgOY94cYcrKm3Y1Zn6VrQBurRzwoIdT+bOHUtzsWoXW0XbBnCcsNf0zj98gW1yNjkaf1LfFOk0j29LQvMVdrN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iA3yi0IO; arc=none smtp.client-ip=185.70.43.16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1781833154; x=1782092354;
	bh=skH6q7yCeGepBg9gyZSMv38ZtnJ0sf0vdmglUYutVYE=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=iA3yi0IOkhP97/Pz5ak8rkphboA9M/L+pE0ikni68OQy7jY9XFXvm7A90VighqsEP
	 HluxMnfpPf/l9MxeCbxCCZDu7AV4PSkoPhEnaUjdPeCLq+eKasL00ajm5zmgoz/faT
	 x0rvBjVumxGA4UDTF/lcSGnCHuAv6GhwcZFI5j8p4f/4gtqZ1nq77/w/TSxwIRs5Fx
	 G3m14vNCTx9XLFmXqM4dqni5YB28R/q5E0aOq+sE5b52aW2tABDCGttgT3LhDaiSn2
	 2EuLsDkJLANL1zd4t0wyrJA4WAd6z3e6BS4uclEgzJI33cuO2LebP8CUj3kkey9bjy
	 /8cXB9HmDqL7A==
Date: Fri, 19 Jun 2026 01:39:06 +0000
To: Matthieu Buffet <matthieu@buffet.re>
From: Bryam Vargas <hexlabsecurity@proton.me>
Cc: =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>, =?utf-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>, Mikhail Ivanov <ivanov.mikhail1@huawei-partners.com>, Paul Moore <paul@paul-moore.com>, Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, linux-security-module@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] landlock: fix TCP Fast Open connection bypass
Message-ID: <20260619013859.268003-1-hexlabsecurity@proton.me>
In-Reply-To: <e0c7b502-931e-481e-89b0-b47687d2b942@buffet.re>
References: <20260617.eemahv8ui7Ee@digikod.net> <20260617180526.15627-1-matthieu@buffet.re> <20260617180526.15627-2-matthieu@buffet.re> <20260618012527.34964-1-hexlabsecurity@proton.me> <e0c7b502-931e-481e-89b0-b47687d2b942@buffet.re>
Feedback-ID: 199661219:user:proton
X-Pm-Message-ID: d067cc83d865a57a151b8a1931ba2fd51c9e9e2a
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[proton.me:s=protonmail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-300580-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,proton.me:dkim,proton.me:mid,proton.me:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E50936A3907

Thanks, that settles it: MPTCP is out of scope by design, not a gap.

I read 854277e2cc8c ("landlock: Fix non-TCP sockets restriction"). It
changed the sock->type !=3D SOCK_STREAM test to !sk_is_tcp(sock->sk),
dropping SMC/MPTCP/SCTP from the TCP rights on purpose, and 3d4033985ff5
pins that with a "MPTCP actions are not restricted" selftest. So my
"|| sk_protocol =3D=3D IPPROTO_MPTCP" suggestion was wrong: it would revert
that decision and break the selftest. Please disregard it.

That leaves the series complete as-is on this axis. Keeping both the v0
guard and the 2/2 selftest sk_is_tcp()-only is correct, and the
Tested-by stands for the TCP and IPv6 fast-open path the patch fixes.

Bryam


