Return-Path: <netdev+bounces-135793-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E3999F39D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:01:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7748428401C
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:01:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14A11FAF14;
	Tue, 15 Oct 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOMwUr17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BC01FAEE8;
	Tue, 15 Oct 2024 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729011629; cv=none; b=jztYczckpacEZ4sjCy6Atp51tVuJA7ZK5O2Er42zNz2v1ar9AipIs9wcUoJ5OrpqvWbdmM5npamMTanECu7ycllUmYLTvLV4/1adYn1kG+SeWBVE9V+q4KN/Ul3KF2ENufZ3Hryot2A+L2QT5bWx5K41tO53fdaJzlymfleEu68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729011629; c=relaxed/simple;
	bh=qutQ+Van85QJSYozCkSL2D9hrHUdQnb3dU1KAlfR99U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=i1IN+5YkzrxY6Ma/aTAHlzsoGhHdNVlZLaUh0LtdN8hV5zObTaC+Q3EEdbc+NFt1K6TdOSZyhleZMw6/cH1eNOGoZmVraB7xBWvc1YpR28ITvmlhNepUb6Sta/NzjtbCvzAnfr/Hafc1dgCfHPbUPMhP1JCysU28nI16tNCaDhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOMwUr17; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D4AC4CED1;
	Tue, 15 Oct 2024 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729011629;
	bh=qutQ+Van85QJSYozCkSL2D9hrHUdQnb3dU1KAlfR99U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GOMwUr17wT2rn9/OPFCVZkQLCqutIrewegSIvp6F/BXLZwj+zh0rhckOztDjV8GA5
	 1Z69m8vjXCazIV9+iPZC3NgCNAEv9lTrRToumaplCCCRVZrmZSy4N+9+M/q3r8MeDR
	 qxHRBNk7SYCFX8Lrklichk5g2S2eMij6jSGBmjoGh4tS2AngF7ic3iairgXU8eZVtL
	 8XXAAaczBfNzahF3uyW5BqHigYE/VlMGuoTCuuTSwB1aoLo8+I4fNmQjYd/iyBBdcJ
	 GMhvGa2o3Txj+x3ymYmtMhuN5vC07nvy/3MqUqdRDaVGBKb9aZACpXCLhwgbI8vhba
	 6AP1OsypkKFaw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC5B3809A8A;
	Tue, 15 Oct 2024 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: phy: aquantia: fix return value check in
 aqr107_config_mdi()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901163449.1227877.18326673570300391311.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:00:34 +0000
References: <f8282e2fc6a5ac91fe91491edc7f1ca8f4a65a0d.1728825323.git.daniel@makrotopia.org>
In-Reply-To: <f8282e2fc6a5ac91fe91491edc7f1ca8f4a65a0d.1728825323.git.daniel@makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: jonathanh@nvidia.com, hfdevel@gmx.net, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, rmk+kernel@armlinux.org.uk,
 bartosz.golaszewski@linaro.org, quic_abchauha@quicinc.com,
 robimarko@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Oct 2024 14:16:44 +0100 you wrote:
> of_property_read_u32() returns -EINVAL in case the property cannot be
> found rather than -ENOENT. Fix the check to not abort probing in case
> of the property being missing, and also in case CONFIG_OF is not set
> which will result in -ENOSYS.
> 
> Fixes: a2e1ba275eae ("net: phy: aquantia: allow forcing order of MDI pairs")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/all/114b4c03-5d16-42ed-945d-cf78eabea12b@nvidia.com/
> Suggested-by: Hans-Frieder Vogt <hfdevel@gmx.net>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: phy: aquantia: fix return value check in aqr107_config_mdi()
    https://git.kernel.org/netdev/net-next/c/57c28e93694d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



