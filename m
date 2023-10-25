Return-Path: <netdev+bounces-44122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CF07D66CA
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 11:30:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24EB71C20C24
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 09:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FD68210F7;
	Wed, 25 Oct 2023 09:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IECaYBO+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630301CAA6
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:30:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBF85C433C9;
	Wed, 25 Oct 2023 09:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698226227;
	bh=WgLbCbZb422DhssWwHjV2F+adNuN8RfYmX8+fYLv5Ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IECaYBO+n/vKUXRzVuk4hUrjt//p87EJnsE8yROhX4317MSk1Z5pgdtRENyIZYsFE
	 XtUX5HeycoXX/+/H0f1geWF0fxF26qqytPrIp3aCuijAzasx2Apd1bGcBvSj+qUb8m
	 07Z/OL+jFsBiitBzmetOn/cW19hIATNlJaAxPRKKwQHAreiT0h3CXCXCaLd+NNXQjX
	 GqKpx9ZkGh+U/8joDjiJZP0tzOLtjqnF4LopHQBASnxibzF9gBUvyg2Hrhv4MAjwWn
	 YcbMIxos0pnR7ePvUiFGlNtnXh3fjya9HXE/2iyH5cpU+Ju7Z0JrjzLqk4P2lbsL1k
	 qSWChpYlFCzQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F17FE11F54;
	Wed, 25 Oct 2023 09:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] sched: act_ct: switch to per-action label
 counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169822622764.10826.9242450205781718610.git-patchwork-notify@kernel.org>
Date: Wed, 25 Oct 2023 09:30:27 +0000
References: <20231024110557.20688-1-fw@strlen.de>
In-Reply-To: <20231024110557.20688-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, pctammela@mojatatu.com,
 jhs@mojatatu.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 24 Oct 2023 13:05:51 +0200 you wrote:
> net->ct.labels_used was meant to convey 'number of ip/nftables rules
> that need the label extension allocated'.
> 
> act_ct enables this for each net namespace, which voids all attempts
> to avoid ct->ext allocation when possible.
> 
> Move this increment to the control plane to request label extension
> space allocation only when its needed.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] sched: act_ct: switch to per-action label counting
    https://git.kernel.org/netdev/net-next/c/70f06c115bcc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



