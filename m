Return-Path: <netdev+bounces-176257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DF3A69860
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 19:50:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2058F189AE20
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 18:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC7207A20;
	Wed, 19 Mar 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPf1Qj1b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E8014AD29;
	Wed, 19 Mar 2025 18:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742410195; cv=none; b=OEYJD+XWo1PmLwyEGZesDCJ8xHSUfErvB1Mg3Gfr+QRdQxop/YlezEfsGxI+GY/X98a6Cw7mxUv1AGcxLDcbmH1VonX5L12PsA9wKlBLMpEGK9RZHUvVHuQEj+SEN+O1wdprsdzJDlHlMm8ydstsrhFoFT6tgzESf2rrUF5liiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742410195; c=relaxed/simple;
	bh=rm4xirwhaDR5TIdx6kvxHxB5k9bRwwf2sUbhGhtC6l0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AxbpL6LyGF0dJy2rg/djHyZPLL1oAeXLCbRfgmn2/+uaNJc/QIoFT+r+ZYpCPfyNpqlMnn6gTsz0D1zzxkk54ngxEH2O/gn9LtmJyubFPW5r2h+jtEifIY4fQcq/LdyJNdHPyNAbOA4f/EWVFQViCm0WHCzwkVwr4wBT+TZ4bcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPf1Qj1b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7C5C4CEEA;
	Wed, 19 Mar 2025 18:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742410195;
	bh=rm4xirwhaDR5TIdx6kvxHxB5k9bRwwf2sUbhGhtC6l0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hPf1Qj1bFyq3/jXZtMYgCV9r6Fv488bi4xU8o2Xu8SYgO55GOzdOJCXZJvXmPZYZp
	 ZA/w06lrkQV9vvap2hBbJWrD8yGkNBGhX7GGTtiYKyuVRuuBqtoCdR9v1o9km/YmqB
	 IsOicz9Wbu6RDfB1rGvjX8rKC+OunuaunjzO+/6v/NT2H+xRQkvFuAoH7AYQzqGlwD
	 g+RyASNOUr1kJj/gj2jkSDbFNNgFg9efMCJ1BzkvZxIz9s2loJCZozyEZ7Sz2OQ/gn
	 H873Jq+RFYHL0X8qfn1vzqMyHNYNNho5LotL2Ju6OEGRZSvXrR5h4fAYd3SEj6YIlz
	 hB1n8BYJq1/ow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EA2380CFFE;
	Wed, 19 Mar 2025 18:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth 2025-03-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174241023127.1152495.8410585054247771618.git-patchwork-notify@kernel.org>
Date: Wed, 19 Mar 2025 18:50:31 +0000
References: <20250314163847.110069-1-luiz.dentz@gmail.com>
In-Reply-To: <20250314163847.110069-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 12:38:47 -0400 you wrote:
> The following changes since commit 2409fa66e29a2c09f26ad320735fbdfbb74420da:
> 
>   Merge tag 'nf-25-03-13' of git://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf (2025-03-13 15:07:39 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2025-03-14
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth 2025-03-14
    https://git.kernel.org/netdev/net/c/a0aff75e1553

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



