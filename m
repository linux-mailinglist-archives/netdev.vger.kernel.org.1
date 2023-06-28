Return-Path: <netdev+bounces-14440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0AC7416E5
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 19:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AEC71C20621
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 17:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BBAD303;
	Wed, 28 Jun 2023 17:03:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D9E322E
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 17:03:20 +0000 (UTC)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DADC1BD5
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 10:03:19 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3942c6584f0so4579372b6e.3
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 10:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1687971798; x=1690563798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XA4ODQc79Y9a3nSxna+2lbmXiaw9B+ecbAslRCTrA+Q=;
        b=B4ber/UKXywL55nkIyALqJV97VNMPrOE7HSoT6txqTcPlDBy5PdU980MkYu8l44fNI
         yDEWc0HcPi9EwdsEimAdilM9PsSlF17yNSJM9DtX4G26SZbk2mQbqZXnRf7clF57JDwO
         HDF2lkOsI+2aM9M76SfKU4GSst0aw69M3Lvn8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687971798; x=1690563798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XA4ODQc79Y9a3nSxna+2lbmXiaw9B+ecbAslRCTrA+Q=;
        b=d2eUNltuAkS1lW3ZabBTfyxr48mxkIc6ehPgV9jGWvOFus2PX1ONtaOJFtB/1CNvqT
         h/c7vygLrBoOTfZrMYmGL3I5KRwkq7zzIT9840T+IFzMfMw/fIaly+43cKrHU4DCgnY3
         F4r6ANhtMPOG23G38qxbJOknrR30poaCmihalHrPszUnDuC+cCi42R0yLfKjNf99tY9H
         T9BRb6IAiPghc3tQpnUEmHi2oAxwKI4W3wlLtrbTj/NBVRxsvY+eFwS+AVW4fK93bndh
         hturLTThrp0EAPCkLpFq7mJWF8h1HyYzkW3TBjrnWxzuU7N7HqO0cq/5RivaHw8+yfP0
         eC6Q==
X-Gm-Message-State: AC+VfDxIyX+RyGSfoQuaLNbw/0IQ3JfqWtX82AzEAF8kVzKunbkliKBR
	a8epoLa0G889cCqaQyvPbSCna4iKpzOif0Ja4bbBvg==
X-Google-Smtp-Source: ACHHUZ6UZziEsEiC/wRh6wFCisbDSJo8/vHJxGVrmNc7iB28Jyu4KJX6K3R8DsGzgDlQEImAbC3WwCR24HE+e8RcR1U=
X-Received: by 2002:a05:6808:bd4:b0:3a0:3161:ee2f with SMTP id
 o20-20020a0568080bd400b003a03161ee2fmr32048712oik.57.1687971798340; Wed, 28
 Jun 2023 10:03:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230116085818.165539-1-konstantin.meskhidze@huawei.com>
 <Y/fl5iEbkL5Pj5cJ@galopp> <c20fc9eb-518e-84b4-0dd5-7b97c0825259@huawei.com>
 <3e113e1c-4c7b-af91-14c2-11b6ffb4d3ef@digikod.net> <b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net>
 <ZJvy2SViorgc+cZI@google.com>
In-Reply-To: <ZJvy2SViorgc+cZI@google.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Wed, 28 Jun 2023 10:03:08 -0700
Message-ID: <CABi2SkX-dzUO6NnbyqfrAg7Bbn+Ne=Xi1qC1XMrzHqVEVucQ0Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/12] Network support for Landlock - allowed list of protocols
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack@google.com>
Cc: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>, 
	"Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>, =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>, 
	willemdebruijn.kernel@gmail.com, linux-security-module@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	yusongping@huawei.com, artem.kuzin@huawei.com, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello,

Thanks for writing up the example for an incoming TCP connection ! It
helps with the context.

Since I'm late to this thread, one thing I want to ask:  all the APIs
proposed so far are at the process level, we don't have any API that
applies restriction to socket fd itself, right ? this is what I
thought, but I would like to get confirmation.

On Wed, Jun 28, 2023 at 2:09=E2=80=AFAM G=C3=BCnther Noack <gnoack@google.c=
om> wrote:
>
> Hello!
>
> On Mon, Jun 26, 2023 at 05:29:34PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> > Here is a design to be able to only allow a set of network protocols an=
d
> > deny everything else. This would be complementary to Konstantin's patch
> > series which addresses fine-grained access control.
> >
> > First, I want to remind that Landlock follows an allowed list approach =
with
> > a set of (growing) supported actions (for compatibility reasons), which=
 is
