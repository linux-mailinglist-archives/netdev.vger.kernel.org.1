Return-Path: <netdev+bounces-142186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 860509BDB6C
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 02:50:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3811F23E58
	for <lists+netdev@lfdr.de>; Wed,  6 Nov 2024 01:50:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6930918C91B;
	Wed,  6 Nov 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gFmGBOvK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F42833F3;
	Wed,  6 Nov 2024 01:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730857826; cv=none; b=GteKHDLrXvOkOGwyIBoKbOUrdRaA3ARult3gJ97aZzUgoF6tlWmuowk8dRZi4NM3dFpuYQlvoljymTxGGuYzY9KK+yxME2fR210ykVMaBIJA0l4H4vstTMYqZf6VDZp1ZYLKkbAHfUW6a+PqoXMXCYZShoRr3tGjYw/Wk5JMYxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730857826; c=relaxed/simple;
	bh=3LFEDOWB+2Q8xYQ6abpdlLPvINSwrYHpsVfa02lPGgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RBqyMYgyfdPigbS3DBEGApZb+fz+B+eAOrVQWrN2TfaAREbm92CxYduFVqJg7lBEcx621ftDcUYMxcJ+F/DdkUJH6Q+eYt31occt8UN0NPORD9pZbH/B+M8/IFxR0+Q96EvGt9zsdke8Eb1btEd3vrgA7gGHMphNmpvgsSUp8/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gFmGBOvK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6AD3C4CECF;
	Wed,  6 Nov 2024 01:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730857825;
	bh=3LFEDOWB+2Q8xYQ6abpdlLPvINSwrYHpsVfa02lPGgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gFmGBOvKRX5nprWnaijVZn0jesxeIkSXG26KOvrPqvWBqyk/7qwYPy8LtrUkRmChS
	 c1au3qoKuOMGIuATGkCAwHtbUmbwZo+unoe4r4T7WMG8ykbukC2oKiM6EcXwOpaLze
	 8KPLEzjfvnLnqIXJkAGoTdsBXNBpS2ys4AjkjmdzyyPk4QSI3XqM0ZChy24sQYVkkw
	 mOMQYfhZu4oK46zWvk3fEhlUcI6P9KIqztD0I0rY/yS/0QYexNz1dnNyELr/xUBWpa
	 J0e3IGRoOnsviSxJTRbbVYeeNruoh59eoA5Uc0xiCTfVrT/x+jkmfr5KkKVG+X/cIt
	 VoPX4C55K7dsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB6A23809A80;
	Wed,  6 Nov 2024 01:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hisilicon: hns: use ethtool string helpers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173085783449.762099.10027713671502165728.git-patchwork-notify@kernel.org>
Date: Wed, 06 Nov 2024 01:50:34 +0000
References: <20241101220023.290926-1-rosenp@gmail.com>
In-Reply-To: <20241101220023.290926-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, shenjian15@huawei.com, salil.mehta@huawei.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, shaojijie@huawei.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 Nov 2024 15:00:22 -0700 you wrote:
> The latter is the preferred way to copy ethtool strings.
> 
> Avoids manually incrementing the pointer. Cleans up the code quite well.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> Reviewed-by: Jijie Shao <shaojijie@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: hisilicon: hns: use ethtool string helpers
    https://git.kernel.org/netdev/net-next/c/7a4ea5da4d02

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



