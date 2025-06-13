Return-Path: <netdev+bounces-197476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3B8AD8BD7
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:14:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B96613A7811
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F54E2D5C7C;
	Fri, 13 Jun 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spvbua0w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DB2275AE2;
	Fri, 13 Jun 2025 12:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749816843; cv=none; b=aXW1c9HiHtzlyS4tXpQ9MJ/0atGwZxLUlp1vYMlNuOrD257/pc8G4+Y4qVmWTg3eR/whFDUz5rl5e9WWg9N06A+HAT1QIbCNYyaInn97R0G48CjvCgofAguoRvX4z3DX0TvykMDzgJQDRa5EO/CNy68z4XP914KkVhkAdP2ulIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749816843; c=relaxed/simple;
	bh=9n6iNHBCKV0GZHwkyD9XOEtgWinRTZGyTm0zXHbGTj8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WZqw8yd8aCKIoaeRj0fE4KaKnJTKrCSeJ5GvlP39DxLQzpInp4Lbvy2oNoMHx16MsFigaBDhjKadSYMC9TF5cB+YXj5Rta/1SlzDU01CA4Oubrl6J7yHGbGdkEUG9SnHk83tQyVVBgQgr27X6nlluDnmczzvHon7X6q5jYO+aqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spvbua0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60EFC4CEE3;
	Fri, 13 Jun 2025 12:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749816842;
	bh=9n6iNHBCKV0GZHwkyD9XOEtgWinRTZGyTm0zXHbGTj8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Spvbua0wsLdsGl5pDN19EMUXpC4ap8aSfq/9e9wylKUORzwKiKC/eNMxcHvmlp6iS
	 HGzt1oOFYFui3i5bzUxJrp4QJLXm4uDqKT917RdGSBgR1P05c7RTu+qApgsEKbGteN
	 FJrU2V940EcGMDbgH9IWPd3vx4PkgrE9VAeuluvKjPM/F/AuMI0K5DQ60jmRwiN0xl
	 wHs2vYRwUN/TybSEuzXJwbnt+sThgy8PYj7FxntZjkiftHz15Qohgbyf0e73RsR7Gy
	 WYq/UkJCSNn2C00jwVkgJITijJk3xwriOK9420MiOmYpFhl8YuHPTibazxW/EVtUnW
	 xwU1ercHPPxRA==
Date: Fri, 13 Jun 2025 14:13:55 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, linux-kernel@vger.kernel.org, Akira Yokosawa
 <akiyks@gmail.com>, "David S. Miller" <davem@davemloft.net>, Ignacio
 Encinas Rubio <ignacio@iencinas.com>, Marco Elver <elver@google.com>, Shuah
 Khan <skhan@linuxfoundation.org>, Eric Dumazet <edumazet@google.com>, Jan
 Stancek <jstancek@redhat.com>, Paolo Abeni <pabeni@redhat.com>, Ruben
 Wauters <rubenru09@aol.com>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, lkmm@lists.linux.dev,
 netdev@vger.kernel.org, peterz@infradead.org, stern@rowland.harvard.edu,
 Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH v2 00/12] Don't generate netlink .rst files inside
 $(srctree)
Message-ID: <20250613141355.1bba92fc@foz.lan>
In-Reply-To: <m27c1foq97.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<m27c1foq97.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Fri, 13 Jun 2025 12:05:56 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > As discussed at:
> >    https://lore.kernel.org/all/20250610101331.62ba466f@foz.lan/
> >
> > changeset f061c9f7d058 ("Documentation: Document each netlink family")
> > added a logic which generates *.rst files inside $(srctree). This is bad when
> > O=<BUILDDIR> is used.
> >
> > A recent change renamed the yaml files used by Netlink, revealing a bad
> > side effect: as "make cleandocs" don't clean the produced files, symbols 
> > appear duplicated for people that don't build the kernel from scratch.
> >
> > There are some possible solutions for that. The simplest one, which is what
> > this series address, places the build files inside Documentation/output. 
> > The changes to do that are simple enough, but has one drawback,
> > as it requires a (simple) template file for every netlink family file from
> > netlink/specs. The template is simple enough:
> >
> >         .. kernel-include:: $BUILDDIR/networking/netlink_spec/<family>.rst  
> 
> I think we could skip describing this since it was an approach that has
> now been dropped.

Ok. Will drop on next versions.

