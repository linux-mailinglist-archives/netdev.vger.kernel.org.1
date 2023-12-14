Return-Path: <netdev+bounces-57422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D731681312B
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 14:18:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668401F20FFA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 13:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34FC54BC8;
	Thu, 14 Dec 2023 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z88tR6GF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45BE710E
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:17:58 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5526993db9fso9737a12.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 05:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702559877; x=1703164677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Nzz009bCK5F2i7STK4T3mKQ2BTIc8hB5IsTWQ0ncsg=;
        b=z88tR6GF8aiR3bhtWIBNrYtNhSX/cQv6OO+/jUrB7iRTsgV9fTdI7mAwcXm5cuez6+
         2QVYyFKDlf9m7PGJzhZQI8VfKTpBAcRjkJ0JVw3fc4E9TCAYALW4CONQ8JBOi9rp5RNd
         mTEq53XjX/7RJXOpYKrt9KYyR9OFeIIH/JzBAxEsFLzOV3dn+cqRdMjo2VbNnHqzGZgZ
         HDTXdFn3eKkeL5SguWu4YzMWWZv1TADIIFllFoHm1XFDzHuS0c4b7dQH3n3tHd2Bf6cI
         d2ZMu0QALYWXr0aZA9BSlaHsSiuPw5XP2E68vgaA7wIq5ywEwDf541U8SEg156CfkY+w
         xFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702559877; x=1703164677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/Nzz009bCK5F2i7STK4T3mKQ2BTIc8hB5IsTWQ0ncsg=;
        b=ZSEVDtZshhuC/58OR7E0oWo2fJBZvHmuQ1G5mXpOECyQf1zqbmdQQEWvFBpd2/uE0Y
         AT+freh9MJ2t10zDor7+q3hsGNDY+V3shpekFMBuHFcwrY4H2fnYWDO29w+UTnqWX3FC
         nhwSF9MQlp1R7tyHFAahbfHTt0KY4ssLJghdeWIzSfA3U4BeE6aFV9W+j2lVpWq9aa1X
         V0xWJ26QNyBV93MFaCdqRRfaJXriBVBwPMJr0PWRuLnmDFnPrEkQGK1suuKCGCSmG8v8
         p13RdcvCVlKWZ7lJC6+InaEIL70PjATHZbCs5h/18wMDXn+HY61cL1B2OA5V2/oeyIgB
         a2Xw==
X-Gm-Message-State: AOJu0YxIN/FSGJ4S7mbUDxn+zB7coyxE4spshZTqBjTrx3nfIj7ra6am
	cYGB57mmhsTCGyAHCDCuNrun0Q/7tIG/86PFPwx1uQ==
X-Google-Smtp-Source: AGHT+IHmopDQbJwS5mno7KGH25ei4JUtKSc6D3yADawqMJyR9i5N3wMeEvFVOjLyf9nJN7oXuj7wZ/3bLPYej3tYQ4Q=
X-Received: by 2002:a50:bacf:0:b0:545:279:d075 with SMTP id
 x73-20020a50bacf000000b005450279d075mr624515ede.1.1702559876549; Thu, 14 Dec
 2023 05:17:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231210111033.1823491-1-maze@google.com> <ebf480701cd22da00c89c5b1b00d31be95ff8e4d.camel@redhat.com>
In-Reply-To: <ebf480701cd22da00c89c5b1b00d31be95ff8e4d.camel@redhat.com>
From: =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date: Thu, 14 Dec 2023 14:17:44 +0100
Message-ID: <CANP3RGfk6PqR2P8HnGX92ODnf6V5iKb+_zjonOsTDOB-3odM5g@mail.gmail.com>
Subject: Re: [PATCH] net: sysctl: fix edge case wrt. sysctl write access
To: Paolo Abeni <pabeni@redhat.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Flavio Crisciani <fcrisciani@google.com>, "Theodore Y. Ts'o" <tytso@google.com>, 
	"Eric W. Biederman" <ebiederm@xmission.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 10:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> wr=
