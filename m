Return-Path: <netdev+bounces-14409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C37C7740BCD
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F4702811EF
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 08:44:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD9B7469;
	Wed, 28 Jun 2023 08:44:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3D033D0
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 08:44:16 +0000 (UTC)
Received: from mail-ej1-x649.google.com (mail-ej1-x649.google.com [IPv6:2a00:1450:4864:20::649])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A463E3591
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:44:13 -0700 (PDT)
Received: by mail-ej1-x649.google.com with SMTP id a640c23a62f3a-9885a936d01so361435966b.0
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 01:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687941852; x=1690533852;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWTqCvFpynWTlr/Bk92iOqs3pjlY33xJu502WZFArtk=;
        b=UnvCFZ/EgQbu70Y9apDAdm3fGUANFW7baJOiol9kVU4gg8MzL0NvBQ4N+uz59HpJBD
         Fu/K/Bl+SVXqDeGoY953GcgyRwp10adeUJnAPz/jplWe6B9ByXOk0vRZTtu2sBfV6q/p
         k6muKnqjRICLiplZOwWzys0XQgB+5hirUmUZWd/ER1+Bdxh1BaVRXykAnUnIL2oQzV2Z
         rMtb0P3ZLVZjxUCaGIOvsXqVX293QeYdE8vaPm+af3Ma4rNMLF5KmWv3xiOVte9Ci6GI
         q9mUE47mr0U1FHLKV6rjAPDNhZ68JnLsbpNNPFckvM2kFdJu6bvjlp0X+1LYUbfwqy+W
         Ki3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687941852; x=1690533852;
        h=content-transfer-encoding:cc:to:from:subject:references
         :mime-version:message-id:in-reply-to:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZWTqCvFpynWTlr/Bk92iOqs3pjlY33xJu502WZFArtk=;
        b=dTF+y5Dvq700LW26VI4kEMWKqxLj6noYEdRpKaVdSL+EXQ3W3G4vAJX2i0yiTPtEfM
         2BQyH3w/OMDIE+ESkSzn66PvtmIW962xhp363N3ECxjsso6kTaJU1cJf//Km91BfNiKj
         g66uwF2tb0B9aG/ORsYqm+OHiEstTdOTK9Y/RvFThua5UkaQv9wUx39G4U15zh/3pfIp
         ayJGnQMOvQ61eCH1WH1Gi3xXK1BoSLIOjwRWbdZ5zfzLmuO8ULWaAPXwYNc6I9o0Sz5z
         BJ5rIqyplMqZNMMcqZ7W9Wrw8NoyLHCPR80DXg5fC9/P/ChGN0LrH8mvUN7oQn8K6VF1
         rRmw==
X-Gm-Message-State: AC+VfDzMbErm4Ocv5NU6qyOzvpvXrjOlifrmdKSSwNSffLTcxywH9YtD
	L77ZT3XgTCOaPMe8c+CpfUVBvTHU6io=
X-Google-Smtp-Source: ACHHUZ48bJmWPrFTeXuhN8e5LgW2WQwXoMrKiJFt9QSGXTD6rf+TwxQIlh+D0GOycpKRQ7zKqM/tpJttpJA=
X-Received: from sport.zrh.corp.google.com ([2a00:79e0:9d:4:21dc:82c2:282f:ee82])
 (user=gnoack job=sendgmr) by 2002:a17:907:7605:b0:98e:46f:bda7 with SMTP id
 jx5-20020a170907760500b0098e046fbda7mr1651554ejc.11.1687941852182; Wed, 28
 Jun 2023 01:44:12 -0700 (PDT)
Date: Wed, 28 Jun 2023 10:44:09 +0200
In-Reply-To: <b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net>
Message-Id: <ZJvy2SViorgc+cZI@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20230116085818.165539-1-konstantin.meskhidze@huawei.com>
 <Y/fl5iEbkL5Pj5cJ@galopp> <c20fc9eb-518e-84b4-0dd5-7b97c0825259@huawei.com>
 <3e113e1c-4c7b-af91-14c2-11b6ffb4d3ef@digikod.net> <b8a2045a-e7e8-d141-7c01-bf47874c7930@digikod.net>
