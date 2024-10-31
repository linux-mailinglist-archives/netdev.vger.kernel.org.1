Return-Path: <netdev+bounces-140591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 393649B71F2
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:31:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AEAF1C238FB
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41B67E0E4;
	Thu, 31 Oct 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dvVTFpoz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3E9768FD;
	Thu, 31 Oct 2024 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338237; cv=none; b=I5Ox0xhNdQY+XXMrQN+ZBC9aifHTKNYlvI7KGIJ2N9yLvCtKWL34MmAvinnXKH82gTFYD0f5gCMhLc8WhMa/uvsRGorDyptVLb4QK0oSyolyILNQRCuZfehZ67orsP0jtA62T1O5tMx3hUJphAw305DOW2obnG9BxfQaXNbkbVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338237; c=relaxed/simple;
	bh=zKCjpv8+1lbNnJfxI1td7Yfa4dTY/6Q23nx1o7epz/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r15+vf9TLWKLCMXeKkgodayVEPevPwQOm0UMKrCmEGFDBNrwp+ks/+tmT7wHGGvXvfY3nCK6NT1HsA746ofREkPoouWcOOB/OAUBFVZgybilkMjJdNuV9qPBu5T5Jy1wDmUD13uDnCCCHuA5hWUW4le6eduq04SLAnhshLEpyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dvVTFpoz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30ACCC4CECE;
	Thu, 31 Oct 2024 01:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338237;
	bh=zKCjpv8+1lbNnJfxI1td7Yfa4dTY/6Q23nx1o7epz/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dvVTFpoz2zeLzmalvJ644eVaHYRGvH/sVELhXMmvVgUqNmmDAyHnxKILkRqBaN7v3
	 +/yGJDLwy38/atBA/uHD4/LEajFKgB92saiBPg5M+SSMe2AjeRufYn2UAPsSCDjE1M
	 ecgMsY8jTRHfgiXb9XIq2BUJDQPYYKwTvBHJV3ryRnZPksmssUKNkeL+guLwCzJmZ+
	 7yzrJNd/EsH/gE9z45wrkrUbUOHjkZ8lzkQqWRyPYMtGMfzo+myhyrDdlmXAoMXSfK
	 7zCvED+cZ609Akz2Skquby6YGQKk2rSVCNdCLxL4/PPkEx2iei+qq9dLWhb7Ez9lJy
	 ntmvSQr33OoAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E85380AC22;
	Thu, 31 Oct 2024 01:30:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: mtk_wed: fix path of MT7988 WO firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173033824500.1516656.10424545238538168762.git-patchwork-notify@kernel.org>
Date: Thu, 31 Oct 2024 01:30:45 +0000
References: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>
In-Reply-To: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 sujuan.chen@mediatek.com, angelogioacchino.delregno@collabora.com,
 matthias.bgg@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 lorenzo@kernel.org, Mark-MC.Lee@mediatek.com, sean.wang@mediatek.com,
 nbd@nbd.name, john@phrozen.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 26 Oct 2024 14:52:25 +0100 you wrote:
> linux-firmware commit 808cba84 ("mtk_wed: add firmware for mt7988
> Wireless Ethernet Dispatcher") added mt7988_wo_{0,1}.bin in the
> 'mediatek/mt7988' directory while driver current expects the files in
> the 'mediatek' directory.
> 
> Change path in the driver header now that the firmware has been added.
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: mtk_wed: fix path of MT7988 WO firmware
    https://git.kernel.org/netdev/net/c/637f41476384

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



