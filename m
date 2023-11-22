Return-Path: <netdev+bounces-50021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7C97F447F
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 12:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA1571C20A25
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39C677468;
	Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8771H0L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFEB5577E
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 11:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E45BCC433C9;
	Wed, 22 Nov 2023 11:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700650823;
	bh=ZlVrbo7UOGX/XECpfOoC/hZSnQldeVUXm8zcILIQOX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P8771H0L+uW8zB2+LqpDnin5KRjLm0a1rixyuC33wmi4WrGlnWUZ7qBf2m/tIchgB
	 kz4EMBkT9bzjOFihUJLl90nLXX4VphtWvzPXFGdL4sDTSrnBZ/5RE1edo3aGo1jlsX
	 br6j3zNPzD9bMzSHuzWciHlyC8px+OpV6EOMhWl9cJlWnfqYMzupDWkA5lKd6K6kNN
	 JdVG4ehv5u3mFVQtx0JvcCZjy3D4bBskyIfsP7rNm4BLjs0CvvPT1qOsEGgj0cqNy1
	 YxMhmOMLXjubGkGUa1KtzFBrRa0u5MPFKEyXdpPoTvmyDQwenMq/57i36/da4j2ByI
	 WBDyqTqLKdgwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CBFA7C3959E;
	Wed, 22 Nov 2023 11:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] nfc: virtual_ncidev: Add variable to check if ndev is
 running
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170065082383.4259.6871325798764809034.git-patchwork-notify@kernel.org>
Date: Wed, 22 Nov 2023 11:00:23 +0000
References: <20231121075357.344-1-phind.uet@gmail.com>
In-Reply-To: <20231121075357.344-1-phind.uet@gmail.com>
To: Nguyen Dinh Phi <phind.uet@gmail.com>
Cc: bongsu.jeon@samsung.com, krzysztof.kozlowski@linaro.org,
 syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 21 Nov 2023 15:53:57 +0800 you wrote:
> syzbot reported an memory leak that happens when an skb is add to
> send_buff after virtual nci closed.
> This patch adds a variable to track if the ndev is running before
> handling new skb in send function.
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> Reported-by: syzbot+6eb09d75211863f15e3e@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/lkml/00000000000075472b06007df4fb@google.com
> 
> [...]

Here is the summary with links:
  - [v2] nfc: virtual_ncidev: Add variable to check if ndev is running
    https://git.kernel.org/netdev/net/c/84d2db91f14a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



