Return-Path: <netdev+bounces-39943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AFA7C4F45
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 11:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2289B28255F
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 09:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6046A1D529;
	Wed, 11 Oct 2023 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cv3/k5EA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40277354FE
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EEF1AC433C9;
	Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697017227;
	bh=EEVqh0ZE/scMal1VISi9CLgOEYyaXTXceYU+wIgHpuo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cv3/k5EACOc8x9sRymmmEcMLGFEDR8IFWtKEt7i96FIbuV+ol/9cRmbIuWT+SlE6m
	 uXdBfto4kAd28DxKuavZaXkPT3S6QgljOhf0We8ZprH0lraTnKvGy4fdkDQ8XcgnDN
	 sBnjKs/tiCS/xVXsfMeVGc4aK6RiGYHCZuMykk/DYAyfovOsMCPc40miNgxfXVyigI
	 C5U4Um4Dlkrzs91Tyn3qAn6IRmUSAOx3j+xJEn/qPTiAlrfoKrV6XRBKmXPeRowp+2
	 dlM9NqBym+ZESxHKJyHzX8mUj1BVvUT5nLpwmU/KLnHuWQtDpeoGZ5oXJEGbAYib1D
	 0AnR3h9TD6txg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D12D1E000BB;
	Wed, 11 Oct 2023 09:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/smc: Fix pos miscalculation in statistics
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169701722685.1947.1054550686820287565.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 09:40:26 +0000
References: <20231009144048.73130-1-wenjia@linux.ibm.com>
In-Reply-To: <20231009144048.73130-1-wenjia@linux.ibm.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 linux-s390@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 hca@linux.ibm.com, jaka@linux.ibm.com, wintera@linux.ibm.com,
 kgraul@linux.ibm.com, raspl@linux.ibm.com, gbayer@linux.ibm.com,
 twinkler@linux.ibm.com, pasic@linux.ibm.com, niho@linux.ibm.com,
 schnelle@linux.ibm.com, tonylu@linux.alibaba.com, guwen@linux.alibaba.com,
 alibuda@linux.alibaba.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  9 Oct 2023 16:40:48 +0200 you wrote:
> From: Nils Hoppmann <niho@linux.ibm.com>
> 
> SMC_STAT_PAYLOAD_SUB(_smc_stats, _tech, key, _len, _rc) will calculate
> wrong bucket positions for payloads of exactly 4096 bytes and
> (1 << (m + 12)) bytes, with m == SMC_BUF_MAX - 1.
> 
> Intended bucket distribution:
> Assume l == size of payload, m == SMC_BUF_MAX - 1.
> 
> [...]

Here is the summary with links:
  - [net] net/smc: Fix pos miscalculation in statistics
    https://git.kernel.org/netdev/net/c/a950a5921db4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



