Return-Path: <netdev+bounces-38238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA677B9D53
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id F3598281A8D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EDD1B297;
	Thu,  5 Oct 2023 13:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qp9BOUDm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE263125A3
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:30:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5C72EC4AF69;
	Thu,  5 Oct 2023 13:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696512635;
	bh=TS8iQF3pZ+MrI0LCqI3NgyUR8ILWgVcCfwy5pAkXYFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Qp9BOUDm024I9JujoEUevDiJH/CXU0J0vxvE2wS9M0GEqKaiZ+ydjKAb6hHE0uhbh
	 rCvtx43h9w2F9T/FEVuYuT/IA2QvKwURb045pIiBqx6L5AryNNtPz8OZko0POSwQYx
	 c2XVyIdZdlFV1y/t+nNA+GBUotZXgfhEGcQw/iAxTj8kdxH3J6pQgKC8iwgwfIvVmt
	 4tv0tj3iuYLbyvsntTWtvYzYHCHWNOXdNetUrUjUHRhRzDPnWUF0cAL86XJWTs/2k0
	 v4KtWUtuokBD7U/16cleqwjA8l+A0MPsyhZGKeld640juxikEJDF8Tmk077rvjQJph
	 IzGKXysbdH+jA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 464BBE11F51;
	Thu,  5 Oct 2023 13:30:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH] net: ethernet: mediatek: disable irq before schedule napi
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169651263528.29610.10578709494865123351.git-patchwork-notify@kernel.org>
Date: Thu, 05 Oct 2023 13:30:35 +0000
References: <20231002140805.568-1-ansuelsmth@gmail.com>
In-Reply-To: <20231002140805.568-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: nbd@nbd.name, john@phrozen.org, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 igvtee@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  2 Oct 2023 16:08:05 +0200 you wrote:
> While searching for possible refactor of napi_schedule_prep and
> __napi_schedule it was notice that the mtk eth driver disable the
> interrupt for rx and tx AFTER napi is scheduled.
> 
> While this is a very hard to repro case it might happen to have
> situation where the interrupt is disabled and never enabled again as the
> napi completes and the interrupt is enabled before.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mediatek: disable irq before schedule napi
    https://git.kernel.org/netdev/net/c/fcdfc462881d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



