Return-Path: <netdev+bounces-197772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CBC3AD9E15
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F491899256
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BB71A3145;
	Sat, 14 Jun 2025 15:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEORoHrG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA766D17;
	Sat, 14 Jun 2025 15:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915163; cv=none; b=uP4VMD0Yqdu0/UdTaNYrJFnZ5JkDfrBySu0IYa2+59MyvJFNYKkwt1UBty1c31gjs54MfYQz0JoGiXAqBCYq29Yh4qIzPo53DcBzfukzH3pLa7iudZ60HPPgROmVHu6Es5rX7ASSsjgIUV+EnjfKbdFeTO7uOIFRBlZy0sWXTas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915163; c=relaxed/simple;
	bh=wt5VV4iKKzOPs6a/o9sxhm0l0iwSY7AAKCodzPrgKt4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HZ5XhfZPX+zjQPgxk/D1lgRmGy+gOn6jSWv5bSQF1MlvwB+2IObANKxq9a+6h2Z82O2TJSJyLxmERDRHIuEL4y7gMaM2gMeASsgMr83btlUh8n6wDPyM0a30bKIALdWQbzDNs7g0gSw1O0budb4110tz93geTILtRK/8hiVeqXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEORoHrG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE840C4CEEB;
	Sat, 14 Jun 2025 15:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749915162;
	bh=wt5VV4iKKzOPs6a/o9sxhm0l0iwSY7AAKCodzPrgKt4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TEORoHrGYSPL1PZ6TDYbQb+3hSK3gdnNckKqJIgbcFsh7TFztCECCuLARbk1TthE3
	 8ju4x3PunSUqdBD5YBsVp8++WUXCEKfw5Zyw2cFpw64+bJ+em0JMx7gUMYozWesxtj
	 cUe2RwapqfQ0BEG5G+NPpYJOgOhtsiqvcbG43BDw52s/gM1PuX6SlxWuXpBG0YZyfs
	 tsMakaqtY6d6UinbE3LI7s7Re7iF/ZZN6u9YhOR+sRBtOAXBi3hRZQcygNS2d+A1Xw
	 ipxps6J1LS5J0VBzsbFldM+hAj2R7wvcXMscbaPiWkj7gXXKHMGdwlb3CwMiwTrLxa
	 4Mxd/3FC87c+Q==
Date: Sat, 14 Jun 2025 17:32:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Akira Yokosawa
 <akiyks@gmail.com>, Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Ignacio Encinas
 Rubio <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, Marco
 Elver <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v4 12/14] MAINTAINERS: add maintainers for
 netlink_yml_parser.py
Message-ID: <20250614173235.7374027a@foz.lan>
In-Reply-To: <CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Donald, Jon,

Em Sat, 14 Jun 2025 15:22:16 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > The parsing code from tools/net/ynl/pyynl/ynl_gen_rst.py was moved
> > to scripts/lib/netlink_yml_parser.py. Its maintainership
> > is done by Netlink maintainers. Yet, as it is used by Sphinx
> > build system, add it also to linux-doc maintainers, as changes
> > there might affect documentation builds. So, linux-docs ML
> > should ideally be C/C on changes to it.  
> 
> This patch can be dropped from the series when you move the library
> code to tools/net/ynl/pyynl/lib.
> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  MAINTAINERS | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index a92290fffa16..2c0b13e5d8fc 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -7202,6 +7202,7 @@ F:        scripts/get_abi.py
> >  F:     scripts/kernel-doc*
> >  F:     scripts/lib/abi/*
> >  F:     scripts/lib/kdoc/*
> > +F:     scripts/lib/netlink_yml_parser.py
> >  F:     scripts/sphinx-pre-install
> >  X:     Documentation/ABI/
> >  X:     Documentation/admin-guide/media/

Adding an entry that would c/c to linux-doc for the parser is
important, as problems there will affect documentation build,
no matter where it is located. Perhaps one option would be to 
create a separate MAINTAINERS entry for it, like:

	YAML NETLINK (YNL) DOC GENERATOR
	M:      Donald Hunter <donald.hunter@gmail.com>
	M:      Jakub Kicinski <kuba@kernel.org>
	F:      <python_lib_location>/netlink_yml_parser.py
	L:      linux-doc@vger.kernel.org

to ensure that changes to it would be C/C to linux-doc.

> > @@ -27314,6 +27315,7 @@ M:      Jakub Kicinski <kuba@kernel.org>
> >  F:     Documentation/netlink/
> >  F:     Documentation/userspace-api/netlink/intro-specs.rst
> >  F:     Documentation/userspace-api/netlink/specs.rst
> > +F:     scripts/lib/netlink_yml_parser.py
> >  F:     tools/net/ynl/

With regards to the location itself, as I said earlier, it is up to
Jon and you to decide.

My preference is to have all Python libraries at the entire Kernel
inside scripts/lib (or at some other common location), no matter where
the caller Python command or in-kernel Sphinx extensions are located.

There is also slight advantage on placing them at the same location:
if we end adding parsers for other subsystems at parse_html.py, having
all of them at the same directory means we don't need to do something
like:

	lib_paths = [
		"tools/net/ynl/pyynl/lib",
		"foo",
		"bar",
		...
	]

	for d in lib_paths:
		sys.path.insert(0, os.path.join(srctree, "scripts/lib"))

	from netlink_yml_parser import YnlDocGenerator        # pylint: disable=C0413
	from foo_yml_parser import FooYamlDocGenerator        # pylint: disable=C0413
	from bar_yml_parser import BarYamlDocGenerator        # pylint: disable=C0413
	...


Thanks,
Mauro

