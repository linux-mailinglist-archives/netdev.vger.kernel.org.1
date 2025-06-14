Return-Path: <netdev+bounces-197826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F613AD9F86
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 21:46:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E5AF61739AA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 19:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C06FE19F43A;
	Sat, 14 Jun 2025 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fnofkYhe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408038FA6;
	Sat, 14 Jun 2025 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749930412; cv=none; b=dhvn61w/K66VhXU4YWA1KkjFBsTLfEvGZy6teWnXy0piTojwQbHYa4GAqvsOwa8fVW/xef5StpUQlzzGtzgV57Yxra/Kww55YFZ4tPWPELSxZs/ivPfZoFb6Uqehgm3XmxLhYHlzdhbRjt15tFSOsKEPxIbCOhEr/wL94piOows=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749930412; c=relaxed/simple;
	bh=QB5PhTxl2zxZGW2hQuAMgRZkgYvJOmtHRS8o1u5BWwc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSjg4VptIoAcbhO+AFL33BUlzcpSoU9U6c5gfldwI8vtk7jfJjZC8LLlIm/npiAWuOIfLLm0Tv2uSxGthPGGABKIVWAnBMSkejw0kv8jtKyNBwxUSjcxCZLkve3Njf4vkDIiBKOERD5juuTIjyrjWhIKARA5XO+dY5otMBB8Zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fnofkYhe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33770C4CEEB;
	Sat, 14 Jun 2025 19:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749930411;
	bh=QB5PhTxl2zxZGW2hQuAMgRZkgYvJOmtHRS8o1u5BWwc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fnofkYhecJv5nZ7IAdQ1eBNk0HN3PmuuLgwecprmbz/pHzTdSWqrYZG3ommQjPbuw
	 jcc8P1tjWSWTbXRl4POwEwlIWJ1mIxugLF5CdsTmYJZRPfaYhZawI5mfpuM5d8VX8J
	 YR7jUFPeoWgdh4m1JtKuJAuZhUZG5gMs9hv7zDn6URlGQ4N6qGiSa82f/R3OevuDnS
	 GEZMZVjIvNjnE5ZqCN4w2mXTqbqhm1UKqji7auA4yJlvRkBw5gkmKepDn6SuVwlJ8y
	 GgA70nsn4DXsH9OyeHbK3UW/M/gIedXyQT+ZMhbcMMd+AxF8Fmha5PfZSH8IsPdmRP
	 rI8qd0Qw3cPHg==
Date: Sat, 14 Jun 2025 12:46:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
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
Message-ID: <20250614124649.2c41407c@kernel.org>
In-Reply-To: <20250614205609.50e7c3ad@foz.lan>
References: <cover.1749891128.git.mchehab+huawei@kernel.org>
	<ba75692b90bf7aa512772ca775fde4c4688d7e03.1749891128.git.mchehab+huawei@kernel.org>
	<CAD4GDZzA5Dj84vobSdxqXdPjskBjuFm7imFkZoSmgjidbCtSYQ@mail.gmail.com>
	<20250614173235.7374027a@foz.lan>
	<20250614103700.0be60115@kernel.org>
	<20250614205609.50e7c3ad@foz.lan>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 14 Jun 2025 20:56:09 +0200 Mauro Carvalho Chehab wrote:
> > I understand that from the PoV of ease of maintenance of the docs.
> > Is it fair to say there is a trade off here between ease of maintenance
> > for docs maintainers and encouraging people to integrate with kernel
> > docs in novel ways?  
> 
> Placing elsewhere won't make much difference from doc maintainers and
> developers.

I must be missing your point. Clearly it makes a difference to Donald,
who is a maintainer of the docs in question.

> I'm more interested on having a single place where python libraries
> could be placed.

Me too, especially for selftests. But it's not clear to me that
scripts/ is the right location. I thought purely user space code
should live in tools/ and bulk of YNL is for user space.

> Eventually, some classes might be re-used in the future
> by multiple scripts and subsystems, when it makes sense, just like we do
> already with Kernel's kAPIs. This also helps when checking what is the
> Python's minimal version that are required by the Kernel when updating
> it at:

I think this is exactly the same point Donald is making, but from YNL
perspective. The hope is to share more code between the ReST generator,
the existing C generator and Python library. The later two are already
based on a shared spec model.

