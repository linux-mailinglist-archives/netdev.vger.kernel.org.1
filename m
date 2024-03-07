Return-Path: <netdev+bounces-78226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B878746F7
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 562491C21A9F
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 03:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534AAE554;
	Thu,  7 Mar 2024 03:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KRB2zUwC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A3C1804E;
	Thu,  7 Mar 2024 03:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709783519; cv=none; b=JWHQGTP55WBB94F5IZ9BrmzNoh929p9fYpaltpR/yz97nbpZEpdt3xPFWgL4V1MC+ImsoVVtuW/j2cEccP2RqlwzkEM6y9cJIJi3E9tYRtRSDAgrdDL5HL8PUhB18hARuP6Xx42dYCddtdp2y3uchsKx4Pmt9rtmveS52eSgFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709783519; c=relaxed/simple;
	bh=+piZR5lNiVVbQ2xJt07TajT/lnGyNU30/lVKD13475A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fl82++UCUF41QXfhTouLel8eWDMKzEo99DgIWs83Y3AOuHqs0wAY8lfQMSyiMiOgYO9XUp5On8MSZC0ZTJwY9xwGqgn9+keJp/8QP2nn1g1ukusYFj6eFs1KFSwjKOWqfiC3JdHORte1oC57Ev/rwflCN7rSwvN8HlDLjRDbfHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KRB2zUwC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86E91C43390;
	Thu,  7 Mar 2024 03:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709783518;
	bh=+piZR5lNiVVbQ2xJt07TajT/lnGyNU30/lVKD13475A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KRB2zUwCzSm2V+3Rp+380sHq0ocNyiGrcRE3jMAZDTYbU2x/W3bXJbo78hqsCUSSv
	 eLmqouHPogy7KdLrCD71SEF3k+oSOVeYyBs8WsvOoeJdx+VubUEqsP/tVH9PCgjiNA
	 NRUAV2iDbQ6XsDll7yInM0mh3Eox9Tn6QZL4/36C6DV3KDbhezKjWZrRfeV9Zsy3fg
	 /hkhwMjoJ2SqSVU2sRDHPRRhVJBUIgXdKBH6tby35NpslSTLGJDO+uXUIFlpxdnOdn
	 +Nh8sDYKM6nY7TUP0Kf4EcSNka6UJiKvuTpzviRrK5fO8OAmpTHQ5oNf/KAh4jHJxM
	 dgCe26RwcDHXg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6E62DD9A4BB;
	Thu,  7 Mar 2024 03:51:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth 2024-02-28
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170978351844.12718.15913227332108763470.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 03:51:58 +0000
References: <20240228145644.2269088-1-luiz.dentz@gmail.com>
In-Reply-To: <20240228145644.2269088-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Feb 2024 09:56:43 -0500 you wrote:
> The following changes since commit 4adfc94d4aeca1177e1188ba83c20ed581523fe1:
> 
>   Documentations: correct net_cachelines title for struct inet_sock (2024-02-28 11:25:37 +0000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth.git tags/for-net-2024-02-28
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth 2024-02-28
    https://git.kernel.org/bluetooth/bluetooth-next/c/244b96c2310e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



