Return-Path: <netdev+bounces-200442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05D85AE5848
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0545D1B613C7
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54821F956;
	Tue, 24 Jun 2025 00:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXAJ9iTv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CDF91DFCB;
	Tue, 24 Jun 2025 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750723796; cv=none; b=N8flfHzk/nsfiMERFgeC76XiDo6H6q7c9oXA9wF/Vteq63OkmR2djT4HB4ZAiTvxCox5hsZD5HBSndOyRcCxeHNglc44UWGNqLiZUDLWhNWVfHwlC50o0paQuHACwvKZEAsAn/e1t9RQPHNjyYRXg9kWDgR9qwb4oMmtZpYxPbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750723796; c=relaxed/simple;
	bh=BpMsilRza2CCgKGrJ9LKpK9RVRVYRbTf98T8prRGtfU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SH8K+OHk/wMmC8wlAoSWbqrfAtYnhOmQqKcbAQjOeoSjEM7kUpvfi+axlfGRuwEJNVl8RpJdWDH0h4Nr5px4OfMIUyDSa4OKtcu4JKskmDK3GDlWfc6CyXFVfWrBONF1U9yzJJSIA5mUePhdog6Me5vYLcl6gouorRKV4QIs1eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXAJ9iTv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3327AC4CEF2;
	Tue, 24 Jun 2025 00:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750723795;
	bh=BpMsilRza2CCgKGrJ9LKpK9RVRVYRbTf98T8prRGtfU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JXAJ9iTvPXvTYS/kksKILey17arQ1UbVasFCYoprGFlXyKi4Lo4TOXyARBdQVNiLf
	 ID6xQm0kUsQrGvhxGpF+S4nNHFTayjQnTleBGntn10gVsHtBIsU6VEaRvTbGoGOAnt
	 9zW3RqPgw3LURE2jcLRxCdbLM2MZgXntbd7HqMvXYdNfaB2lE26zr2dsRgI1LDX1MB
	 esl11Q5aZ/euqljyAs6U4BOtQHAvqtP0ugtq8QCyKhYSDynQCeELTZyD3/rB9jH/nW
	 K+PaAqqMzSEDgeOdSvH2jG1dm9JZ9Y6YdYGvaILoyMICdaDJjs5YIbmi5rnzoAmP2S
	 AgeIbsNVjuAUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 73DD239FEB7D;
	Tue, 24 Jun 2025 00:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] caif: reduce stack size, again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175072382199.3339593.4920663472402856853.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 00:10:21 +0000
References: <20250620112244.3425554-1-arnd@kernel.org>
In-Reply-To: <20250620112244.3425554-1-arnd@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, arnd@arndb.de, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Jun 2025 13:22:39 +0200 you wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> I tried to fix the stack usage in this function a couple of years ago,
> but there is still a problem with the latest gcc versions in some
> configurations:
> 
> net/caif/cfctrl.c:553:1: error: the frame size of 1296 bytes is larger than 1280 bytes [-Werror=frame-larger-than=]
> 
> [...]

Here is the summary with links:
  - caif: reduce stack size, again
    https://git.kernel.org/netdev/net-next/c/b630c781bcf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