> 
> > Part of the issue is that sphinx-build only produces html files for sources
> > inside the source tree (Documentation/). 
> >
> > To address that, add an yaml parser extension to Sphinx.
> >
> > It should be noticed that this version has one drawback: it increases the
> > documentation build time. I suspect that the culprit is inside Sphinx
> > glob logic and the way it handles exclude_patterns. What happens is that
> > sphinx/project.py uses glob, which, on my own experiences, it is slow
> > (due to that, I ended implementing my own glob logic for kernel-doc).
> >
> > On the plus side, the extension is flexible enough to handle other types
> > of yaml files, as the actual yaml conversion logic is outside the extension.  
> 
> I don't think the extension would handle anything other than the Netlink
> yaml specs, and I don't think that should be a goal of this patchset.

Not necessarily. We do have already DT yaml files (although there's
a separate process to handle those outside the tree). Nothing prevents
we end having more. See, the way Sphinx parser works is that it will cover
all files with *.yaml extension no matter where it is located within the
tree. We may end needing to use it for something else as well (*).

(*) at the last Media Summit, we did have some discussions about using
    either yaml or rst for sensor documentation.

> > With this version, there's no need to add any template file per netlink/spec
> > file. Yet, the Documentation/netlink/spec.index.rst require updates as
> > spec files are added/renamed/removed. The already-existing script can
> > handle it automatically by running:
> >
> >             tools/net/ynl/pyynl/ynl_gen_rst.py -x  -v -o Documentation/netlink/specs/index.rst  
> 
> I think this can be avoided by using the toctree glob directive in the
> index, like this:
> 
> =============================
> Netlink Family Specifications
> =============================
> 
> .. toctree::
>    :maxdepth: 1
>    :glob:
> 
>    *
> 
> This would let you have a static index file.

Didn't know about such option. If it works with the parser, it sounds good 
enough.

> 
> > ---
> >
> > v2:
> > - Use a Sphinx extension to handle netlink files.
> >
> > v1:
> > - Statically add template files to as networking/netlink_spec/<family>.rst
> >
> > Mauro Carvalho Chehab (12):
> >   tools: ynl_gen_rst.py: create a top-level reference
> >   docs: netlink: netlink-raw.rst: use :ref: instead of :doc:  
> 
> I suggest combining the first 2 patches.
> 
> >   docs: netlink: don't ignore generated rst files  
> 
> Maybe leave this patch to the end and change the description to be a
> cleanup of the remants of the old approach.

Ok for me, but I usually prefer keeping one patch per logical change.
In this case, one patch adding support at the tool; the other one
improving docs to benefit from the new feature.

> Further comments on specific commits
> 
> >   tools: ynl_gen_rst.py: make the index parser more generic
> >   tools: ynl_gen_rst.py: Split library from command line tool
> >   scripts: lib: netlink_yml_parser.py: use classes
> >   tools: ynl_gen_rst.py: do some coding style cleanups
> >   scripts: netlink_yml_parser.py: improve index.rst generation
> >   docs: sphinx: add a parser template for yaml files
> >   docs: sphinx: parser_yaml.py: add Netlink specs parser  
> 
> Please combine these 2 patches. The template patch just introduces noise
> into the series and makes it harder to review.

Ok.

> >   docs: use parser_yaml extension to handle Netlink specs
> >   docs: conf.py: don't handle yaml files outside Netlink specs
> >
> >  .pylintrc                                     |   2 +-
> >  Documentation/Makefile                        |  17 -
> >  Documentation/conf.py                         |  17 +-
> >  Documentation/netlink/specs/index.rst         |  38 ++
> >  Documentation/networking/index.rst            |   2 +-
> >  .../networking/netlink_spec/.gitignore        |   1 -
> >  .../networking/netlink_spec/readme.txt        |   4 -
> >  Documentation/sphinx/parser_yaml.py           |  80 ++++
> >  .../userspace-api/netlink/netlink-raw.rst     |   6 +-
> >  scripts/lib/netlink_yml_parser.py             | 394 ++++++++++++++++++
> >  tools/net/ynl/pyynl/ynl_gen_rst.py            | 378 +----------------
> >  11 files changed, 544 insertions(+), 395 deletions(-)
> >  create mode 100644 Documentation/netlink/specs/index.rst
> >  delete mode 100644 Documentation/networking/netlink_spec/.gitignore
> >  delete mode 100644 Documentation/networking/netlink_spec/readme.txt
> >  create mode 100755 Documentation/sphinx/parser_yaml.py
> >  create mode 100755 scripts/lib/netlink_yml_parser.py  

Thanks,
Mauro

