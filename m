Return-Path: <netdev+bounces-199817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB04AE1ED3
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 17:38:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 535951C2749A
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C3972E54C9;
	Fri, 20 Jun 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oJdOGt/9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389EE2D5410;
	Fri, 20 Jun 2025 15:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750433500; cv=none; b=DyccujuMqfuGuSZ0SjCcN9Xvytue3I4Lhkn4vf6a7jIU1qN9SeOAbDBNpIAcd0P6YsdhCYma8ZOU1YoPpQYXMWVMj1e2C/GlfFDcm1Rs6Bl/eo65+2DmTePXspYIM+ZE6+XMWTzR2+SOXy9+9bzZnOHenvVMSoAwv2HHALwDipg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750433500; c=relaxed/simple;
	bh=iEFys1xc86l4xtETpg83SAgsifwnlZH1zuU6toODk5w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NpYh5cJIlj5X+E3sxQOTdMVoI7YPdWg4u02hWpauKJgIS2pMx6yXdwC+/tjf0WAqcsTMHWq9pWdQ8w6zLJxBQRR/tTe3FfSH06oYKtXMW6akkaZEiSsFWtTaWE+4MFNe4Hp0u9lP2D6OBWWxO1CTVX/RDWYTiT09HhIojEtlH0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oJdOGt/9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C8EC4CEF0;
	Fri, 20 Jun 2025 15:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750433500;
	bh=iEFys1xc86l4xtETpg83SAgsifwnlZH1zuU6toODk5w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oJdOGt/9sIYB1KkSe+3nyc+LxyaEtycRPXHeperkDCsgcc7fHizbtlLI7BeFyIL2H
	 AHOsDCzaoIAWCMu+tBwPIGef/r1cfK+3/y6xvdw7Hb9TwcLc+c/HUf7QyRCDAg0Zrn
	 X/ULCXxIYYpyRQlxDRrC/rpxKboMjsjoehZuxrjZy1EqSnuxmC6i++CTgxY2ie/xk4
	 7ZvOL9I3WBx1v0GsNEm/hwGR0pIHQ/QhoKwg7GubDihcWQLlB93/bGuXwGdrBal5Pg
	 /WYDxCcQe0c+PU2Yu/2XxX1trOgvwcYwnsUGub69rGdKzKoDjLAL5S48nM0Ap9Q6lz
	 AgQzVEqLGia1A==
Date: Fri, 20 Jun 2025 17:31:29 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Donald Hunter
 <donald.hunter@gmail.com>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Breno
 Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, Marco
 Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v4 12/14] MAINTAINERS: add maintainers for
 netlink_yml_parser.py
Message-ID: <20250620172949.1525075a@sal.lan>
In-Reply-To: <877c17h4wt.fsf@trenco.lwn.net>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
	<20250614173235.7374027a@foz.lan>
	<20250614103700.0be60115@kernel.org>
	<20250614205609.50e7c3ad@foz.lan>
	<20250614124649.2c41407c@kernel.org>
	<877c17h4wt.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Em Thu, 19 Jun 2025 14:06:58 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> Jakub Kicinski <kuba@kernel.org> writes:
>=20
> > On Sat, 14 Jun 2025 20:56:09 +0200 Mauro Carvalho Chehab wrote: =20
>=20
> >> I'm more interested on having a single place where python libraries
> >> could be placed. =20
> >
> > Me too, especially for selftests. But it's not clear to me that
> > scripts/ is the right location. I thought purely user space code
> > should live in tools/ and bulk of YNL is for user space. =20
>=20
> I've been out wandering the woods and canyons with no connectivity for a
> bit, so missed this whole discussion, sorry.

Sounds fun!

> Mauro and I had talked about the proper home for Python libraries when
> he reworked kernel-doc; we ended up with them under scripts/, which I
> didn't find entirely pleasing.  If you were to ask me today, I'd say
> they should be under lib/python, but tomorrow I might say something
> else...

Yeah, I guess you proposed lib/python before... I could be wrong though.
Anyway, at least for me lib/python sounds a better alternative than
scripts. I won't mind tools/lib/python or some other place.

> In truth, I don't think it matters much, but I *do* think we should have
> a single location from which to import kernel-specific Python code.
> Spreading it throughout the tree just isn't going to lead to joy.

We're aligned with that regards: IMO, we need a single store within
the Kernel for classes that might be shared.

As I commented on one of PRs, maybe the series could be merged
with Donald proposed (tools/net/ynl/pyynl/lib/doc_generator.py),
while we're still discussing. So, let's focus on get it reviewed
and merged without needing to wait for a broader discussion
about its permanent location.

We can later shift the code once we reach an agreement.

-

To start the discussions about a permanent location, in the specific=20
case of YNL, we currently have there:

	$ tree -d tools/net/ynl/ -I __pycache__
	tools/net/ynl/
	=E2=94=9C=E2=94=80=E2=94=80 generated
	=E2=94=9C=E2=94=80=E2=94=80 lib
	=E2=94=9C=E2=94=80=E2=94=80 pyynl
	=E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 lib
	=E2=94=94=E2=94=80=E2=94=80 samples

where pyynl have executables and pyynl the python libraries.

what I would suggest is to move what it is under "pyynl/lib"
to "{prefix}/ynl", where "{prefix}" can be "lib/python",
"tools/lib/python", "scripts/lib" or whatever other location
we reach an agreement.

For now, I placed the latest version of my doc patch series
under:

	https://github.com/mchehab/linux/tree/netlink_v8

to have a central place to have them on one of my scratch
trees.

I sent today for review to linux-doc ML an initial patch series
with some non-YAML related patches. I have another set of
patches after it, which I'm planning to send on Monday. At the
end, there are the YAML parser submission.

Regards,
Mauro

