Return-Path: <netdev+bounces-198865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE6AEADE0F0
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0D05189B31F
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 02:01:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D96D71A23AC;
	Wed, 18 Jun 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ly14iN7J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B415019DFAB
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212048; cv=none; b=a9wDGWar8n+SVtqhxp4/EDdaPF8NXJDrnUuJ1Dycd6abrcZrixQuwBCURq2h2klIrMIA119eGPRvjFMpt/DkEEuxBFH0xLO/zZtR7tiQdMlJHnH+fy7XVuEC6fZNgfEaUwBlwTOeoyKczF397VpMg4fXnQRPlsytJnequ9BfnZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212048; c=relaxed/simple;
	bh=KIHLX4JYEr49LFeTFGFg2fDH5y0vS0MHp4CMJmWm6nE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a52r4f4DsfEmSzixBuzKrao1b0lcRhfVCFrj2aWfMXykUD06KbQIaJXXjPWANeYEYJ5SeYvQNn1xQhxldqeOsJkrSZ03vu8o0GpADOHJYY4x3fJWX9J2bHF43HzLEqrm/yRqIwlSrasq1IwGAJukA3wIbU61TBIBglEpI2N4XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ly14iN7J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 420B7C4CEF0;
	Wed, 18 Jun 2025 02:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750212048;
	bh=KIHLX4JYEr49LFeTFGFg2fDH5y0vS0MHp4CMJmWm6nE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ly14iN7JZdhj7aEgh7sapQkLOuUZMyo45G+K6+qwvREOWw7eJvDYCrtdICjUZAdcD
	 ll38O1aM9FoZg82l4tKREZVSRD3GHNCkRlW3UtexmSkpbUlY/leZFPE/jt2UcjY6lf
	 7SjaZLbImJxmnpNzZ+GajKctFUFf12DtLtHML0c1YzuFyKNbKk4SxVYmcLv9JWXEoc
	 PZED4KyNxxluz+OQ9AT3K0i2F1U3024s/JDWJc1BA6kB9yRXLhAu7lyVcqIFyWok0z
	 ZzwccqTSLQZPu75Fy4EkxBANToKSAxdHB0lSAQC+EYnPSWfylbwdQ3/JSyWW1jDn1M
	 KCTscF+VbNEoA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E64D738111DD;
	Wed, 18 Jun 2025 02:01:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] dpll: remove documentation of rclk_dev_name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021207649.3767386.12042674533025587787.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 02:01:16 +0000
References: <20250616-dpll-member-v1-1-8c9e6b8e1fd4@kernel.org>
In-Reply-To: <20250616-dpll-member-v1-1-8c9e6b8e1fd4@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 13:58:35 +0100 you wrote:
> Remove documentation of rclk_dev_name member of dpll_device which
> doesn't exist.
> 
> Flagged by ./scripts/kernel-doc -none
> 
> Introduced by commit 9431063ad323 ("dpll: core: Add DPLL framework base
> functions")
> 
> [...]

Here is the summary with links:
  - [net-next] dpll: remove documentation of rclk_dev_name
    https://git.kernel.org/netdev/net-next/c/ec315832f6f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



