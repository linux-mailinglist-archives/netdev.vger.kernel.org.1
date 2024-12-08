Return-Path: <netdev+bounces-149971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA5B9E848F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 11:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2870316492F
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 10:55:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7716137776;
	Sun,  8 Dec 2024 10:55:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8286753389
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 10:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.58.86.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733655322; cv=none; b=AWewLOpSYRqv8nJoWXF6GoDXWkHwYaCfontYMoCWeNllj2v8DcrMgoUryUQXZ3eTu6vczZfw66HisYEPuPRwRzt+6hj3VyzU4z9q/OyEXhe1xCREgtBLRf/fvFA0wJf+rEXCuitJg4gqjE4JTdO6YkjDfIJ1o/vt7pe7tOdKnR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733655322; c=relaxed/simple;
	bh=lr+TyEqVzpZPbpI51/6LKjVPsP319+dSbF2YokAVsKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=BxzPWl5KiJPydEwiUeRMFae6pN+eI8GEieaDPcFhmte2tZOvz3fUqqr4yLOfpWqObsaP5VyaFuLPIiMSo8AqUkBvV62ea56YGd7vimxq0goINc++8bczBHL+V72nuBWblEwleZ6a3jkN/F/QozNP8O0XjiKf2AtWEvHNejbMbKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM; spf=pass smtp.mailfrom=aculab.com; arc=none smtp.client-ip=185.58.86.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ACULAB.COM
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aculab.com
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-103-0xfNP5aEOouEojCi3iOoPw-1; Sun, 08 Dec 2024 10:55:17 +0000
X-MC-Unique: 0xfNP5aEOouEojCi3iOoPw-1
X-Mimecast-MFC-AGG-ID: 0xfNP5aEOouEojCi3iOoPw
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 8 Dec
 2024 10:54:23 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 8 Dec 2024 10:54:23 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Kuniyuki Iwashima' <kuniyu@amazon.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuni1840@gmail.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH v1 net-next 00/15] treewide: socket: Clean up
 sock_create() and friends.
Thread-Topic: [PATCH v1 net-next 00/15] treewide: socket: Clean up
 sock_create() and friends.
Thread-Index: AQHbR7QcAbstjqGo3EytsBLjYMbb9LLcJTmg
Date: Sun, 8 Dec 2024 10:54:23 +0000
Message-ID: <85ad278ad61943938a6537f1405f7814@AcuMS.aculab.com>
References: <20241206075504.24153-1-kuniyu@amazon.com>
In-Reply-To: <20241206075504.24153-1-kuniyu@amazon.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pm3PsDxq1E5lXt9j_wFD1jVDOrODeQlj47YPsXO8nJY_1733655315
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

From: Kuniyuki Iwashima
> Sent: 06 December 2024 07:55
>=20
> There are a bunch of weird usages of sock_create() and friends due
> to poor documentation.
>=20
>   1) some subsystems use __sock_create(), but all of them can be
>      replaced with sock_create_kern()

Not currently because sock_create_kern() doesn't increase the ref count
on the network namespace.
So I have an out of tree driver that end up using __sock_create() in
order that the socket holds a reference to the network namespace.

>   2) some subsystems use sock_create(), but most of the sockets are
>      not exposed to userspace via file descriptors but are exposed
>      to some BPF hooks (most likely unintentionally)

AFAIR the 'kern' flag removes some security/permission checks.
So a socket that is being created to handle user API requests
(user data might be encapsulated and then sent) probably ought
to have 'kern =3D=3D 0' even though the socket is not directly exposed
through the fd table.=20

>   3) some subsystems use sock_create_kern() and convert the sockets
>      to hold netns refcnt (cifs, mptcp, rds, smc, and sunrpc)
>=20
>   4) the sockets of 2) and 3) are counted in /proc/net/sockstat even
>      though they are untouchable from userspace
>=20
> The primary goal is to sort out such confusion and provide enough
> documentation for future developers to choose an appropriate API.
>=20
> Regarding 3), we introduce a new API, sock_create_net(), that holds
> a netns refcnt for kernel socket to remove the socket conversion to
> avoid use-after-free triggered by TCP kernel socket after commit
> 26abe14379f8 ("net: Modify sk_alloc to not reference count the netns
> of kernel sockets.").
>=20
> Throughout the series, we follow the definition below:
>=20
>   userspace socket:
>     * created by sock_create_user()
>     * holds the reference count of the network namespace
>     * directly linked to a file descriptor
>     * accessed via a file descriptor (and some BPF hooks)
>     * counted in the first line of /proc/net/sockstat.
>=20
>   kernel socket
>     * created by sock_create_net() or sock_create_net_noref()
>       * the former holds the refcnt of netns, but the latter doesn't
>     * not directly exposed to userspace via a file descriptor nor BPF

That isn't really right:
A 'userspace socket' (kern =3D=3D 0) is a socket created to support a user'=
s
API calls. Typically (but not always) directly linked to a file descriptor.
Security/permission checks include those of the current user/process.

A 'kernel socket' (kern =3D=3D 1) is a socket that isn't related to a user =
process.
These fall into two groups:
1) Normal TCP (etc) sockets used by things like remote filesystems.
   These need to hold a reference to the network namespace and will stop
   the namespace being deleted.
2) Special sockets used internally (perhaps for routing).
   These don't hold a reference, but require the caller have a callback
   for the namespace being deleted and must close the socket before
   the callback returns.
   The close must be fully synchronous - FIN_WAIT states will break things.

> Note that I didn't CC maintainers for mechanical changes as the CC
> list explodes.

This whole change (which is probably worth it) need doing in a different
order.
Start with the actual change to the socket create code and then work
back through the callers.
That may require adding wrapper functions for the existing calls that
can then finally be deleted in the last patch.

Additionally boolean parameters need to be banned, multiple ones
are worse - you really can tell from the call site what they mean.

So change the boolean 'kern' parameter to a flags one.
You then want 0 to be the normal case (user socket that holds a ref).
Then add (say):
=09#define SOCK_CREATE_NO_NS_REF 1
=09#define SOCK_CREATE_KERN      2
Initially add to the top of sk_alloc():
=09if (flags & SOCK_CREATE_NOREF)
=09=09flags |=3D SOCK_CREATE_KERN;
Now all the code compiles and works as before.

Next find all the call sites (especially those that pass 1)
and change so they pass the correct flag combination.
(Some static inlines/#defines might help with long lines.)

Finally change sk_alloc() to return NULL if NO_NS_REF
is set without KERN.

None of the 'pass through' functions need changing except to
ensure the parameter is 'unsigned int flags' (not 'bool kern').

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)


