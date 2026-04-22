Return-Path: <netdev+bounces-280296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id PpwiAChB6GllHwIAu9opvQ
	(envelope-from <netdev+bounces-280296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:31:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 48525441C5F
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 05:31:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A5B6300F12E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 03:31:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAD39A06B;
	Wed, 22 Apr 2026 03:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bs7sHMUH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BB03A1CD
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 03:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776828708; cv=pass; b=ueFL93oFLyezBxyaraCUrJP9mnhpILkwp9TPpiF7KRpwSRGd8WQ61F41+LUDeS91gY/7t4Onrv6EAdRFTHNG5fmVKrZIoTw7v+LNanMbahCfz9s2TRTAjauJ39aVe7+6iGur5JQDPEk5+LJBaOoUv3phrU+gEdKLSud3KtYvTXo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776828708; c=relaxed/simple;
	bh=N27EOhK7auLzR+/02H89MbksVXXgMOXn2QiPGHDFR7E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=smQ/6QORU9KT3sGrU0/5mdLcW5Ow602X/pDk2IUaVAoKMbmPlKFaBtZ0noR9ThHst6epPfF3ZVZbBDexYFqAUmcE5Jfd75BdonX34lpHORcdzvLLXeKUKGBQlBghJYuEvJMUUS1NZwAwIBL4RIg4OfeuBmQyqNqImKKKkyqPReI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bs7sHMUH; arc=pass smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488ff90d6c7so38952795e9.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 20:31:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776828705; cv=none;
        d=google.com; s=arc-20240605;
        b=a4R8uzmuWeURc3OY4XOIL86+eDLsfCO4UxwV513wypHlIUREjGs88rMHMGFsaFWaQe
         95EYaYZ/fvMvE10GfnR7v6ST01SdUe97M/nwAqx1sLX1nYeAs9Zsiu/K4el7L7Z4TuSW
         Id4KqYGf+XW7L5J30TweCvNRt/J8sK35o4EysvXPzxp8sR6kpBSPvuukP85fOLuvEQNj
         /+TawVwI0yZ0o43hb7kRKRFevmUlyWO7ylpPmQU8RZEw2CYK7tJJmEI1jqnswT0f+qs0
         0Eh+Ml9y2QP/ZQvpGd0dEu/lmvf7Qd8Eln40MTA27RBj3aNcvUsjzySHxhNmxVLGVWCU
         anQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ojvQXvOD48VewuoUPRkS6bYSjpL7KnIpoJORaZS/O+Q=;
        fh=a7Ufb1JAqxeu8Tnq7LPiQ3ahn0D2s6ig/VBLaNuQ+0M=;
        b=VGbT2IOtsnWE8Q+ZrMf/DPq/7+aSkdaB5OwJwMHNrDuBbG0kFTu1CYVww2UW5iVgMj
         s2GI18ufEP5r6ebH9uM6NVetunWWfRwTJxQDGKkQYgkCHsURobi1/PBmUaORbXp55jAO
         mhzg+Lhiu/IDKUfNO7I0S53fUTK0bse7p7tkOLw2w56wf3u420oWtG9XmcuRxe4u14aG
         MAFS72CrIa6xq2s3O3wjWZ9FTpkD97yWvHDZ40ZSjN/ENL/PRfOEl2spUjsJm+ZIDOiR
         DtlSIvNge4V8Xl9g+W1YTNlmypmhuU+SiIqSgIYnbsX9/KgJJmwkEvTEWAYiVRS/+5wC
         28tg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776828705; x=1777433505; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojvQXvOD48VewuoUPRkS6bYSjpL7KnIpoJORaZS/O+Q=;
        b=bs7sHMUHMhSjPO0V3Yi6l4qz6SVgLYiW8UEW4BNLiS6VKnFoADaMuDtSK0D1EPAAer
         G4riYNp7uO7WU7dKhrhVyfvPTdJDEJFRepwsY8PTCuM+BpVDmkrpuNWyx0qfbYI4Ae7F
         DTM1hO8Hf6Krx++axp8GzKqMZEbWrCcV+FbIfLyQYsTWTecfpSQOh0RJrFlI7TbH+hNT
         MLMLIET0+gAgBEN9aFcgL7bC5qo4pGNq7f1EyciKad/uSUJgL5jlfCL7q8nluxxwUbGt
         +UqMH6Nr9ZgtENHukdrOuYeJVVAPh1NZ06KxKv26X3I5MLy188bvUjX6jlY6K7r58rs9
         Ifqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776828705; x=1777433505;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojvQXvOD48VewuoUPRkS6bYSjpL7KnIpoJORaZS/O+Q=;
        b=Mvu/L6yuRXnOgdwLZLC8KxKe16Wx6cdg101dbYUm0RfOqvRR5/tCCp7N6zxM19DdI4
         e0S6t46XfJ66zQuHVWjCgg23Fyi74a9MqGcX27ALUo7teFp8m35xhtz+PGms9NZ87Gb6
         XGf+8uJhUU3jmhQJ1d5U4FVqFcIGH7wvO/TL3LcjsqiJu611xQQoAPRqvoqhYDT7D1IE
         f+rc+pxX6rmZ2ezDgYN/PTQZniQkv6mgNwarMmN2hLk2X4K9/4No86Vpkmfl66raudTu
         /jcpyF34U0E05RXJakt6gGdV5ZaeWPZVGRSK+6hgxHMBcf4Zj2zfO82rdUysXUq+5/K5
         S0hg==
X-Forwarded-Encrypted: i=1; AFNElJ+W2cd4LpSDFJ9kF4YfueHLOoe9yB0dLDPOCu8QHWoE7l3lscq4a8faFbA0G5WhQUro2yoCqbY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwMUE8vcRJcmHPHaDEUt6ge5YaGhRyq5bwQqhR5Euyv8zWDISQ
	rvafbvkgJYS0gu1PfeOjZHOwtPHQggToXfad1SwGaoo2tqBHU42ZbIL2FEatTTgmNgj+j7q3KO6
	QcvDAbk40LQrTVFzRUFe3nu7yCRggCUU=
X-Gm-Gg: AeBDievSPCrOUG0ZNsNWB5ZOi/aklvWxDMHsahrBfp8arAYvPXLpFtf05FabzEx4+vC
	MkPOBqHZPABq2ZLB6lsHH4BC3d4GoM6zdXg0yoJffNkeqjAn1NJsK/FukALRaH1ClBirSCq6+Sz
	bXpE9I6EgV3P/i7CQjLXNxmDDDtB93TQmto8JHfS0rgmCqqfJ0f5A9ghAw6f3xdrk47UQJL6vEh
	T/zBVJrQEccCKrh8LOjq1/i+yHYQR7UQ5Yt70i4eNLRnUnZP1f6y583g2oVUKQ2cL+m3TEE3z/q
	duQAe3wD5h/4Ybe+YS7t25EnhQsP3uqyQHtTi5tPmPhyOU+I
X-Received: by 2002:a05:600c:308a:b0:48a:54fd:54ea with SMTP id
 5b1f17b1804b1-48a54fd690emr57151705e9.12.1776828705053; Tue, 21 Apr 2026
 20:31:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260414013634.43997-1-ahacigu.linux@gmail.com> <CANn89i+vq9O8PJZaDf=0YjcKTM8=-64TcUn-i-F4siGKAMKz+A@mail.gmail.com>
In-Reply-To: <CANn89i+vq9O8PJZaDf=0YjcKTM8=-64TcUn-i-F4siGKAMKz+A@mail.gmail.com>
From: Altan Hacigumus <ahacigu.linux@gmail.com>
Date: Tue, 21 Apr 2026 20:31:32 -0700
X-Gm-Features: AQROBzD_W2VUpj8A43-4btJkIXSCnCgEm9H24RfUxZJiXFu49vm1cNLBCA21YYU
Message-ID: <CALjTKDkJ9L-88hdODbt-8D=eEDe6r5egtTfk_RnwgVq_NF+q+g@mail.gmail.com>
Subject: Re: [PATCH net] tcp: make probe0 timer handle expired user timeout
To: Eric Dumazet <edumazet@google.com>
Cc: Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	"David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Enke Chen <enchen@paloaltonetworks.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280296-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ahacigulinux@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 48525441C5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 20, 2026 at 9:58=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Mon, Apr 13, 2026 at 6:36=E2=80=AFPM Altan Hacigumus <ahacigu.linux@gm=
ail.com> wrote:
> >
> > tcp_clamp_probe0_to_user_timeout() computes remaining time in jiffies
> > using subtraction with an unsigned lvalue.  If elapsed probing time
> > already exceeds the configured TCP_USER_TIMEOUT, the subtraction
> > underflows and yields a large value.
> >
> > Handle this expiration case similarly to tcp_clamp_rto_to_user_timeout(=
).
> >
> > Fixes: 344db93ae3ee ("tcp: make TCP_USER_TIMEOUT accurate for zero wind=
ow probes")
> > Signed-off-by: Altan Hacigumus <ahacigu.linux@gmail.com>
> > ---
> >  net/ipv4/tcp_timer.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
> > index 5a14a53a3c9e..4a43356a4e06 100644
> > --- a/net/ipv4/tcp_timer.c
> > +++ b/net/ipv4/tcp_timer.c
> > @@ -50,7 +50,8 @@ static u32 tcp_clamp_rto_to_user_timeout(const struct=
 sock *sk)
> >  u32 tcp_clamp_probe0_to_user_timeout(const struct sock *sk, u32 when)
> >  {
> >         const struct inet_connection_sock *icsk =3D inet_csk(sk);
> > -       u32 remaining, user_timeout;
> > +       u32 user_timeout;
> > +       s32 remaining;
> >         s32 elapsed;
> >
> >         user_timeout =3D READ_ONCE(icsk->icsk_user_timeout);
> > @@ -61,6 +62,8 @@ u32 tcp_clamp_probe0_to_user_timeout(const struct soc=
k *sk, u32 when)
> >         if (unlikely(elapsed < 0))
> >                 elapsed =3D 0;
> >         remaining =3D msecs_to_jiffies(user_timeout) - elapsed;
> > +       if (remaining <=3D 0)
> > +               return 1;
>
> I do not think this chunk is needed ?
> If @remaining is signed, then perhaps change the following line to:
>
> remaining =3D max_t(int, remaining, TCP_TIMEOUT_MIN);
>

The if (remaining <=3D 0) return 1 handles the already-expired case and
mirrors the logic in tcp_clamp_rto_to_user_timeout().

max_t(s32, remaining, TCP_TIMEOUT_MIN) with remaining changed to s32
also fixes the underflow; I used the explicit early return for symmetry
with the RTO helper, but I can switch that in v2 if you prefer.

> Also, it would be great to have a  new packetdrill test.
>

With packetdrill, AFAICS it would require a late ACK to be processed
after TCP_USER_TIMEOUT has elapsed but before tcp_probe_timer() runs the
abort check - i.e. a race between the RX softirq path and the timer.
This is not purely an event/packet ordering problem, so it is not clear
to me how a deterministic behavior can be simulated with packetdrill
without tying it to exact probe timing.

> >         remaining =3D max_t(u32, remaining, TCP_TIMEOUT_MIN);
> >
> >         return min_t(u32, remaining, when);
> > --
> > 2.43.0
> >

Thanks

