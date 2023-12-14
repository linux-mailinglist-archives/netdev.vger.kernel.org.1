Return-Path: <netdev+bounces-57582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5C813839
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 18:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E2C51C20F25
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 17:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AAC665EB5;
	Thu, 14 Dec 2023 17:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="INrZDHVb"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DBA121
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:16:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702574186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MhL95NMRHTomnhtExuXArq1k4RIba5maai0PYgVgIYA=;
	b=INrZDHVb/vFTznQaUg8iot/EsN49icIhQUsujXEQ4OepzXM5iDBdK7ptZ172jVyePiYrcC
	rQXqrBFK3B2WH0Ms9ziYBhg4X4vZwujkTPAIMyLaKvOtNOdnLMeukLF1w3Hrfuuc3pDqMk
	QOWIhU5HmdR7lrRmEPu6SCzOpmQ2LbY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-nqJMzeNnPGGoe4W9PE9eKw-1; Thu, 14 Dec 2023 12:16:25 -0500
X-MC-Unique: nqJMzeNnPGGoe4W9PE9eKw-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a1f72871acdso136939766b.0
        for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 09:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702574184; x=1703178984;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MhL95NMRHTomnhtExuXArq1k4RIba5maai0PYgVgIYA=;
        b=hsd5euN1vHo2I1/MKGxSC4Zl/LhcwkD0kvwJnCKjSyfYR2Z/VMX3XI3sel3lfJYgUO
         qjkMj5NmZGqb1FNMv2DzBGSIUPQ+wqlcI8OVu7vyvSXSIbHYrf1y+18e/r5Z1m7FQPwD
         BDY4KU8KLMYXfz0iO1YwRwiPMndjCNSW/FAmjEczpEyWoYUhNERx6Tq4+4zQMYFhwIre
         hvhjTWeUUybifBAFmUGWT/t+WGU0ZxVePp3oHUYjObZ2GhBrWzRAyyQPURLf4Jd7PfO+
         jeL5L7lj9CPwdDS1JvDwZKKdxFKzHeakfnkY2lGa28J1RRwuQ6b4+x9Ah6EYPywtlbMj
         YpVw==
X-Gm-Message-State: AOJu0YwD1y4FZFwGhjIYOzcHRZhmEdhR3oGCNbZpxZ1iysPueKsxhBg3
	3thTdmo5n/zK+6TVLMJRTZvNoSYcoh7VqkFmyFPWBhxXriwsA6jC0zk1x8iA9tB7zSJIvcWDwdE
	DCdKLhDXYPnj4K8KA
X-Received: by 2002:a17:907:a805:b0:9e6:69d:46b4 with SMTP id vo5-20020a170907a80500b009e6069d46b4mr10620276ejc.6.1702574184214;
        Thu, 14 Dec 2023 09:16:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVqkdBJEInRFs8Fc6fxyvFlPTB8j7gXya13sBdlD+i6t8imuoKWNDb+z/wWLTwu2nRZqWGkw==
X-Received: by 2002:a17:907:a805:b0:9e6:69d:46b4 with SMTP id vo5-20020a170907a80500b009e6069d46b4mr10620262ejc.6.1702574183862;
        Thu, 14 Dec 2023 09:16:23 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-252-36.dyn.eolo.it. [146.241.252.36])
        by smtp.gmail.com with ESMTPSA id vk5-20020a170907cbc500b00a1ce56f7b16sm9680706ejc.71.2023.12.14.09.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 09:16:23 -0800 (PST)
Message-ID: <8e2475cba51a078e0e12c219d81ae8f14e2196b3.camel@redhat.com>
Subject: Re: [PATCH] net: sysctl: fix edge case wrt. sysctl write access
From: Paolo Abeni <pabeni@redhat.com>
To: Maciej =?UTF-8?Q?=C5=BBenczykowski?= <maze@google.com>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>,  "David
 S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Flavio Crisciani <fcrisciani@google.com>,
 "Theodore Y. Ts'o" <tytso@google.com>, "Eric W. Biederman"
 <ebiederm@xmission.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Thu, 14 Dec 2023 18:16:21 +0100
