Return-Path: <netdev+bounces-117687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1D294ED07
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 14:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35A21B220D4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C2617A5B5;
	Mon, 12 Aug 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d7cX6JuR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED3316F0E6;
	Mon, 12 Aug 2024 12:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723465832; cv=none; b=lydT/zvXnudIPNRaGRdg4FXtq3Q6IQ2xTqvDpgzzW8VNWfVettNHQV9YQBgR8zng36gKzkQkvByWADRLPDputZU18YPo4MTZtfp/gH6eV9NplhonRMqraxliFe9v6RfzUuib51ycHAFKgJuz5ZSur1Vg9M3w6jNF81h/EMeNgeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723465832; c=relaxed/simple;
	bh=Y3M6jSyN7jY0NZrGwpas6C3aQWF8o8iyoC0CN+T2EU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=j+vgBewmHi8GZJdbkV3BPwz5/g7tBiSYT4YNFRM32QwNNHZdPsVpiVa4293bGmJW6CJrJDpCA9eN/ohRBn4SA9ExLXranFJaaAW2NmlcNMGLIsLX2RR2f8ZUzOlhR5k6xXRnbJ2zt65rLrSacU7iekZtu3pVeTrgVfSr6t/zjVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d7cX6JuR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF1DC32782;
	Mon, 12 Aug 2024 12:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723465831;
	bh=Y3M6jSyN7jY0NZrGwpas6C3aQWF8o8iyoC0CN+T2EU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=d7cX6JuRQfNRZqt1FZHIzt8fkC/4D0M00J9T6d0pNkCE0OtKowx1PwN58Q0nMs77u
	 fMK9hkaVUU0bDH3TRk4swbCYn2uNoYQ53QT8os2v2V157MQ1d1giYkoxAa5e99oa5N
	 poxZRk+eKl59V6xvARLieXPxxsaV7h6d3Su0gsRLARG/xwv+MTeAhn24qkuXgTXWzW
	 WXoAG0tpAK8x7YKtfuHZowpQ9+a9TnNMC7/2GOLchD0Kfv7rappzsJiTK02bqp4jAt
	 2o5GvLGE39fWGUM64MKUwqVSRAHzeLIkLAUdKE8m5B0Cd0/inZSVgUEkrPOBrR4Wzm
	 lVPy+vKShPTnA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B73382332D;
	Mon, 12 Aug 2024 12:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2 net-next] net: sunvnet: use ethtool_sprintf/puts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172346582974.1009420.9342776686210373540.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 12:30:29 +0000
References: <20240809205525.155903-1-rosenp@gmail.com>
In-Reply-To: <20240809205525.155903-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nabijaczleweli@nabijaczleweli.xyz,
 akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
 justinstitt@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  9 Aug 2024 13:55:18 -0700 you wrote:
> Simpler and allows avoiding manual pointer addition.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/sun/sunvnet.c | 34 +++++++++---------------------
>  1 file changed, 10 insertions(+), 24 deletions(-)

Here is the summary with links:
  - [PATCHv2,net-next] net: sunvnet: use ethtool_sprintf/puts
    https://git.kernel.org/netdev/net-next/c/f547e956dd84

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



