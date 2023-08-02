Return-Path: <netdev+bounces-23775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BBF776D7A0
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 21:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC1711C20CBC
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 19:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB36011197;
	Wed,  2 Aug 2023 19:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E91078C
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4AF59C43395;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691004023;
	bh=Butcr5heUBdkbqvWKjDWioNMbfo2PMIes5Z1+It9MF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MzrtDEKL9JV0nMKLP91uHuf/X9/arADLWwvejIX6DS5PJEk1pKWmGRffXhaCkyMo+
	 fo8xIrgglN9x8mylYMe4FBBnjxsMv9KLNtKIXQlbaV4zxq/wHVenhRtWV+HGT5V7Fy
	 HMo4qGo/CijkNUtp/21QzrJzNWcdWERfmDpRHA1tUFHKFmOVRw4WN/mfPUf85rtcfr
	 iVyoeh3dQFxoaHVaN3W4vgqMQAAOCiFE8ion1lxHu4D9VE2B+73VsN/s2ndELxabUD
	 tB5+iY1aiaxu+y/olYqL1wiAbf8eL87m5SAMztY0ceQpcrMoiqzUEHg4bg/UAQ6zOV
	 hlQVjToHwd/cA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E9F2E270DA;
	Wed,  2 Aug 2023 19:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dsa: hellcreek: Replace bogus comment
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169100402318.28133.17712919158940124809.git-patchwork-notify@kernel.org>
Date: Wed, 02 Aug 2023 19:20:23 +0000
References: <20230801131647.84697-1-kurt@linutronix.de>
In-Reply-To: <20230801131647.84697-1-kurt@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Aug 2023 15:16:47 +0200 you wrote:
> Replace bogus comment about matching the latched timestamp to one of the
> received frames. That comment is probably copied from mv88e6xxx and true for
> these switches. However, the hellcreek switch is configured to insert the
> timestamp directly into the PTP packets.
> 
> While here, remove the other comments regarding the list splicing and locking as
> well, because it doesn't add any value.
> 
> [...]

Here is the summary with links:
  - [net-next] net: dsa: hellcreek: Replace bogus comment
    https://git.kernel.org/netdev/net-next/c/ae3683a34265

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



