Return-Path: <netdev+bounces-79305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358D7878AEF
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 23:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5DD6282415
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 22:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A21958229;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JhtmA9cf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F7158220
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710197437; cv=none; b=pEF5hSgMgVuL3PhhaXPllTOSZmOPvaha9CleqYq+oXYYYnNY8VnfRcJ07tBEaA9GXKHwtqsojWMZ5S77JRpBcTlX6zc8aX5P5mptXYjvRw+CvA4RQJDlTPirJEm5Qq/INITZ9cN8OCBKZrEI3zZf60XA6JomBOfxkiJfsDBpgEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710197437; c=relaxed/simple;
	bh=oKN5hvlU+Vm7or3V3cNEg4Gky8/9lPjpTenVgAMngX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UzM9Rb7bT5f/iEEavTL+0NCP73hplC06BAylKfQvQigRpUPnoVM2rzhHJyUPYbpmZrp4lsW3joORaGvIDSk6CICHDWD91WTb2H76XiCJ0P0VNgmwdf6FayHFpX9VZMfswLkSQVWF60VnewhGG+RO8ERNuDbXLTDqYJu7L9aXybQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JhtmA9cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4584FC43142;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710197437;
	bh=oKN5hvlU+Vm7or3V3cNEg4Gky8/9lPjpTenVgAMngX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JhtmA9cfCq5bnrNexbJfsXCUYN0wx+ra+ZBtRAE6X52omRpXycaQBobGleB4BmY2o
	 9xuVxIIiSSaclvsJOj0ogRDS280WGEQVg/h7JkBm+nZ9G2Ivuc3FjaK+cUVk23Srjr
	 +/BboABpwSbm0klYzv50eoxhd8AjffU2/q24tfDJGlq7MuhgzCeESQHUnd+gExcAyj
	 61K3pIl2bjOHXSVyOg+5kZBkWULLuGXiFhPQGHkyoc08J+fmvnsWFgomIWF/TeNgUk
	 3fDaKuWeXEeUO2l78L31w47TEidRLlnmG1eqTBn6QL5uVEb91C6ewts0L1Uw/XaH0G
	 G7dH1/YOEyQQQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BD19D9505A;
	Mon, 11 Mar 2024 22:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: remove trailing semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171019743717.8733.3761023828122919800.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 22:50:37 +0000
References: <20240308192555.2550253-1-kuba@kernel.org>
In-Reply-To: <20240308192555.2550253-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 Mar 2024 11:25:55 -0800 you wrote:
> Commit e8a6c515ff5f ("tools: ynl: allow user to pass enum string
> instead of scalar value") added a semicolon at the end of a line.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: donald.hunter@gmail.com
> CC: jiri@resnulli.us
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: remove trailing semicolon
    https://git.kernel.org/netdev/net-next/c/a0d942960d9b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



