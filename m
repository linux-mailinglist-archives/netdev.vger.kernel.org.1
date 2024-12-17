Return-Path: <netdev+bounces-152457-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85FBA9F4039
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 02:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEF79169F00
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 01:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2DBB13C836;
	Tue, 17 Dec 2024 01:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBXqoV9A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECB043AB9
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 01:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734400217; cv=none; b=ldj8OlmzhWO2amBoPGgYMMklInYI5W6Q7nH/O31jH4rpvNapMTgDnQDVyyWXm480eSDhyuJBcVTyPtTqd41vlE3xoSd+r68zoH2rEp30ijobeIsiRfFrAjEOcbobA8lGJqnejH5xrA3QFK9w6VQN2muq0F+Yq/z0plco8R29Hu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734400217; c=relaxed/simple;
	bh=PjzC8lIUltZ73iOeFgRZChV9cZue4ru17BNBRqqjs+U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oSdHrYN1vXv3sgYS+9Vg0YJ/2v/11A7hllKAjSZOm/TIIXuIttz4zucVYJBKe7xogoTMUKnCTeE4bRPVFkyjX4IFEcf5bsCU3Z4XoNzGhfd3fNzRYzb9eyeWoqWrIxteXfaB8x2un7WDMMVGr64tR1ssmmjGnsJiW3H9vPns9rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBXqoV9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CBFEC4CED3;
	Tue, 17 Dec 2024 01:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734400216;
	bh=PjzC8lIUltZ73iOeFgRZChV9cZue4ru17BNBRqqjs+U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rBXqoV9AtP2BOkzHrmbKKZmGBHf7RSGfjl1okFRptHGo1A88+XlYwy4qiS00Eq/8K
	 5NQjtNZOKllWIs+LZ945XqD4WQkr/kQVVyNaVI+XVd/EoBGyyPGdhQrHvQYcymTlUX
	 imLA+pfSs4KDtRatnj3XegvWlLzut1cBbGWURNlIDM7JqhkvAbmTbx/fjZqlqRRqfv
	 6cOQRbKdcUMq2VqPyxokLcAB77sSVKbtYrYeB229iot13IazqLfEzssxtPY6Z1SvTS
	 DTs2Hcwlf4M1lXBhByfiYRac5gUZfrIiYrA363bs4TSf2neo6gYL2Jdi6wp1Wnxy2y
	 zD56cWyUB1P7Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC9A3806656;
	Tue, 17 Dec 2024 01:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [pull-request] mlx5-next 2024-12-16
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173440023328.411680.11934858732198065724.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 01:50:33 +0000
References: <20241216124028.973763-1-tariqt@nvidia.com>
In-Reply-To: <20241216124028.973763-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 14:40:28 +0200 you wrote:
> Hi,
> 
> The following pull-request contains mlx5 IFC updates for your *net-next* tree.
> Please pull and let me know of any problem.
> 
> Regards,
> Tariq
> 
> [...]

Here is the summary with links:
  - [pull-request] mlx5-next 2024-12-16
    https://git.kernel.org/netdev/net-next/c/9495e6688522

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



