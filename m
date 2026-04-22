Return-Path: <netdev+bounces-280339-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OaGBQJ96GmsKwIAu9opvQ
	(envelope-from <netdev+bounces-280339-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:47:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA9F4431B0
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 09:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36BE630474DB
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 07:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF583372ED7;
	Wed, 22 Apr 2026 07:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P3HtJIZL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D987F2DC77F
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776843589; cv=pass; b=GKftuVoiVUNYFbHcDFYMLbjNwU/Al5C33pKsUNfYyKnd0wCc1vKGax8yvRVn+bARaCP7gQwXN0at1tSl5hb5mq+Zig24gEBJiT2zNhq0er2kdvftRQF1BUgZN/EMeMKPqiVCh3l+nP9kkNVT9J8TPmAqmam/kYUJIusR2rZxwjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776843589; c=relaxed/simple;
	bh=JIrqPstQwYNJn316wsBaxXz9zfKoIdJWF3ekFOqkV2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNvPPK4+fDj6Gk1BWhDlzBVIy0M6XRlfad93MilwSWyY8QZgwYIeUpQIAhXRn3IvVN+/c/+D1Hajr5TLG05FzHSZ0C1b8BKnE06wpvQxOyXKuNHaF2zkhRT+xBXXehb/AoEk96w2zcCIcIUTOwpvHtm+fRCI9c6bOkgpj5lMoeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P3HtJIZL; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8ed4dd182efso159046185a.3
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 00:39:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776843586; cv=none;
        d=google.com; s=arc-20240605;
        b=VEADnTF3Wzt9DXkJBXk8gWZfB8AttJ+TV4R89DPgzmR3mGH147R45pgWtZOd+FYvFf
         S1eF9zIKBdyHf2DJKVT+IOoIXdlOH/o5e32458Z/os4KQJs9/PSi0GpoDAiDLQ+mwVfv
         JbUakATfHikN/YPATpY+mTD4qs/ChOf8GO1OC+hgDlN913/bEMzg3C/KlHwoYeBKkCui
         Y3171babEgnbjPA3Tzc0I1Dp6MeuNNTIvO6kAUnsg5zHLnJQV0cXe7BVQr+qBmQBRXho
         qGgPTjN920IdwkZGOaF1WsgfhvsE2s60FQyJsaJFoeItdiEAByfIy49Plm2JiFOg4RVk
         VymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=E8AU1puBQWeKYqSEIxsINcktHRXGb7onN9YVXllTiVY=;
        fh=DhuG2D2chCHdXCaDPKTqk4m5sQ+v6n7dtRAwcL9AFS8=;
        b=Bc0CYAsYWglt4QIfSS3c/nOBwKhtfAY0uh5VehaV9XY/unGlJ0bsV039pgCqi/0gKx
         F8N1lX/9MdJh3+OULmrCfO38pjwrASorR7u6nzPE+sgQpgAH7RUVq0DVb5iw5gGKW0E7
         tU7rsn6Seg8kTnIuIXWUgcW4scO9Pj7AFaVBbAXXfyG2enyZ/JCfLr3mRB8cZ6xU90os
         HfUBMs3VOvaJjZqppp+ze50zeIx+udJJ9mesm9o4BjGL74gUC85lJLNcb/lrhlyWalGG
         8W7nTMa/Qup/ZCCxxf2QbwGLr7dlQ189g6UVQJc3Z47TAAzdSmobN+V84Mv8seza71aR
         dc9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776843586; x=1777448386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E8AU1puBQWeKYqSEIxsINcktHRXGb7onN9YVXllTiVY=;
        b=P3HtJIZLs7kDSBolrJNzMrG1uE48oHG8h06yAyq9xPxUwa+s1ryX+Q9KdgHmIqUjpL
         3aiWKO8DoQABhi05ThWbW4LAdwPkmN5orv7fGQ4v+3yOgUQJVdXsfOisRIprQqaAny9e
         KkG11tb72a2h4842ibzCILZjcROa++ZBcdeKvxxAHfhP3l9niBcWIAvpMl15nqrxwb24
         jBXdx7Hwu3RtvGYshO92zjYDDgcBQtrjZ2kQS0Kg2qpmqDLT7ouomyO+bB8zJCUOx1Ku
         xcutZB7UElyBsZrl4+orjDLJ5TRuQ3mQBjeUMHBtwF/fyhpq8uXJ7/jwArUMeOsj5Rhe
         553w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776843586; x=1777448386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E8AU1puBQWeKYqSEIxsINcktHRXGb7onN9YVXllTiVY=;
        b=Rt3Q+59Z3p6uHqr8Yt8PP4pDC0TLR7dr4uriqF9bubqDitRApXkrMCVkDghVjcomSO
         sLYRh/OGkdLcwDf7cbp7vDJ+/a8hNT12Hg8TtZoWdH7kZ//LJpCoYHaM2HlBgByhwF5D
         n3hpJuVGB55+M+og2IB7U9ljZOi5ah80w9vsZwZLoAjyw+bH0D3lE+jJ3YA+n1FESuNE
         tAAj8oWt3FDMXn2BaEWc0HGsRjRUAKumOylPN31EAoj5VYJ5+X6R6IIaBqYy+40bUzxq
         k0eKLHvkVy6M4XJs/so77QBEGnZuSCq19cagTItqbP7bALlsq4oNxphWQzhkQpSTHDxq
         kecA==
X-Forwarded-Encrypted: i=1; AFNElJ9unHs0ZazeHup1KCy28VOI3xcXr8TwVe+Iuqxzo9wv9MeJisV+L56ejTRnqBiLZS1149ylnuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdlnWI0xV0AWjPPRsdjA1flBy3ZIDO9NUaITouWGYCMUMFSBn7
	jP9IlkVRSDvxWYl+wvKK4QplhQuPrOQow6CR6bNn7FDgM/SOujsagH307THgTg/pGlgpXPbVELc
	l6PK8XQzoRZxYgW65/deRsMo42zwStDvLmBO2fukd
X-Gm-Gg: AeBDieul5wwmdCOtocMOfFQe99bW1CkrwXaWECyXrsHhLGv6XyXuw/PRGb8DdGXG1e8
	N3jnFNIJqdqDFwgRSEU1lVyd1o4Zs8V2vtNiD2qWoXHWEiB5po7cZ0aE/WyADHayW9dCcwl+Mxu
	25NiVIWtGIkVy62AUxAq3sIkshURv+J4LVhGUxcxJC2rHMW7zqw6negnpnr3vC7BrSLwpeAL509
	7JshPM+Krt2UIOVQws2RLxk9W7nlOUDnXUnAZIPLzkgO9Vt8m7Z1d0tGxvW2cfkJ6P/vAPykLMy
	dK7RgTLaJPxMZ5dCogiYXg+Bpo2WPZENWo4Y4lfXodUUOOE50zUH+M34YvgRisSJjF8wi1yIMdP
	DcR10Y1bF
X-Received: by 2002:a05:620a:4589:b0:8c7:13b8:8b55 with SMTP id
 af79cd13be357-8e79236daddmr2963147785a.46.1776843585314; Wed, 22 Apr 2026
 00:39:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414013634.43997-1-ahacigu.linux@gmail.com>
 <CANn89i+vq9O8PJZaDf=0YjcKTM8=-64TcUn-i-F4siGKAMKz+A@mail.gmail.com> <CALjTKDkJ9L-88hdODbt-8D=eEDe6r5egtTfk_RnwgVq_NF+q+g@mail.gmail.com>
In-Reply-To: <CALjTKDkJ9L-88hdODbt-8D=eEDe6r5egtTfk_RnwgVq_NF+q+g@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 22 Apr 2026 00:39:33 -0700
X-Gm-Features: AQROBzA8TC84INUrYccUyZ1jV2DQcRrv0QbfayCd9P2QgDRedVzWP2R4pTIwduQ
Message-ID: <CANn89iKwgoxM==synaLGKEP3k0jtCJ4b+Bap8ZF9k8yHJGnORg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make probe0 timer handle expired user timeout
To: Altan Hacigumus <ahacigu.linux@gmail.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Enke Chen <enchen@paloaltonetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280339-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 8EA9F4431B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 21, 2026 at 8:31=E2=80=AFPM Altan Hacigumus <ahacigu.linux@gmai=
l.com> wrote:
>
> On Mon, Apr 20, 2026 at 9:58=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> >
> > On Mon, Apr 13, 2026 at 6:36=E2=80=AFPM Altan Hacigumus <ahacigu.linux@=
gmail.com> wrote:
> > >
> > > tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> > > using subtraction with an unsigned lvalue.  If elapsed probing time
> > > already exceeds the configured TCP_USER_TIMEOUT, the subtraction
> > > underflows and yields a large value.
> > >
> > > Handle this expiration case similarly to tcp_clamp_rto_to_user_timeou=
t().
> > >
> > > Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero wi=
ndow probes")
> > > Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
> > > ---
> > >  net/ipv4/tcp_timer.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > > index 5a14a53a3c9e..4a43356a4e06 100644
> > > --- a/net/ipv4/tcp_timer.c
> > > +++ b/net/ipv4/tcp_timer.c
> > > @@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const stru=
ct sock *sk)
> > >  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when=
)
> > >  {
> > >         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> > > -       u32 remaining, user_timeout;
> > > +       u32 user_timeout;
> > > +       s32 remaining;
> > >         s32 elapsed;
> > >
> > >         user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> > > @@ -61,6 +62,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct s=
ock *sk, u32 when)
> > >         if (unlikely(elapsed < 0))
> > >                 elapsed =3D 0;
> > >         remaining =3D msecs_to_jiffies(user_timeout) - elapsed;
> > > +       if (remaining <=3D 0)
> > > +               return 1;
> >
> > I do not think this chunk is needed ?
> > If @remaining is signed, then perhaps change the following line to:
> >
> > remaining =3D max_t(int, remaining, TCP_TIMEOUT_MIN);
> >
>
> The if (remaining <=3D 0) return 1 handles the already-expired case and
> mirrors the logic in tcp_clamp_rto_to_user_timeout().

