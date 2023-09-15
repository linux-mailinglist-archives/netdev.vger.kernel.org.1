Return-Path: <netdev+bounces-34133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AF87A2414
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 19:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14BF2281668
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 17:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B94D125D0;
	Fri, 15 Sep 2023 17:00:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDF1125CA
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 17:00:21 +0000 (UTC)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E45D92D59
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:59:50 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-68fc9e0e22eso1962904b3a.1
        for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1694797190; x=1695401990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ge/4NlqHA8ZtPv3aOaYpT5kS9jEKzM1aOB7LW9SjVFI=;
        b=Fu74vU66pSe7rB0zAd7GPjMDXmfGyBs5ZVgeF4wn3NmG2gWAM4rg3SqQAQ67AcZAxn
         1kV/q7cbhyIxNgagDE6Ti35T0Jg/8ve9ZvKQySi6YRERGgb+d+Evz/n1+QcuylZWistF
         SbahHNyzygAhnDK0MWWeAyCXSMf4dkaqXL4ESqFRzNpMXII/budXGSrsBHUPmyAtoyhw
         Sp3BfHFcQWNCjLxJyLparngSkE9yxCZYCn7UvKYaWNZANiLxi2o20pQrpYg6Wb4fz2My
         /wzz1u3W6Mhxe4hcQaShIHguVYxVR1TiM0SZgk7JbFecw1PqUS+1LsdIyvtUVZ8CGOYy
         nh6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694797190; x=1695401990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ge/4NlqHA8ZtPv3aOaYpT5kS9jEKzM1aOB7LW9SjVFI=;
        b=g5hHbjAo/g+aoitFyt1VnQZgDJmAPoSgchhTOQprZXwXQ/oyV6UAxNIrNdUr3VYfNF
         gaBvWW2BBHJzBw0M+OIRtPDsyPGLUmBXnr+yWggNDIJifAAb7ZQnba5xYJ4Pr9+QJVW7
         lHe+31Mldlm+arcIZR9+hfN3zpsvf4/4RlJ2ubASjEh6IK+OCcEC12r3w2K7Y55JRaa7
         jEBN4NjD6vOY3YtpOD0IAr8gyJErwn1IwS2DDJBYe/MU2CDsS69/Ay2rTxgC2PApTMYs
         eSYpokg6ic7wybE6KADSoyJ05iMGDJ4S7Q5sPbCossK7jqwII+O3QZM+LZFOxu4q/eQK
         r5fg==
X-Gm-Message-State: AOJu0Ywu+61WnQsSQYS7EyP3PudUl2eEngnO8dBZ/zN1Z297bt3eI+z+
	1vQc1TT1BXWZi7KiNPc/frMWrw==
X-Google-Smtp-Source: AGHT+IH1jFIhwdMnic5vgAuo0ZATXXnCInqcvNw5G36vPrCBWjZ6EGki6ffiQrYt+D+XsoqZfZxxxA==
X-Received: by 2002:a05:6a00:2d1e:b0:68f:e0c2:6d46 with SMTP id fa30-20020a056a002d1e00b0068fe0c26d46mr2189404pfb.23.1694797190298;
        Fri, 15 Sep 2023 09:59:50 -0700 (PDT)
Received: from hermes.local (204-195-112-131.wavecable.com. [204.195.112.131])
        by smtp.gmail.com with ESMTPSA id fe16-20020a056a002f1000b0068be216b091sm3206866pfb.24.2023.09.15.09.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Sep 2023 09:59:50 -0700 (PDT)
Date: Fri, 15 Sep 2023 09:59:48 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: David Ahern <dsahern@kernel.org>
Cc: nicolas.dichtel@6wind.com, Thomas Haller <thaller@redhat.com>, Benjamin
 Poirier <bpoirier@nvidia.com>, Hangbin Liu <liuhangbin@gmail.com>, Ido
 Schimmel <idosch@idosch.org>, netdev@vger.kernel.org, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <20230915095948.63f9dd69@hermes.local>
In-Reply-To: <b6837627-27a9-b870-c85b-799c23705a74@kernel.org>
References: <ZLobpQ7jELvCeuoD@Laptop-X1>
	<ZLzY42I/GjWCJ5Do@shredder>
	<ZL48xbowL8QQRr9s@Laptop-X1>
	<20230724084820.4aa133cc@hermes.local>
	<ZL+F6zUIXfyhevmm@Laptop-X1>
	<20230725093617.44887eb1@hermes.local>
	<6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
	<7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
	<640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
	<8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org>
	<ZNKQdLAXgfVQxtxP@d3>
	<32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
	<cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com>
	<b6837627-27a9-b870-c85b-799c23705a74@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 13 Sep 2023 08:41:05 -0600
David Ahern <dsahern@kernel.org> wrote:

> On 9/13/23 1:58 AM, Nicolas Dichtel wrote:
> > Le 11/09/2023 =C3=A0 11:50, Thomas Haller a =C3=A9crit=C2=A0:
> > [snip] =20
> >> - the fact that it isn't fixed in more than a decade, shows IMO that
> >> getting caching right for routes is very hard. Patches that improve the
> >> behavior should not be rejected with "look at libnl3 or FRR". =20
> > +1
> >=20
> > I just hit another corner case:
> >=20
> > ip link set ntfp2 up
> > ip address add 10.125.0.1/24 dev ntfp2
> > ip nexthop add id 1234 via 10.125.0.2 dev ntfp2
> > ip route add 10.200.0.0/24 nhid 1234
> >=20
> > Check the config:
> > $ ip route
> > <snip>
> > 10.200.0.0/24 nhid 1234 via 10.125.0.2 dev ntfp2
> > $ ip nexthop
> > id 1234 via 10.125.0.2 dev ntfp2 scope link
> >=20
> >=20
> > Set the carrier off on ntfp2:
> > ip monitor label link route nexthop&
> > ip link set ntfp2 carrier off
> >=20
> > $ ip link set ntfp2 carrier off
> > $ [LINK]4: ntfp2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq=
 state
> > DOWN group default
> >     link/ether de:ed:02:67:61:1f brd ff:ff:ff:ff:ff:ff
> >  =20
> > =3D> No nexthop event nor route event (net.ipv4.nexthop_compat_mode =3D=
 1) =20
>=20
> carrier down is a link event and as you show here, link events are sent.
>=20
> >=20
> > 'ip nexthop' and 'ip route' show that the nexthop and the route have be=
en deleted. =20
>=20
> nexthop objects are removed on the link event; any routes referencing
> those nexthops are removed.

The netlink notification path can and does not have any flow control.
The problem with what is propoosed is that if there are 1M route entries
and a link event happens, some of the RTM_DELROUTE events will be dropped
when the netlink queue overruns. Therefore daemons can not depend on RTM_DE=
LROUTE
for tracking, and instead should look for the link event and do bulk
cleanup then.

