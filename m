Return-Path: <netdev+bounces-104657-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6012590DD86
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 22:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1030284D51
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 20:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F1A1741E5;
	Tue, 18 Jun 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r0YJwnNk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7286E53E24;
	Tue, 18 Jun 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718743229; cv=none; b=n3N/6TpNASjLzjqsHu11w4kRw/cLYClrPX5CDaWoGIyGESH7qSDZn8xZW/6TLpEnUfmv/j/c1QDJzBXpY1gNt4sruBYGq/l2iitHaoGkMzNcwnQDdEd8uOZb0UmO14cKwyXcOEMC9P7f63769kMmgyU3Q4Zska4BxjFy+V6u5BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718743229; c=relaxed/simple;
	bh=1ocjK+LT7BoyXhpjfZNC0U0iXoBHcU0xFkJyKOSnhvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BtZXBr9fjnhJ2rA6u+0TqcinhQtgTD5Ea3Okv9yBJteelMWZOQUXzEID7vi1GMkZS+ybKhHlcmGkgdtO2fjrdhoI4Mi7Pjeyq2VVrKrUBba5em9pd/5AJitsusjFJJGqAmnywP5JiGNgqRxDtfqm7Dz2WTmt5Sh8HV7nl31nDB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r0YJwnNk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 02CDCC4AF1C;
	Tue, 18 Jun 2024 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718743229;
	bh=1ocjK+LT7BoyXhpjfZNC0U0iXoBHcU0xFkJyKOSnhvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r0YJwnNk3nMf/A9kRJd4eaMNe1ZiViQelSYtpjKJeYiHuh4dyrlj1kJRteBVOzE/s
	 HHflbSpYzyOUSyWGsLBKaW5zWgBwOv/g6YE/JtStUNVmQ+l51UfwQbJzh66BbErOhJ
	 7+v6yBqT8SA3lwBhm1tp2jxf3fH0UEDcIqg6dbWM9AVsJqr510AYHpw5Z/cXaAXL7D
	 G9/A8xkyxKxKLxWJj2IG/aLtblpcG3U1mZORsSASWRyTIVpsJq/LtRRUnkyE8PvraX
	 MZiYisio+gz7BwRGJqDZrDy3YOdVA15oWBc5GFqnM+ueaHl8M27GlWbV2MrjWtvcUr
	 Hr1E4dhA5+Ubg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDFE0C43638;
	Tue, 18 Jun 2024 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] ptp: fix integer overflow in max_vclocks_store
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171874322890.29933.12278872783438831362.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 20:40:28 +0000
References: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
In-Reply-To: <ee8110ed-6619-4bd7-9024-28c1f2ac24f4@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: yangbo.lu@nxp.com, richardcochran@gmail.com, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, christophe.jaillet@wanadoo.fr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jun 2024 12:34:32 +0300 you wrote:
> On 32bit systems, the "4 * max" multiply can overflow.  Use kcalloc()
> to do the allocation to prevent this.
> 
> Fixes: 44c494c8e30e ("ptp: track available ptp vclocks information")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: It's better to use kcalloc() instead of size_mul().
> 
> [...]

Here is the summary with links:
  - [v2,net] ptp: fix integer overflow in max_vclocks_store
    https://git.kernel.org/netdev/net/c/81d23d2a2401

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



