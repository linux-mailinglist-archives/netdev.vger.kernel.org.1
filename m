Return-Path: <netdev+bounces-107475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C7691B23F
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 00:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7661E1C21D90
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 22:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFF01A254A;
	Thu, 27 Jun 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KeLiogIG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA30D19B590
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 22:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719527629; cv=none; b=qdP3aGk5o1TQetcqrPMJadLM/Y3JhfG//7c4FJDah4C0y/T/j+FsmNpFDRWQgguN3CIr8iEl43afrrTXjgTcMvF5vvT086SOlvV4aKWjxLc67wsmD50CFLQBk2OOX6f52t5cuNc2mcxkyFmpipUPTtegJIB23xuQivCY8Zqt1n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719527629; c=relaxed/simple;
	bh=owzXk9TMfWi9iRaAhW2TUCLk4P91oRm7ND5JM/NdHrc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIkkKh0LPc/lTBVuTHOlC9iO9kHm23vWKpvMQgUHYomkzF3YyEU426k3WvCh8VDbWeRjio3XVIaTFZHfYInWS4vi2zxad0JhN6gjWGf5YDMhVwwMpkK6pEiJe8B52JSwEnB4eEb/xvF277LNUEBLHbBu9462p605stvs0Tl5uxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KeLiogIG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7D6C2BBFC;
	Thu, 27 Jun 2024 22:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719527629;
	bh=owzXk9TMfWi9iRaAhW2TUCLk4P91oRm7ND5JM/NdHrc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KeLiogIGQauitlMVr9ZoMD0XS9Fbio0p2KB6MBgZfMWachcFQw4Bb0xmz4/TtetNf
	 qHWdLtuxpgZ45+ufk25fxb3fQTTFigeMLB70FzbwGJr/sPQ/nRAquAIT+dtEPoxXHM
	 B7Ju/Yx8FHFsJx2K87e6nEKo7eroiEw0zY/6XzHlvkk9EDjbqTwICjiDa/OeoYceTk
	 2mUZay6yyHrf1D4vbLv0kihBV74AJhWxiPfEGITzd4Rx8PYH82daK9+LJ5qfO/rTbY
	 h+Q4mqGKo5mBs3UfbYJH1GhiC+DtXI3kcncGMmS/gGyWfnROwgfIkGHqrCEGvi5C41
	 Kwqa+p4TwkTAA==
Date: Thu, 27 Jun 2024 15:33:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lance Richardson <rlance@google.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 netdev@vger.kernel.org, pabeni@redhat.com, borisp@nvidia.com,
 gal@nvidia.com, cratiu@nvidia.com, rrameshbabu@nvidia.com,
 steffen.klassert@secunet.com, tariqt@nvidia.com
Subject: Re: [RFC net-next 01/15] psp: add documentation
Message-ID: <20240627153347.75e544ac@kernel.org>
In-Reply-To: <CAHWOjVJ2pMWdQSRK_DJkx7Q9zAzLx6mjE-Xr3ZqGzZFUi5PrMw@mail.gmail.com>
References: <20240510030435.120935-1-kuba@kernel.org>
	<20240510030435.120935-2-kuba@kernel.org>
	<66416bc7b2d10_1d6c6729475@willemb.c.googlers.com.notmuch>
	<20240529103505.601872ea@kernel.org>
	<CAHWOjVJ2pMWdQSRK_DJkx7Q9zAzLx6mjE-Xr3ZqGzZFUi5PrMw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 27 Jun 2024 11:14:39 -0400 Lance Richardson wrote:
> > > Connection key rotation is not supported? I did notice that tx key
> > > insertion fails if a key is already present, so this does appear to be
> > > the behavior.  
> >
> > Correct, for now connections need to be re-established once a day.
> > Rx should be easy, Tx we can make easy by only supporting rotation
> > when there's no data queued.
> 
> Could you elaborate on why updating the Tx key should only be allowed when
> no data is queued? At the point rekeying is being done, the receiver should
> accept both the new and previous key:spi.

I didn't say it shouldn't be allowed, just that disallowing it
initially would make the implementation easier ;)

> The lack of support for rekeying existing connections is a significant gap. At
> a minimum the API for notifying the application that a rotation has occurred
> should be defined, 

Notifications are in place, that's one of the reasons I chose netlink.

> and the implementation should allow the configuration of a new Tx
> key:spi for rekeying.

I was under the possibly mistaken impression that Google have used PSP
for years without rekeying... Did I misunderstand?

> A tiny bit logic would also be needed on the Rx
> side to track the current and previous SPI, if the hardware supports
> keys indescriptors then nothing more should be needed on the Tx side.
> If the NIC maintains an SA database and doesn't allow existing
> entries to be updated, a small amount of additional logic would be
> needed, but perhaps that could be (waving hands a bit) the
> responsibility of the driver.

Interesting. Hm. But SADB drivers would then have to implement some
complex logic to make sure all rings have cycled, or take references.
I'd rather have an opt-in for core to delay reaping old keys until
all sockets which used them went empty at least once (in wmem sense).

