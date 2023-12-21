Return-Path: <netdev+bounces-59692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C2F81BC98
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 18:08:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861582840A9
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5145822D;
	Thu, 21 Dec 2023 17:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U12SdpwP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E8259908
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 17:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7811db57cb4so65066085a.0
        for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 09:07:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703178478; x=1703783278; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FmCRKRUpBy9ZPc6yTej9Koy6uWjJ+ei8EtSFS6dCLhc=;
        b=U12SdpwPMpIXGGVy9J8Zk6+Opq8vo6QMSyDVEyiK0bMZ3TlxNOy6titdk+PWiu1VXM
         +vzidyKcHKQrdEMKF/B6Cnbiwo7gfUZMQMOzMlD0dX6HxZZFo16UR7J+Iunm2wiyc2xY
         eVhYhmAtZMmHGCK3HbV/WdcquaF23MrlYi+LTzmCfc0eX5alJCwnb1Du3v8P6/52a5Wo
         BGiS81+wqnPl3VMMoNzsseCf0FY0+iKsA+YeI6RfDxwD2sNLvcC9sYOyzWskI6N++RzK
         ollIk+hpmXSfjEZ7SKw0TcgF+9uO7bdrqYUmCwv8pLVcSfzdQ73nRshl/jQztgfyZyZX
         3q1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703178478; x=1703783278;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FmCRKRUpBy9ZPc6yTej9Koy6uWjJ+ei8EtSFS6dCLhc=;
        b=etIn66RxjcScCmny6va0bNmUJSMYNPH836hNn3KG++BVrl4QDtsMDaYDgEAL4iMw26
         x0Gh5XWXAODusx1o3Tnmfh3RUfphbToy07vff0/vExeHVTUldZy2UKbELUcCUF5/qVIj
         ORvs8HRqcIFNY3jIAY/ypylfIYaUou47tpBSb9yErh5sG0kVcWNzBTwQVZm962QpBap7
         VVJFVxb9KVEkOngTkCEYVMKGwSmgu+bkrUc1aPoqajkIZGOWN5LPE1ZemlhrWd9Dbev6
         lruhTyGFSuqWvcObvLvMYPeKWqme9YWHrrzPg0e2v4NT8LVJCCVMW1PxT4jWMux+F39P
         0SpQ==
X-Gm-Message-State: AOJu0YyZcQAc7FWaLtO9ZrYI47QVR5jPM1bxm1SePzsmlax4djicCWyt
	TVo51jskNAjCeJxwg54M3oc=
X-Google-Smtp-Source: AGHT+IHewtv5ImuQWhN2Ksa7uIOsk55JL0WGOxWn8h/5Tu9foUwxIwG5SN7Um1C8+LoEVdXtjAI8WA==
X-Received: by 2002:a05:620a:11a6:b0:77f:71dd:d64 with SMTP id c6-20020a05620a11a600b0077f71dd0d64mr1301894qkk.13.1703178477704;
        Thu, 21 Dec 2023 09:07:57 -0800 (PST)
Received: from localhost (114.66.194.35.bc.googleusercontent.com. [35.194.66.114])
        by smtp.gmail.com with ESMTPSA id n8-20020a0cec48000000b0067f33b99ed1sm746157qvq.94.2023.12.21.09.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Dec 2023 09:07:57 -0800 (PST)
Date: Thu, 21 Dec 2023 12:07:56 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?SsO2cm4tVGhvcmJlbiBIaW56?= <jthinz@mailbox.tu-berlin.de>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Arnd Bergmann <arnd@arndb.de>, 
 Thomas Lange <thomas@corelatus.se>, 
 Netdev <netdev@vger.kernel.org>, 
 Deepa Dinamani <deepa.kernel@gmail.com>, 
 John Fastabend <john.fastabend@gmail.com>
Message-ID: <658470ecd37f1_82de329452@willemb.c.googlers.com.notmuch>
In-Reply-To: <7cf460a9eea4f52f928d8624fb9e8c54b7f15566.camel@mailbox.tu-berlin.de>
References: <a9090be2-ca7c-494c-89cb-49b1db2438ba@corelatus.se>
 <658266e18643_19028729436@willemb.c.googlers.com.notmuch>
 <0d7cddc9-03fa-43db-a579-14f3e822615b@app.fastmail.com>
 <bff57ee057bdd15a2c951ff8b6e3aaa30f981cd2.camel@mailbox.tu-berlin.de>
 <6582ffd3e5dc7_1a34a429482@willemb.c.googlers.com.notmuch>
 <7cf460a9eea4f52f928d8624fb9e8c54b7f15566.camel@mailbox.tu-berlin.de>
Subject: Re: net/core/sock.c lacks some SO_TIMESTAMPING_NEW support
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

J=C3=B6rn-Thorben Hinz wrote:
> On Wed, 2023-12-20 at 09:53 -0500, Willem de Bruijn wrote:
> > J=C3=B6rn-Thorben Hinz wrote:
> > > Hi Arnd,
> > > =

> > > thanks for indirectly pinging me here about the unfinished patches.=

> > > I
> > > kinda forgot about them over other things happening.
> > > =

> > > Happy to look back into them, it looks like it would be helpful to
> > > apply them. Is it fine to just answer the remarks from earlier this=

> > > year, after a few months, in the same mail thread? Or preferable to=

> > > resubmit the series[1] first?
> > =

> > Please resubmit instead of reviving the old thread. Thanks for
> > reviving
> > that.
> Thanks for the hint, will do so! (Maybe after Christmas.)
> =

