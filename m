Return-Path: <netdev+bounces-197770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8944FAD9DF5
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 17:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E3E677A3DFA
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 15:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682E02D9EF0;
	Sat, 14 Jun 2025 15:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7Rz/p2x"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F78256C7C;
	Sat, 14 Jun 2025 15:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749913284; cv=none; b=J+5Q9C4Rk11SwtPIV+0a6Z5f8pfe2LabljrdBLopuPC9/mGZNcnsDPPI5m5Lbu1F2iaiLAGrNoa4EVoo17gyIiD0WO1DQOM/UqBmRV2WL2k+IGFalbMdKB7eq3XRpwdQLTfx1sjZ7/GVVP8Lpi6DAE4BspW6alIMKBmAEsOUZOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749913284; c=relaxed/simple;
	bh=vF9J/Iy5Mhyyh2bS6OeH5FuKuHIGlTckQsbcj/+qB2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S1MpacSCL8gFJWcajcaSCk6bLsPvqbiyYlg/yss158Ws3TMdtClaesKFDZryrIv1wL8iW9iojH1RtYfV1S8p5fuPaC6/u9l+k0P0aw7GlWxvvZ0jUTue51WneEOBWf7EGtJQ+JSpT5Z3B9Or8fU5VUpXVya6nfLobbwN9deNVzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7Rz/p2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3859C4CEEB;
	Sat, 14 Jun 2025 15:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749913283;
	bh=vF9J/Iy5Mhyyh2bS6OeH5FuKuHIGlTckQsbcj/+qB2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R7Rz/p2xSefUKAqOOlLZW/3yhBIedFk/me+RiFDwAxMXj9VNuueimU1T/3SbrzvrY
	 at44IW5wo2Rzb0hGCPpr01OcLp1/heM2dwPCrwu3mIwSVq2p07XOrUMZaYFQYWBJta
	 NDH2/99bJHMn1GDc+A1N8IcSGw+Ww7qxd1fmOrOJs4JCaZxge/iOFVndNbsCc6hmSl
	 VoDYWaCltdzGlEJ2wTxv0GCUGuBPsC6emCk1RO5dd6vakTPX64Ocl72FdnwUDU5e90
	 dFn1nNIV7pfunT4Kw4cAcE9V9d21HqvUo+vpAIVVWzUxMB3DNz+XHteZTZIRpd3JVr
	 V029aMZN/pgJQ==
Date: Sat, 14 Jun 2025 17:01:16 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Linux Doc Mailing List
 <linux-doc@vger.kernel.org>, Akira Yokosawa <akiyks@gmail.com>, Breno
 Leitao <leitao@debian.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Ignacio Encinas Rubio
 <ignacio@iencinas.com>, Jan Stancek <jstancek@redhat.com>, Marco Elver
 <elver@google.com>, Paolo Abeni <pabeni@redhat.com>, Ruben Wauters
 <rubenru09@aol.com>, Shuah Khan <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v2 05/12] tools: ynl_gen_rst.py: Split library from
 command line tool
Message-ID: <20250614170116.15b91ad2@foz.lan>
In-Reply-To: <CAD4GDZwJtrL3uRCXNJ9vdfXAnjL4H5nhSqn3GDSW90Ee22qgGA@mail.gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<440956b08faee14ed22575bea6c7b022666e5402.1749723671.git.mchehab+huawei@kernel.org>
	<m234c3opwn.fsf@gmail.com>
	<20250613141753.565276eb@foz.lan>
	<CAD4GDZwJtrL3uRCXNJ9vdfXAnjL4H5nhSqn3GDSW90Ee22qgGA@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Sat, 14 Jun 2025 14:34:01 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> On Fri, 13 Jun 2025 at 13:18, Mauro Carvalho Chehab
> <mchehab+huawei@kernel.org> wrote:
> >
> > Em Fri, 13 Jun 2025 12:13:28 +0100
> > Donald Hunter <donald.hunter@gmail.com> escreveu:
> >  
> > > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> > >  
> > > > As we'll be using the Netlink specs parser inside a Sphinx
> > > > extension, move the library part from the command line parser.
> > > >
> > > > No functional changes.
> > > >
> > > > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > > > ---
> > > >  scripts/lib/netlink_yml_parser.py  | 391 +++++++++++++++++++++++++++++
> > > >  tools/net/ynl/pyynl/ynl_gen_rst.py | 374 +--------------------------  
> > >
> > > I think the library code should be put in tools/net/ynl/pyynl/lib
> > > because it is YNL specific code. Maybe call it rst_generator.py  
> >
> > We had a similar discussion before when we switched get_abi and
> > kernel-doc to Python. On that time, we opted to place all shared
> > Python libraries under scripts/lib.
> >
> > From my side, I don't mind having them on a different place,
> > but I prefer to see all Sphinx extensions getting libraries from
> > the same base directory.  
> 
> It's YNL specific code and I want to refactor it to make use of
> tools/net/ynl/pyynl/lib/nlspec.py so it definitely belongs in
> tools/net/ynl/pyynl/lib.

To avoid duplicating comments, let's discuss this at patch 12/14's
thread.

Thanks,
Mauro

