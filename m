Return-Path: <netdev+bounces-114236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CB941AB7
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 18:46:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11ACC280BDB
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D218801A;
	Tue, 30 Jul 2024 16:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHFnND48"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0901A6166;
	Tue, 30 Jul 2024 16:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722357995; cv=none; b=kCb6A2ODJZc09cQGMx35RdwC5v2ztGcFKyxDjpjnji7k7OEAMiqx/rLCXpdHuq0F/Bm4e3mCc99bf5YaHtvMLOLDlLFL1S0uOYgFIa6nU0sX0XhbbPrrDZwkl2Rk4CTt+SyDen6KXl4CHlymLd/FpjJ2p/OXZka0tB1rrWt3muY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722357995; c=relaxed/simple;
	bh=yKocv73H+egn5xniKK26t57F3q3tjDzVqN7vvpAbTsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ETi1bF1PgO5TnHyIOa8yHKPdES+UXplI0Uda4P8/3KrDtSvO1MhrgQeyi2/207OZy0BQMb1WG2CxG6e5afIyLpOAIluS/E72UQS/CL9vNoLtqxABVtndipTQUXVmXQ+YnRktQ7bT0wz8In9kMqqJ9DAT0SXlKJ95byhZSlDdJHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHFnND48; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30E80C4AF11;
	Tue, 30 Jul 2024 16:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722357994;
	bh=yKocv73H+egn5xniKK26t57F3q3tjDzVqN7vvpAbTsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DHFnND488rxxZJnzdmpMR00HFpiDrHPdXtEQmHAistn3OGYmVUyEUXAIM0en3BruP
	 B/8iWUELTLa4bhS1YmkhWidHmq6kj084YU5KRPykIyjZlOe+lm7QAbLz9A+78LGqPA
	 X29lO6MPcJLr11DDdxMmWsOQ5R1zZHgw/xTDjRINpjfZvWqeZNMYRaPEhq7ATbSqSl
	 7yd+AUTwWK+fYkOppRRz3Qvr5mW9dwOtxgvRvhBBDPIautHjim1K4et9kh49Fqw+wq
	 WtHrLeZl9uD5AuOWaC8228ddxfhhSz/00Dz4myIEOTvG0cuRCa7OPh+H3uanA0Eci1
	 +0qyU8PyhywZQ==
Date: Tue, 30 Jul 2024 17:46:31 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	kuba@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: Add skbuff.h to MAINTAINERS
Message-ID: <20240730164631.GE1967603@kernel.org>
References: <20240729141259.2868150-1-leitao@debian.org>
 <20240730125700.GB1781874@kernel.org>
 <ZqkQPeb8iNlqfSh9@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqkQPeb8iNlqfSh9@gmail.com>

On Tue, Jul 30, 2024 at 09:09:33AM -0700, Breno Leitao wrote:
> Hello Simon,
> 
> On Tue, Jul 30, 2024 at 01:57:00PM +0100, Simon Horman wrote:
> > On Mon, Jul 29, 2024 at 07:12:58AM -0700, Breno Leitao wrote:
> > > The network maintainers need to be copied if the skbuff.h is touched.
> > > 
> > > This also helps git-send-email to figure out the proper maintainers when
> > > touching the file.
> > > 
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > I might have chosen the NETWORKING [GENERAL] rather than the
> > NETWORKING DRIVERS section. But in any case I agree skbuff.h
> > should be added to Maintainers.
> 
> I will move the same change to "NETWORKING [GENERAL]" then, and carry
> you Reviewed-by if you don't mind.

Thanks, please feel free to do so.

