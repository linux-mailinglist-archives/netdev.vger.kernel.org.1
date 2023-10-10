Return-Path: <netdev+bounces-39413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A49B27BF115
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 04:50:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6961C20C04
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 02:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36F2615A7;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/ijsvDh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0295510F5;
	Tue, 10 Oct 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE742C433CA;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696906225;
	bh=Q5s1VZPYSu7cCJ2rJAuxMhAetdHKNdZm685p/HDoroc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/ijsvDhn+w7otl1J7HbIa+sLxP8OUx0bIN0E55RYLohfPhgjOagv/PWODvsYJdGH
	 FlWCuFPQDjjWyYJno+NdcA4PghE30mfKmcxzhVQUD9itTSzhvCMt+YZ7ZTTxuSyaLA
	 4LP8evtXoHO9LgLMq9/p3iC/hcntejZuLeBVFClREpbu0/k5da0QPXKFBghG754NRm
	 OuL8uIb8sI3H3SWKQg9H4d4hkYu1ERFI8ljvOPWvyWxCFPDxc7rJskW2ByDovF//AS
	 vLdnF9TwDBUjh7/bfdiHUji+T2sO61DZLI00un02sS7sQ6/A5+eSVX0moRYXzg3PWJ
	 lT8AnIiXS7wqg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8FFE2E11F4C;
	Tue, 10 Oct 2023 02:50:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cavium/liquidio: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169690622558.548.11736861209884778850.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 02:50:25 +0000
References: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
In-Reply-To: <20231005-strncpy-drivers-net-ethernet-cavium-liquidio-octeon_device-c-v1-1-9a207cef9438@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: dchickles@marvell.com, sburla@marvell.com, fmanlunas@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 05 Oct 2023 22:52:34 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> We expect `app_name` to be NUL-terminated:
> 	dev_info(&oct->pci_dev->dev,
> 		 "Running %s (%llu Hz)\n",
> 		 app_name, CVM_CAST64(cs->corefreq));
> ... and it seems NUL-padding is not required, let's opt for strscpy().
> 
> [...]

Here is the summary with links:
  - cavium/liquidio: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/c04235395595

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



