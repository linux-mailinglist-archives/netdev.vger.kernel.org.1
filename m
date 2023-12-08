Return-Path: <netdev+bounces-55404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7243380ACB1
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 20:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23C761F21353
	for <lists+netdev@lfdr.de>; Fri,  8 Dec 2023 19:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E87C481AA;
	Fri,  8 Dec 2023 19:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omo4m+6u"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCF57315
	for <netdev@vger.kernel.org>; Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF946C433C8;
	Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702062623;
	bh=7c4U8d/Xgx5YOWv0MnWoDPrbyZJ91k09ukzZsFs3nSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omo4m+6uZx9SDOvRrAxc4vuY+foGN6w2tumE7fEQPT1W8FYczmhU9n8YWPpd+ndjf
	 Ytmm/zRfFAHeDBtXVyOxKYSpgTWn50obThklagyugPyN6rqT25kFtRQJ/6iv75OBDH
	 BxpA3X2wspzWDr4PgjrzRZ1V2+pS03cRyO/DlBAnzCYWwMSAChbXQrFH1L7Eh1GMLQ
	 qf1oRFHMpvvZygKJ1qjFbJD7jUBdkzBcx8wdyQEqJpBIGHxlhtuCZpcH8k5uqaMlOR
	 YS8lZ4fm7Uab0L7NWmwLDCI/iTNWGoRlTBCUvt7pgfsSBQslRfcBa8/riWpUrSJeKK
	 uMjaez5XBAMqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95D73C595CB;
	Fri,  8 Dec 2023 19:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: dsa: microchip: use DSA_TAG_PROTO without
 _VALUE define
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170206262361.18001.17068135319214332459.git-patchwork-notify@kernel.org>
Date: Fri, 08 Dec 2023 19:10:23 +0000
References: <20231206160124.1935451-1-sean@geanix.com>
In-Reply-To: <20231206160124.1935451-1-sean@geanix.com>
To: Sean Nyekjaer <sean@geanix.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 Dec 2023 17:01:23 +0100 you wrote:
> Correct the use of define DSA_TAG_PROTO_LAN937X_VALUE to
> DSA_TAG_PROTO_LAN937X to improve readability.
> 
> Signed-off-by: Sean Nyekjaer <sean@geanix.com>
> ---
> Changes since v1:
>  - removed Fixes tag
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: dsa: microchip: use DSA_TAG_PROTO without _VALUE define
    https://git.kernel.org/netdev/net-next/c/cf02bea7c171

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



