Return-Path: <netdev+bounces-135154-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE55A99C87D
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 13:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD511F21D6E
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 11:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CCE273446;
	Mon, 14 Oct 2024 11:13:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E24E156C69;
	Mon, 14 Oct 2024 11:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728904423; cv=none; b=VpuRfu+NTG2JArcHF9SesguzGhKWMJNgIw09rDnxoGqIGwsUbU8tTOgE1nmENXs7riLRtkcX1ohvhNWaEMNNmHT6DmhsLeIpU1Nr8KAYBHgYcA/KNF4yW4VphxkDEAV/XHUaxxMhIxzSGPsHMbb2EzvEJue7zL7ojxDFsUzORMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728904423; c=relaxed/simple;
	bh=s9EdIrToNe1X4raz+OIvL//9qPb1YTxtelE1sffA10w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=KJifnSmF5ex9KppAqJAnp4ZfxAIe9bcRylS49WswBQo334ShcE+aYji6U3ZP/VDArvHB7ih6expv5E0iYjnO01BHvhPmlVMGE1CTBEpfGlO+DnUVYvTL9mXq6Dc802iIhZbPaHLwC4cZAiVumZlgng6UH7ybBmtpSwRSAFLdsbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 8135492009C; Mon, 14 Oct 2024 13:13:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7C88A92009B;
	Mon, 14 Oct 2024 12:13:39 +0100 (BST)
Date: Mon, 14 Oct 2024 12:13:39 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Thorsten Leemhuis <linux@leemhuis.info>
cc: Johannes Berg <johannes@sipsolutions.net>, 
    Jakub Kicinski <kuba@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>, 
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
    Linux Networking <netdev@vger.kernel.org>, 
    Loic Poulain <loic.poulain@linaro.org>, 
    Sergey Ryazanov <ryazanov.s.a@gmail.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, 
    Simon Horman <horms@kernel.org>, Martin Wolf <mwolf@adiumentum.com>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
In-Reply-To: <cc949ab7-b5aa-4812-9c4a-d50bfee92de0@leemhuis.info>
Message-ID: <alpine.DEB.2.21.2410141209390.40463@angie.orcam.me.uk>
References: <20231023032905.22515-2-bagasdotme@gmail.com> <20231023032905.22515-3-bagasdotme@gmail.com> <20231023093837.49c7cb35@kernel.org> <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com> <20231023185221.2eb7cb38@kernel.org>
 <3a68f9ff27d9c82a038aea6acfb39848d0b31842.camel@sipsolutions.net> <cc949ab7-b5aa-4812-9c4a-d50bfee92de0@leemhuis.info>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 14 Oct 2024, Thorsten Leemhuis wrote:

> >>> He's now in a state of limbo. He has significant contribution
> >>> (and gets listed by get_maintainer script with (AFAIK) no way
> >>> to filter him out), yet emails to him bounces. What will be
> >>> the resolution then?
> >>
> >> Yes :( Not much we can do about that (even if we drop him from
> >> maintainers all fixes will CC him based on the sign-off tags).

 FWIW adding an entry to .get_maintainer.ignore is the way to sort it.

  Maciej

