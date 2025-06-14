Return-Path: <netdev+bounces-197774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA3AD9E1C
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:35:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2555A3B1625
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD1E1A7264;
	Sat, 14 Jun 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omw4a+VT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB85BA49;
	Sat, 14 Jun 2025 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749915334; cv=none; b=Q0bAyFNwstEWYPe6uWHD0z+E8p3fuFxqiw1YUCTpgXZt0MUKc1v0V7NtdcZfh/Igi7G8tpR/ltV9PLpeh5irEYjaBZ8fUuFINkk2/ZbG+3afXQK0qggLmEeSDNiHiwiMjvhR043CwnNmCL9ATq0EuIkYyYuEAxFinow8Cu45MoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749915334; c=relaxed/simple;
	bh=ejpJV221trzwYJvf1TsCy4LrSL+qVaKDtjf6IfJzEhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGzE9e+VsRjfY1xYjWevVKgkXVdDOw/9xUi0j+bpzj0xivXImJpwLWYL7bfBjP0lO9jDfWNg6HG891bzLLM/pjyBOnH+HRPaa5hoLTPSedGO9mwI/KQg42t18/2HTPtlba7LTxHd4zFIlb4iskFSbga8ThtlUH6viKWINLtVHJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omw4a+VT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C02DC4CEEB;
	Sat, 14 Jun 2025 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749915334;
	bh=ejpJV221trzwYJvf1TsCy4LrSL+qVaKDtjf6IfJzEhA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omw4a+VTYNL8f2CICm437rg/Ano6GHNU46bGEtkC89eF+qUmB1wG6plsm2GOB2l2N
	 oEYYqCyGY8OgMrAdwSG8AK/ygA9p7wdGnlBol2wK46l11SKFrR6ImQcNuppD7Op6iH
	 w9ao4bjWMOSeQoSz2ZwLGx5mwUz5KX+pS6TI6AQryAHVRGCrO0A432kK+Sd+oURr0O
	 3q122Yr4zQ9bYDrdcLp2oj2yyYRxCOiQEwJIa8/qROIvhy7DuX6fjXH75YnClbhKQu
	 Wg6l4ChJ2hXLHzpViZQNm8OqVIRR9X5n79YXN4TAL7ppHk+4zF+fgW5fZKeeUrYQvF
	 1zp2uWcF0Va9Q==
Date: Sat, 14 Jun 2025 17:35:26 +0200
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
Subject: Re: [PATCH v4 07/14] tools: ynl_gen_rst.py: move index.rst
 generator to the script
Message-ID: <20250614173526.2fe415e7@foz.lan>
In-Reply-To: <CAD4GDZxPTFmKeNqRZBxW1ij6Gy0L3hrbB6q9G6WdFb8h6Zhr=g@mail.gmail.com>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<31466ece9905956c2e1a3d3fc744cfc272df5d88.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZxPTFmKeNqRZBxW1ij6Gy0L3hrbB6q9G6WdFb8h6Zhr=g@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 14 Jun 2025 15:15:25 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> On Sat, 14 Jun 2025 at 09:56, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > The index.rst generator doesn't really belong to the parsing
> > function. Move it to the command line tool, as it won't be
> > used elsewhere.
> >
> > While here, make it more generic, allowing it to handle either
> > .yaml or .rst as input files.  
> 
> I think this patch can be dropped from the series, if instead you
> remove the index generation code before refactoring into a library.

Works for me. I'll wait for you and Jon's comments with regards to the
location before sending a new version.

Regards,
Mauro

> 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/lib/netlink_yml_parser.py  | 101 ++++++++---------------------
> >  tools/net/ynl/pyynl/ynl_gen_rst.py |  28 +++++++-  



Thanks,
Mauro

