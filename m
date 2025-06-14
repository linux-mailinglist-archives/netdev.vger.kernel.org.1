Return-Path: <netdev+bounces-197769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D00AD9DEE
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 16:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E0F170A30
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 14:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55FC2E175B;
	Sat, 14 Jun 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tSVAvMs5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8111FC8;
	Sat, 14 Jun 2025 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749913126; cv=none; b=lD7YaKb+xGbReRqNwRwo5N7L4eu0S46GHZHMEdphXxvEL0xZMTxNg4VvoaiDDtDG+Wuip3MHzs4R6l3YuxY0trI7pMNIHOvt1MKoKG7IpDHVlVv/5RI2CQ1vf+9LjB+21sySqVg6iUUG8lRS86nXxv+/cT5LGAQAcefXhAHKR+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749913126; c=relaxed/simple;
	bh=8mO7WKyJqajUY7NimuV3wsknV491ZZ3uyL2AvijCGt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u6PU3SyY/HHEXWnpXyFPckNEPsaRk+pSZ0wuNvcZoGqGtuqgOg1dFUSaNLmRpVgNvyISw1VNWMrzzzhAtzpT1VJaUoMaQSZlwvPmsoigbNGGzInTNHRSmRp6wpKpeA2uH7av0WLZyxlF2R0i0Pr7jmRK3W8+iTygYQ7mFA3fO4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tSVAvMs5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29138C4CEEB;
	Sat, 14 Jun 2025 14:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749913126;
	bh=8mO7WKyJqajUY7NimuV3wsknV491ZZ3uyL2AvijCGt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tSVAvMs5nad0bV97gI9po8cXWQdtABmJ9BnMbKyGCQT/AJjR8X20Lx6JxAtifB4oM
	 jsdQ+rjoTl0IH2ZeE6+UU9IU9OIcBdXZZqt2FJkFfRyPcTjzEtf4U1R+URYeE1stgE
	 Fs7WH+O+KAGJuA37J7KJxaLibDGmYjbah/TDTPCJdEt+OXE9yYLBs6/b9WHyUPbRRH
	 cvnO7y8dmRmZrUbDBS0N5Mrzqubt8fL7A7XHUgddddUlv/WY6Yld6mh4HyscJ2vC2D
	 z5RgVY8qJwlBoht/ORJYW6+HK3lFt9SDANBgHbJkIs6xoM2fNQQDyrUA/xipDSek3W
	 dfGM7yN9c7FPA==
Date: Sat, 14 Jun 2025 16:58:37 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Akira Yokosawa <akiyks@gmail.com>, Breno Leitao
 <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Ignacio Encinas Rubio <ignacio@iencinas.com>, Jan
 Stancek <jstancek@redhat.com>, Marco Elver <elver@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Ruben Wauters <rubenru09@aol.com>, Shuah Khan
 <skhan@linuxfoundation.org>, joel@joelfernandes.org,
 linux-kernel-mentees@lists.linux.dev, linux-kernel@vger.kernel.org,
 lkmm@lists.linux.dev, netdev@vger.kernel.org, peterz@infradead.org,
 stern@rowland.harvard.edu
Subject: Re: [PATCH v4 04/14] tools: ynl_gen_rst.py: make the index parser
 more generic
Message-ID: <20250614165837.35e9abde@foz.lan>
In-Reply-To: <CAD4GDZwCLd0rAi-FTWZ2UEsfbMtvxbFAqcLeLtE7SfiJUB2VWg@mail.gmail.com>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<3fb42a4aa79631d69041f6750dc0d55dd3067162.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZwCLd0rAi-FTWZ2UEsfbMtvxbFAqcLeLtE7SfiJUB2VWg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 14 Jun 2025 14:41:29 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > It is not a good practice to store build-generated files
> > inside $(srctree), as one may be using O=<BUILDDIR> and even
> > have the Kernel on a read-only directory.
> >
> > Change the YAML generation for netlink files to allow it
> > to parse data based on the source or on the object tree.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  tools/net/ynl/pyynl/ynl_gen_rst.py | 22 ++++++++++++++++------
> >  1 file changed, 16 insertions(+), 6 deletions(-)  
> 
> It looks like this patch is no longer required since this script
> doesn't get run by `make htmldocs` any more.
> 
> Instead, I think there is cleanup work to remove unused code like
> `generate_main_index_rst`

It is too early to drop it on this series, as only this patch:

	[PATCH v4 09/14] docs: use parser_yaml extension to handle Netlink specs

stops using it.

> This whole script may be unnecessary now, unless we want a simple way
> to run YnlDocGenerator separately from the main doc build.

It is up to you to keep or drop after patch 9. Yet, on my experiences with
kernel_doc.py and get_abi.py, it is a lot easier to test the parser via 
a simple command line script, without having Sphinx parallel build, complex
doc build logic and Sphinx exception handling in place.

My suggestion is to keep ynl_gen_rst.py, removing generate_main_index_rst
as a cleanup patch after patch 9.

Regards,
Mauro

