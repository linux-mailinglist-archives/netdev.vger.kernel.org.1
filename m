Return-Path: <netdev+bounces-51649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 764A87FB951
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 18B97B21568
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 11:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B3004F5F4;
	Tue, 28 Nov 2023 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgSy7foS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4131C3C
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A266CC433C7;
	Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701170425;
	bh=Bbx88lqFMGatwFHlD0kQVkdO9pmX8bC2BeBmnxyMEmQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GgSy7foS9Mx9VL3KJuEL7r1pvft1WAsNxazpPgZpFChIpm9hPTAzcPa6LzjZoxH2F
	 ilp72qD9tIpKuThy+Sxs0AjoV31d17lTKwX+cp2+sOcuZ3A33qKmp/YnsAUSA197VY
	 nd6xnCxiqUf43dbgNDPC/uEgng3RdA2yJBQoReaPxh6Txp7yZlfVWGDqznF0NHO5S2
	 1UAUl5Yx2nHd5TkcOlqcoe1v48hv2u2Fo2vUMF3JJnGflpwEH6VEA9KJyIgwQYmnPH
	 KXd71HVLA133Uwpu4kSjGTgqZKZkQGP1uz+2wdzqj/InV4J1hDli0zH4cv22FNp7qk
	 BSSVLGbRs9YmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88933DFAA83;
	Tue, 28 Nov 2023 11:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-pf: Restore TC ingress police rules when
 interface is up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170117042555.17319.6348597047572958500.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 11:20:25 +0000
References: <1700930217-5707-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1700930217-5707-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep Bhatta <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Nov 2023 22:06:57 +0530 you wrote:
> TC ingress policer rules depends on interface receive queue
> contexts since the bandwidth profiles are attached to RQ
> contexts. When an interface is brought down all the queue
> contexts are freed. This in turn frees bandwidth profiles in
> hardware causing ingress police rules non-functional after
> the interface is brought up. Fix this by applying all the ingress
> police rules config to hardware in otx2_open. Also allow
> adding ingress rules only when interface is running
> since no contexts exist for the interface when it is down.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Restore TC ingress police rules when interface is up
    https://git.kernel.org/netdev/net/c/fd7f98b2e12a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



