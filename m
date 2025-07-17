Return-Path: <netdev+bounces-207916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1282B09010
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 17:01:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8002189C96C
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 15:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A827C2F94A9;
	Thu, 17 Jul 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnQ6tS7p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820182F94A5;
	Thu, 17 Jul 2025 15:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752764407; cv=none; b=mxi7+Og2ysc2s9BlWhlaTyYJ4EehQ06UERr2RqRl6Cjx+ztk6vqLFdp2kSz5JkyBxf7Yuq+DlHZcQlhc7s3FPXqxC883VxsoHa5eu1dBH8Cxj7Khqae3t0RnqE/kOKsXFug6PFjgI2SAfi+W7oS+X4bNy3bV0MO06gMCi7cA1rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752764407; c=relaxed/simple;
	bh=HnHmL/G0PzooFwurbzM2LDdza5KTG9j1066D6fe1aAc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IrAwLRhyb3wrLr0xy043+8G9xuGlPApUfAN5HueXfU+nsF6fvAlqMrm3IbDSRu/ppH95UacBVJvJvczVv024o17psgjexZa7cGUNHeDT+d/ZB+jvqlK9GLSB2ihfXVGlOc9tE/9O1OuTa83Elh74UtPMhM+sR0xyfVdLau4YJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnQ6tS7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBDAC4CEE3;
	Thu, 17 Jul 2025 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752764407;
	bh=HnHmL/G0PzooFwurbzM2LDdza5KTG9j1066D6fe1aAc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lnQ6tS7pZMc1l8xjuOcoQ+EOsuvX8ZyzqHaNIGuZRFbEfRpaTUtwFfT1z6ZdvImtB
	 GZTVe6olIzg5GAj8lCI6RFm8PtY1IbgLLd/a2B4WoOQDjpo87oEjB3Xq9oAhPGq95Q
	 3KRmwPBpcKpYYq40l0vl7i49diWSa0eRaBhpHZ/mFlBnEjjR61Ojm+f4d1/avrn+bi
	 MQipMZjUFmJ74GDqGGq9SGD3kdlr+neqhDg2OpEHkoZ0dLUgbgs5YyVzYFBlnB7tNs
	 ONUXIPURp0Q6Idv+cukKxu3TbFFr8J14SyFHJOVkCIf+JzRzlHwDiLde1iL522TqAE
	 C4cVvotrDOh+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C87383BF47;
	Thu, 17 Jul 2025 15:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-07-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276442700.1962379.205576720847311067.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 15:00:27 +0000
References: <20250717142849.537425-1-luiz.dentz@gmail.com>
In-Reply-To: <20250717142849.537425-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 10:28:49 -0400 you wrote:
> The following changes since commit dae7f9cbd1909de2b0bccc30afef95c23f93e477:
> 
>   Merge branch 'mptcp-fix-fallback-related-races' (2025-07-15 17:31:30 -0700)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-07-17
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-07-17
    https://git.kernel.org/netdev/net/c/a2bbaff6816a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



