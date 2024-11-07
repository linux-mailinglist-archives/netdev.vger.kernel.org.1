Return-Path: <netdev+bounces-142829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B17879C06CF
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 14:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75D14284A01
	for <lists+netdev@lfdr.de>; Thu,  7 Nov 2024 13:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2B9320F5D1;
	Thu,  7 Nov 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0/EfHss"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3921EE039;
	Thu,  7 Nov 2024 13:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730984423; cv=none; b=ZItC21pQ3akzswO3XKd+TB2S/4e58MHxoH1zOe7/6FbuKdZR6hlEmaE09RwqKNNIkOimj1lV8vkrXwGz2BnTmTwNtuRdLcN3Zo9HYB50h8u481IFlgzCyuXfeVvf9CTz5acDtJta5GZ0dAN6cKy80v/BlbnMoAXh+PQ2Ey+2DY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730984423; c=relaxed/simple;
	bh=fRjLRIAHkS780LON1XUI9SHpCtQ884j2ETBKpqZpz+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JRvox5fkrmZD6tXxViOr+PS37SuVHfMZM8defPJ+UMIEg2uKMeBsK09dMSzjVamdAqR9qCFzlXQKf23SEALwYMEBycnQ/VAzY8Pia06sAQyt899MkQY7hDMPosCBVUeaJKG55YuQ9uC3AKtaU3GxCv0IVoj8ooGpqWvsbYhzA7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0/EfHss; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F57DC4CECC;
	Thu,  7 Nov 2024 13:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730984423;
	bh=fRjLRIAHkS780LON1XUI9SHpCtQ884j2ETBKpqZpz+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p0/EfHssCuT66ePS6pBZrHYTLNry92YECnY0NR/28cTy7L7/2kC95HQoQZ3GIkWx+
	 kAD8KN4VWNgVdIYSL9WansddmoLUwlrTPhjPhWe4GaIGkoSikAA0pLP3lbTta6WohL
	 rbpIXBqG1f7eEdMAI6/20uGOEJfw+g3KATHPgVD4BYq3nXC6d97EZZ6O6XhoUFRPYY
	 6zENDz44kAIuF48KcZukaHKzx2lHADwzizQivpHLBemObj3Pk0/iSGPcXeiyuSPj9z
	 wIc82YF+r+i00OYuxeAiI+LyfQ3f4yRO60rJsyvUan/mC5jz/jIl+gKYNWw83ICwa7
	 vfMm5/QXD0F1w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FF13809A80;
	Thu,  7 Nov 2024 13:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] Fix the arc emac driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173098443225.1955426.12955426674911835946.git-patchwork-notify@kernel.org>
Date: Thu, 07 Nov 2024 13:00:32 +0000
References: <20241104130147.440125-1-andyshrk@163.com>
In-Reply-To: <20241104130147.440125-1-andyshrk@163.com>
To: Andy Yan <andyshrk@163.com>
Cc: andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, david.wu@rock-chips.com,
 andy.yan@rock-chips.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  4 Nov 2024 21:01:37 +0800 you wrote:
> From: Andy Yan <andy.yan@rock-chips.com>
> 
> 
> The arc emac driver was broken for a long time,
> The first broken happens when a dma releated fix introduced in Linux 5.10.
> The second broken happens when a emac device tree node restyle introduced
> in Linux 6.1.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] net: arc: fix the device for dma_map_single/dma_unmap_single
    https://git.kernel.org/netdev/net/c/71803c1dfa29
  - [v2,2/2] net: arc: rockchip: fix emac mdio node support
    https://git.kernel.org/netdev/net/c/0a1c7a7b0adb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



