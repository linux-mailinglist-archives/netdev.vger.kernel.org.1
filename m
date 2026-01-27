Return-Path: <netdev+bounces-253653-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEBaBmobeGnooAEAu9opvQ
	(envelope-from <netdev+bounces-253653-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:56:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 526088ED41
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 02:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A21133025A49
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0078729AB1A;
	Tue, 27 Jan 2026 01:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X1zFDDMj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E7529A30E
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 01:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769479013; cv=pass; b=NGUlxvwZHikAPe2lSqgX3lAmiv+galiYtnB+pWVmxdctllnGKo13XN9HZOcfxbixwENV3TjUzeWPMQ+UdCtoPryyX4b2x6F+U4vdBBfPb0N3X3JI6Fii+mCQ9LBbnJI7p6mg+52eJxdsMzJzapwWgwbEct7r14vE2/3HLf7rysg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769479013; c=relaxed/simple;
	bh=UsOd37x84WhoPK4fANF2p80tPKL7EjCI/FwrCNOFWtY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WkAeXuQyOsB/OPkNDw3u3SaZlZlSYOzRjoxguesyP9N5/xvIQFtBUwlL0Jme3nH0khxgxmfhlW/I5B7OAHWN4agBnsvuLSIOZWvCxJaGl9c9UyZlPhr1n4KRcz4HxzmLTUjbmdAadikSw40jP24woAe9DwjBR+iTDTsG8JIW5pY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X1zFDDMj; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385b6a15affso56270771fa.0
        for <netdev@vger.kernel.org>; Mon, 26 Jan 2026 17:56:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769479010; cv=none;
        d=google.com; s=arc-20240605;
        b=bkeMxwiyZdR2xQ4023pn+icQTZzzywrtlKlQ/u3UaKhJh0Vf1vn1/EKQMmkBLDKV5y
         O/iJwTj97mGU7h/9uK6KTW4OfOIT1szOJlaxmGSQd5JjzHwhqAM4IZQ5MW08sVgz1fGq
         jEOfJicKN+SFVew+w9vhmqhcf1mWbggTBvgvL6Ttz4OnkGNDGa5hnN/1iYx3QdnvCeLk
         5SAfKc/WSmXODQVqF+hxydrH6j/4kNxNChhB8KmHNBpiTdbe1CgrbNlwUaBhD7OEHs/t
         n+DDVbHp76w8EgcXbJYwzfD/5sL2Oxk5n69Phya7+cnNrz8yFPnWt/8cv+U+nrxNgpCo
         tw5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+o9wYbUSqMFX/fxF123OBIwHzXNpYjM6L3UpsDJz0FM=;
        fh=37ckb9NJd6aMRPoTiVU3IG+rzBvfJ7u47pYMpS7j6jg=;
        b=GWIAgUQu5skpIKdV8oIeFKilz2AJ4mW8yTZ15QIPp6BIeGiQbEIo1TvJGMgI8l5qqQ
         YG72MC0jG8yXK3nDZiRA3y+tk84tyYcTrdoNr5EjNMMVD8LyNoeSU3odd1VmcWF/Gyp6
         9VP09KlOoeo3j/u+E+pWNOdnditcY5Q4r80WwzoNFW8keEyPAXZQOYWmiYn6etzgo3Wh
         v3amIJhHRap1qn2u1WZEV6jFsjqE6GR4TfDZd0k7ZoCOH4T9YG/Sc9Z3OCSvOKbH9v2a
         ag0cHp982GqPvwBMX0daS2DIvZPXnNna8TgJP7Iy5qzYAHHvHy3lR3vSOYOQ3cGqk6C3
         k60g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769479010; x=1770083810; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+o9wYbUSqMFX/fxF123OBIwHzXNpYjM6L3UpsDJz0FM=;
        b=X1zFDDMjZ09au5cVzBO6U8iiGNud6xr2QyKvO8WU0PQ7N/O7Z49TrfMK/Xrbvm2fVB
         9mBMi0s+X5Xgmr7ZK9ydIciFuXj4LozJjZCBfqC9dCOz9feiAfKSZM3LTFnaa0HVj7C6
         HSsK1QagQgpOij+4EGCnTG8xH8YCU20Z6ak1YmmjQkigSEtSfyyXhhRFwmzpUCGKxreH
         rmZl1l074vmKKHPFUKAiLfiifXUXGDgUwH97s/q5I4ZIiLcRl6OYTBzdf+GF3/4ahjP2
         VO2WGTqPSpp/7FSbL3C7D3s9DZUegWmsAKz4mKWfGdiYi/qFe61SVBJSd2ZGODWC8+2N
         R80w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769479010; x=1770083810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+o9wYbUSqMFX/fxF123OBIwHzXNpYjM6L3UpsDJz0FM=;
        b=cVNRcE5lRMwdSYlPkI/Vtdgcl1pvtooSxaaKQg09u5aHNycuxl5RbkRIdjlce7eRgD
         d+20+V0CCNLxjZWLmZk4qqOMpCCCKoYmXAJ8PLhGHyxSP0tA8FOGCFqLxxEmYGy2A2L8
         Io75E+LeTvloHaoeBOWxBRAjX3XYhs5+uSXVRCaEPkh/6Jzv+/di/Fvr3iHjWyfon7L6
         yi0pKWRgd37N1G3Rqbev46Ak+lqSco9mMo74aJXYsBaziP+qqKn7huNHTZ0zXCJPde9U
         KS6Wr8+VG8uJx4NhNM3V+9l01Cb39u2XVGzlDJU4xnIX61TOY2c8U1uhDvi3JOUymtPm
         /aOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVS72FDyb861YYs32HJ/FbESI5iECBI2j+GqKFl+sMII8QjqVjAfsqqL1qK/ApBDZbemcH9g4E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeYNnDTzE8zkToM0n2K7levQDJ9a5yq9ZmBUNIpYcbAETkw3kg
	kMPa5z0dSwUTMK81clz1cD/7bw9gXZxvZirozgTc4u0zyAxfXaqM+vDiqwe6x/P41MIlHjNVIwv
	shjAlXLFV1ZQdjaD1pTHn3cyTtkL2poU=
X-Gm-Gg: AZuq6aIQn9iAjNrvNcJG4v0pnxDKIciWBX3IIsUVgrr+9X0y1R3bPC/wyt3+6jKq38m
	71XzPbGaZBz8FxPVpnghuCdAy/zJWnX6tCjZN4G3iHut9sNJfUJD7J+B0JCa7YEmXtRbsmkiAAO
	9aRUrXG8nMQf6nUY9XdFbAERCbexbtJs1qSNuONYpAfC1qdfCoKcf1yEMgwtEBwQHsrvHizpe7F
	a82KtQrdSFOg4ps0wgTulntMlE1YxmSJyCJ8X8cJb2D8Wfy5pQb8mSOXlaQQJ+AchZ0BnRE
X-Received: by 2002:a05:6512:3f0d:b0:59b:92a2:19b8 with SMTP id
 2adb3069b0e04-59e041407b0mr10882e87.25.1769479010206; Mon, 26 Jan 2026
 17:56:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260123111605.4089200-1-edumazet@google.com> <CADVnQyktV_z9=SoT7yhkT6mBQKRjaJgpwLhR2SdWGQS3iKD3Tw@mail.gmail.com>
 <ebb3a731-a3ec-444e-8efe-aa13cb76adad@redhat.com> <CANn89iL=a922QTQUwr5EK6XeL+gQu-zeqca1PYhs-NBu3aeyzg@mail.gmail.com>
In-Reply-To: <CANn89iL=a922QTQUwr5EK6XeL+gQu-zeqca1PYhs-NBu3aeyzg@mail.gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 27 Jan 2026 09:56:12 +0800
X-Gm-Features: AZwV_Qizh6XwzN3PV1HpkkcrUKxOWE_8-YVI9_YyzZw2vqFWaaJRDJD6epASJhk
Message-ID: <CAL+tcoCsAJ+pOs6M2E2xRMa=VKNB9wwoR2DEbiFyvOmfe_dkGQ@mail.gmail.com>
Subject: Re: [PATCH net-next] tcp: move sk_forced_mem_schedule() to tcp.c
To: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253653-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,kernel.org,google.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kerneljasonxing@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 526088ED41
X-Rspamd-Action: no action

Hi Eric,

On Mon, Jan 26, 2026 at 4:45=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Jan 26, 2026 at 9:18=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > Hi Eric,
> >
> > On Fri, Jan 23, 2026 at 6:16=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > > TCP fast path can (auto)inline this helper, instead
> >  of (auto)inling it from tcp_send_fin().
> > >
> > >> No change of overall code size, but tcp_sendmsg() is faster.
> > >
> > > $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> > > add/remove: 0/0 grow/shrink: 1/1 up/down: 141/-140 (1)
> > > Function                                     old     new   delta
> > > tcp_stream_alloc_skb                         216     357    +141
> > > tcp_send_fin                                 688     548    -140
> > > Total: Before=3D22236729, After=3D22236730, chg +0.00%
> > >
> > > BTW, we might change tcp_send_fin() to use tcp_stream_alloc_skb().
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > I've a question out of sheer curiosity: are you using some specific too=
l
> > to look for inline opportunity, or "just" careful code and/or objdump
> > analysis?

Paolo, right, you beat me to it! I'm also curious :)

>
> I am studying performance profiles on a stress test using Google
> production kernels,
> on platforms that are a big chunk of the fleet.
> These kernels are very close to upstream (at least for core and TCP
> networking stacks), and use clang and FDO.
>
> I am currently focusing on some functions that even FDO does not
> inline, for some reasons.

Eric, could you share your more valuable experience and methodology behind =
this?

Prior to the recent work you've done, I completely missed that we
could even do something with the inline functions. Normally using perf
doesn't give us a clear micro observation of those functions
especially about some hints on whether we should inline some
functions. If there is any tool, it would be super awesome!

Let me guess, are you trying to avoid function call action as much as
you can in the hot path based on your deep understanding of
ingress/egress performance?

Thanks,
Jason

