Return-Path: <netdev+bounces-53012-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E42B8011C6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 18:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D65831F20ECE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 17:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D3D64E1CF;
	Fri,  1 Dec 2023 17:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AMfJpfQi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBF3FE
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 09:35:50 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c69c61b58so5739a12.1
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 09:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701452149; x=1702056949; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ighLnsNKlGEusYnZIjGHrM2bIKvbBxs/6auQXEZuSN0=;
        b=AMfJpfQiDfFYNcWeOkGzGOHDkko09NqMw6fDuBblGyattyuGgepMCiW7Uit963abTS
         x2hgcXMIWmBJIYYsGrbBw46/PavVlPds1m/qFRBR8YlQUUCfE31ZSCNdTBIaV6NOLB2v
         6J3BDoozJd5A2WpcYccg159t9xApaU+FWn+n/csJx8sH7TPAxHg0jnwjfQgv5SnWyce6
         E5nMlk38O86uiw65dvMJpk6kSIH/Mp+NGqpOl4ijFUsSzPCTWLVxJmITmkA1xi7pug0F
         UV1lKHBJxUHGhrETd73GTKqAolcJcp2GDiBRdulmvnqi+ljqERk1ch6q4l2Vpt9ZnYyc
         lXhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452149; x=1702056949;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ighLnsNKlGEusYnZIjGHrM2bIKvbBxs/6auQXEZuSN0=;
        b=pQ+Ddic6aL+Z3DKfw/218U95vr7kce4P1jn5GH//uXhR1CeSUczy5rUpTGYtNt2sVl
         qBXAleq6PZVq2bteGBE4mQl/2bXO40umtjWKDaNQqh7jDpxDpAbRS9tnftSHbjDvZar6
         b5T7JOBnkpRp/bKrmoKOS0SwUpSZgAej0XX+4vvDbVF9VykGq+m4POL7Mq/zkgvmpToe
         CvF/Xo+Q6yrsEXv8XB2H07SZ8/tqh+QQbML95tArOOwca0rWcyLyGpcMV9ToUCvMiQrT
         cx2Oq2NoQrPj+3BDt49AEH/P8I687BY3cWw9PiaNlPZMITkuX+DJ9PBa2kxbYume+yqo
         SWSg==
X-Gm-Message-State: AOJu0Yz7Bso9zYNG9AoM4v+IuQp++m/1NS0dyOsa+hZcdvWmKZLOlB2G
	wNhk7LNn7Ykxoagg4U+ZqKn1TuU4AeaafkaYSqyvOg==
X-Google-Smtp-Source: AGHT+IGOOWqrh7Pf7APXQCtAvo3OP32OjLA+KHU1DDueB4Pq6swavliS5/BSDYQUBoSU6stfcmOY/hUFfu5ApdRtIrg=
X-Received: by 2002:a50:c31b:0:b0:54c:44c7:4d4 with SMTP id
 a27-20020a50c31b000000b0054c44c704d4mr161793edb.2.1701452148022; Fri, 01 Dec
 2023 09:35:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231201083926.1817394-1-judyhsiao@chromium.org>
 <CANn89iJMbMZdnJRP0CUVfEi20whhShBfO+DAmdaerhiXfiTx5A@mail.gmail.com>
 <CAD=FV=Vf18TxUWpGTN9b=iECq=5BmEoopQjsMH2U6bDX2=T3cQ@mail.gmail.com>
 <CANn89iLzmKOGhMeUUxeM=1b2PP3kieTeYsmpfA0GvJdcQMkgtQ@mail.gmail.com> <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
In-Reply-To: <CAD=FV=UxS9qxYNdd+kqtW3VRSK=0H9ZPgW=CeSEjfbJXut+PaQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 1 Dec 2023 18:35:34 +0100
Message-ID: <CANn89iLuY3dg6tpJCosGVOVR2FbT09DGXZpfb+zuW_BnPVf32g@mail.gmail.com>
Subject: Re: [PATCH v1] neighbour: Don't let neigh_forced_gc() disable
 preemption for long
To: Doug Anderson <dianders@chromium.org>
Cc: Judy Hsiao <judyhsiao@chromium.org>, David Ahern <dsahern@kernel.org>, 
	Simon Horman <horms@kernel.org>, Brian Haley <haleyb.dev@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Joel Granados <joel.granados@gmail.com>, Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 1, 2023 at 6:16=E2=80=AFPM Doug Anderson <dianders@chromium.org=
> wrote:
>
> Hi,
>
> On Fri, Dec 1, 2023 at 7:58=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
> >
> > On Fri, Dec 1, 2023 at 4:16=E2=80=AFPM Doug Anderson <dianders@chromium=
.org> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Dec 1, 2023 at 1:10=E2=80=AFAM Eric Dumazet <edumazet@google.=
com> wrote:
> > > >
> > > > On Fri, Dec 1, 2023 at 9:39=E2=80=AFAM Judy Hsiao <judyhsiao@chromi=
um.org> wrote:
> > > > >
> > > > > We are seeing cases where neigh_cleanup_and_release() is called b=
y
> > > > > neigh_forced_gc() many times in a row with preemption turned off.
> > > > > When running on a low powered CPU at a low CPU frequency, this ha=
s
> > > > > been measured to keep preemption off for ~10 ms. That's not great=
 on a
