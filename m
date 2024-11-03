Return-Path: <netdev+bounces-141306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F8B9BA6B6
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 17:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 491351C20E8D
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2796187872;
	Sun,  3 Nov 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HBZrq32M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD217DE15
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 16:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730652620; cv=none; b=uAiLDOvKfSeNAdD4dpCXwIFxDfyZU0qB1bf1/xTWsrlXRr+Lk6OLZ+CKQGz3OASuRpVuhbJUkIo5yuK7UAmrPxqRZkIKA4UfIN/iA8PXpRT+se6cbr5xbUfxT3QKOE0brpaJ5idwHlqG2lFrBQPaVXxdsCcWjsSTt1EtxDrV0xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730652620; c=relaxed/simple;
	bh=fAH43iaR3xSBXLb+ghTUXG3rTHWqfd0Bd8qXJOIuCWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EnsTPvpdkXNkjNp0o9QTDgeq+csbqth0BuUB0vKQOyo+DK6sptrRJqdKn21tOxpd4Ep0gqxZ1q6Jwyt77uIUIu+VohyeDHEnDJweDPKzrRwXdtatCUwy6DyvVw/RB0rRiEh3IRB675iCuulD0eYAebjEpNFR95WY08ciqOkeEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HBZrq32M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51C2AC4CECD;
	Sun,  3 Nov 2024 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730652620;
	bh=fAH43iaR3xSBXLb+ghTUXG3rTHWqfd0Bd8qXJOIuCWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HBZrq32MTCg14CczsUl6oXFRRZkdljWa0GuR+u3nx1B+v96HrjjWkfacsE4LGOcsy
	 0+ipVNi7P2NIqEvxaEE94keKkRibKNEwXPRx5/tZ2J+L41g25RhbMVJCKKgEGWCtS6
	 oQA2unpN5UQ5uG2TZl+sI9TLzi5a/RJHSkWqxbWVz9uiTg+gnriYCR75iNDWfQO1k8
	 glOhR6gBGn/VXxgdLvk8bUD3V4iUHAcsy39MGAMzX2asUXwU/b3opYc4H7FUL7iTaC
	 SqPkoL/uhdLUD0SVvC68BR21uIR+HHI9vYAvqsQT5+KsW9+/WKEhBZADBZJkHHfmM5
	 Gys16Pk/6/4TQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ECC0238363C3;
	Sun,  3 Nov 2024 16:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] dpll: expose clock quality level
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173065262875.3211787.8836462758014664413.git-patchwork-notify@kernel.org>
Date: Sun, 03 Nov 2024 16:50:28 +0000
References: <20241030081157.966604-1-jiri@resnulli.us>
In-Reply-To: <20241030081157.966604-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, donald.hunter@gmail.com,
 vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com, saeedm@nvidia.com,
 leon@kernel.org, tariqt@nvidia.com, maciejm@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Oct 2024 09:11:55 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Some device driver might know the quality of the clock it is running.
> In order to expose the information to the user, introduce new netlink
> attribute and dpll device op. Implement the op in mlx5 driver.
> 
> Example:
> $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/dpll.yaml --dump device-get
> [{'clock-id': 13316852727532664826,
>   'clock-quality-level': ['itu-opt1-eeec'],    <<<<<<<<<<<<<<<<<
>   'id': 0,
>   'lock-status': 'unlocked',
>   'lock-status-error': 'none',
>   'mode': 'manual',
>   'mode-supported': ['manual'],
>   'module-name': 'mlx5_dpll',
>   'type': 'eec'}]
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] dpll: add clock quality level attribute and op
    https://git.kernel.org/netdev/net-next/c/a1afb959add1
  - [net-next,v4,2/2] net/mlx5: DPLL, Add clock quality level op implementation
    https://git.kernel.org/netdev/net-next/c/e2017f27b6f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



