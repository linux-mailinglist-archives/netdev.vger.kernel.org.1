Return-Path: <netdev+bounces-212025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A53BB1D546
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 11:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305EA561F5E
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 09:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A4625A2AB;
	Thu,  7 Aug 2025 09:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bz2cTOOe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E33C22D7B0
	for <netdev@vger.kernel.org>; Thu,  7 Aug 2025 09:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754560093; cv=none; b=MDPLaLQaCZN/AAkdOnAhjxnD6QtBaBsx2slt3Sxb/5qk6CaojicOeqXrVGhJSGgYT4TZw7Y9nX7TXsh2PvuBVCpCValYvsP09W8c/CUESU4g2xgxh5vnOXVotgitp4dJt0vtd4VOluY/fzeeleGTw08m0f8YpQHCYxGN7xYvYDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754560093; c=relaxed/simple;
	bh=5j63TcvqF73KeVM4BbHJK5fADef1lh/sCVEvI3je1XY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IrorHAhfEW8J2acqVDw94sKIR+VBf7g686dNR55/aNbhSzFZvL6+bzjAYcyNpQeITJr4cCqN+gPWVQmNQC2MGKPhlQOuRwSH/9grCSgeXMdieivXQvEFxv7YC1HuJHetmpAWXJZD2AlRJ8/Pcx/x1Yh6VcpNKEftJAMybXK6lu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bz2cTOOe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1798FC4CEEB;
	Thu,  7 Aug 2025 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754560092;
	bh=5j63TcvqF73KeVM4BbHJK5fADef1lh/sCVEvI3je1XY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bz2cTOOeH6G3/CLydXaQGU/qAzEWzMHFNFpigsMkjNw8eljKHyd+Q92AYudFg2Xg2
	 8QGEwv1YfmM/SfKA04doPbkgELfz6UYRT8+YZMo/AlLGARDXj5B9Fjg61hxrKHAkE1
	 njCmk3A6HpwPLB+7oJigS2p9r0btPdJ25FVA37Iau11G8PdfagXN0gvyMY3tdCdXh6
	 9j2cEzKprQkjWewGFdDwIUZAwrEx2KjGgCaSYxpkEUXv8UlslOzh2RqrVN2PGIPRm2
	 GSo+/yYV6DFTkx5I/FAXcZx7RuEIguOBjbAdCBSdtGgmQeiv/H8YheTbQ5V6vSP9rV
	 mTF9gx/YLZeUQ==
Date: Thu, 7 Aug 2025 10:48:08 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Dennis Chen <dchen27@ncsu.edu>, Dennis Chen <dechen@redhat.com>,
	netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, petrm@nvidia.com
Subject: Re: [PATCH net-next 0/3] netdevsim: Add support for ethtool stats
 and add
Message-ID: <20250807094808.GA82267@horms.kernel.org>
References: <20250805213356.3348348-1-dechen@redhat.com>
 <20250805155550.3ed93078@kernel.org>
 <CALSBQO=Q5fPxAuAAdgN8eUgTGVzdRYhthLvb6052SzsDV0uZ3A@mail.gmail.com>
 <20250806074800.65fa46bc@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806074800.65fa46bc@kernel.org>

On Wed, Aug 06, 2025 at 07:48:00AM -0700, Jakub Kicinski wrote:
> On Wed, 6 Aug 2025 10:05:27 -0400 Dennis Chen wrote:
> > > The tests for netdevsim must test something meaningful in the kernel.
> > > This submission really looks like you need it to test some user space
> > > code.
> > 
> > This test would help verify that ethtool_ops correctly propagates stats to
> > userspace, would that not be significant enough for a test?
> > 
> > My thought was that it would be similar to the patches for ethtool
> > --show-phys here:
> > https://lore.kernel.org/netdev/20250710062248.378459-1-maxime.chevallier@bootlin.com/
> 
> What are you trying to test. Like, what _actually_ made you and Kamal
> write these patches? I can't think of many bugs in the area. And you
> clearly have zero familiarity with our recommendation of what stats
> to report and how :/ so if anything your code is hurting more than
> helping.

Thanks Jakub,

I'll work with the team to find a better approach.

