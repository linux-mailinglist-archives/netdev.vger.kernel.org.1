Return-Path: <netdev+bounces-279434-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sESGDAOo4mnW8gAAu9opvQ
	(envelope-from <netdev+bounces-279434-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:37:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CCA41EBCD
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B74023056274
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 283D537CD24;
	Fri, 17 Apr 2026 21:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B2pzULT5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A12B3446AF
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 21:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776461818; cv=pass; b=OnsTZRiSeV8Mcdlp7thCECQWWeJ2DLBB5s9CzRqW65tdn/NApAN2tgXyzqr5ORX3kIXiPj0l4YTqfo+DT6cyL8l5SYHo6oVgzS00AL0GVZdq/VAZGkwsL14xQZT/10PcdozVt/RZztchUI9We5UMgxsG2b8FQbcc2AEjpHvMGqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776461818; c=relaxed/simple;
	bh=ZXiltfWE4RjYDKX0h2BdEVFTHGYKiGp+ydF6j7iFCms=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bw5k8Iv2JUhdvfR/cqJjzMZGqUnGj1ITagJGcwVpRREiBx78P0gfxM55Cyas2wEqnYTunPKzhWY1I/Nm36mwz3Gtd5tBGlJhh+NIbMcbSCiQ1BTn0g7vqaEmDz2OF9WYNtjrC6TSPF3NwL8EQd6O07SVp71GwvJNYKx6bxWo8nM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B2pzULT5; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-43d64313c39so883523f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 14:36:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776461813; cv=none;
        d=google.com; s=arc-20240605;
        b=exsrw7sFN/UaVjavRXEA8ZhkZd+y/QGWeKZLH40aFyBAgXDienzSFrOX8HaypShhsV
         FhbpjGiNRaxmnmfXtsaduIlsP2TUxFdighhdgGj8hKJ1oqgwz/v+BbI6w+jijxjmiHVN
         /+Vx89HXvuvBOcVg2CMJ1n66cNxEQ9SCyGlpwZ7ZEA20pZsBF457Woyr1awciYmOtTN1
         mqI38J3jGsMuN2NrW2eXqth4tCAJ1UCQlmCIdKZoNo7bvRhLUnRehtd9ZfOx+lTX2Vov
         9yUlw0h3OWSmtyH4CTXGesg30puycB0eggh8I+5Tuu4cPNVTLVvkG7k5L3u12Ay9oGva
         wNvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZXiltfWE4RjYDKX0h2BdEVFTHGYKiGp+ydF6j7iFCms=;
        fh=4gHd5dVaMmUMFT3ulj2tChJPGonwS68xf+OG7s8AK24=;
        b=jeKgTJVzAmZ0Olb/tpA0tdQoeMfOrDYoX+mGDesypviCbdOA+QKo01/nhpQZ0sbZ+u
         oDRwtLL1kUN2mmvdMz2h71yBu89EP1DYrwgnX6Kxghknjli6bcs+31RexRGbRhQoXZQd
         C2ZFFJHUcdiS3RgQHmdCpYhYajzbktET7avyUlpGAlD4ZBDTBteG0bLGxhR6hSVNEfsz
         EmDFE53wgGqFjneVUuKkS7getBeusPdshv1VhvzkQt/qo6MWBAUj8aES6PZWDrUbqOzm
         YWHVYQAnPfu6xr95KQYw6W+rMV5xHRmbkQz2azwEocDiHnxuBvChHmRY6rpvCOlElwUG
         FpaA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776461813; x=1777066613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZXiltfWE4RjYDKX0h2BdEVFTHGYKiGp+ydF6j7iFCms=;
        b=B2pzULT5O/39uT8BDrSSZrXFMW+u61IEaicGbqSSP6SK8/cMMSnudvQ6TDbkpWFO89
         V92pSAKjiOdZYqWoittbtlgGspWf16+RpRD0TeMbJzCOexK4hWHPiZik53HR/P5jmIWi
         QAXvf7TwB7X+VsHGP5yo+NZnCkcVbG60mpcwytprMiM9M567ELJDB1VeX7RHZk2VuawK
         KIruOr3nupkVkZrk0+RM13FAwgOV7snkznxRKj37dOEhCZ4uSLADqdmK+SfeF2oVOsVq
         JZ5wLV+Qa3yO6HnEoED3vdAtYtilSUV03ETqUconab8704VF4HoJMPfldPAlzriuoCCR
         KgHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776461813; x=1777066613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZXiltfWE4RjYDKX0h2BdEVFTHGYKiGp+ydF6j7iFCms=;
        b=VMilyGc48Pm4+rpAJ+l9kVThAbINTJuHNUQ/RhvU3sf/Gm2G556foffGkMNW6I+gNm
         cMRnoKhs0VQuKQHOjINdFzoF1CSVK2iYhXN4mvXzSkVICUvdb3tdILPvs5SVf7uVWNQM
         yOYyXBBGf4LrlNKH83s5A0pgwFGhNMtMbrxvbR8BgDNGgD70OZ0DI1dnN/pDEtGJ5NWq
         CaGqTCJW2j/otvAeC0dWUlyVFxKUZ1KA5v/zoDU48Z9EZeRMD86c1SxnUXnuAiZVw/fq
         1Ml0p0XMgpQY2d05uHDhrfKlfOqfa1GlQzv50LyHDTP+iCGNI86lkuMYMh+Se4mOsxbO
         XVSw==
X-Gm-Message-State: AOJu0YytVFqCiSX19XqzHSIKgYVDiI/ubZEpWKlpOkDrm+/Ri2WIxrQi
	k3Gg1zK4tImf38eT79vCVmaXoePvTbC7EF1KoSwlvpmptYd6imJEqxG4vHlBa5Hri1sGivv8N+H
	m6tm4triqjJAttqpOv2KewX64mvrmmRc=
X-Gm-Gg: AeBDievoJ+a5gdQbA0ljMAWVj0aK/utk0q+8Lp3QURnLQHg8VK8vhcNCTSycZ9/DgxQ
	GfPz5LzXtjKKYDU2zH3pVkWC0pAe0psu8zbDVmDuGPB9zC4m/hS3F6evEcHc8/+Q0Bf7bKGz4M8
	hWGLdOcCQWCdOhQCLrHNKqWezrlS9j38ss/Y7IzqB7rQWS/uf8hOSSK0iN+o5vT3+goL1+ank5V
	QvLMyPnkF6iYbYnJqFabSIooxSyJp56J7+VWJB7XFPR6hxfZNbnzlJfBRLN20D7WG6os/86EEK5
	/ZTN2hF5i/fRTqte6tOPy3dJhhoH+gE84Yj9BduMFRKzGcbCTnc=
X-Received: by 2002:a5d:64c3:0:b0:43d:309b:9c4f with SMTP id
 ffacd0b85a97d-43fe3db2d1amr6421923f8f.6.1776461812902; Fri, 17 Apr 2026
 14:36:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260417202518.1354891-1-rubenkelevra@gmail.com> <CANn89i+zy=YttsDesBzvtSrkdY+==L_L6j4O7EFjYKEggcXbGA@mail.gmail.com>
In-Reply-To: <CANn89i+zy=YttsDesBzvtSrkdY+==L_L6j4O7EFjYKEggcXbGA@mail.gmail.com>
From: Ruben Kelevra <rubenkelevra@gmail.com>
Date: Fri, 17 Apr 2026 23:36:40 +0200
X-Gm-Features: AQROBzByBkdxialAwVvthJshMsyjtzZsG65NjDTkgtBN7l4BXXRaTH8A9gnxq-M
Message-ID: <CAGHX7-OsuADyxGr-QoRRspuXYm_3aS590Ez4zvGsjyPsSKLJsg@mail.gmail.com>
Subject: Re: [PATCH] tcp: fix orphan count order in __tcp_close()
To: Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279434-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rubenkelevra@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D1CCA41EBCD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 10:54=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Apr 17, 2026 at 1:25=E2=80=AFPM RubenKelevra <rubenkelevra@gmail.=
com> wrote:
> >
> > __tcp_close() calls sock_orphan(sk) first and drains the backlog with
> > __release_sock(sk), which might call tcp_done() which decrements the
> > tcp_orphan_count. After which we will increment tcp_orphan_count again.
> >
> > Since tcp_orphan_count is an unsigned int, we underflow to uint_max if =
we
> > started with a 0 - at least on all current supported platforms.
> >
> > I could not locate a direct user of this value, and in
> > tcp_orphan_count_sum() this underflow is contained by adding the unsign=
ed
> > int value into a signed int sum, causing it to behave like -1 on curren=
t
> > supported platforms and then get clamped by max(n, 0) to 0.
> >
> > The impact therefore is currently limited to e.g. tcp_too_many_orphans(=
)
> > checking an artificially low value, if the cached sum is refreshed with=
in
> > this timeframe.
> >
> > This fix mirrors the previous fix I found while investigating: commit
> > 75c2d9077c63 ("[TCP]: Fix sock_orphan dead lock")
> >
> > Later commit eb4dea585304 ("net: Fix percpu counters deadlock") moved t=
he
> > increment down for old percpu_counter reasons. commit 19757cebf0c5 ("tc=
p:
> > switch orphan_count to bare per-cpu counters") changed orphan accountin=
g to
> > plain per-cpu counters, so that old reason no longer applies the same w=
ay
> > now.
>
> I find this patch rather confusing. Have you used an LLM to generate it?
>
> You are mentioning old patches that are not relevant (bh disable/enable).
>
> Given we advise only increasing tcp_max_orphans value (default being
> 262144 on modern hosts),
> your patch has really no effect.

Hey Eric,

no. But I'm not a native speaker. I'm sorry if my explanation did not
meet your or the project's communication quality.

The point I was trying to make is that currently we underflow and
overflow an unsigned and signed int in case we start with 0 in
tcp_orphan_count. And while it currently has no real effect on real
world applications, as we use a 100ms cached value anyway, I just
wanted to clean up this "old" approach which was apparently chosen for
historical reasons to circumvent bugs, not because it was the intent
implementation.

That's what my list of old commits about the history was meant to reference=
.

Best regards,

Ruben

On Fri, Apr 17, 2026 at 10:54=E2=80=AFPM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Fri, Apr 17, 2026 at 1:25=E2=80=AFPM RubenKelevra <rubenkelevra@gmail.=
com> wrote:
> >
> > __tcp_close() calls sock_orphan(sk) first and drains the backlog with
> > __release_sock(sk), which might call tcp_done() which decrements the
> > tcp_orphan_count. After which we will increment tcp_orphan_count again.
> >
> > Since tcp_orphan_count is an unsigned int, we underflow to uint_max if =
we
> > started with a 0 - at least on all current supported platforms.
> >
> > I could not locate a direct user of this value, and in
> > tcp_orphan_count_sum() this underflow is contained by adding the unsign=
ed
> > int value into a signed int sum, causing it to behave like -1 on curren=
t
> > supported platforms and then get clamped by max(n, 0) to 0.
> >
> > The impact therefore is currently limited to e.g. tcp_too_many_orphans(=
)
> > checking an artificially low value, if the cached sum is refreshed with=
in
> > this timeframe.
> >
> > This fix mirrors the previous fix I found while investigating: commit
> > 75c2d9077c63 ("[TCP]: Fix sock_orphan dead lock")
> >
> > Later commit eb4dea585304 ("net: Fix percpu counters deadlock") moved t=
he
> > increment down for old percpu_counter reasons. commit 19757cebf0c5 ("tc=
p:
> > switch orphan_count to bare per-cpu counters") changed orphan accountin=
g to
> > plain per-cpu counters, so that old reason no longer applies the same w=
ay
> > now.
>
> I find this patch rather confusing. Have you used an LLM to generate it?
>
> You are mentioning old patches that are not relevant (bh disable/enable).
>
> Given we advise only increasing tcp_max_orphans value (default being
> 262144 on modern hosts),
> your patch has really no effect.