In-Reply-To: <CANP3RGfk6PqR2P8HnGX92ODnf6V5iKb+_zjonOsTDOB-3odM5g@mail.gmail.com>
References: <20231210111033.1823491-1-maze@google.com>
	 <ebf480701cd22da00c89c5b1b00d31be95ff8e4d.camel@redhat.com>
	 <CANP3RGfk6PqR2P8HnGX92ODnf6V5iKb+_zjonOsTDOB-3odM5g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2023-12-14 at 14:17 +0100, Maciej =C5=BBenczykowski wrote:
> On Thu, Dec 14, 2023 at 10:37=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> =
wrote:
> >=20
> > On Sun, 2023-12-10 at 03:10 -0800, Maciej =C5=BBenczykowski wrote:
> > > The clear intent of net_ctl_permissions() is that having CAP_NET_ADMI=
N
> > > grants write access to networking sysctls.
> > >=20
> > > However, it turns out there is an edge case where this is insufficien=
t:
> > > inode_permission() has an additional check on HAS_UNMAPPED_ID(inode)
> > > which can return -EACCES and thus block *all* write access.
> > >=20
> > > Note: AFAICT this check is wrt. the uid/gid mapping that was
> > > active at the time the filesystem (ie. proc) was mounted.
> > >=20
> > > In order for this check to not fail, we need net_ctl_set_ownership()
> > > to set valid uid/gid.  It is not immediately clear what value
> > > to use, nor what values are guaranteed to work.
> > > It does make sense that /proc/sys/net appear to be owned by root
> > > from within the netns owning userns.  As such we only modify
> > > what happens if the code fails to map uid/gid 0.
> > > Currently the code just fails to do anything, which in practice
> > > results in using the zeroes of freshly allocated memory,
> > > and we thus end up with global root.
> > > With this change we instead use the uid/gid of the owning userns.
> > > While it is probably (?) theoretically possible for this to *also*
> > > be unmapped from the /proc filesystem's point of view, this seems
> > > much less likely to happen in practice.
> > >=20
> > > The old code is observed to fail in a relatively complex setup,
> > > within a global root created user namespace with selectively
> > > mapped uid/gids (not including global root) and /proc mounted
> > > afterwards (so this /proc mount does not have global root mapped).
> > > Within this user namespace another non privileged task creates
> > > a new user namespace, maps it's own uid/gid (but not uid/gid 0),
> > > and then creates a network namespace.  It cannot write to networking
> > > sysctls even though it does have CAP_NET_ADMIN.
> >=20
> > I'm wondering if this specific scenario should be considered a setup
> > issue, and should be solved with a different configuration? I would
> > love to hear others opinions!
>=20
> While it could be fixed in userspace.  I don't think it should:
>=20
> The global root uid/gid are very intentionally not mapped in (as a
> security feature).
> So that part isn't changeable (it's also a system daemon and not under
> user control).
>=20
> The user namespace very intentionally maps uid->uid and not 0->uid.
> Here there's theoretically more leeway... because it is at least under
> user control.
> However here this is done for good reason as well.
> There's plenty of code that special cases uid=3D0, both in the kernel
> (for example capability handling across exec) and in various userspace
> libraries.  It's unrealistic to fix them all.
> Additionally it's nice to have semi-transparent user namespaces,
> which are security barriers but don't remap uids - remapping causes confu=
sion.
> (ie. the uid is either mapped or not, but if it is mapped it's a 1:1 mapp=
ing)
>=20
> As for why?  Because uids as visible to userspace may leak across user
> namespace boundaries,
> either when talking to other system daemons or when talking across machin=
es.
> It's pretty easy (and common) to have uids that are globally unique
> and meaningful in a cluster of machines.
> Again, this is *theoretically* fixable in userspace, but not actually
> a realistic expectation.
>=20
> btw. even outside of clusters of machines, I also run some
> user/uts/net namespace using
> code on my personal desktop (this does require some minor hacks to
> unshare/mount binaries),
> and again I intentionally map uid->uid and 0->uid, because this makes
> my username show up as 'maze' and not 'root'.

I see, thanks for all the details.

> This is *clearly* a kernel bug that this doesn't just work.
> (side note: there's a very similar issue in proc_net.c which I haven't
> gotten around to fixing yet, because it looks to be more complex to
> convince oneself it's safe to do)

Indeed the potential security related issue is the root cause of my
concerns here. I could not identify any such problem, but I must admit
the uid mapping is not the kernel I know better.

I definitely could use another pair of eyeballs here ;)

Cheers,

Paolo


