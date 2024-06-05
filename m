Return-Path: <netdev+bounces-101174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008C38FDA1E
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 01:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 881DA28380F
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 23:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1B5D153565;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DTWH6rwd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8998DC15D;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717628434; cv=none; b=rYTyt/wrfrsRPTw69k2iKQxz9LbZwd1W2qslV8dfhXIjyQE4LSnrtLXdc+sC1SveCuIAdSNyvWCINN7/i3fEs4ufTrSaF//xGEkh/E7m1+Sk+Zv8t+Lg70jnKSkZ4RVWlyawwrVaSN6Zkk9mFv8NWP6ROZn508MuOpd9vbKjwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717628434; c=relaxed/simple;
	bh=874CuEqBDhO5LkPFXKPIAmkGHDYIphCHms3xFeGLJYY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iYShBSAoR28HtRBMl3LE5ccxW/o+eteSOUflDjA/8pC/xfDoIyQf+wOxvelXCs09l8YtBXRF+qBW8vf0UKQQydwIrwUwuKzMIW51jTGbwPo6WAo+DoxSdbiOBbUWbhHCWhT4JU0aMZnYwx5r6eFuM4mhsmt62MyQkR95LSVMrr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DTWH6rwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C59AC32782;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717628434;
	bh=874CuEqBDhO5LkPFXKPIAmkGHDYIphCHms3xFeGLJYY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DTWH6rwdXkRAXB9JC988OG4WrMd3goFGOn5FBHYM1f+1nxk3fc63qovWOnYHqwaPn
	 1g/YRt9OTnwg7YPrmISqNgXMVfMp39Fbu9uNOq3lzleFogG5OoJFKRiiS1Y6pQbonV
	 J2qqTutrkTwpReqRMh53eFDkoBgMQiXNfc29gZQd6f/lzrvLgjPKWy4Y/b1rPJO9ns
	 HRofJkwfG7C62obeZnrCG7r607Je1RXgp/nYHVsPTm/eLryeF0Vm1N6f6gmElHRBHr
	 q3bPI0wlwL4jRyJftEVKag3qpdH9KzFP81x0BkZedYNWATbPk/S/2vI9+zqxQx2zJj
	 5ZipREDw7g57Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BC6AC4332C;
	Wed,  5 Jun 2024 23:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ionic: advertise 52-bit addressing limitation for
 MSI-X
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171762843403.9199.12097128294110866724.git-patchwork-notify@kernel.org>
Date: Wed, 05 Jun 2024 23:00:34 +0000
References: <20240603212747.1079134-1-drc@linux.ibm.com>
In-Reply-To: <20240603212747.1079134-1-drc@linux.ibm.com>
To: David Christensen <drc@linux.ibm.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Jun 2024 17:27:41 -0400 you wrote:
> Current ionic devices only support 52 internal physical address
> lines. This is sufficient for x86_64 systems which have similar
> limitations but does not apply to all other architectures,
> notably IBM POWER (ppc64). To ensure that MSI/MSI-X vectors are
> not set outside the physical address limits of the NIC, set the
> no_64bit_msi value of the pci_dev structure during device probe.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ionic: advertise 52-bit addressing limitation for MSI-X
    https://git.kernel.org/netdev/net-next/c/1467713eb224

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



