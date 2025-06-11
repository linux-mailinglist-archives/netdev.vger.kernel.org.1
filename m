Return-Path: <netdev+bounces-196655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC418AD5B81
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 18:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C5961885E86
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 16:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 392A11DF75C;
	Wed, 11 Jun 2025 16:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jy6IT4ki"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23861A5B99;
	Wed, 11 Jun 2025 16:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749658265; cv=none; b=sK/unnk1vNILlkHkvdaca/Ya5kH3GOcImFHOBiKBrsWsE0JQNX/tv2BVxrJ85h0ToYU0FTP1TmFQ7YDMgm76KEeXGFKXslpXZajuycF2pAgNB08o/2dh4FA3ZPx/YtW2Il5U5BBplQgQEqF6qFJt5bXD340lqpdqf/ZujyMICLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749658265; c=relaxed/simple;
	bh=dZ8l0HjmwfhJtitEaf6kw6c4ZQY523g8u3AvC2TJ93A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgaUesONdmHxQPxGjFbRlizKrG+cQZRYFp+gIng/sc1frNcfrhO4AtAIc9J9LvdcbkOOhoJ2c/MPuIe4LYLLNbEK3hobDQ3YASYH5uPS8lxCHuco7w/oysezgQTUWPmJFnKoXqcvt3xSwArBDFNBuQHJ8nfT1c76h4gttUCC9M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jy6IT4ki; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007BEC4CEE3;
	Wed, 11 Jun 2025 16:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749658264;
	bh=dZ8l0HjmwfhJtitEaf6kw6c4ZQY523g8u3AvC2TJ93A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jy6IT4kiD2lDYe71W7diDiGt7oL1e/xuNhWSoXCCAtj4caCgRHLRqPdmYvYW0PiRI
	 JU/i/Csy6gD8wNDGapjxU9VaUk4rfzlXsP7nOW74W1Jeq1gqes+i5e5I3jsafmU3xv
	 OR4zg1wvmNKL9bItwL/Sz95VxD1D1hxCXh00OkDsfBDfZvLytbwFD8QO/9dImO9tEb
	 EAC3SYvvn6DuYJ0ueHh8NNuitcZcf2HP1E6QglBZYOh3TI1kMLoOjCgdZ4yZFTg5XJ
	 GD87oKR3rk08/4zSSO8ZZmL1RbKPuxwuVORjYwDN8svITdJw7XtZnCg7PfNLmzaL0j
	 XBdqKJN8dmhjA==
Date: Wed, 11 Jun 2025 18:10:56 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Akira Yokosawa" <akiyks@gmail.com>, "Breno Leitao"
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, "Ignacio
 Encinas Rubio" <ignacio@iencinas.com>, "Marco Elver" <elver@google.com>,
 "Shuah Khan" <skhan@linuxfoundation.org>, Eric Dumazet
 <edumazet@google.com>, Jan Stancek <jstancek@redhat.com>, Paolo Abeni
 <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH 4/4] docs: netlink: store generated .rst files at
 Documentation/output
Message-ID: <20250611181056.6543e71e@sal.lan>
In-Reply-To: <m24iwmpl0m.fsf@gmail.com>
References: <cover.1749551140.git.mchehab+huawei@kernel.org>
	<5183ad8aacc1a56e2dce9cc125b62905b93e83ca.1749551140.git.mchehab+huawei@kernel.org>
	<m24iwmpl0m.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 11 Jun 2025 12:36:57 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > It is not a good practice to store build-generated files
> > inside $(srctree), as one may be using O=<BUILDDIR> and even
> > have the Kernel on a read-only directory.
> >
> > Change the YAML generation for netlink files to be inside
> > the documentation output directory.
> >
> > This solution is not perfect, though, as sphinx-build only produces
> > html files only for files inside the source tree. As it is desired
> > to have one netlink file per family, it means that one template
> > file is required for every file inside Documentation/netlink/specs.
> > Such template files are simple enough. All they need is:
> >
> > 	# Template for Documentation/netlink/specs/<foo>.yaml
> > 	.. kernel-include:: $BUILDDIR/networking/netlink_spec/<foo>.rst  
> 
> I am not a fan of this approach because it pollutes the
> Documentation/output dir with source files and the kernel-include
> directive is a bit of a hacky workaround.
> 
> > A better long term solution is to have an extension at
> > Documentation/sphinx that parses *.yaml files for netlink files,
> > which could internally be calling ynl_gen_rst.py. Yet, some care
> > needs to be taken, as yaml extensions are also used inside device
> > tree.  
> 
> The extension does seem like a better approach, but as mentioned by
> Jakub, we'd want to add stub creation to the YNL regen.
> 
> The only other approach I can think of to avoid generating files in the
> source tree or polluting the Documentation/output dir is to stage all of
> the Documentation/ tree into BUILDDIR before adding generated files
> there, then running:
> 
>   sphinx-build BUILDDIR/Documentation BUILDDIR/Documentation/output

I did some tests here adding yaml to conf.py:

	-source_suffix = '.rst'
	+source_suffix = ['.rst', '.yaml']

Such change made the extension to automatically generate one file per 
each existing yaml without the need of adding any template. I tested on 
a brand new tree with just Sphinx + netlink files + Breno's original
extension (untouched). Such empty tree was generated with 
sphinx-quickstart (sent a reply to Breno with a patch with all inside
it).

When applying it to the Kernel, we can do this change at
Documentation/conf.py, together with:

	-exclude_patterns = ['output']
	+exclude_patterns = ['output', 'devicetree/bindings/**.yaml']

(glob pattern not tested)

As we don't want DT yaml files to be processed as netlink families.

After such tests, it sounds to me that the Sphinx extension approach 
may work without requiring templates. Tested here with Sphinx 8.1.3.

Regards,
Mauro