> > =

> > IIRC the only open item was to limit the new BPF user to the new API?=

> > That only applies to patch 2/2.
> Another point was to not change the behavior of
> getsockopt(SO_TIMESTAMPING_OLD), that=E2=80=99s just a minor change.
> =

> About limiting BPF to the SO_TIMESTAMPING_NEW, I am unsure if this is
> feasible, necessary, or even makes a difference (for a BPF program). In=

> many places, BPF just passes-through calls like to get-/setsockopt(),
> only testing whether this call is explicitly allowed from BPF space.
> =

> Also, due to its nature, BPF code often has to re-provide defines, see
> for example tools/testing/selftests/bpf/progs/bpf_tracing_net.h This is=

> also the case for SO_TIMESTAMPING_*. A limitation of BPF to
> SO_TIMESTAMPING_NEW could only be done in the allowed get-/setsockopt()=

> calls, not through any BPF-provided defines.
> =

> I will take another look at this aspect and add my comments/findings to=

> a resubmission.
> =

> > =

> > The missing sk_getsockopt SO_TIMESTAMPING_NEW might be breaking
> > users,
> > so is best sent stand-alone to net, rather than net-next.
> Hmm, I initially sent both patches together and to bpf-next since the
> second, BPF-related patch depends (for the included selftest) on the
> first one already being applied.
> =

> I=E2=80=99m unsure how to split them because of the dependency. Would o=
ne add a
> comment that commit X needs to be pulled in from net for commit Y to be=

> applied in bpf-next? (That sounds bound to break something.)
>
> Also, getsockopt(SO_TIMESTAMPING_NEW) has been missing since 2019,
> since SO_TIMESTAMPING_NEW was added. Do you think it is still "urgent"
> enough to provide it through net instead of net-next/bpf-next?

net gets pulled into net-next at least once a week. If you submit this
patch now, it will likely be in bpf-next by the time we get to the
second more involved patch.

This report was a reminder that the current omission can actually
break users, so having it as a fix that goes to stable is warranted.
The Fixes tag will be

Fixes: 9718475e6908 ("socket: Add SO_TIMESTAMPING_NEW")


> > =

> > > Thorben
> > > =

> > > [1]
> > > https://lore.kernel.org/lkml/20230703175048.151683-1-jthinz@mailbox=
.tu-berlin.de/
> > > =

> > > On Wed, 2023-12-20 at 09:43 +0000, Arnd Bergmann wrote:
> > > > On Wed, Dec 20, 2023, at 04:00, Willem de Bruijn wrote:
> > > > > Thomas Lange wrote:
> > > > > > diff --git a/net/core/sock.c b/net/core/sock.c
> > > > > > index 16584e2dd648..a56ec1d492c9 100644
> > > > > > --- a/net/core/sock.c
> > > > > > +++ b/net/core/sock.c
> > > > > > @@ -2821,6 +2821,7 @@ int __sock_cmsg_send(struct sock *sk,
> > > > > > struct cmsghdr *cmsg,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 sockc->mark =3D *(u32 *)CMSG_DATA(cmsg)=
;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 break;
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIME=
STAMPING_OLD:
> > > > > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 case SO_TIMESTAMPING_NE=
W:
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (cmsg->cmsg_len !=3D CMSG_LEN(sizeof=
(u32)))
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return -EINVAL;
> > > > > > =

> > > > > > However, looking through the module, it seems that
> > > > > > sk_getsockopt() has no
> > > > > > support for SO_TIMESTAMPING_NEW either, but sk_setsockopt()
> > > > > > has.
> > > > > =

> > > > > Good point. Adding the author to see if this was a simple
> > > > > oversight
> > > > > or
> > > > > there was a rationale at the time for leaving it out.
> > > > =

> > > > I'm fairly sure this was just a mistake on our side. For the cmsg=

> > > > case,
> > > > I think we just missed it because there is no corresponding
> > > > SO_TIMESTAMP{,NS}
> > > > version of this, so it fell through the cracks.
> > > > =

> > > > In the patch above, I'm not entirely sure about what needs to
> > > > happen
> > > > with the old/new format, i.e. the
> > > > =

> > > > =C2=A0=C2=A0 sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname =3D=3D=

> > > > SO_TIMESTAMPING_NEW)
> > > > =

> > > > from setsockopt(). Is __sock_cmsg_send() allowed to turn on
> > > > timestamping
> > > > without it being first enabled using setsockopt()? If so, I think=

> > > > we need to set the flag here the same way that setsockopt does.
> > > > If
> > > > not, then I think we instead should check that the old/new format=

> > > > in the option sent via cmsg is the same that was set earlier with=

> > > > setsockopt.
> > =

> > __sock_cmsg_send can only modify a subset of the bits in the
> > timestamping feature bitmap, so a call to setsockopt is still needed
> > =

> > But there is no ordering requirement, so the __sock_cmsg_send call
> > can
> > come before the setsockopt call. It would be odd, but the API allows
> > it.
> > > > =

> > > > For the missing getsockopt, there was even a patch earlier this
> > > > year
> > > > by J=C3=B6rn-Thorben Hinz [1], but I failed to realize that we ne=
ed
> > > > patch
> > > > 1/2 from his series regardless of patch 2/2.
> > > > =

> > > > =C2=A0=C2=A0=C2=A0=C2=A0 Arnd
> > > > =

> > > > [1]
> > > > https://lore.kernel.org/lkml/20230703175048.151683-2-jthinz@mailb=
ox.tu-berlin.de/
> > > =

> > =

> > =

> =




