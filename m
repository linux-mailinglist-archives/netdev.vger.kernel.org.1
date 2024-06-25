Return-Path: <netdev+bounces-106481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83BB9916928
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 15:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 405F4288942
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 13:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE59F15FA7B;
	Tue, 25 Jun 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uUOUb7iM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C0315F31D;
	Tue, 25 Jun 2024 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719322829; cv=none; b=LG+/1IqWypGROQ1dmto7icPKxxebVwhMOvdo9mxgRqz8aLEVNjzrCmwCtys46AA+faBiqrqUm0FfyL8b40CvgW9pB+Vzu/XTGsC8U5GOe30Gp9IcXnW7JSjo0ovMVQqr7EABk9o6uBZ0rIp0S4fCrZaqQw6beJU3llnaxpRG4n8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719322829; c=relaxed/simple;
	bh=bGu3K0PSd3D4kR7zfKQqykYHOv/3l6O8xqGzMibxHfY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pETSpWy8/cZ0yp5EkVUaqUbItaLM5+aUy959UadIsimw07At7KFi7YO/T2gD1A4Gg3I58eqt0DlEUQy2LmaWmrahiXf6m1mxivy9BQCBBaA/FHyjc/tVOiRaM5isMTEqyk34UJ85lIPnRNyZ3+jybo7n9aJaD9yTm4OuRskJDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uUOUb7iM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DE51C4AF07;
	Tue, 25 Jun 2024 13:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719322829;
	bh=bGu3K0PSd3D4kR7zfKQqykYHOv/3l6O8xqGzMibxHfY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uUOUb7iMVtani2kfVm1cCQ2Qq9V37OchJFFAvqu5Qpci07799p/WeElNNjjvVrL0W
	 905vvoZ3XVA+DO2Arnlvo4ZGztz49f3dLgvhHXJfg03INp+GoDus59vXmikd+YFucN
	 8eswVH9npRe+sLZCe5JBT01O30W2TWXicH/eFVyzRmDw5HVDUeMeP+AYrnLw6bNbfu
	 3qhwP8flSRftfYRsjxe4lpOJAXSLYJJ2z62q2GTc/xjudLYWRDzawkcMa7P9GD5fgy
	 rTQHxNW/o6L5Pe3WTI8I7xWIhK0XMsjQxybsQg4/NfK8WYki50aK2PwiXsO7Rap2YY
	 IHMeXWTEWHgtQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 52339C54BD4;
	Tue, 25 Jun 2024 13:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_eth_soc: ppe: prevent ppe update
 for non-mtk devices
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171932282933.23951.10092690151381575278.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jun 2024 13:40:29 +0000
References: <20240623175113.24437-1-eladwf@gmail.com>
In-Reply-To: <20240623175113.24437-1-eladwf@gmail.com>
To: Elad Yifee <eladwf@gmail.com>
Cc: daniel@makrotopia.org, nbd@nbd.name, sean.wang@mediatek.com,
 Mark-MC.Lee@mediatek.com, lorenzo@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 23 Jun 2024 20:51:09 +0300 you wrote:
> Introduce an additional validation to ensure that the PPE index
> is modified exclusively for mtk_eth ingress devices.
> This primarily addresses the issue related
> to WED operation with multiple PPEs.
> 
> Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
> Signed-off-by: Elad Yifee <eladwf@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_eth_soc: ppe: prevent ppe update for non-mtk devices
    https://git.kernel.org/netdev/net-next/c/73cfd947dbdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



