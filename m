Return-Path: <netdev+bounces-37519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF7067B5C28
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 22:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2728B281AAF
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 20:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F41D539;
	Mon,  2 Oct 2023 20:38:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74989CA44
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 20:38:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431D4C433C8;
	Mon,  2 Oct 2023 20:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696279085;
	bh=jKPwA4P6nQ5kxg8vRRfjFSgIxbHzzXE+7FY6uh0C2P4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eMqhukkfUrEcD0BYIw9hLxIg3fzeK2MSY6RlwpYsMwk4n5udXEKJm6wwceq/UawYM
	 bT3W3blw2X//ge96SadRcKD0FxGUAXyHMk3kZor4RdwSmulOXquYqaw5j0M4PBssRe
	 WqnQmm41g0i2mKi8jIj1InHjEihqmUiuebgAHmQ4X5gslT6R5yK9Ta9Vhv1640MrYc
	 9w4FoxLQg3zQR4mh6IROehSrpEV9sR8WRYtXNpzYVw0PU342FQAp5hV2EyX843gaET
	 d62nT5V31kd18lwm3t0l1Xs7EO5od75lDmW3YN4tukKwGuKhXsdargVQob1MR/oC3M
	 JCaCGvym2RQSA==
Date: Mon, 2 Oct 2023 13:37:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Remi Pommarel <repk@triplefau.lt>
Cc: Paolo Abeni <pabeni@redhat.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Jose Abreu <joabreu@synopsys.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: stmmac: remove unneeded
 stmmac_poll_controller
Message-ID: <20231002133759.133d8a97@kernel.org>
In-Reply-To: <ZRKozLps8dmDmQgc@pilgrim>
References: <20230906091330.6817-1-repk@triplefau.lt>
	<626de62327fa25706ab1aaab32d7ba3a93ab26e4.camel@redhat.com>
	<ZRKozLps8dmDmQgc@pilgrim>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 Sep 2023 11:47:56 +0200 Remi Pommarel wrote:
> > I'm sorry for the incremental feedback, but we also need a suitable
> > Fixes tag, thanks!  
> 
> I didn't include Fixes tag because it would go back up to the initial
> driver support commit [0]. I can't be sure that this commit includes
> necessary NAPI implementation to be able to get rid of
> .ndo_poll_controller callback back then. And I am not able to test it on
> older version than 5.15.x hence I only included the 5.15.x Cc tag
> version prerequisite.
> 
> But I surely can add a Fixed tag if it is ok for it to be [0].
> 
> Also sorry for the long replying delay.
> 
> [0] commit 47dd7a540b8a ("net: add support for STMicroelectronics Ethernet controllers")

AFAIU the Fixes tag only indicates where the bug was present,
no guarantees on whether the fix can be backported as far back.
IOW I think [0] as Fixes tag will be perfectly correct, please
repost with it included?

