Return-Path: <netdev+bounces-150951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C49EC277
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 03:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B38D9188A8CF
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 748ED1FCFD2;
	Wed, 11 Dec 2024 02:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtzPu5uW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD321FCF7C;
	Wed, 11 Dec 2024 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885422; cv=none; b=HKdNqYVWcvsx2tbTnW3xMUMRa+ms0HXkFz4iFUwVQ/t8QGcTD0yDv9vYBZS1c8wvbkov0vDxgaNTAwtA5VJSq7+HSPzPQkTmzjKFOTPob1AagWqrao3wXSHVxFkMIPVpratCIKLe//h+ZE6VQGqcpbrKcsEEJOgdWYBlafTVrdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885422; c=relaxed/simple;
	bh=YRgcNzsaBd1SrRU3chvIKHWbYMTPPsSrn1/6DIre7kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B13yIF64h2wWGSS8yJIMIEktXzZ6DVpAGrintJAORPua5Rpivz+ODoZ1Gm/j+mB/g20LkfrEsc5jU4l5Xd0jWE3RnUSiuXqevl/Km+DfQ1E+UUV7obO3BGclOfaJV3xD69fNrMUZr5orv5XpPI9S5k0j6czSZSPPmSW3SNMTNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtzPu5uW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D46D4C4CEDD;
	Wed, 11 Dec 2024 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885421;
	bh=YRgcNzsaBd1SrRU3chvIKHWbYMTPPsSrn1/6DIre7kA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PtzPu5uWjGmhVC+Xc8WNbSNpL+thYVLWcTRqUPlZrNOi4cNs33AtdTIWwlMODY9rz
	 a2WRT/tvcqnQkWKvsKVigpjVE3cW5hxFccooLAUwNBLMVlVuvuZvGAElmoG4X2ugKo
	 GSymWchGSFM54k+XqW6dqUnP9paDT5EIrT8+x3J1xgaxo/B6KH1MdeVMkmTOhqo7Rh
	 bUjcbkcmh6Z+s6I9h6YNbkKdYsYpTqnjRrBqtCiLbKFrV0JrcKvdsQLKGCtYU0M55S
	 GD2v2n6kvElkKtU3rB2B/5zwz7YvG5Jyg2i3Lc7wuvY+jPMX4DxkRnQ9kNlkPMh2/m
	 C271n15Eqm1LQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB409380A954;
	Wed, 11 Dec 2024 02:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: Replace deprecated PCI functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388543774.1096205.840423563430703446.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:50:37 +0000
References: <20241206195712.182282-2-pstanner@redhat.com>
In-Reply-To: <20241206195712.182282-2-pstanner@redhat.com>
To: Philipp Stanner <pstanner@redhat.com>
Cc: chandrashekar.devegowda@intel.com, chiranjeevi.rapolu@linux.intel.com,
 haijun.liu@mediatek.com, m.chetan.kumar@linux.intel.com,
 ricardo.martinez@linux.intel.com, loic.poulain@linaro.org,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  6 Dec 2024 20:57:13 +0100 you wrote:
> pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
> PCI subsystem.
> 
> Replace them with pcim_iomap_region().
> 
> Additionally, pass the actual driver name to that function to improve
> debug output.
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: Replace deprecated PCI functions
    https://git.kernel.org/netdev/net-next/c/ce864c76ccd6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



