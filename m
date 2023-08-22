Return-Path: <netdev+bounces-29632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90DE8784214
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:30:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 255FE280F9F
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 13:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03E51C9FA;
	Tue, 22 Aug 2023 13:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39FB7F
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 13:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5677DC433CA;
	Tue, 22 Aug 2023 13:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692711021;
	bh=LNGUoL1KG18y9unWKDzAxPS4XdVps2A+wAR839EAHmk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JMRPDiIdV4oXN3F9BFmOIkjCrg0umN9NXumdv5ezXwNGX8xWKc2lhWz6Qbe3qeZw0
	 P2iR1+J0WfXsPc9WkZPjY6af7bGuaAxuvFHA8SstBxuAQuzIFUxM1IRcdqSGmHZ3th
	 tw6HLdUfc67g1G/gMvjcR0G5gky56gmqNj1sU3FFAxElTPlXvNVGnVerXXXfItJ0IR
	 mUGxOAcOkaI2RS3Z1i5HIWxweJQ0oZoxMbUVORgH46ExIgjvOqEOVbGjSjSJDwDjBV
	 zBNoBAC9M3/Y6MB77rwm652lHb7DpZMupS0BlVxUM6GX4J//2wHHs5/bRUWkIogaGh
	 hNNXJh6GZlLfw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B2A6C595CE;
	Tue, 22 Aug 2023 13:30:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] bonding: update port speed when getting bond speed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169271102123.2732.11112110631297941921.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 13:30:21 +0000
References: <20230821101008.797482-1-liuhangbin@gmail.com>
In-Reply-To: <20230821101008.797482-1-liuhangbin@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, j.vosburgh@gmail.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, edumazet@google.com, liali@redhat.com,
 jiri@nvidia.com, razor@blackwall.org, ajschorr@alumni.princeton.edu

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Aug 2023 18:10:08 +0800 you wrote:
> Andrew reported a bonding issue that if we put an active-back bond on top
> of a 802.3ad bond interface. When the 802.3ad bond's speed/duplex changed
> dynamically. The upper bonding interface's speed/duplex can't be changed at
> the same time, which will show incorrect speed.
> 
> Fix it by updating the port speed when calling ethtool.
> 
> [...]

Here is the summary with links:
  - [net-next] bonding: update port speed when getting bond speed
    https://git.kernel.org/netdev/net-next/c/691b2bf14946

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



