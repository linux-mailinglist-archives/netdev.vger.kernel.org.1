Return-Path: <netdev+bounces-123495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A35196514E
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35A85284589
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A144518B475;
	Thu, 29 Aug 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELdlvzrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74724189B82;
	Thu, 29 Aug 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724964927; cv=none; b=nG+5rCPsjwX1aeYPAZ01oGpqs0JOf/Z8u5iXYyVGF5dj/aXKwuQcOVigmyGnD7As54zbjgdXr3wPV2tKbaaHJyPwdXfMiJbSR91sDWK2lXVDI/aP9k5Wvmeneyh1nVwOGPwMusdwx+nDiae1XtAEDipxY95BXR6gUGF4YZ6pnmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724964927; c=relaxed/simple;
	bh=98NgYxDFTZsyIcVeJpstEhZpPHzU/V/rLwQM7OZ3NQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m+epfsSHSXGObwLPfRbSV1I+onj4kBX3OwzDOKKYMoVlmbp84DfGw5umNsaF+jqe/+rU9yCwgul1rx5IugjrKMSmBCIQc/NAnWCDY5Q8hVieYIiPdWvkXVDD980KIiZam9CXxVjmlijHV2fkVXSFsTTV3vUb4/8cfbY93mwuEOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELdlvzrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E043BC4CEC1;
	Thu, 29 Aug 2024 20:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724964926;
	bh=98NgYxDFTZsyIcVeJpstEhZpPHzU/V/rLwQM7OZ3NQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ELdlvzrQNZephMZGNw04ktlB7TzO/liAMo28JPJwsWjRBGuZUG6Sp1GEGHsl0maLF
	 Hdq+5/tKOH2OHnKAlC/4IPVS0+l44HBiWcTQd1BYnKYBRe3bhtPyeik4ztJKP/NXN3
	 R2FTYTLdka6XBFtVcGH3M3xLRuzE7NYqIeTb+bgQq1FBSYW09DdOA6yV5OoE+Bg35+
	 RITfWrkEYC0D32vdzqEs28MS7vHzm72qI+4aB2E7jV+uLrVIavIYTDnyufWVCL+bJQ
	 hvIeUgLnXsyEwLq2ugiy7ySE/l+qlMrj4QXfZNSse3zIDIDb58ZEbdOLe1GzRwzLMy
	 TvJ5eFpo9fBdw==
Date: Thu, 29 Aug 2024 21:55:22 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
	o.rempel@pengutronix.de, p.zabel@pengutronix.de
Subject: Re: [PATCHv2 net-next] net: ag71xx: update FIFO bits and descriptions
Message-ID: <20240829205522.GC1368797@kernel.org>
References: <20240828223931.153610-1-rosenp@gmail.com>
 <20240829165234.GV1368797@kernel.org>
 <CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com>
 <20240829124752.6ce254da@kernel.org>
 <CAKxU2N9F6+nZzW=me_ti76RwUFiKqG5RT0Ztgztc8yE9O3fwhQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N9F6+nZzW=me_ti76RwUFiKqG5RT0Ztgztc8yE9O3fwhQ@mail.gmail.com>

On Thu, Aug 29, 2024 at 01:21:02PM -0700, Rosen Penev wrote:
> On Thu, Aug 29, 2024 at 12:47 PM Jakub Kicinski <kuba@kernel.org> wrote:
> >
> > On Thu, 29 Aug 2024 10:47:01 -0700 Rosen Penev wrote:
> > > > Please consider a patch to allow compilation of this driver with
> > > > COMPILE_TEST in order to increase build coverage.
> > > Is that just
> >
> > Aha, do that and run an allmodconfig build on x86 to make sure nothing
> > breaks. If it's all fine please submit
> Funny enough it did break due to a mistake (L0 vs LO).

Then I'd say this exercise is a success :)

> I guess I'll
> send a series just to keep these patches together.

In general, if you have multiple patches for the same driver,
for a single tree (net or net-next) I would either:
1) Send them as a series
2) Wait for one to be accepted before sending the next one

Option 1 seems appropriate here.

