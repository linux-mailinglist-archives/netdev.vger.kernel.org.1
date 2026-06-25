Return-Path: <netdev+bounces-301991-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id j2R1FvtCPWrc0QgAu9opvQ
	(envelope-from <netdev+bounces-301991-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:02:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B186A6C6E87
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Psi9Oqa8;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301991-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-301991-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 37979303BB94
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3BD3E7BC2;
	Thu, 25 Jun 2026 15:02:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CDD3DC856
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:02:13 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782399735; cv=pass; b=TXdNMdBhZYS8Q2lZ/jGgSiZlLsjZKq4EQMDcY2KyBSn+CpECWbCGk3Kqcnlsk7mcy9mZo6X9NkAfKP3+xb+JwbgnGC7R/OcBDH6tJOi08qFy/9d3R1x4edNVYeukX9U5sgNGbvb3wxYVvcvp21AGFlZ8omtEUgFoz2IyS4mQ1DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782399735; c=relaxed/simple;
	bh=HIeVhErbP2tFuXUakeJ57jOMeSSFkYm+yxSGx4IMpYM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fWQCLTmW+/q0MxNYHaZRbi554CkFWinkXw33NH7UXfLbaj1/5z/Tp+s8eRYksyb5x3+b94hp04PcqinDypsBH8wmcVLjPCg6e6k2TW82DuQUPS5q5h8GZU1XbKUZXBrjA2emANx3SknZ6AGZObweMB6TOWNoRFuHNgM8Znjkt38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Psi9Oqa8; arc=pass smtp.client-ip=209.85.219.52
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-8ddd7bad263so21612546d6.2
        for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 08:02:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782399732; cv=none;
        d=google.com; s=arc-20260327;
        b=ozaXJa5b8bjPkSm8q4YvwH8tis0A2Zu4SXXYoSbmDy1CCyN5mhg53wGNDiLuEZA4bJ
         5Tn7ADwQmNgMBC70xf1otuNdxb8uyF5ZOyH3q2qXnC8Z/L/K4P2tVLaAoTHfxJYriU6H
         s5lyHKGU18gTA8v9EjIcVZcGF7IJKdf/7DJVa6lC4h32wLUfYUge4eXOoRGwS3AhPIms
         5qSA9b8y5CPu10PQoljos+yW+0yXhbimoR7i5WSARRD2zlRI+aVu1t6n0+zApKxXn+dJ
         i43RsYNTEPVl6gUBr796J+V4WczCZccKwptf5nTUv164fJoTSCHen35GS/EvhBmlZC4D
         0SkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hdsXaMcfpS69v0Arn3SsCt3rcRq1UgYdzoDCfYVoQuo=;
        fh=KTp19Zd5iMnVIT0VmGC9Qjrn6tEqvtrRF8bLnNiyb+E=;
        b=farJrF3xFhOiym8Eg+raKSyWJE+oiY/pGqRAWYHmF53AUu54DxsF2qZICx9ZcYb7P3
         R/g2c8MHnmB3VfV9dTYa5QTndwf6mURgO9iQfDeaT3jmY6GymtIR2MYV7F0AIhMeJKBH
         5BOZa/hwbAwNhOy+9+/vfx5O9ZsOLLzfc74KTyWpDNZrf7V6NAmYz4gzqBfNd40H45X2
         sslgcl66b6mRI/YMKMRMJ980v7+K1+JxjE2pS9ELxB2UCKZBZhQ4ytRuz+lgiu3j7wSw
         UFS2+UtbX5NVjZQRL3rt6oQxtQ4YDUOH8rBdORqe/yUCR24sj4HLhgYR0lBK2QDeWVwL
         YG6Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782399732; x=1783004532; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hdsXaMcfpS69v0Arn3SsCt3rcRq1UgYdzoDCfYVoQuo=;
        b=Psi9Oqa8XNFsXuTbqP20KWonAzkR5ygGhRoCfjqAncjpkql8RBe1nW1AH9qlVzS4eJ
         J+f8KjOK7KS982POOE0/DBAe+mcNWOErjXMimDGgramL+dd8HodZMu9G0c1q/v7QJXau
         fnhU+NXNBnjqLNZ+aCraIde1i34dRHPZvkUlGGSLHE+66ytsh7lM7NpsKce/TB9LPnav
         tgzMnlNMWTr312bxKxF3khIkR5ktnsb8rgYP3VjZAacSu0MTlA2HBEzLhdA9e5YNRNd2
         5yVBESYkLW2OwZLLUO6+vX/28MrgH1yj5BbO4mPfFMA1re2spsaTafIfzmvHbFx/gINW
         3qwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782399732; x=1783004532;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hdsXaMcfpS69v0Arn3SsCt3rcRq1UgYdzoDCfYVoQuo=;
        b=Kof3nFJVCaLSX17zlmKk8vQA9M3NE9k55rPu7bOjk8CIycN+HYrd0zSW6Tr8bUCt1n
         kAGL67KZliaxyUSBV2pxrx25I5eb0bbXrC/e/oVNe3bc+mgS7QYuXOHx5428ifKVhELk
         s0sGbcjY/kdfbDqLmR8v2cDGPSk+bgk/XrYX2MvaWJr35r+NycyT3v9MNTy5uQ9ayB9n
         miLLSAC3csfHdX2HoS47NjXzBr42VmWnkTLXyHG9nOqnoT+2i70ExUKqUYMhALw1jMq8
         fpi88DkvjRbpwMMbW2YRK6Pyh3ylkWZsXgHmRdffy3njLPSV8aWgKeXPW05vOEBtWazP
         rIKA==
X-Forwarded-Encrypted: i=1; AHgh+Rq0Kx/tpXbOPSOccEEV4xAx3K81n9ptWeMhsM5oiM3LzxcqmwiwccnMs9l9qAin6xJfrFkdt2Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyC/zeZ6IjEVIrgsFibgo+WSoOmHYMvxGGilHXENEg+y2YP+qG
	/2D/UwSPChkShdkm6aCE3EHSsikAOB7jGSV0vqfrzii1/ueHaGVOR8X6UXZzkWzx7by+EkMVpP+
	btiJ/Wgya03kQ2ber9trgM83swDg6hbFf+juw
X-Gm-Gg: AfdE7ckFo/VF39bnK2CC1k4GeSOIKzvB4mER3TSJpeZRCGwuVjCiYfgtO48V7oWMgij
	L8rw7wYfwjP/0L202BF54e4skOeD784YLQuDmvuOjWG+gO/lJWdJiQWH8dmAV6EKvICYTv4lGIj
	wMGym6ct7JWIr9rTZpZomvgReukxXI3UzbvAZaXh8+izUtOJPVyEnaNapQGMATD2hxUaQAaJHg0
	tSQr458ly6I1Kd59Wtt0uTNoy9qDqlqQh1rpVopiJSUZXjbEKAj8DehSMpCveTBOWH9mZ36phyH
	Uc3zYBkVornB3sbA2L/QFbpO2DWfOyz9QXJfcnO/yyLET8fInmDaI7Vk
X-Received: by 2002:a05:6214:3bc2:b0:8c7:76cf:5088 with SMTP id
 6a1803df08f44-8e6cfb6e1f9mr59877076d6.0.1782399731573; Thu, 25 Jun 2026
 08:02:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260530224646.160777-1-manishbaing2789@gmail.com>
 <20260531101237.13c5580d@pumpkin> <CAJvdc_fwRc8QH=DHPtTNiWEg3bm0qqs_-jOwDQ4frUJLLfCQPQ@mail.gmail.com>
 <CAJvdc_fTNPbJcgVv4kTe7VP9ibrzECHkad8Uyan8KrP-=WTyOQ@mail.gmail.com>
In-Reply-To: <CAJvdc_fTNPbJcgVv4kTe7VP9ibrzECHkad8Uyan8KrP-=WTyOQ@mail.gmail.com>
From: Manish Baing <manishbaing2789@gmail.com>
Date: Thu, 25 Jun 2026 20:31:59 +0530
X-Gm-Features: AVVi8Ce2ZLFOBGb781YNFuMp_wrhWJ56VvqEoDXJhZi6wLgoLv6ZFZC5TMHzsvw
Message-ID: <CAJvdc_ek_UY9TU7+6Ng6dcofwHu7wxpTCq3QwAuPHGrVGZ=ADg@mail.gmail.com>
Subject: Re: [PATCH v2] mctp: serial: replace memset with zero-initialization
To: David Laight <david.laight.linux@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-301991-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[manishbaing2789@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:david.laight.linux@gmail.com,m:jk@codeconstruct.com.au,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:davidlaightlinux@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[manishbaing2789@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B186A6C6E87

Hi David,
Just a quick follow-up on this thread.
Please let me know how you would like me to proceed with this patch.

Thanks & Regards ,
Manish

On Sun, Jun 7, 2026 at 1:20=E2=80=AFAM Manish Baing <manishbaing2789@gmail.=
com> wrote:
>
> Hi David,
>
> Just a quick follow-up on this thread. When you have a moment, I would
> love to hear your thoughts on my previous email.
> Please let me know how you would like me to proceed with this patch.
>
> Thanks & Regards ,
>  Manish
>
> On Sun, May 31, 2026 at 3:06=E2=80=AFPM Manish Baing <manishbaing2789@gma=
il.com> wrote:
> >
> > Hi David,
> >
> > I understand that this might just be unnecessary churn for the
> > networking subsystem, and I am perfectly fine dropping the patch if
> > that is the case.
> >
> > However, for my own learning, I would love to get your perspective on
> > this. I was carrying over a pattern from recent cleanups in the IIO
> > subsystem [1],
> > as empty brace initialization was noted as the preferred approach in
> > those discussions (including by Kees Cook [2]).
> >
> > Is the reasoning behind that recommendation just not applicable to
> > netdev,or is the policy here strictly against code churn unless it
> > fixes a tangible bug?
> >
> > Thanks for the guidance.
> >
> > [1]: https://lore.kernel.org/all/20250611-iio-zero-init-stack-with-inst=
ead-of-memset-v1-0-ebb2d0a24302@baylibre.com/
> > [2]: https://lore.kernel.org/linux-iio/202505090942.48EBF01B@keescook/
> >
> > Regards,
> > Manish
> >
> >
> > On Sun, May 31, 2026 at 2:42=E2=80=AFPM David Laight
> > <david.laight.linux@gmail.com> wrote:
> > >
> > > On Sat, 30 May 2026 22:46:46 +0000
> > > Manish Baing <manishbaing2789@gmail.com> wrote:
> > >
> > > > Use empty brace initialization (=3D {}) instead of explicit memset(=
)
> > > > to zero-initialize stack memory to simplify the code.
> > > >
> > > > No functional change.
> > >
> > > Isn't it also entirely pointless?
> > >
> > > -- David
> > >
> > > >
> > > > Signed-off-by: Manish Baing <manishbaing2789@gmail.com>
> > > > ---
> > > > Changes in v2:
> > > > - Fixed a compilation error caused by a duplicate variable declarat=
ion caught
> > > >   by the kernel test robot.
> > > >
> > > >  drivers/net/mctp/mctp-serial.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp=
-serial.c
> > > > index 26c9a33fd636..df721ca4e07b 100644
> > > > --- a/drivers/net/mctp/mctp-serial.c
> > > > +++ b/drivers/net/mctp/mctp-serial.c
> > > > @@ -536,13 +536,12 @@ struct test_chunk_tx {
> > > >
> > > >  static void test_next_chunk_len(struct kunit *test)
> > > >  {
> > > > -     struct mctp_serial devx;
> > > > +     struct mctp_serial devx =3D { };
> > > >       struct mctp_serial *dev =3D &devx;
> > > >       int next;
> > > >
> > > >       const struct test_chunk_tx *params =3D test->param_value;
> > > >
> > > > -     memset(dev, 0x0, sizeof(*dev));
> > > >       memcpy(dev->txbuf, params->input, params->input_len);
> > > >       dev->txlen =3D params->input_len;
> > > >
> > >