ote:
>
> On Sun, 2023-12-10 at 03:10 -0800, Maciej =C5=BBenczykowski wrote:
> > The clear intent of net_ctl_permissions() is that having CAP_NET_ADMIN
> > grants write access to networking sysctls.
> >
> > However, it turns out there is an edge case where this is insufficient:
> > inode_permission() has an additional check on HAS_UNMAPPED_ID(inode)
> > which can return -EACCES and thus block *all* write access.
> >
> > Note: AFAICT this check is wrt. the uid/gid mapping that was
> > active at the time the filesystem (ie. proc) was mounted.
> >
> > In order for this check to not fail, we need net_ctl_set_ownership()
> > to set valid uid/gid.  It is not immediately clear what value
> > to use, nor what values are guaranteed to work.
> > It does make sense that /proc/sys/net appear to be owned by root
> > from within the netns owning userns.  As such we only modify
> > what happens if the code fails to map uid/gid 0.
> > Currently the code just fails to do anything, which in practice
> > results in using the zeroes of freshly allocated memory,
> > and we thus end up with global root.
> > With this change we instead use the uid/gid of the owning userns.
> > While it is probably (?) theoretically possible for this to *also*
> > be unmapped from the /proc filesystem's point of view, this seems
> > much less likely to happen in practice.
> >
> > The old code is observed to fail in a relatively complex setup,
> > within a global root created user namespace with selectively
> > mapped uid/gids (not including global root) and /proc mounted
> > afterwards (so this /proc mount does not have global root mapped).
> > Within this user namespace another non privileged task creates
> > a new user namespace, maps it's own uid/gid (but not uid/gid 0),
> > and then creates a network namespace.  It cannot write to networking
> > sysctls even though it does have CAP_NET_ADMIN.
>
> I'm wondering if this specific scenario should be considered a setup
> issue, and should be solved with a different configuration? I would
> love to hear others opinions!

While it could be fixed in userspace.  I don't think it should:

The global root uid/gid are very intentionally not mapped in (as a
security feature).
So that part isn't changeable (it's also a system daemon and not under
user control).

The user namespace very intentionally maps uid->uid and not 0->uid.
Here there's theoretically more leeway... because it is at least under
user control.
However here this is done for good reason as well.
There's plenty of code that special cases uid=3D0, both in the kernel
(for example capability handling across exec) and in various userspace
libraries.  It's unrealistic to fix them all.
Additionally it's nice to have semi-transparent user namespaces,
which are security barriers but don't remap uids - remapping causes confusi=
on.
(ie. the uid is either mapped or not, but if it is mapped it's a 1:1 mappin=
g)

As for why?  Because uids as visible to userspace may leak across user
namespace boundaries,
either when talking to other system daemons or when talking across machines=
.
It's pretty easy (and common) to have uids that are globally unique
and meaningful in a cluster of machines.
Again, this is *theoretically* fixable in userspace, but not actually
a realistic expectation.

btw. even outside of clusters of machines, I also run some
user/uts/net namespace using
code on my personal desktop (this does require some minor hacks to
unshare/mount binaries),
and again I intentionally map uid->uid and 0->uid, because this makes
my username show up as 'maze' and not 'root'.

This is *clearly* a kernel bug that this doesn't just work.
(side note: there's a very similar issue in proc_net.c which I haven't
gotten around to fixing yet, because it looks to be more complex to
convince oneself it's safe to do)

> > This is because net_ctl_set_ownership fails to map uid/gid 0
> > (because uid/gid 0 are *not* mapped in the owning 2nd level user_ns),
> > and falls back to global root.
> > But global root is not mapped in the 1st level user_ns,
> > which was inherited by the /proc mount, and thus fails...
> >
> > Note: the uid/gid of networking sysctls is of purely superficial
> > importance, outside of this UNMAPPED check, it does not actually
> > affect access, and only affects display.
> >
> > Access is always based on whether you are *global* root uid
> > (or have CAP_NET_ADMIN over the netns) for user write access bits
> > (or are in *global* root gid for group write access bits).
> >
> > Cc: Flavio Crisciani <fcrisciani@google.com>
> > Cc: "Theodore Y. Ts'o" <tytso@google.com>
> > Cc: "Eric W. Biederman" <ebiederm@xmission.com>
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Fixes: e79c6a4fc923 ("net: make net namespace sysctls belong to contain=
er's owner")
> > Signed-off-by: Maciej =C5=BBenczykowski <maze@google.com>
> > ---
> >  net/sysctl_net.c | 13 ++++---------
> >  1 file changed, 4 insertions(+), 9 deletions(-)
> >
> > diff --git a/net/sysctl_net.c b/net/sysctl_net.c
> > index 051ed5f6fc93..ded399f380d9 100644
> > --- a/net/sysctl_net.c
> > +++ b/net/sysctl_net.c
> > @@ -58,16 +58,11 @@ static void net_ctl_set_ownership(struct ctl_table_=
header *head,
> >                                 kuid_t *uid, kgid_t *gid)
> >  {
> >       struct net *net =3D container_of(head->set, struct net, sysctls);
> > -     kuid_t ns_root_uid;
> > -     kgid_t ns_root_gid;
> > +     kuid_t ns_root_uid =3D make_kuid(net->user_ns, 0);
> > +     kgid_t ns_root_gid =3D make_kgid(net->user_ns, 0);
> >
> > -     ns_root_uid =3D make_kuid(net->user_ns, 0);
>
> As a fix I would prefer you would keep it minimal. e.g. just replace
> the if with the ternary operator or just add an 'else' branch.

If you think that's better, I'll resend a v2.

>
> Cheers,
>
> Paolo
>

--
Maciej =C5=BBenczykowski, Kernel Networking Developer @ Google

