Return-Path: <netdev+bounces-68726-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99F37847B73
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 22:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBC361C2354D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 21:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8898172E;
	Fri,  2 Feb 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omBu+xpb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D317A723;
	Fri,  2 Feb 2024 21:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706908922; cv=none; b=TDxh4bl6MnK5iHJzgPnotE7/qPFcrLeL7YHD/Zwdl5wBR0tcsy0MN1AJ6zsPoHdwIdRRDStZVSFM56Z2ulbRclXXSl7Untnb3eZP3xH6oYZdgRC7vfiWV0m46OLFPVs/eP5HJlMZk1/Tr7Y6BobCu+fpsABXO+5yyouYseFnsk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706908922; c=relaxed/simple;
	bh=dX8bqHK6dWtd6zKOSklzWQ9UXyHOad7tEhuyHxxpX7o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u/3hRBBlybFulNTFXKOZvt2j87KdjPXzFiR01fz+bUYEoKz4XgEBMWV7PplZc583hqmxGoCIlTDNydQkPj6/N7eNRJVY7hBYAJG7OlK8nRe7FyY2CwBQGrpF2SrvxrmEqZhq7j5x0eg7uBJTEfkpiejgDMkT0P9lRqCfhzvqszQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omBu+xpb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 551BCC43390;
	Fri,  2 Feb 2024 21:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706908922;
	bh=dX8bqHK6dWtd6zKOSklzWQ9UXyHOad7tEhuyHxxpX7o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omBu+xpb6BNz/hchfYs/tZrIeI026SlLs/E6sTdiTXQmtovZLToHoLmxAsVn4KOXb
	 1PPEUmEJnoU5ui0BMWdPsBvTac1QCa6fbnWY/myV6c6LaQxRi22Fa5WMggZG3sFYV8
	 UO9Gvn0zITO/5L6evrilXxUTQf64pcALLoJj70k0CKmvRYcE3iWu33wS8dSnO6WT9r
	 g6qZ96hevKgePhd24cgSDc0yV6B9WJtmvaXUEtzaFdis5f/EITuv5yRuTGclNwUqUW
	 G4bmHoZE7Qf1uj1E8f8ndrowKeBI53WJyTkA2ZackXZASU5CP5Nzgrp3ly9PQFwvwJ
	 1+t3AnRicT9zA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3B242C04E27;
	Fri,  2 Feb 2024 21:22:02 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 5/7] MAINTAINERS: Bluetooth: retire Johan (for now?)
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170690892223.8971.11685624402080242796.git-patchwork-notify@kernel.org>
Date: Fri, 02 Feb 2024 21:22:02 +0000
References: <20240109164517.3063131-6-kuba@kernel.org>
In-Reply-To: <20240109164517.3063131-6-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, marcel@holtmann.org, johan.hedberg@gmail.com,
 luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jan 2024 08:45:15 -0800 you wrote:
> Johan moved to maintaining the Zephyr Bluetooth stack,
> and we haven't heard from him on the ML in 3 years
> (according to lore), and seen any tags in git in 4 years.
> Trade the MAINTAINER entry for CREDITS, we can revert
> whenever Johan comes back to Linux hacking :)
> 
> Subsystem BLUETOOTH SUBSYSTEM
>   Changes 173 / 986 (17%)
>   Last activity: 2023-12-22
>   Marcel Holtmann <marcel@holtmann.org>:
>     Author 91cb4c19118a 2022-01-27 00:00:00 52
>     Committer edcb185fa9c4 2022-05-23 00:00:00 446
>     Tags 000c2fa2c144 2023-04-23 00:00:00 523
>   Johan Hedberg <johan.hedberg@gmail.com>:
>   Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
>     Author d03376c18592 2023-12-22 00:00:00 241
>     Committer da9065caa594 2023-12-22 00:00:00 341
>     Tags da9065caa594 2023-12-22 00:00:00 493
>   Top reviewers:
>     [33]: alainm@chromium.org
>     [31]: mcchou@chromium.org
>     [27]: abhishekpandit@chromium.org
>   INACTIVE MAINTAINER Johan Hedberg <johan.hedberg@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net,5/7] MAINTAINERS: Bluetooth: retire Johan (for now?)
    https://git.kernel.org/bluetooth/bluetooth-next/c/0bfcdce867f7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



