Return-Path: <netdev+bounces-123793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC159668C5
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:14:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B757A1F23715
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 18:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFE81BAECC;
	Fri, 30 Aug 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRUviqe7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8183A61FEB;
	Fri, 30 Aug 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725041675; cv=none; b=FayFCv4g3S4jhIdue2wiN34NWon7wA3+nW2lLXaGrPc6VFQtYRO7UG1LN2qduS1rt3V+FE9iaiaGohV7GTOd+H7FHS7KKMXXWPCoTtyQOcoqhFtyKBy4UwlgcWuJdNQvl6lasQ50W9SxBMY8uHmey82tLuSsd8H997YskbxImWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725041675; c=relaxed/simple;
	bh=sNqDgrGCz22L2upEkK7XHWMdxxRo6ahFTX3BiWV9QCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDKcbERE+aKkb/KjSxy91fcaS6cflM1SqmzGArTlqQxxjLTOHMOGgSYg49HOi1aqtI55sD00qIoVtSp1AtKIbcjadtWpg/Lrp5ZQryAStoQBqPI+pKl0zjWqV5EMCXZdImMGtm40bWGlx9YWTzB8swRUdiMvZkoObhKJFa0NpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRUviqe7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08726C4CEC2;
	Fri, 30 Aug 2024 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725041675;
	bh=sNqDgrGCz22L2upEkK7XHWMdxxRo6ahFTX3BiWV9QCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MRUviqe7lZN3d7NfW2SYVkqq3Fyb82myS1HSsenexEPA7UoSVQD4a0zVmLsIAmq7m
	 VB4OxWXj4P3k/0Dke2HZquPwuG7/ZHFrRNUFefcFQf1okRRg1OA2/eAYzoPqWCG08O
	 ivGO2XCbXIuGRKQItgTbKiQy8ClNffOH95zD0AlNXdHDuxHyT/ssJHHCNJU94i3IcP
	 TgtcbRdPRUmo0b9e4tEVe9eFV19/oFbapyUPL5Ycz4FQcSwxgQtSXDezdLo2is1Nho
	 5i+XlAhB+TLQGOw20jLDRwMr2YMyDc0mkGDnBV6QF2DsrSii07iebWiAiLOcJfLk76
	 HPPbraMFw50bw==
Date: Fri, 30 Aug 2024 19:14:30 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: Re: [PATCH net-next 1/6] net: ag71xx: add COMPILE_TEST to test
 compilation
Message-ID: <20240830181430.GC1368797@kernel.org>
References: <20240829214838.2235031-1-rosenp@gmail.com>
 <20240829214838.2235031-2-rosenp@gmail.com>
 <20240830154942.GT1368797@kernel.org>
 <CAKxU2N_ao94KNa+wZFmx+ZMRjTc5UXD0PgqXF=pb27w93xh9Gw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N_ao94KNa+wZFmx+ZMRjTc5UXD0PgqXF=pb27w93xh9Gw@mail.gmail.com>

On Fri, Aug 30, 2024 at 10:32:08AM -0700, Rosen Penev wrote:
> On Fri, Aug 30, 2024 at 8:49 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Aug 29, 2024 at 02:48:20PM -0700, Rosen Penev wrote:
> > > While this driver is meant for MIPS only, it can be compiled on x86 just
> > > fine. Remove pointless parentheses while at it.
> > >
> > > Enables CI building of this driver.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > Thanks, this seems to work well.
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > As a follow-up, could you consider adding a MODULE_DESCRIPTION()
> > to this module. It now gets flagged on x86_64 allmodconfig W=1 builds.
> v2 patchset?

I'd wait to see if this patchset is accepted.
And if so, send a new patch separately.
If not, perhaps add it to v2.

