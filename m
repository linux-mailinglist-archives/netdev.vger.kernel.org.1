Return-Path: <netdev+bounces-38020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD4D7B8666
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 19:25:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id DEF711F222DD
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 17:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536E91CAB6;
	Wed,  4 Oct 2023 17:25:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 426E71BDC1
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 17:25:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561E0C433C7;
	Wed,  4 Oct 2023 17:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696440328;
	bh=EAkymE/o1SEBuuXWw/QWqDVXCelOtrX/lIByZ98hZJ8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TNb11iPBE2/5MFKAgt05MTpJXTCKaIRg7rCPai1At0nx3R0M2a7EjH2tWaI5wFPYf
	 hA3ncCBOS+DrGShHe2ZURe/G/+bQpAwBBPeJzWBpOlXmrIzglx2dP3YwQkjQ8AMoOn
	 +s4qHiabBnKnJCa+8wOl0AillAzht3ndXGpK1fY7NLoNSRKDgFo0/jFjWqpul7VIGa
	 5kJpkO3HmmyogY1Xha9d6cKdRx7AjPAKG+evYOrdJ4P+HeWlIrz23NBHQaflMeXXh8
	 K8YcHwGoRf00F0jJN++kA9oh46nv5aFKQO1Ik9YwOXE4zsl3UopI3pn/AJpkCYxv0v
	 i0OdPY+YLekwA==
Date: Wed, 4 Oct 2023 10:25:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: patchwork-bot+netdevbpf@kernel.org, khalasa@piap.pl,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: ixp4xx_eth: Specify min/max MTU
Message-ID: <20231004102527.3a4bf0e2@kernel.org>
In-Reply-To: <CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
References: <20230923-ixp4xx-eth-mtu-v1-1-9e88b908e1b2@linaro.org>
	<169632602529.26043.5537275057934582250.git-patchwork-notify@kernel.org>
	<CACRpkdacagNg8EA54_9euW8M4WHivLb01C7yEubAreNan06sGA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 3 Oct 2023 23:54:49 +0200 Linus Walleij wrote:
> Sorry Paolo, this is the latest version of this patch, which sadly changed
> Subject in the process:
> https://lore.kernel.org/netdev/20230928-ixp4xx-eth-mtu-v3-1-cb18eaa0edb9@linaro.org/
> 
> If it causes trouble for you to replace the patch I can rebase
> this work on top of your branch, just tell me.

Yes, please! Sorry about the mess, we're a bit backlogged after we
all went to Kernel Recipes :(

