Return-Path: <netdev+bounces-140148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DD49B560B
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2BC5B20BEA
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CE420969B;
	Tue, 29 Oct 2024 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CftWwSUt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1981518FDC5;
	Tue, 29 Oct 2024 22:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730242224; cv=none; b=sHYREOVL6+q62wdbkRxwfraBv4XBr+oVP0s110fOUSVdU3IPeLsBD5Jv0VYiHYNc4BqnnOYj5BgMj0LJjq7djZN9fb3JHbG1QM5i1Tt6xw4KmDamdfp1ZVixFr3VaCoRkoy+U5PHLVWgJOrwoOD9G9NsMtho485TBsQM1qJfWho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730242224; c=relaxed/simple;
	bh=krniV51Ko7jZpV+ajgbFgC9UweWVT9ARQMWOdJf6Euk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m8vRIsszPp6jdAwmCd6wsLWAYocezgbUFmR8gc/IJYMdoHUaA9nWqC3C95sPT8O26glJA50njWAC7gLNlpb8Mm3JzG1hGj76kzyFCPE4WPi+v3ZoCA8ccR+hruSl0/7ZUYQTOf8RMQ3ACFnUVAljTMemUQSLmDA8IfboivP4c/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CftWwSUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F2FC4CECD;
	Tue, 29 Oct 2024 22:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730242223;
	bh=krniV51Ko7jZpV+ajgbFgC9UweWVT9ARQMWOdJf6Euk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CftWwSUtLUKiR7SQfyF99kPtt5bB1JWo2DAJypOk95j6dwNVkrGDpfzsqHGlOwpDi
	 8apb8hNu9ZltEg+cy8dupQifgUgbZz98eaaO0xVJF/qEht6Xh9zpeXgzpbTX76Jlfr
	 IKwuN+pGLiMc6MMFrjXJsty6KABqMlVY2nmY0kyf8kh9ZthsxDacq2Al/AJ15/+xG7
	 QzZIXPZZLhp9lwvo2zY6L5221sDmdASTSDpa+Hddsc9p/S0qN8IxeETAFEJz5n+vfI
	 6F207nFXwpyC2o3Pu1zXnBw0DgblsBPk/465gCgUOG377LMYsEiJytF0l518kIPjR2
	 lHf6LNRMbtlMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 713B9380AC00;
	Tue, 29 Oct 2024 22:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next v3] net: ftgmac100: refactor getting phy device handle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173024223125.844299.5349038134200267566.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 22:50:31 +0000
References: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>
In-Reply-To: <20241022084214.1261174-1-jacky_chou@aspeedtech.com>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@baylibre.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 16:42:14 +0800 you wrote:
> Consolidate the handling of dedicated PHY and fixed-link phy by taking
> advantage of logic in of_phy_get_and_connect() which handles both of
> these cases, rather than open coding the same logic in ftgmac100_probe().
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> v2:
>   - enable mac asym pause support for fixed-link PHY
>   - remove fixes information
> v3:
>   - Adjust the commit message
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: ftgmac100: refactor getting phy device handle
    https://git.kernel.org/netdev/net-next/c/4dbc8d6d05b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



