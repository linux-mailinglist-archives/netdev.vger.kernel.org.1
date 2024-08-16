Return-Path: <netdev+bounces-119282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED0E9550DC
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 20:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A992856B7
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 18:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96C571BE23E;
	Fri, 16 Aug 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rrzrWI+w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1D41BD51F;
	Fri, 16 Aug 2024 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723833031; cv=none; b=RX6zx431CipZrifmYfLXMo6CpvpvGOq3LZa0o3kxVMyCLGElBKhJJfzW0DafJsNlK6KlK/+/V8M1uUDDv157xb9bxHMEhYkPRbvy1Y7ZE0/DgKcam7H19H6CHPzLPoeA9GXQUMyqhuZ1/negJZLO6Tr1MpCDKgxnyKyqLRoACUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723833031; c=relaxed/simple;
	bh=UxDpM3SHEArLzOCozwwNyeM8qDoerGueObJ3gi67Fzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nu8AXWELi2NoT/qjkZLfITOt51yEfbR5Y1Q4PCMGXhe/wnAXXwz8JwaEyKyQilDJ/8yHelMjkl0wW7vXBG+FaUz0OC9regJzDF6g8AxhB9XKedS99Y2DAWgOHJ/vQBXeo0xVqbjI2kXplJVYual/FfBxcmtGaY0bjfMOoopxDc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rrzrWI+w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6556C4AF0F;
	Fri, 16 Aug 2024 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723833031;
	bh=UxDpM3SHEArLzOCozwwNyeM8qDoerGueObJ3gi67Fzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rrzrWI+wrDimo6Vlic0ruw6aYYO/scKHPCQrOadZZniQKfoELAcmVQsgp4Iq3JMLB
	 TeAJliYtE3DxqH1F82uDVGrTlfMVjBpEDZTq7Ev713O+gL8WMBGvWPoJpiVPiPz3A5
	 vQblMvsb2G3ULDr2cgazBnf2D5jSTxedcTnRky51RjkixG6Jrgdqdb4aHO8TDxEkrM
	 mmVcNvMPArUrzyk4fdbBlPIxd4dq7PI4ZcJzKc2up5pO/YTASeEmQ0QWPFoY0gwLt4
	 24v7TQhiTNGuN8yTmhDNDB/1Hu4rEyTPj5ZqNhhl6lP1A8WCHauIAshZ9xdbJEfEyI
	 AyDpNo60x0zng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DD638232A9;
	Fri, 16 Aug 2024 18:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] use more devm for ag71xx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172383303025.3598282.2567158642009588521.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 18:30:30 +0000
References: <20240813170516.7301-1-rosenp@gmail.com>
In-Reply-To: <20240813170516.7301-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
 linux-kernel@vger.kernel.org, o.rempel@pengutronix.de

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Aug 2024 10:04:56 -0700 you wrote:
> Some of these were introduced after the driver got introduced. In any
> case, using more devm allows removal of the remove function and overall
> simplifies the code. All of these were tested on a TP-LINK Archer C7v2.
> 
> Rosen Penev (3):
>   net: ag71xx: devm_clk_get_enabled
>   net: ag71xx: use devm for of_mdiobus_register
>   net: ag71xx: use devm for register_netdev
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net: ag71xx: devm_clk_get_enabled
    https://git.kernel.org/netdev/net-next/c/df37fcf58f2a
  - [net-next,v2,2/3] net: ag71xx: use devm for of_mdiobus_register
    https://git.kernel.org/netdev/net-next/c/8ef34bea8cad
  - [net-next,v2,3/3] net: ag71xx: use devm for register_netdev
    https://git.kernel.org/netdev/net-next/c/cc20a4791641

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



