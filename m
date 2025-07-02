Return-Path: <netdev+bounces-203121-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 365A5AF089B
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF6A443FF0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AE01DE8AE;
	Wed,  2 Jul 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OldhVjix"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2091C1DE4C3;
	Wed,  2 Jul 2025 02:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751424004; cv=none; b=r+fj4pjdRkg8ljWCriyFKuiryjweD6PmFRBMhGrUaVaFW+RRS16AHRvFU6ZomvXrPJHzSsMPvwUwUXdXQBNRxq5PnGKr+AeV73kFkHZ4raBgFSdhSU0JTtwzilZhvGgebEItcoXVfEGctMuxX8S67tm9dbJct7KUAhWNZqdU+SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751424004; c=relaxed/simple;
	bh=uegAaZS7eogMqidDjY4f4rq47lp5m3d7kfUjEelRoDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vAs3ccsdBZTOU9qQn4rt+PFsXMsbYyAB4+L1Jd8jW/0y9r7aPJHyQY4k/Sus9BwfRzsnPlhWV5NlX0W9ZzUtWAxeqvH6lEASzBzHFDiAGHtYVgVzEBw9cJB7RxaCBLCHrdZkyr8gbFfuwlDA+wvS0+rm4AsExjEanftrZBusN9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OldhVjix; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F35C4CEEF;
	Wed,  2 Jul 2025 02:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751424004;
	bh=uegAaZS7eogMqidDjY4f4rq47lp5m3d7kfUjEelRoDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OldhVjix8h8PG8fmFggrAI8+LJByXSl8zqS+vuJ52VqxviX7e4kd732J5S0AcrNii
	 0910ysFFXrwCgIjuvhk8TCBHcEkvXVJoFGD4lkPQwSMatTitGSbqLOnoIcFs4TwbXR
	 OavX8DDCNHuNFveM5q3V9VplKpPlL0mOMPVtzZu0ml6NLgAsRW00YlHDPhhEHCkJHo
	 XZQ8BvOhl8OCKS/8q0q/Kk9ZrCS/JMT2KmAJOre5CXsFUd2IOG89FiqVWQddpVFS6J
	 pt/u11Ijdubsd+J9FYXDI4492Qv9v+23Igk1RGDePlyx3H3+i2eSqXPlpzYQ+c3gx5
	 a9aSyhDX8jxUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB013383BA06;
	Wed,  2 Jul 2025 02:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/1] phy: micrel: add Signal Quality Indicator
 (SQI) support for KSZ9477 switch PHYs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142402850.183540.10621772163520728797.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:28 +0000
References: <20250627112539.895255-1-o.rempel@pengutronix.de>
In-Reply-To: <20250627112539.895255-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 13:25:39 +0200 you wrote:
> Add support for the Signal Quality Indicator (SQI) feature on KSZ9477
> family switches, providing a relative measure of receive signal quality.
> 
> The hardware exposes separate SQI readings per channel. For 1000BASE-T,
> all four channels are read. For 100BASE-TX, only one channel is reported,
> but which receive pair is active depends on Auto MDI-X negotiation, which
> is not exposed by the hardware. Therefore, it is not possible to reliably
> map the measured channel to a specific wire pair.
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/1] phy: micrel: add Signal Quality Indicator (SQI) support for KSZ9477 switch PHYs
    https://git.kernel.org/netdev/net-next/c/f461c7a885d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



