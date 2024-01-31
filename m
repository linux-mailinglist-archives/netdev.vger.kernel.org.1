Return-Path: <netdev+bounces-67562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D12F8440D6
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 14:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40EEE1F22733
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6555B7FBBC;
	Wed, 31 Jan 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VeK68afW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2417F493;
	Wed, 31 Jan 2024 13:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706708427; cv=none; b=oWYe1RsnOLHqR5cF6/pw09RrLuLDhLTB83aJx0CaROOw0d77HEBZvef84sUnigesY0uceTcCP5J6aMCzArYX5a7GMD7nrV9JLLgZolBx/1IAIGrwZ310E6mMzh9gwswGvaGn6nIZa4Sh2+sCm8gxiuOakVTaUY9CjFLBoKYupCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706708427; c=relaxed/simple;
	bh=lWttfl32UtfKQxmCE2Lha+V1wyRrpzCmonLS/CtSrm4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nu9z49wsCZ/IABpvQbO1C4pRu51qMpjN/Zjmd4JipPpI6wO3g2XnJFJEoHlK+gkVgoLvKyQO83LNmZYKf6I9SfOgSk4z276YS6gP+AFJbRwYq1AK+/spC5SDoRuobG6ETWvbkFgH08xvre5wSETSpwfS0INHgNKxVHoJR/HBCCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VeK68afW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 111B9C433B1;
	Wed, 31 Jan 2024 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706708427;
	bh=lWttfl32UtfKQxmCE2Lha+V1wyRrpzCmonLS/CtSrm4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VeK68afWIF1FtCC4TcOQdFncLFI8IFyetcPgjfZNZkdhfsaq0ufM3Z/Rw8rei2GfZ
	 /303qLegwVOwoxQayD8tll86xcQorruempbTdodfPVZC3GqLh9yfdqAdUaHeswwpk4
	 4hhso5k3gWJFURFi0ebGOV8H3tZDYSOwI0RTo/G5wg7ZtzpclUKn3oEJRPIEDJj69s
	 IgTePlUbtJa0BwNzJZBTeMXbX0b+h3q+IJZyNqJIxzMjbKQYlCkD3jARYlSEv3e2eH
	 s4xBkkYY7GVyMJ8VEpxSXiPMhaR29SWfC/64uO25RYSTVex/us3oRGA2tICmCJCAj9
	 C5wzuLi1wheIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E986CE3237F;
	Wed, 31 Jan 2024 13:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: lan966x: debugfs: Fix showing the port keyset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170670842695.31681.17230280565350658604.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 13:40:26 +0000
References: <20240128195134.3600629-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240128195134.3600629-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 28 Jan 2024 20:51:34 +0100 you wrote:
> On lan966x, it is possible to use debugfs to print different information
> about the VCAPs. Information like, if it is enabled, how the ports are
> configured, print the actual rules. The issue is that when printing how
> the ports are configured for IS1 lookups, it was parsing the wrong
> register to get this information. The fix consists in reading the
> correct register that contains this information.
> 
> [...]

Here is the summary with links:
  - [net-next] net: lan966x: debugfs: Fix showing the port keyset
    https://git.kernel.org/netdev/net-next/c/e746094b1bb0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



