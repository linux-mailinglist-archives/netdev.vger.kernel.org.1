Return-Path: <netdev+bounces-300539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RmGCJL9sNGpgXwYAu9opvQ
	(envelope-from <netdev+bounces-300539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:10:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E387D6A2E6F
	for <lists+netdev@lfdr.de>; Fri, 19 Jun 2026 00:10:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="LOB43kn/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300539-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300539-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B16E0301E5A9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 22:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75547330305;
	Thu, 18 Jun 2026 22:09:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC261D432D
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 22:09:05 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781820548; cv=pass; b=S5LTurIM4sGrLJoCL42NquvvvdNt6DSGWtUalt7gf2yXVhdvb53b3sJwBal1NarX7OQbghtSTw8B9gRhKVYknaFjMgWaF66i2Lg/tPt9GyEE2aWs7Guh/pWxbAONdnWSUT/mCss9e2wE82LcSiSdp/gRfSXp/JzoA18B2uf7yZI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781820548; c=relaxed/simple;
	bh=FP57ixB6vas9YSLhEpafEgUrTpTmh6IMV95sPY1Cm/g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8QKhDVfxNgZKf5u75aEm7xEbxdbYmomjod440mScay5c4hWqiTOV4xShbnHjQoGh0U+F6rR3hoCq1qUGPFpu11PD86wrHL//bWRZjuQy7ssOAHdzhUwWpJaK11rcmCYYdr3PVo4UGGSkaZkhgBeKHnH1v36cl1SfTihBT6PopE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOB43kn/; arc=pass smtp.client-ip=209.85.210.173
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84536e2857eso1033023b3a.0
        for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 15:09:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781820545; cv=none;
        d=google.com; s=arc-20240605;
        b=bvJByA3eXgT+hjw3GgPb8jGxpfcpfiNQ0N+wK+CBbCVMHwjAhREYKGwiO9gIAbi5qu
         xUMNgb0vy1lVdlAmj4re4GG8p01Hjn4l9gFlooAWKdWNqFCkYA7wlX5TKhhBjMVW9/YS
         pqfQqMTmM6N83WP+cgsdOBSpCuISWc5QD66+S3R3R9yxrZuCIFvmPY5WQsdMGr7T4Uzw
         JLK9ATWGoraFbe/BsmI5lqYhKRoobiXQ93cAS5Ftx7bVEDx+SMf5cewEmPo0pIr/Vcnz
         h5Mb/mVzLhAdnGXZoIFeghe/YPl221/2h378FjYZt4hVAFguW+YfvtDqp2kRxHik1uXi
         Va4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pAlFSiEpASE+H9CxsPg4DvwVnR9n4xFOZ5gXGl5r4bo=;
        fh=bPWtr0gPe0NqD52gA6wscJA50bRcDkbd6O3I13RwQtQ=;
        b=IVWax3VtthpCC4R/b4fdbyGM+IqbMFDucP9FBP+heaPPvHNjlaDJyMPtp1p3pJRMKE
         qgH81Mu10BtbTZMlhyJKsVX4AB4hebKE0/KlnnRuK4Q78t56S+W4DkyyX70StSshHpyr
         ouiubRitGqUeXB0n49umESsGM0nOQ/paFzgnwoBP/P8t0M5HT8CtFatrM4jgWKTBGdvb
         iDGwEbxvN0sT7F84LLMPuhDyuCIV1sR8W4lYHrpPAFpNdRtxUQJMDhha050jEs8uF/lQ
         QhLpFKKiqtRdAGLAX1VFvnco0HYXs8jTszhNjfo66Q2E6lvkL4tw4Ch9egKelOZNmAYS
         +JgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781820545; x=1782425345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAlFSiEpASE+H9CxsPg4DvwVnR9n4xFOZ5gXGl5r4bo=;
        b=LOB43kn/cSy1dW5r6NJK2VpvtT5A8nlJiboLJdOPm1Reb2ZyEtxR1aFu3CU/m4yK4e
         grNc1Ioe1Vq5FKksqJO7lLki7OhnD6lhb5aRgOz1Ot7gSS0vVX9OI8zCpdR29LIa+ykF
         tm2qHGddVhTXQ+HoQNRlyk9UxaZVlFdi4g91GNK9xF1Kc7NExSmhqvD87TtnaHtPFqqn
         BTV1EcNXYvRt8rTPCbv4vCYPYBauyJ4SS1zNw2Q8tPCuNRjXh2xbBsj+PJUByU3WD/W8
         LiOJZ+rKxcpWASLzZuIF4XSDf28McR3e7n9ESRorhvHeC/6DlghDq6JqUbFDUu073Io9
         LnMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781820545; x=1782425345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pAlFSiEpASE+H9CxsPg4DvwVnR9n4xFOZ5gXGl5r4bo=;
        b=M2F1Cc0ObOGPd6r+ZuiuaSALaiyn88IZc6eCzIjap0lhngCCaILtFsTozzhx5ZGz2q
         lrb7Z7LekP+9o/EbFPiLICnW4/fhyKvjcuAjnyobNqvp5K5Dqc5ivr4cBnpkrnGyuEIg
         LIiResqDcevPLkYn8/1/bXhxmzPD3ZFYZKKKLpW4z9/JAGjs1FxtzY6FqQ05nR744NRs
         z+zjqdjyPbRBEGISwnR9CTfbjZqk5Xh13G22tbOJODgGzhPmzDQXn/5vi0JsRhIL/nfk
         cI7kDeyJdDiKtn9XYMQWq1JES3umwXYs0A8QauW8kGr88ScY0HU+WygexSbQsCfOxnRw
         Xcqw==
X-Gm-Message-State: AOJu0Yx39udQ5Iks7GpAFOzbubV/dpzeAbER3dN7/6WtDeq2J1N3EsXC
	Cw5EqpUJN8nnrAXJ2spe0ni1jZFMhd6pvNiXEDn9TqnLPFhk8dgQGhh6m7teiUpL8QzITGCNep1
	227wbnUn+Rxar6kbtg1tLvXcAgMzcKio=
X-Gm-Gg: AfdE7ckI10Xq5tpw4KOpZ5VWPoembE2oGyXyQfY2bm7E4MRMzFdQMXRA69772zYGMxc
	Tsz5SKRddZJk0cMJKRwndj2TM/BrV0XbLV91lIzWi6Oqq6XkM4ZlrYht6VC9YYIJIlmJH5QLSCp
	xipQtymnDOmEnekeCciBA5P0OfDEN+kdnKuiIuZXua9Q1RqKofMeTd2P1R8LKFAcw2MksqZpsMm
	owspFucwmhPg/mOKzjZwNttO8RPlHj/9Ttm+qbmd7YBXUPC/sWlxu0DosN3SvwFWOr6gjp6tMW0
	mxtvk6PifX+R1QtYx3h+MyvyAVAYoY27MvK7qRmg+diu+E54BTRVO4DVsYad6vMAYYTdJTT4j9r
	uWHcz9w==
X-Received: by 2002:a05:6a00:3d04:b0:836:5c3c:2054 with SMTP id
 d2e1a72fcca58-845508a0f2emr758798b3a.37.1781820544920; Thu, 18 Jun 2026
 15:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13a54c38586e0e1c7d46dfc16c3f6e1a7685001b.1781570014.git.lucien.xin@gmail.com>
 <20260617104013.852168-1-horms@kernel.org>
In-Reply-To: <20260617104013.852168-1-horms@kernel.org>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 18 Jun 2026 18:08:52 -0400
X-Gm-Features: AVVi8Cda4bpB7H8jsE-_f5NzyxbrGEuRzgXqeYsgC-Xoa1h8pNoShrYQk4Y8aBk
Message-ID: <CADvbK_c_+tm=sX_NH-JoppGaqrzt-jAb43NKs-2VXaohb9z1Vg@mail.gmail.com>
Subject: Re: [PATCH net 2/2] sctp: add INIT verification after cookie unpacking
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-sctp@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, edumazet@google.com, pabeni@redhat.com, 
	marcelo.leitner@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-300539-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-sctp@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:marcelo.leitner@gmail.com,m:marceloleitner@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,kernel.org,google.com,redhat.com,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:url,mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E387D6A2E6F

On Wed, Jun 17, 2026 at 6:40=E2=80=AFAM Simon Horman <horms@kernel.org> wro=
te:
>
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Now I have enough verified information to produce the report.
>
> commit 9d74027bfd0cb22a103cca034883f0fcb4e2535a
> Author: Xin Long <lucien.xin@gmail.com>
>
> sctp: add INIT verification after cookie unpacking
>
> This commit adds sctp_verify_init() checks after cookie unpacking in
> the COOKIE-ECHO processing paths when cookie_auth_enable is disabled.
> It also changes the bounds comparison inside sctp_verify_init() from
> chunk->chunk_end to peer_init + ntohs(peer_init->chunk_hdr.length).
>
> > diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> > index 41958b8e59fd..21b9eb1c02e9 100644
> > --- a/net/sctp/sm_make_chunk.c
> > +++ b/net/sctp/sm_make_chunk.c
> > @@ -2298,7 +2298,7 @@ int sctp_verify_init(struct net *net, const struc=
t sctp_endpoint *ep,
> >        * VIOLATION error.  We build the ERROR chunk here and let the no=
rmal
> >        * error handling code build and send the packet.
> >        */
> > -     if (param.v !=3D (void *)chunk->chunk_end)
> > +     if (param.v !=3D (void *)peer_init + ntohs(peer_init->chunk_hdr.l=
ength))
> >               return sctp_process_inv_paramlength(asoc, param.p, chunk,=
 errp);
>
> [High]
> Can this new comparison reject INIT chunks whose final parameter has a
> length that is not a multiple of 4?
>
> sctp_walk_params() advances pos.v by SCTP_PAD4(ntohs(pos.p->length)) on
> every iteration:
>
>   include/net/sctp/sctp.h:
>   #define _sctp_walk_params(pos, chunk, end)\
>   for (pos.v =3D (u8 *)(chunk + 1);\
>        ...
>        pos.v +=3D SCTP_PAD4(ntohs(pos.p->length)))
>
> so when the final parameter has an unpadded length L that is not 4-byte
> aligned, pos.v ends at peer_init + offset_of_last_param + SCTP_PAD4(L),
> which exceeds peer_init + ntohs(peer_init->chunk_hdr.length) by 1..3.
>
> The previous comparison used chunk->chunk_end, which inqueue.c computes
> with the padding included:
>
>   net/sctp/inqueue.c:
>   chunk->chunk_end =3D ((__u8 *)ch) + SCTP_PAD4(ntohs(ch->length));
>
> so the old check accepted unaligned-length final parameters; the new
> check returns 0 from sctp_verify_init(), and the callers then invoke
> sctp_abort_on_init_err() and emit an ABORT.
>
> Note that this change is in sctp_verify_init() itself, so it affects
> every caller, not just the new COOKIE-ECHO sites: sctp_sf_do_5_1B_init,
> sctp_sf_do_5_1C_ack, sctp_sf_do_unexpected_init, sctp_sf_do_5_1D_ce
> and sctp_sf_do_5_2_4_dupcook all reach this comparison.
>
> Realistic triggers include:
>
>   - Locally-generated INITs constructed by sctp_make_init() when both
>     auth_enable and asconf_enable are set: with the default chunk IDs
>     ASCONF + ASCONF_ACK the AUTH-CHUNKS parameter has length 6 and is
>     typically the last parameter, leaving chunk_hdr.length unaligned.
>
>   - Peer INITs containing any final parameter with non-4-aligned
>     length, e.g. SCTP_PARAM_SUPPORTED_ADDRESS_TYPES with 1 or 3 types
>     last, AUTH-CHUNKS with N=3D1,2,3 entries last, or any unknown TLV.
>
> Even in the COOKIE-ECHO context the new bound seems too strict, since
> sctp_pack_cookie() copies the INIT verbatim with memcpy(cookie + 1,
> init_chunk->chunk_hdr, ntohs(...->length)) followed immediately by
> raw_addrs, so unpacked cookies recovered from peers that sent an INIT
> with an unaligned-length final parameter would also be spuriously
> rejected.
>
> Would comparing against peer_init + SCTP_PAD4(ntohs(peer_init->
> chunk_hdr.length)) preserve the long-standing semantics of chunk_end
> while still validating the cookie-derived peer_init bounds?
>
There's no problem here, as INIT or INIT_ACK chunk's length is always
a multiple of 4, unless it's an abnormal one. We don't need SCTP_PAD4()
for this check.

Thanks.

