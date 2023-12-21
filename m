Return-Path: <netdev+bounces-59559-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF4C081B490
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C3CD286032
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46E0C6A34B;
	Thu, 21 Dec 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S00hdi7L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8F46A33D
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 11:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9AC9BC433C9;
	Thu, 21 Dec 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703156423;
	bh=POJ7wrVjvf+Xj55YdAJtuUoveALv2FTC19aMhFyrx6U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=S00hdi7L7Vmg1Mpw0olBmR5ipEnI7MfTMfRDcB2sMrXmiwn3puHkHKdXxPJovUflz
	 M/pIT6QaAgCbEUMm7xojEXNv7zKjWhQOivQzX7iTPFWmYh4XsicgVk/CLAB6Pr66Vg
	 uZ5aMQZiHeD2+rqMLdkMwHLzCaZLyq2wSQjy312X1ubEjFsLYwqPKjIh1Ntz+XoE2Q
	 hEM8+z5CR31484lsKUuSGWDaDT7MUFDD0AStoax9I7T9gYPCiA0lCVe6Qv8fWkiEYb
	 v/UIakxSRHNf4lMXznljWC0udGIfXDNjftNHP/h9L18v0sJHbKgsQtWQrtqv2L4Gvj
	 Z0C01+/mntFHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7DB8CD8C985;
	Thu, 21 Dec 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: check dev->gso_max_size in gso_features_check()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170315642351.11742.14004973251222851877.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 11:00:23 +0000
References: <20231219125331.4127498-1-edumazet@google.com>
In-Reply-To: <20231219125331.4127498-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 19 Dec 2023 12:53:31 +0000 you wrote:
> Some drivers might misbehave if TSO packets get too big.
> 
> GVE for instance uses a 16bit field in its TX descriptor,
> and will do bad things if a packet is bigger than 2^16 bytes.
> 
> Linux TCP stack honors dev->gso_max_size, but there are
> other ways for too big packets to reach an ndo_start_xmit()
> handler : virtio_net, af_packet, GRO...
> 
> [...]

Here is the summary with links:
  - [net] net: check dev->gso_max_size in gso_features_check()
    https://git.kernel.org/netdev/net/c/24ab059d2ebd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