Subject: Re: [PATCH v9 00/12] Network support for Landlock - allowed list of protocols
From: "=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack@google.com>
To: "=?iso-8859-1?Q?Micka=EBl_Sala=FCn?=" <mic@digikod.net>
Cc: "Konstantin Meskhidze (A)" <konstantin.meskhidze@huawei.com>, 
	"=?iso-8859-1?Q?G=FCnther?= Noack" <gnoack3000@gmail.com>, willemdebruijn.kernel@gmail.com, 
	linux-security-module@vger.kernel.org, netdev@vger.kernel.org, 
	netfilter-devel@vger.kernel.org, yusongping@huawei.com, 
	artem.kuzin@huawei.com, Jeff Xu <jeffxu@google.com>, 
	Jorge Lucangeli Obes <jorgelo@chromium.org>, Allen Webb <allenwebb@google.com>, 
	Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello!

On Mon, Jun 26, 2023 at 05:29:34PM +0200, Micka=C3=ABl Sala=C3=BCn wrote:
> Here is a design to be able to only allow a set of network protocols and
> deny everything else. This would be complementary to Konstantin's patch
> series which addresses fine-grained access control.
>=20
> First, I want to remind that Landlock follows an allowed list approach wi=
th
> a set of (growing) supported actions (for compatibility reasons), which i=
s
> kind of an allow-list-on-a-deny-list. But with this proposal, we want to =
be
> able to deny everything, which means: supported, not supported, known and
> unknown protocols.
>=20
> We could add a new "handled_access_socket" field to the landlock_ruleset
> struct, which could contain a LANDLOCK_ACCESS_SOCKET_CREATE flag.
>=20
> If this field is set, users could add a new type of rules:
> struct landlock_socket_attr {
>     __u64 allowed_access;
>     int domain; // see socket(2)
>     int type; // see socket(2)
> }
>=20
> The allowed_access field would only contain LANDLOCK_ACCESS_SOCKET_CREATE=
 at
> first, but it could grow with other actions (which cannot be handled with
> seccomp):
> - use: walk through all opened FDs and mark them as allowed or denied
> - receive: hook on received FDs
> - send: hook on sent FDs
>=20
> We might also use the same approach for non-socket objects that can be
> identified with some meaningful properties.
>=20
> What do you think?

This sounds like a good plan to me - it would make it possible to restrict =
new
socket creation using protocols that were not intended to be used, and I al=
so
think it would fit the Landlock model nicely.

Small remark on the side: The security_socket_create() hook does not only g=
et
invoked as a result of socket(2), but also as a part of accept(2) - so this
approach might already prevent new connections very effectively.

Spelling out some scenarios, so that we are sure that we are on the same pa=
ge:

A)

A program that does not need networking could specify a ruleset where
LANDLOCK_ACCESS_SOCKET_CREATE is handled, and simply not permit anything.

B)

A program that runs a TCP server could specify a ruleset where
LANDLOCK_NET_BIND_TCP, LANDLOCK_NET_CONNECT_TCP and
LANDLOCK_ACCESS_SOCKET_CREATE are handled, and where the following rules ar=
e added:

  /* From Konstantin's patch set */
  struct landlock_net_service_attr bind_attr =3D {
    .allowed_access =3D LANDLOCK_NET_BIND_TCP,
    .port =3D 8080,
  };

  /* From Micka=C3=ABl's proposal */
  struct landlock_socket_attr sock_inet_attr =3D {
    .allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
    .domain =3D AF_INET,
    .type =3D SOCK_STREAM,
  }

  struct landlock_socket_attr sock_inet6_attr =3D {
    .allowed_access =3D LANDLOCK_ACCESS_SOCKET_CREATE,
    .domain =3D AF_INET6,
     .type =3D SOCK_STREAM,
  }

That should then be enough to bind and listen on ports, whereas outgoing
connections with TCP and anything using other network protocols would not b=
e
permitted.

(Alternatively, it could bind() the socket early, *then enable Landlock* an=
d
leave out the rule for BIND_TCP, only permitting SOCKET_CREATE for IPv4 and
IPv6, so that listen() and accept() work on the already-bound socket.)

Overall, this sounds like an excellent approach to me. =F0=9F=91=8D

=E2=80=94G=C3=BCnther

--=20
Sent using Mutt =F0=9F=90=95 Woof Woof