tcp_clamp_rto_to_user_timeout() has two conditionals.

if (remaining <=3D 0)
   return 1;
return min_t(u32, icsk->icsk_rto, msecs_to_jiffies(remaining));

First one was to avoid to call msecs_to_jiffies() with a negative number.

tcp_clamp_probe0_to_user_timeout() has 3 tests already, you want to
add a fourth one...
I would prefer something less obscure.
We do not care if we return 1 or 2 (TCP_TIMEOUT_MIN) jiffies

>
> max_t(s32, remaining, TCP_TIMEOUT_MIN) with remaining changed to s32
> also fixes the underflow; I used the explicit early return for symmetry
> with the RTO helper, but I can switch that in v2 if you prefer.
>
> > Also, it would be great to have a  new packetdrill test.
> >
>
> With packetdrill, AFAICS it would require a late ACK to be processed
> after TCP_USER_TIMEOUT has elapsed but before tcp_probe_timer() runs the
> abort check - i.e. a race between the RX softirq path and the timer.
> This is not purely an event/packet ordering problem, so it is not clear
> to me how a deterministic behavior can be simulated with packetdrill
> without tying it to exact probe timing.

I was trying to sense if the bug was serious or not, considering last
tcp_clamp_probe0_to_user_timeout()
statement is:

return min_t(u32, remaining, when);

Perhaps you should give more details in the changelog. What were the
symptoms of this bug, for TCP_USER_TIMEOUT users.

