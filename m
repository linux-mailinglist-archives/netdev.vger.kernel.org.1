Return-Path: <netdev+bounces-177140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 225B4A6E061
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 18:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E9A188B2B6
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 17:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29DAD26280C;
	Mon, 24 Mar 2025 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHe5Zm5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014A11D514A;
	Mon, 24 Mar 2025 16:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742835599; cv=none; b=cl59fO7yFUTbqjQnkg0Gq3g3WAHr0ucLxqRuEPm0lI4sjKaz/5mWq8Q/KElWHcQjcMb7nUHwpMWad8MU442IGbuwKFbuAFvxHxLMi9k7Zyd+xwddHhME7DAVLI/Owab2J5ZH0ozs0fBNJ8fFwdKtLjo572HthTzqNSx3tHATlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742835599; c=relaxed/simple;
	bh=R8Y139KSJEoEMPvzdoIiX04zKRPgVlk+9dHVzsRpa/g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yd/RXIgLaZYvofg7SZtctuW/9cL9U8waWuxz7ou5q0RvcnTe/drsvK/Y9NlMvkrwiHNZ3NrdqTp4Yk4EiQK3JoznMYOU9CniOlYR6jrL2o8MlngjJUaaPEDJZ7OjMYGAeUdfQPsqog8qs6LsOxTPI4/1TqhZZaP7SP9dHBiSjgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHe5Zm5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BDEDC4CEDD;
	Mon, 24 Mar 2025 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742835598;
	bh=R8Y139KSJEoEMPvzdoIiX04zKRPgVlk+9dHVzsRpa/g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XHe5Zm5bjWlwo07Trq4d3uRndKyy3KfqnkClIbTO0O1F00/DBxfEZdjaQq9f26Njq
	 bxMDb8sXKqefMVVJIDxTW3QbPNSy4ZqokpyT+Mx89zqOEI0HTW0UGftGuZmVjz0CdI
	 jrbIi06xLkbkgyzb6uGxAQydqtOfk/LqjUTlspEoiSRd7Z7a3e9LlQPoxnr5e5K4ll
	 MGn4R8BcsR80i7DapKderb/OP1aVmtOvL1Oo6gOaxOuRt6BhU8l0IoEuoW2+3lAtC/
	 mrtaOV87FfINouhgI88jGMu3zOCRsKcIzVP9aPx1LcDSVnqTjYz+TVP5tdUjyMfw3w
	 MwP0RkOkF31Ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE886380664D;
	Mon, 24 Mar 2025 17:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: phy: dp83822: fix transmit amplitude if
 CONFIG_OF_MDIO not defined
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174283563452.4097226.5621496775450844248.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 17:00:34 +0000
References: <20250317-dp83822-fix-transceiver-mdio-v2-1-fb09454099a4@liebherr.com>
In-Reply-To: <20250317-dp83822-fix-transceiver-mdio-v2-1-fb09454099a4@liebherr.com>
To: Dimitri Fedrau via B4 Relay <devnull+dimitri.fedrau.liebherr.com@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dima.fedrau@gmail.com,
 gerhard@engleder-embedded.com, dimitri.fedrau@liebherr.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Mar 2025 08:48:34 +0100 you wrote:
> From: Dimitri Fedrau <dimitri.fedrau@liebherr.com>
> 
> When CONFIG_OF_MDIO is not defined the index for selecting the transmit
> amplitude voltage for 100BASE-TX is set to 0, but it should be -1, if there
> is no need to modify the transmit amplitude voltage. Move initialization of
> the index from dp83822_of_init to dp8382x_probe.
> 
> [...]

Here is the summary with links:
  - [v2] net: phy: dp83822: fix transmit amplitude if CONFIG_OF_MDIO not defined
    https://git.kernel.org/netdev/net-next/c/8fa649fd7d30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



