Return-Path: <netdev+bounces-250442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C68CBD2B501
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 05:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C862130194EF
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53E344052;
	Fri, 16 Jan 2026 04:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lr8YbhNG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1F342534;
	Fri, 16 Jan 2026 04:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768537415; cv=none; b=NlYBeV+dbgI+dc3WuI1EGGGMihVM+XORi0NGU3djcKXwIA0C5cvAyhA30yqw6x69GE5Qv85Utg5rRxt8UpLoUyWfXdCnf+fgB59jMXz9gZgnTdmKI1uV6bDXecWEhAOScx1fxnAffXcLj+ynj4QHqnJ2kkztQ7yX0p8Z1sEwdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768537415; c=relaxed/simple;
	bh=bKGN9ojOmxae7da9bMpz9sjOeqsILuGbfwjjJX3u6yg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rTxEDfTPkEroh+Q3lupDM+hG950PImZgnPsNqIWOnEuUprmlGAKva9IyET01TIvkqJNp9ykuXkXUd1eZEK1TYT/PRB6dgNuUn2AIbCi/9cPd/5jPnWrSCh0HwE1JAcwqMJaItGqj9fuOfjXUoA5R6nD53uPIIB3f+ahTNqjgOTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lr8YbhNG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7EEC116C6;
	Fri, 16 Jan 2026 04:23:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768537414;
	bh=bKGN9ojOmxae7da9bMpz9sjOeqsILuGbfwjjJX3u6yg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lr8YbhNGYC3KqrDpq/4N56z7RiiOv6xkta/kQ3N/bqs8vtQjhBxoF9casH4fQ4vbs
	 M7b/S+sLkGQoA1rPJtKFAc+s4V2GVfjlQ07+u+By2b6lz3ahxXrJaaqDv8nGiD4yDl
	 2LCwKv/BoqjWeNNfu9N37/oL6xUfKKOi2+OIsbidwoF/8D2miHTxSYqRCvDLtNp7Wd
	 LjUlHOK58SiAmPAUumfVidJBSIa0iaHngIuui09JStFp91oaen78cPrS1+7AG1+hNd
	 KNrX82YScYlNQviTFcqq/6rtGpoLdSukUPFW0XNoNeA+ZNmarzY6ipi4LuTQxjAg4E
	 TGl/7BCPNP5Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5C1D380AA4C;
	Fri, 16 Jan 2026 04:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: freescale: ucc_geth: Return early when TBI
 PHY
 can't be found
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853720655.81103.460026902506669237.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 04:20:06 +0000
References: <20260114080247.366252-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20260114080247.366252-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, xiaopei01@kylinos.cn,
 christophe.leroy@csgroup.eu, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 thomas.petazzoni@bootlin.com, dan.carpenter@linaro.org, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Jan 2026 09:02:46 +0100 you wrote:
> In ucc_geth's .mac_config(), we configure the TBI Serdes block represented by a
> struct phy_device that we get from firmware.
> 
> While porting to phylink, a check was missed to make sure we don't try
> to access the TBI PHY if we can't get it. Let's add it and return early
> in case of error
> 
> [...]

Here is the summary with links:
  - [net,v2] net: freescale: ucc_geth: Return early when TBI PHY can't be found
    https://git.kernel.org/netdev/net/c/a74c7a58ca2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



