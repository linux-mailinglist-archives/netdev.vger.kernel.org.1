Return-Path: <netdev+bounces-34349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBF07A35CE
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 16:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9621C20866
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 14:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966FE4A32;
	Sun, 17 Sep 2023 14:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD384A2D
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 14:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E447CC433C9;
	Sun, 17 Sep 2023 14:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694960422;
	bh=zUtWz9g4B9LburLkv1hDAggJaJDo0JAQNWqmKa50EFc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lwERfuq/k1g8IxrnQYO9GZ/576k5TSVqzcyZ/8u6MKz/jqWBxgM4Bh82jM/iKcnGT
	 z/vJL6ImLZjQ8JyfowBHg3E1OEkk7hNnlq2nmJ/sH2PxW9MSNhgIElsfQ/TyeRlzg6
	 OnKlF2sgKG4WvbZLFHuEuHlT8ga7XJAAL5viEv2t9RZlC/hQYKDACabcYWQMIsU3Bi
	 S2clUhStEGkGq+tRQlnrImBCXdkT/zaImE6kZDtCFic6aUop11gUX08CJ146h6iee/
	 ogPjvDKRA0n3lDQErpAAnJmpN01AISACQ0RLbNb7jBRE+P7TOPjpj4lr3jZQNhKFXn
	 uVKsvWNY+SUcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA3FAE26885;
	Sun, 17 Sep 2023 14:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 net] ipv4: fix null-deref in ipv4_link_failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169496042282.14652.10041213543711903914.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 14:20:22 +0000
References: <ZQPn2cF3aX/523eC@westworld>
In-Reply-To: <ZQPn2cF3aX/523eC@westworld>
To: Kyle Zeng <zengyhkyle@gmail.com>
Cc: pabeni@redhat.com, dsahern@kernel.org, vfedorenko@novek.ru,
 davem@davemloft.net, netdev@vger.kernel.org, ssuryaextr@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 14 Sep 2023 22:12:57 -0700 you wrote:
> Currently, we assume the skb is associated with a device before calling
> __ip_options_compile, which is not always the case if it is re-routed by
> ipvs.
> When skb->dev is NULL, dev_net(skb->dev) will become null-dereference.
> This patch adds a check for the edge case and switch to use the net_device
> from the rtable when skb->dev is NULL.
> 
> [...]

Here is the summary with links:
  - [v3,net] ipv4: fix null-deref in ipv4_link_failure
    https://git.kernel.org/netdev/net/c/0113d9c9d1cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



