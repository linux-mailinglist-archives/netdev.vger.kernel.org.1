Return-Path: <netdev+bounces-50594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6B97F63F7
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 17:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E283281A20
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 16:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9BA83FB21;
	Thu, 23 Nov 2023 16:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pTAB8MJV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F6410C7
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:32:26 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-548ae9a5eeaso11927a12.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 08:32:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700757145; x=1701361945; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kHnx14cr1yCK8qle9tu2EE/pgUOBSdUP8QNopUBV1ok=;
        b=pTAB8MJVLfCdKrBFt3EDg5XJN+BVkaCDpdEBi6MO4zb45FMBKy+MXcjfoRdWcpYcB6
         9kHJ+ZHf/sBinz8UeEqoBleBmmzneFnTJcRxBtYx9Ht34zhCroTZoVgHibgyjrlTwIKB
         zQgsjxRdrFZFF/wBeDXXhhjpmDbxzrzA+Ln1VPP+hs5VAmbzU3BXaMCxpTLHYRcgtZRU
         NiWEo4aRf/qHUx3C/JXxXEyRfZI7C4mNIi0PnFpXhXxikU6xF2QdTy7ZJlFnPSHCHVJG
         0+bhYEUmdICIRUuhX0dJr0GpDqRv097OgbWFkGy55fOOBL4zzJlMS7CSifvzSy+ZVUl7
         m4hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700757145; x=1701361945;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kHnx14cr1yCK8qle9tu2EE/pgUOBSdUP8QNopUBV1ok=;
        b=DfzfIdjIt1B0jvBg8Li4VMbgOVQp/+mc3lfAe+rJP5Eyh1uMr/Zxd00SWdisyWaua2
         E+qVEsdeD70B97jPAt4mIauOiYy8yYj0xYF8dxLC280jfemgKqcT2rngI1eRNfyfDzec
         9G6xu2CXB47M3vuGvPSxZzF4X9cyn78cxtsTC5yh5xtmrLVocT1cbtQBXYz5LIlnjTo8
         VddgU8vhqF1NDmRkcGTnyYvCzxzHOWaN6Q8EjovNOT9Fcw71ZZtqsIO6geXkQuu46Tmt
         aA0QGp3VnsrVUwdoIsDe9d7ypF2a2YuOX7oTL4BtITf2LjqQKKXPuRH7Pl71Cn9hoMx+
         c33w==
X-Gm-Message-State: AOJu0YwMFaBydwo0PSV2PgTH/R+KUp4VfikmM8qbKbYBOItEA57dLtmK
	uXwzzonh+1tvYisbLIqa2EqnrvbauHY+gkPIagmu9Q==
X-Google-Smtp-Source: AGHT+IERAzT2DH14wnLepk/HR1XspkDfoaCAepJVb9iyd7gTXAqiNiKYOdIkOlYeflAbx8t1ArAm/oe72C+mWNV5/sc=
X-Received: by 2002:a05:6402:35ca:b0:544:24a8:ebd with SMTP id
 z10-20020a05640235ca00b0054424a80ebdmr390780edc.4.1700757144364; Thu, 23 Nov
 2023 08:32:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231115210509.481514-1-vschneid@redhat.com> <20231115210509.481514-2-vschneid@redhat.com>
 <CANn89iJPxrXi35=_OJqLsJjeNU9b8EFb_rk+EEMVCMiAOd2=5A@mail.gmail.com> <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
In-Reply-To: <CAD235PRWd+zF1xpuXWabdgMU01XNpvtvGorBJbLn9ny2G_TSuw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 23 Nov 2023 17:32:10 +0100
Message-ID: <CANn89iKRSKz0e8v+Z-UsKGs4fQWDt6eTAw71VENbSmfkEicTPA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] tcp/dcpp: Un-pin tw_timer
To: Valentin Schneider <vschneid@redhat.com>
Cc: dccp@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-users@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, 
	Juri Lelli <juri.lelli@redhat.com>, Tomas Glozar <tglozar@redhat.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2023 at 3:34=E2=80=AFPM Valentin Schneider <vschneid@redhat=
.com> wrote:
>
> Hi Eric,
>
> On Mon, 20 Nov 2023 at 18:56, Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Wed, Nov 15, 2023 at 10:05=E2=80=AFPM Valentin Schneider <vschneid@r=
edhat.com> wrote:
> > >
> > > @@ -53,16 +53,14 @@ void dccp_time_wait(struct sock *sk, int state, i=
nt timeo)
> > >                 if (state =3D=3D DCCP_TIME_WAIT)
> > >                         timeo =3D DCCP_TIMEWAIT_LEN;
> > >
> > > -               /* tw_timer is pinned, so we need to make sure BH are=
 disabled
> > > -                * in following section, otherwise timer handler coul=
d run before
> > > -                * we complete the initialization.
> > > -                */
> > > -               local_bh_disable();
> > > -               inet_twsk_schedule(tw, timeo);
> > > -               /* Linkage updates.
> > > -                * Note that access to tw after this point is illegal=
.
> > > -                */
> > > +              local_bh_disable();
> > > +
> > > +               // Linkage updates
> > >                 inet_twsk_hashdance(tw, sk, &dccp_hashinfo);
> > > +               inet_twsk_schedule(tw, timeo);
> >
> > We could arm a timer there, while another thread/cpu found the TW in
> > the ehash table.
> >
> >
> >
> > > +               // Access to tw after this point is illegal.
> > > +               inet_twsk_put(tw);
> >
> > This would eventually call inet_twsk_free() while the timer is armed.
> >
> > I think more work is needed.
> >
> > Perhaps make sure that a live timer owns a reference on tw->tw_refcnt
> > (This is not the case atm)
> >
>
> I thought that was already the case, per inet_twsk_hashdance():
>
> /* tw_refcnt is set to 3 because we have :
>  * - one reference for bhash chain.
>  * - one reference for ehash chain.
>  * - one reference for timer.
>
> and
>
> tw_timer_handler()
> `\
>   inet_twsk_kill()
>   `\
>     inet_twsk_put()
>
> So AFAICT, after we go through the hashdance, there's a reference on
> tw_refcnt held by the tw_timer.
> inet_twsk_deschedule_put() can race with arming the timer, but it only
> calls inet_twsk_kill() if the timer
> was already armed & has been deleted, so there's no risk of calling it
> twice... If I got it right :-)
>

Again, I think you missed some details.

I am OOO for a few days, I do not have time to elaborate.

You will need to properly track active timer by elevating
tw->tw_refcnt, or I guarantee something wrong will happen.