> > > > > system with HZ=3D1000 which expects tasks to be able to schedule =
in
> > > > > with ~1ms latency.
> > > >
> > > > This will not work in general, because this code runs with BH block=
ed.
> > > >
> > > > jiffies will stay untouched for many more ms on systems with only o=
ne CPU.
> > > >
> > > > I would rather not rely on jiffies here but ktime_get_ns() [1]
> > > >
> > > > Also if we break the loop based on time, we might be unable to purg=
e
> > > > the last elements in gc_list.
> > > > We might need to use a second list to make sure to cycle over all
> > > > elements eventually.
> > > >
> > > >
> > > > [1]
> > > > diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> > > > index df81c1f0a57047e176b7c7e4809d2dae59ba6be5..e2340e6b07735db8cf6=
e75d23ef09bb4b0db53b4
> > > > 100644
> > > > --- a/net/core/neighbour.c
> > > > +++ b/net/core/neighbour.c
> > > > @@ -253,9 +253,11 @@ static int neigh_forced_gc(struct neigh_table =
*tbl)
> > > >  {
> > > >         int max_clean =3D atomic_read(&tbl->gc_entries) -
> > > >                         READ_ONCE(tbl->gc_thresh2);
> > > > +       u64 tmax =3D ktime_get_ns() + NSEC_PER_MSEC;
> > >
> > > It might be nice to make the above timeout based on jiffies. On a
> > > HZ=3D100 system it's probably OK to keep preemption disabled for 10 m=
s
> > > but on a HZ=3D1000 system you'd want 1 ms. ...so maybe you'd want to =
use
> > > jiffies_to_nsecs(1)?
> >
> > I do not think so. 10ms would be awfully long.
> >
> > We have nsec based time service, why downgrading to jiffies resolution =
???
>
> Well, the whole issue is that we're disabling preemption, right?
> Unless I'm mistaken, on a 1000 HZ system then a task's timeslice is
> 1ms and on a 100 HZ system then a task's timeslice is 10ms. When we
> disable preemption then the problem is that we can keep going past the
> end of our timeslice. This is bad for whatever task the system is
> trying to schedule instead of us since it will be blocked waiting for
> us to re-enable preemption.
>
> So essentially the problem here is really tied to jiffies resolution,
> right? Specifically, if jiffies is 100 Hz then it's actually
> inefficient to timeout every 1 ms--I think it would be better to use
> up our whole timeslice.

It is not because a kernel is built with HZ=3D100 that each thread has
to consume cpu times in 10ms slices.

Process scheduler does not use jiffies at all, but high resolution time ser=
vice.

Keep in mind this code is run from soft-interrupt, not a dedicated processu=
s.

>
>
> > > One worry might be that we disabled preemption _right before_ we were
> > > supposed to be scheduled out. In that case we'll end up blocking some
> > > other task for another full timeslice, but maybe there's not a lot we
> > > can do there?
> >
> > Can you tell us in which scenario this gc_list can be so big, other
> > than fuzzers ?
>
> The place we hit this wasn't actually with fuzzers but with normal
> usage in our labs. The only case where it was a really big problem was
> when neigh_forced_gc() was scheduled on a "little" CPU (in a
> big.LITTLE system) and that little CPU happened to be running at the
> lowest CPU frequency. Specifically Judy was testing on sc7180-trogdor
> and the lowest CPU Frequency of the "little" CPUs was 300 MHz. Since
> the littles are less powerful than the bigs, this is roughly the
> equivalent processing power of a big core running at 120 MHz.
>
> FWIW, we are apparently no longer seeing the bad latency after
> <https://crrev.com/c/4914309>, which does this:
>
> # Increase kernel neighbor table size.
> echo 1024 > /proc/sys/net/ipv4/neigh/default/gc_thresh1
> echo 4096 > /proc/sys/net/ipv4/neigh/default/gc_thresh2
> echo 8192 > /proc/sys/net/ipv4/neigh/default/gc_thresh3
> echo 1024 > /proc/sys/net/ipv6/neigh/default/gc_thresh1
> echo 4096 > /proc/sys/net/ipv6/neigh/default/gc_thresh2
> echo 8192 > /proc/sys/net/ipv6/neigh/default/gc_thresh3
>
> However, I still believe that we should land something like Judy's
> patch because, no matter what kernel tunings we have, the kernel
> shouldn't be disabling preemption for so long.

Sure, and I suggested a refinement, because as I said jiffies can
stick to a value.

Not sure why a refinement given by a network maintainer is not an option ?

I must be missing something.

>
> I will also note that, while I don't know the code at all, someone on
> our networking team commented this: High CPU usage / latency on
> neigh_cleanup_and_release is expected naturally because of our
> relatively-noisy lab environment: there are often hundreds if not
> thousands of devices + virtual devices in a single L2 network.

Well, I know this code a bit, trust me.

