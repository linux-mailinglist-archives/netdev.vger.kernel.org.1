Return-Path: <netdev+bounces-197477-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E83AD8BE2
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 14:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8D9B1895D8C
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 12:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD472DA756;
	Fri, 13 Jun 2025 12:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sdckog3d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01ACC27281E;
	Fri, 13 Jun 2025 12:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749817081; cv=none; b=bZV6dObUfTmezG0Lr1pf1T9cELLD0r400Wq38vrgYRLopsBP+mVCylILROhzVamSbmVc49jZq+Ob+6GCs+ZoDo1lFJqJjqajR8jKZRF6A/sbIAeG3lP0uVn7EHQL0kimRqt0EMASH1krLT58HGUW8fMiIJZnJpLwh/KJVrNVXm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749817081; c=relaxed/simple;
	bh=gXzoRb7uJ+yYbBWIj96AUPad1dMJkavyCS+pd5PmGms=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fiWXT/iMcYx3KspEKbPYBx65VbfAMkg6GXjaQwA38XbcOXT/6gW9eW5WYkGUsvZ7eQixHj95UEELmCJDyDUWvEEaKKcY69IMZYciHxDIHXSuA/ZmAg4LYKDv9iJQQKXbhKJA5BTG5qgIKzLjAO8rpqM96DpEuo3SnX6NhKdf7HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sdckog3d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAC4AC4CEE3;
	Fri, 13 Jun 2025 12:17:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749817080;
	bh=gXzoRb7uJ+yYbBWIj96AUPad1dMJkavyCS+pd5PmGms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Sdckog3dBHS2nYXbzy8edite6b3n+fFL1jbXQ7QLacd3jS4cRTzrHXcaBB8pOhtPz
	 RZ/+/8examrUcMmbIo+znU7tMMyh1GYBaURivhVeXLe5riNDTrg5+fM/m0RSNaUZkN
	 911w9r0EmC7jgf+hz48nah/ykx8t/yW8mvinju0hHwFEyTbnJsgy3w+qJ9/WLLCb/8
	 1DltTz/jsEu5pbPSx4LKSpPt++06kzZP7NaAhP1M1pxAqqdtP6q3WMc66Satp8tuSV
	 XX59vS3cdqsMICezAEC1eSAYrpbSq3RLGpnR1V8ij7riQbiDITX8Vvhbk1FuKoaY5H
	 waD/oUGGEZVhQ==
Date: Fri, 13 Jun 2025 14:17:53 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet
 <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>, "Akira Yokosawa"
 <akiyks@gmail.com>, "Breno Leitao" <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Ignacio
 Encinas Rubio" <ignacio@iencinas.com>, "Jan Stancek" <jstancek@redhat.com>,
 "Marco Elver" <elver@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ruben
 Wauters" <rubenru09@aol.com>, "Shuah Khan" <skhan@linuxfoundation.org>,
 joel@joelfernandes.org, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, lkmm@lists.linux.dev, netdev@vger.kernel.org,
 peterz@infradead.org, stern@rowland.harvard.edu
Subject: Re: [PATCH v2 05/12] tools: ynl_gen_rst.py: Split library from
 command line tool
Message-ID: <20250613141753.565276eb@foz.lan>
In-Reply-To: <m234c3opwn.fsf@gmail.com>
References: <cover.1749723671.git.mchehab+huawei@kernel.org>
	<440956b08faee14ed22575bea6c7b022666e5402.1749723671.git.mchehab+huawei@kernel.org>
	<m234c3opwn.fsf@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Em Fri, 13 Jun 2025 12:13:28 +0100
Donald Hunter <donald.hunter@gmail.com> escreveu:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
>=20
> > As we'll be using the Netlink specs parser inside a Sphinx
> > extension, move the library part from the command line parser.
> >
> > No functional changes.
> >
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  scripts/lib/netlink_yml_parser.py  | 391 +++++++++++++++++++++++++++++
> >  tools/net/ynl/pyynl/ynl_gen_rst.py | 374 +-------------------------- =
=20
>=20
> I think the library code should be put in tools/net/ynl/pyynl/lib
> because it is YNL specific code. Maybe call it rst_generator.py

We had a similar discussion before when we switched get_abi and
kernel-doc to Python. On that time, we opted to place all shared
Python libraries under scripts/lib.

=46rom my side, I don't mind having them on a different place,
but I prefer to see all Sphinx extensions getting libraries from
the same base directory.

Jon,

What do you think?

Thanks,
Mauro

