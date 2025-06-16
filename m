Return-Path: <netdev+bounces-198029-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E4D8ADADC8
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:51:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64A30188DFCC
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EC92BCF47;
	Mon, 16 Jun 2025 10:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJUk/Ui9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D05295D8F;
	Mon, 16 Jun 2025 10:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750071075; cv=none; b=gikmnZw6IksytBQTSS5leXZXVVIZ0mKZR3WoMMfScBGVbD+UcOOkxVZeQDqweQXKVgtvyhnaIopPFZ86D3lpDOiA1j2HPw8CI9uUgWskOvAiMzmsgqpIfxmaqJQu6pPw1EIxvig6XeR250IgdgtJfcaF6zswLMtTxrdyjUmONaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750071075; c=relaxed/simple;
	bh=WaQAp1hhm2gKAeY2p2nZTgu1+jygTwVGUhSeNAqM2RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gCZPgvnLJ1D0MPMVBZNnf28xUrcnOqziQxNfZZqbn0Ts6V4UiCpzcEHDe6TP37DjcKeGlXJ727dJOG3n9i91OWuzsdMgogHr4Oj4AD/ESxHmuEMZ4yVt4b4dB9lB+nEclJrNU1iVIAGeM7+UpTeicU0sZRvPaFUjE4LPWN0lZ4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJUk/Ui9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 744D5C4CEF1;
	Mon, 16 Jun 2025 10:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750071073;
	bh=WaQAp1hhm2gKAeY2p2nZTgu1+jygTwVGUhSeNAqM2RQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BJUk/Ui9lefM/bDm0RZwP71Ccys+RiIcirvbkyHC2lIfyWHo8zRYLNdFHrIpjdAqO
	 c93QasgHPhoURjWaivuDm5HgOv8CIV+StPUP/MGmaGb9r6DvV9MiJPo8GjUkIjQU4I
	 k87jG2OwBsCMEk0QAaNB1A/ryl2t+CWHsVv2ujj79HrEp1Xpifn5AqsJ3zrx1a5THl
	 PNWJShMVwyk9yo0VTvXPUlt6WlGBZMeW6torR1uYzgbWDyI1pgb2xcFqjg5qwGSxue
	 ZayjqOhpLfwP9diAiya5uA0TXsTsqetkpdolFrk2DF2P/DOvF3kwftOvUS2IHFzGLZ
	 l05YHL9Rpgb0w==
Date: Mon, 16 Jun 2025 12:51:06 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, Akira
 Yokosawa <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>,
 Marco Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v4 12/14] MAINTAINERS: add maintainers for
 netlink_yml_parser.py
Message-ID: <20250616125106.5d7fd18f@foz.lan>
In-Reply-To: <20250614124649.2c41407c@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
	<20250614173235.7374027a@foz.lan>
	<20250614103700.0be60115@kernel.org>
	<20250614205609.50e7c3ad@foz.lan>
	<20250614124649.2c41407c@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Sat, 14 Jun 2025 12:46:49 -0700
Jakub Kicinski <kuba@kernel.org> escreveu:

> On Sat, 14 Jun 2025 20:56:09 +0200 Mauro Carvalho Chehab wrote:
> > > I understand that from the PoV of ease of maintenance of the docs.
> > > Is it fair to say there is a trade off here between ease of maintenan=
ce
> > > for docs maintainers and encouraging people to integrate with kernel
> > > docs in novel ways?   =20
> >=20
> > Placing elsewhere won't make much difference from doc maintainers and
> > developers. =20
>=20
> I must be missing your point. Clearly it makes a difference to Donald,
> who is a maintainer of the docs in question.

Heh, I was just saying that I missed your point ;-)

See, you said that "there is a trade off here between ease of maintenance
for docs maintainers and encouraging people to integrate with kernel
docs in novel ways".

I can't see how being easy/hard to maintain or even "integrate with
kernel docs in novel ways" would be affected by the script location.

Whatever it is located, there should be MAINTAINERS entries that would
point to YAML and network maintainers maintainers:

	$ ./scripts/get_maintainer.pl tools/net/ynl/pyynl/ynl_gen_rst.py --nogit -=
