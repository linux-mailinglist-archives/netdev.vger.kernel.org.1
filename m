Return-Path: <netdev+bounces-198119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0633BADB520
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7E13ABD2A
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 15:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98041E834F;
	Mon, 16 Jun 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbgKzOlD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B482BEFF9
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 15:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750087166; cv=none; b=Q7CUu9YuhX7KXB/zDexiKIArqvi8ByJZPKKqGzvsio2a01qTG0TdA2RCmCIie/gV3Y+D0H2kvWvzczlZztA4V4LzjKinKgxG9Rlu+EAMx9R69f5IWTUwnZ1dTu0H6k3dKGlUUPEVaFQyZ3JZD/YWyXUIUPWgeY6j2pGMv0nE9M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750087166; c=relaxed/simple;
	bh=wbUyEVZzoWIRZlbanC21YaQp3v4NdRvFBdLC2fNdYT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GfMH6BZj9lN/PQHaXJqi8tdU/iEm/ERAHnsDxRrRhYEpQOhF0/UdiMUMLLXmZjfi/xpta1E9bjpHUq5zbcKp8Uxth7S6LP5JM9L9uiGvDA+3sNF4BfhiNQRt9pWc1JVqB1vuNt1cplzusQPg3NkjHuek62KYZM4wN0GvJFdxVTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbgKzOlD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B93C4CEF0;
	Mon, 16 Jun 2025 15:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750087166;
	bh=wbUyEVZzoWIRZlbanC21YaQp3v4NdRvFBdLC2fNdYT8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nbgKzOlD0CBqvHnwjAgm0MtKp+2MQShyKGubX+0H0UUxO8nbaLucageAYWW2frFIe
	 Fjg8RHRe1Y/BVf2oecswknXP3EFiXr+PX5IKCjoY7Nezs5vB5Av6ZfV+x1L4EJOL3k
	 RGZTcBD69zMjV1YaDv8HjnYJL6RAIawiPkBnWOP4hpC+u1q74FIfWI690D5vZQN5+Y
	 px2KueBytBY4Di2nzYT71lKb0gjXjkRK6mK424eXPT7UhqNvl+ZUcg9fdpO2JTZjmM
	 PE28aQbfOYn7c8WJj9S1BBACTSXCoL1YKqA0Cup2FbYrNWZxu7D7PfZ6gxufqMj4qF
	 xG6MqwSVBupFg==
Date: Mon, 16 Jun 2025 18:19:21 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexander Duyck <alexander.duyck@gmail.com>, netdev@vger.kernel.org,
	hkallweit1@gmail.com, davem@davemloft.net, pabeni@redhat.com,
	kuba@kernel.org, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [net-next PATCH 0/6] Add support for 25G, 50G, and 100G to fbnic
Message-ID: <20250616151921.GD750234@unreal>
References: <174956639588.2686723.10994827055234129182.stgit@ahduyck-xeon-server.home.arpa>
 <20250612094234.GA436744@unreal>
 <daa8bb61-5b6c-49ab-8961-dc17ef2829bf@lunn.ch>
 <20250612173145.GB436744@unreal>
 <52be06d0-ad45-4e8c-9893-628ba8cebccb@lunn.ch>
 <20250613160024.GC436744@unreal>
 <aEyprg21XsgmJoOR@shell.armlinux.org.uk>
 <20250616103327.GC750234@unreal>
 <aFABfaQywj1GOQiv@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFABfaQywj1GOQiv@shell.armlinux.org.uk>

On Mon, Jun 16, 2025 at 12:35:25PM +0100, Russell King (Oracle) wrote:
> On Mon, Jun 16, 2025 at 01:33:27PM +0300, Leon Romanovsky wrote:
> > On Fri, Jun 13, 2025 at 11:43:58PM +0100, Russell King (Oracle) wrote:
> > > On Fri, Jun 13, 2025 at 07:00:24PM +0300, Leon Romanovsky wrote:
> > > > Excellent, like you said, no one needs this code except fbnic, which is
> > > > exactly as was agreed - no core in/out API changes special for fbnic.
> > > 
> > > Rather than getting all religious about this, I'd prefer to ask a
> > > different question.
> > > 
> > > Is it useful to add 50GBASER, LAUI and 100GBASEP PHY interface modes,
> > > and would anyone else use them? That's the real question here, and
> > > *not* whomever is submitting the patches or who is the first user.
> > 
> > Right now, the answer is no. There are no available devices in the
> > market which implement it.
> 
> That's strictly your own opinion, I doubt it's based on facts.

I based it on wrong assumption, that device on the market in 2025 needs
to be part of upstream Linux kernel too. I was wrong, sorry about that.

Thanks

