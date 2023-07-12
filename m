Return-Path: <netdev+bounces-17316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 600827512C1
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A9E2281A0A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F38FCF9C1;
	Wed, 12 Jul 2023 21:50:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104BDF56
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39024C43395;
	Wed, 12 Jul 2023 21:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689198624;
	bh=A3T2+vy9r48wQvEh+j2m/KnXHi7WH4v0eHVFt3agVjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AcNh3RndA/Kzm8pooIqJnY4+0KnjgHT4x5nJhoPwF9sS3/Oyv2BvyWh5tXsq3U+BS
	 VeIGoGP42duDpXoi+BsGpZ+xE4nAPbzrSj4v9jKPk5R+0DGK24auVN/UKlHkEar3RU
	 5dlc/vl0wfYtNvBZF7+hoNp8OtUxDAqOJkWQ44V2jwRLNnjKwgthXQ+iljfU6Ltq2J
	 7JhPWXM+A/yE3VF6qooiprGrIPhSD7m83VSZI8jyux6qEgJOdlwHtGto6huW8QHWJi
	 KHN4UaRbpyBPixPEqJ/jSoxnJeWSDs8JCYeadoeu+Bd/plJIdvvnP6EErArQsPgXEQ
	 6Ya+gUibClMGQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1F471E4D010;
	Wed, 12 Jul 2023 21:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: add a scheduling point in
 established_get_first()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168919862412.303.10025202981219260414.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 21:50:24 +0000
References: <20230711032405.3253025-1-wenjian1@xiaomi.com>
In-Reply-To: <20230711032405.3253025-1-wenjian1@xiaomi.com>
To: Jian Wen <wenjianhn@gmail.com>
Cc: edumazet@google.com, davem@davemloft.net, wenjian1@xiaomi.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jul 2023 11:24:05 +0800 you wrote:
> Kubernetes[1] is going to stick with /proc/net/tcp for a while.
> 
> This commit reduces the scheduling latency introduced by
> established_get_first(), similar to commit acffb584cda7 ("net: diag:
> add a scheduling point in inet_diag_dump_icsk()").
> 
> In our environment, the scheduling latency affects the performance of
> latency-sensitive services like Redis.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: add a scheduling point in established_get_first()
    https://git.kernel.org/netdev/net-next/c/9f4a7c930284

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



