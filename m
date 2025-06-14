Return-Path: <netdev+bounces-197820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E56AD9F2C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0EA2A1760E5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 18:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D96C1EF397;
	Sat, 14 Jun 2025 18:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnEVX1n2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A811DE4D8;
	Sat, 14 Jun 2025 18:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749927376; cv=none; b=NTNLQjwP4Vcx27fo47fvXgLjLkfU3qRh3KI0MTvLvuFm1wqJ8r3NrIYdXuwSfwGxXxOE0NK9Y14wV53QupvE3jO7+20Gmaa/nEDln7MYzd1jlKDHgB6hDXEJpwy/vFH6Nbeq7oh0Nsfe2bJgQsPkph30l/JnM+qhBp7z2oNvx54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749927376; c=relaxed/simple;
	bh=Ay9WNfd7Dkl5+6/0J8IggnfWgT3C7wSHD0mCsf3vo9M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GbW1jXvxIICdGSL54YtTlRBJJ7QEnaFuNC9ksFiw8YUTDbJG9xt8gg1mbwySMUo0KmogLQI+9bKQBLh0PQtcdoGpxtQd+yKzg/AR9mALP1Xag2cEU995JKlKDZCmn/A0h7LzV3n9SuO0MRDIP7Y3C2TyaS9GwSjVDkyVjcJBP4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnEVX1n2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16268C4CEEF;
	Sat, 14 Jun 2025 18:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749927376;
	bh=Ay9WNfd7Dkl5+6/0J8IggnfWgT3C7wSHD0mCsf3vo9M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lnEVX1n2MxvyMsJ4d1/QTdLtOBZR2/8cC7OnUGlndhbnoUp2wZIYEMhi7bvSkEI4F
	 l3ui9zw3cjaof3z7J0eL4PhCdAgl5vP7rdHax9fSQd7DZQg2TAUwPwRJVWtcKJLUBN
	 RE+cOiMKSY5W+slhJ3acsRhbi5JUGljhPHiB5vEAlRPAloJlRS8KN2lwBVGIv4B0op
	 EgKwLx9yrdWUFYOf4mxquUTsOEanaePdCThj3/EnfDMDs4eglmzj2i8CabZydFS/4b
	 ivbkx24q4+997EoKwW4I8iSVG12TVfLN9ObHpJ6WFtdy3C+0r6nOg9SzUMrllsPVyp
	 Gb+91nCyrLHUA==
Date: Sat, 14 Jun 2025 20:56:09 +0200
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
Message-ID: <20250614205609.50e7c3ad@foz.lan>
In-Reply-To: <20250614103700.0be60115@kernel.org>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
	<20250614173235.7374027a@foz.lan>
	<20250614103700.0be60115@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 14 Jun 2025 10:37:00 -0700
Jakub Kicinski <kuba@kernel.org> escreveu:

> On Sat, 14 Jun 2025 17:32:35 +0200 Mauro Carvalho Chehab wrote:
> > > > @@ -27314,6 +27315,7 @@ M:      Jakub Kicinski <kuba@kernel.org>
> > > >  F:     Documentation/netlink/
> > > >  F:     Documentation/userspace-api/netlink/intro-specs.rst
> > > >  F:     Documentation/userspace-api/netlink/specs.rst
> > > > +F:     scripts/lib/netlink_yml_parser.py
> > > >  F:     tools/net/ynl/    
> > 
> > With regards to the location itself, as I said earlier, it is up to
> > Jon and you to decide.
> > 
> > My preference is to have all Python libraries at the entire Kernel
> > inside scripts/lib (or at some other common location), no matter where
> > the caller Python command or in-kernel Sphinx extensions are located.  
> 
> I understand that from the PoV of ease of maintenance of the docs.
> Is it fair to say there is a trade off here between ease of maintenance
> for docs maintainers and encouraging people to integrate with kernel
> docs in novel ways?

Placing elsewhere won't make much difference from doc maintainers and
developers.

I'm more interested on having a single place where python libraries
could be placed. Eventually, some classes might be re-used in the future
by multiple scripts and subsystems, when it makes sense, just like we do
already with Kernel's kAPIs. This also helps when checking what is the
Python's minimal version that are required by the Kernel when updating
it at:

	Documentation/process/changes.rst

And writing patches documenting it like:

	d2b239099cf0 ("docs: changes: update Sphinx minimal version to 3.4.3")
	5e25b972a22b ("docs: changes: update Python minimal version")

Properly setting the minimal Python version is important specially to
check if the minimal version set at changes.rst is compatible with
the Makefile build targets:

	$ pip install --user vermin
	...
	$ vermin -v scripts/lib/
	Detecting python files..
	Analyzing 9 files using 24 processes..
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/abi/abi_parser.py
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/abi/abi_regex.py
	~2, ~3       /new_devel/v4l/docs/scripts/lib/abi/helpers.py
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/abi/system_symbols.py
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/kdoc/kdoc_files.py
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/kdoc/kdoc_output.py
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/kdoc/kdoc_parser.py
	2.3, 3.0     /new_devel/v4l/docs/scripts/lib/kdoc/kdoc_re.py
	!2, 3.6      /new_devel/v4l/docs/scripts/lib/netlink_yml_parser.py

	Tips:
	- You're using potentially backported modules: argparse, typing
	  If so, try using the following for better results: --backport argparse --backport typing
	- Since '# novm' or '# novermin' weren't used, a speedup can be achieved using: --no-parse-comments
	(disable using: --no-tips)

	Minimum required versions: 3.6
	Incompatible versions:     2

Thanks,
Mauro

