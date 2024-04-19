Return-Path: <netdev+bounces-89591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B2F8AACDE
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 12:31:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D33271C21043
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19C6D7E564;
	Fri, 19 Apr 2024 10:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BD5XMxqi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E889F2BB06
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 10:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713522628; cv=none; b=o9E7LI5ld2E6RdIe6becaXkbivD/4G8M+MAOgbRQX7SABB/vPBe4tvutNdPoFLXY2/z9ZKBKO8aAEiyPL2qBX9FZ43KRSP1zclbrkOJCWxdGXkU3AdfodUrk7v5sEzS0ZjI3JckaxNlKgUrsNVoZID5tUDR8E/phHgEU37v3AGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713522628; c=relaxed/simple;
	bh=fTzWCRa2IL0gt1/fzHaFtmKUMxl064mbwFGA0o3X+YQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q2KV+3Qa/Ri+CCXfG6r4uJsZxWPb686Dq2CtAWbZQHt9/V2X6jQQpA5TzIyk+xeQ5Ce9MitIDKZ8iYnPLP2Xj9A74S8xigMmiNqKiTVeQg6/zlNGpC+L+E2w4zR7slKQ7JrRLrF5BpTKpvcg623GHEr7Zlwzztt1nRewzRWj8k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BD5XMxqi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CA76AC32782;
	Fri, 19 Apr 2024 10:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713522627;
	bh=fTzWCRa2IL0gt1/fzHaFtmKUMxl064mbwFGA0o3X+YQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BD5XMxqirepXmAaUbRTSVWMhJL1JEiGP+7ay20aiGWFW/Nf71vcGVp+2J1UL9XNfj
	 3qc1CZnk8wCWzQ/5TdRDhJnQRC4eaYmj66nfqWdcif3Z8Wd2QQcRAPwvrU1A1pk0DX
	 kdwJpZmNNM+SN9dgwUW0SnZO3LnMekat8nCLQy38J4FyS9T4GnUIyVwqdxU24buWLr
	 jO0Ein8bHDsETCUHIWXvjfrjK7LR+T2Vn7C7xbixi2ejjJgyUri0JUJ4TL2/k3VoIZ
	 cURc/0EfHepI1sdEoTIY7PnKdiVlmh9KxBxtkbtX1+YQ6Ph5/Jf3HaB7bstptdDqpZ
	 5VUaBbaMvQAVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BE0DAC43616;
	Fri, 19 Apr 2024 10:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: fix alloc msix vectors failed
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171352262777.3691.13832804483742566164.git-patchwork-notify@kernel.org>
Date: Fri, 19 Apr 2024 10:30:27 +0000
References: <20240418021557.5166-1-duanqiangwen@net-swift.com>
In-Reply-To: <20240418021557.5166-1-duanqiangwen@net-swift.com>
To: Duanqiang Wen <duanqiangwen@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 mengyuanlou@net-swift.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linyunsheng@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Apr 2024 10:15:56 +0800 you wrote:
> driver needs queue msix vectors and one misc irq vector,
> but only queue vectors need irq affinity.
> when num_online_cpus is less than chip max msix vectors,
> driver will acquire (num_online_cpus + 1) vecotrs, and
> call pci_alloc_irq_vectors_affinity functions with affinity
> params without setting pre_vectors or post_vectors, it will
> cause return error code -ENOSPC.
> Misc irq vector is vector 0, driver need to set affinity params
> .pre_vectors = 1.
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: fix alloc msix vectors failed
    https://git.kernel.org/netdev/net/c/69197dfc6400

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



