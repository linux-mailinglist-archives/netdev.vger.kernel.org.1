Return-Path: <netdev+bounces-89801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C59348AB948
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 05:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C90A1F2139E
	for <lists+netdev@lfdr.de>; Sat, 20 Apr 2024 03:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31CBC13B;
	Sat, 20 Apr 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dNLjzMOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758E08472
	for <netdev@vger.kernel.org>; Sat, 20 Apr 2024 03:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713585033; cv=none; b=Q0pwMI2NKLuHjB9TrA4EAT7NxPxqCeEd0kDgGIEBoyGI1zp4zyhfBhytYm0h3iE/rIPZChwN0j0vE/c4Kzmxdo0vjldcmQCtMqLnZkcrqIX48sUljQvGrs3OBP5xb383D/UjlVgR54s769reO6Z8am0WHGH6L0n0VGUgFyfSFms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713585033; c=relaxed/simple;
	bh=pVjQGefeewHQhoznVJmoWioiA1YXtVcNM6Q3BKO0bAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PCisQ1JXrguVzbC24Z6gJhmvY4JetnD837QC+INOHnrvD2+Q8F3LorJY+jQsKO7QsG0pzLxSpssLrQjZEhW3ue413LCUyxKYv8FfymfWzjOWM4T/mLxSu6hEvBR0gWbHZI6yG5SRC8k3VRjqLsQh6K/kZVLGjzyolCcjv0lRvB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dNLjzMOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CB91EC113CE;
	Sat, 20 Apr 2024 03:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713585032;
	bh=pVjQGefeewHQhoznVJmoWioiA1YXtVcNM6Q3BKO0bAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dNLjzMOTiw5gAbzeckR4N46XUMekpiMddlx/Bylx72RpRBuXP1gomPNTwPbb2h+H8
	 kWSPj8MuSo1ZUv/82OD6YaWsvNu3oeaPveADmsEu4rMPpsRbSaO7l+ALw+muMj9a0t
	 Soa7VZCm4qFSlcKIoiyyDYxavxmBbrrLPvCOYpoqbpEHS8zkW8GPd28mIjKKo2MsKp
	 8R/8xJXiCY3asLqKFRj4aTWSLD12Igy4XDTiC/pOmw3BHRE3zK9fg2jxAvHO44Gtli
	 2BCatdgQNSo3QXTILCDMlwrhs7/S+n82i3K1jiTMMEs8gw3DNppSSvlhm+KHc0/Sgl
	 1Qy/7WumqBHlw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B7A11C43618;
	Sat, 20 Apr 2024 03:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] mlxsw: Fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171358503274.31195.14039830410285866432.git-patchwork-notify@kernel.org>
Date: Sat, 20 Apr 2024 03:50:32 +0000
References: <cover.1713446092.git.petrm@nvidia.com>
In-Reply-To: <cover.1713446092.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 mlxsw@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Apr 2024 15:46:05 +0200 you wrote:
> This patchset fixes the following issues:
> 
> - During driver de-initialization the driver unregisters the EMAD
>   response trap by setting its action to DISCARD. However the manual
>   only permits TRAP and FORWARD, and future firmware versions will
>   enforce this.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] mlxsw: core: Unregister EMAD trap using FORWARD action
    https://git.kernel.org/netdev/net/c/976c44af4814
  - [net,v2,2/3] mlxsw: core_env: Fix driver initialization with old firmware
    https://git.kernel.org/netdev/net/c/7e2050a83663
  - [net,v2,3/3] mlxsw: pci: Fix driver initialization with old firmware
    https://git.kernel.org/netdev/net/c/773501d01e6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



