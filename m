Return-Path: <netdev+bounces-122524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE4296193D
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 23:31:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3811C22D12
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 21:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D424B1D45F4;
	Tue, 27 Aug 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F1ZOdqDg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2FD1C942C;
	Tue, 27 Aug 2024 21:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724794238; cv=none; b=faXFlM58uFaW+/SiEGJpV9LMM+oGT3M/ot2KnGAzRVIJwL+EnDibICcFLoSv0hzx82snWayqVXqPdIDbJvNLOk3HEnbSkZ1GY3UJEhTPjxsWn5myyYEFcW0nQmg9wAmdPCgsFzwkkBNNDrgNghM6TG7JGp6rr5XJMqF5uenUSak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724794238; c=relaxed/simple;
	bh=UF5oNncSFvh5U+Vjqi3Hnl24mcbFhjSedPb+WcU/Gm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KIo1VvtWbT0bt3KWnXvxs5/1d8UB31S3nvDja0ogZ39ur0nge3ULbyJsotmmX2rRYMHaBx6yQXTkakicwY2x9G0oX5bfIHjwGH4pm5U3+89bBrTwBEUZtwwUUV2Kx8P+HhpXw4a2X+zwb3E6wi8/ckRh6nunH2wCHbGCtb6omZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F1ZOdqDg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D513C4AF16;
	Tue, 27 Aug 2024 21:30:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724794238;
	bh=UF5oNncSFvh5U+Vjqi3Hnl24mcbFhjSedPb+WcU/Gm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F1ZOdqDgh9eaByDkMTogAgtVkUPaLms3uPDn4TdjdAdZOh9rgT5jsKiOijCAWRQkA
	 Wbz4kCjX4Jql6YYuteW496b9Qk6T3VwJg2GdmeOwKEuN15G/mKVKMcicX/6DphU9ml
	 8pdx/H/pmYSBZ9YyFuorkvtuEMFQy4K0WngwyICuGiN705hepCO5SlRsZkbsXqMhZC
	 Mg9XDg2PB0juHMifWw0u0Sbj4bMc3a52mJWn5BP9NRuAb6paawIYZq3CuYRWjZ9jLl
	 R6Bn+jbdY5EPOeY6FFw9iXFpkqNk+ZabwjRPMAf3Kqtdw4cHtqvOWnpFozZND4BuDt
	 6xMqFxn8PatNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E5E3822D6D;
	Tue, 27 Aug 2024 21:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -next 0/3] net: fix module autoloading
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479423799.767553.16922286999565364785.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 21:30:37 +0000
References: <20240826091858.369910-1-liaochen4@huawei.com>
In-Reply-To: <20240826091858.369910-1-liaochen4@huawei.com>
To: Liao Chen <liaochen4@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 chris.snook@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lorenzo@kernel.org, nbd@nbd.name,
 sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Aug 2024 09:18:55 +0000 you wrote:
> Hi all,
> 
> This patchset aims to enable autoloading of some net modules.
> By registering MDT, the kernel is allowed to automatically bind
> modules to devices that match the specified compatible strings.
> 
> Liao Chen (3):
>   net: dm9051: fix module autoloading
>   net: ag71xx: fix module autoloading
>   net: airoha: fix module autoloading
> 
> [...]

Here is the summary with links:
  - [-next,1/3] net: dm9051: fix module autoloading
    https://git.kernel.org/netdev/net-next/c/2e25147a6560
  - [-next,2/3] net: ag71xx: fix module autoloading
    https://git.kernel.org/netdev/net-next/c/c76afed1bace
  - [-next,3/3] net: airoha: fix module autoloading
    https://git.kernel.org/netdev/net-next/c/7d2bd8ac9d24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