> > kind of an allow-list-on-a-deny-list. But with this proposal, we want t=
o be
> > able to deny everything, which means: supported, not supported, known a=
nd
> > unknown protocols.
> >
> > We could add a new "handled_access_socket" field to the landlock_rulese=
t
> > struct, which could contain a LANDLOCK_ACCESS_SOCKET_CREATE flag.
> >
> > If this field is set, users could add a new type of rules:
> > struct landlock_socket_attr {
> >     __u64 allowed_access;
> >     int domain; // see socket(2)
> >     int type; // see socket(2)
> > }
> >
> > The allowed_access field would only contain LANDLOCK_ACCESS_SOCKET_CREA=
TE at
> > first, but it could grow with other actions (which cannot be handled wi=
th
> > seccomp):
> > - use: walk through all opened FDs and mark them as allowed or denied
> > - receive: hook on received FDs
> > - send: hook on sent FDs
> >
> > We might also use the same approach for non-socket objects that can be
> > identified with some meaningful properties.
> >
> > What do you think?
>
> This sounds like a good plan to me - it would make it possible to restric=
t new
> socket creation using protocols that were not intended to be used, and I =
also
> think it would fit the Landlock model nicely.
>
> Small remark on the side: The security_socket_create() hook does not only=
 get
> invoked as a result of socket(2), but also as a part of accept(2) - so th=
is
> approach might already prevent new connections very effectively.
>
That is an interesting aspect that might be worth discussing more.
seccomp is per syscall, landlock doesn't necessarily follow the same,
another design is to add more logic in Landlock, e.g.
LANDLOCK_ACCESS_SOCKET_PROTOCOL which will apply to all of the socket
calls (socket/bind/listen/accept/connect). App dev might feel it is
easier to use.

> Spelling out some scenarios, so that we are sure that we are on the same =
page:
>
> A)
>
> A program that does not need networking could specify a ruleset where
> LANDLOCK_ACCESS_SOCKET_CREATE is handled, and simply not permit anything.
>
> B)
>
> A program that runs a TCP server could specify a ruleset where
> LANDLOCK_NET_BIND_TCP, LANDLOCK_NET_CONNECT_TCP and
> LANDLOCK_ACCESS_SOCKET_CREATE are handled, and where the following rules =
are added:
>
>   /* From Konstantin's patch set */
>   struct landlock_net_service_attr bind_attr =3D {
>     .allowed_access =3D LANDLOCK_NET_BIND_TCP,
>     .port =3D 8080,
>   };
>
>   /* From Micka=C3=ABl's proposal */
>   struct landlock_socket_attr sock_inet_attr =3D {
>     .allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
>     .domain =3D AF_INET,
>     .type =3D SOCK_STREAM,
>   }
>
>   struct landlock_socket_attr sock_inet6_attr =3D {
>     .allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
>     .domain =3D AF_INET6,
>      .type =3D SOCK_STREAM,
>   }
>
> That should then be enough to bind and listen on ports, whereas outgoing
> connections with TCP and anything using other network protocols would not=
 be
> permitted.
>
TCP server is an interesting case. From a security perspective, a
process cares if it is acting as a server or client in TCP, a server
might only want to accept an incoming TCP connection, never initiate
an outgoing TCP connection, and a client is the opposite.

Processes can restrict outgoing/incoming TCP connection by seccomp for
accept(2) or connect(2),  though I feel Landlock can do this more
naturally for app dev, and at per-protocol level.  seccomp doesn't
provide per-protocol granularity.

For bind(2), iirc, it can be used for a server to assign dst port of
incoming TCP connection, also by a client to assign a src port of an
outgoing TCP connection. LANDLOCK_NET_BIND_TCP will apply to both
cases, right ? this might not be a problem, just something to keep
note.

> (Alternatively, it could bind() the socket early, *then enable Landlock* =
and
> leave out the rule for BIND_TCP, only permitting SOCKET_CREATE for IPv4 a=
nd
> IPv6, so that listen() and accept() work on the already-bound socket.)
>
For this approach, LANDLOCK_ACCESS_SOCKET_PROTOCOL is a better name,
so dev is fully aware it is not just applied to socket create.

> Overall, this sounds like an excellent approach to me. =F0=9F=91=8D
>
> =E2=80=94G=C3=BCnther
>
> --
> Sent using Mutt =F0=9F=90=95 Woof Woof

-Jeff