-nogit-blame --nogit-fallback
	Donald Hunter <donald.hunter@gmail.com> (maintainer:YAML NETLINK (YNL))
	Jakub Kicinski <kuba@kernel.org> (maintainer:YAML NETLINK (YNL))
	"David S. Miller" <davem@davemloft.net> (maintainer:NETWORKING [GENERAL])
	Eric Dumazet <edumazet@google.com> (maintainer:NETWORKING [GENERAL])
	Paolo Abeni <pabeni@redhat.com> (maintainer:NETWORKING [GENERAL])
	Simon Horman <horms@kernel.org> (reviewer:NETWORKING [GENERAL])
	netdev@vger.kernel.org (open list:NETWORKING [GENERAL])
	linux-kernel@vger.kernel.org (open list)
	YAML NETLINK (YNL) status: Unknown

	(do they all apply to YNL doc parser?)

Plus having doc ML/Maintainer on it:

	Jonathan Corbet <corbet@lwn.net> (maintainer:DOCUMENTATION)
	linux-doc@vger.kernel.org (open list:DOCUMENTATION)

So, at least the file called by the Sphinx class should be at the
linux-doc entry at the maintainers' file.

The rationale is that linux-doc and Jon should be c/c, just in case some=20
change there might end causing build issues using a version of the toolchain
that is officially supported, as documented at
Documentation/process/changes.rst, e.g. currently whatever it there is=20
expected to be compatible with:

	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
	        Program        Minimal version       Command to check the version
	=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
	...
	Sphinx\ [#f1]_         3.4.3            sphinx-build --version
	...
	Python (optional)      3.9.x            python3 --version
	...


This is independent if the YNL classes are either at scripts/lib
or at tools/net/ynl/pyynl/lib.

>=20
> > I'm more interested on having a single place where python libraries
> > could be placed. =20
>=20
> Me too, especially for selftests. But it's not clear to me that
> scripts/ is the right location. I thought purely user space code
> should live in tools/ and bulk of YNL is for user space.

Several scripts under scripts/ are meant to run outside build
time. One clear example is:

	$ ./scripts/get_abi.py undefined

That basically checks if the userspace sysfs API is properly
documented, by reading the macine's sysfs node and comparing
with the uAPI documentation. Such tool can also used to check if
the ABI documentation Python classes are working as expected.

So, it is a mix of kernel build time and userspace.

There are also pure userspace tools like those two:

	./scripts/get_dvb_firmware
	./scripts/extract_xc3028.pl=09

Both extract firmware files from some other OS and write as a
Linux firmware file to be stored under /lib/firmware. They are
userspace-only tools.

-

=46rom my side, I don't care where Python classes would be placed,
but I prefer having them on a single common place. It could be:

	/scripts/lib
	/tools/lib
	/python/lib

eventually with their own sub-directories on it, like what we have
today:

	${some_prefix}/kdoc
	${some_prefix}/abi

In the case of netlink, it could be:

	${some_prefix}/netlink

Yet, IMO, we should not have a different location for userspace
and non-userspace, as it is very hard to draw the borders on several
cases, like the ABI toolset.

> > Eventually, some classes might be re-used in the future
> > by multiple scripts and subsystems, when it makes sense, just like we do
> > already with Kernel's kAPIs. This also helps when checking what is the
> > Python's minimal version that are required by the Kernel when updating
> > it at: =20
>=20
> I think this is exactly the same point Donald is making, but from YNL
> perspective. The hope is to share more code between the ReST generator,
> the existing C generator and Python library. The later two are already
> based on a shared spec model.

That makes perfect sense to me. Yet, this doesn't preventing having
a:

	${some_prefix}/ynl

directory where you would place Netlink YNL parsing, where the prefix
would be either:

	- /scripts/lib
	- /tools/lib
	- /python/lib
	- something else

It may even use some common classes under:

	${some_prefix}/${some_common_prefix}

---

Now, seeing your comments, maybe the main point is wheather it is OK to=20
add userspace libraries to scripts/lib or not. IMO, using "/scripts/lib"
is OK, no matter if the script is kernel-build related or "pure userspace",
but if there are no consensus, we could migrate what we have to
"python/lib" or to some other place.


Thanks,
Mauro

