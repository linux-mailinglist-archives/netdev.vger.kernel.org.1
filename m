Return-Path: <netdev+bounces-37622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1047B65DF
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 11:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 8820B1C204FA
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 09:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C2D11C8B;
	Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B402906
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3D36CC433C7;
	Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696326624;
	bh=XiFGqaj5iaBiPzlCZL8MSPSaOR/Bu9GxFKivnqk5qO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kDy8qhfcGGw7HlEs0ya5ZWH8ScaIk0A65wtXDSCJfquGwZA/XDTU4A2x6lsqGWqG8
	 bufwfMLKGyxJUkMNxMNhOx+FmM7uIdlk3jZabjBQ7GvSiKz5S2KNv4zhwcCmfn7fhT
	 SjMq/pKBwo/YikgblH8Z6j/WjDRA+ZC9oX8/1BScWxWd0QkJ0Di+gTmLEkfXwaRoBE
	 4FMdOZe8aIhCM1wwTve4/9PrIxMmo/pkRoxaCFBynazx5ERKYzLue+VTPSu6X0CgiF
	 MKZIl/F7FnGk6UAY2xmMAo4aWbYsIJuAfK96s/pmstQaInJ/x/5EYePzlAu1Q/TvR/
	 35vBkWOS/oZUQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1C7D4E270EF;
	Tue,  3 Oct 2023 09:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: amd: Support the Altima AMI101L
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169632662410.31348.9736191366632838999.git-patchwork-notify@kernel.org>
Date: Tue, 03 Oct 2023 09:50:24 +0000
References: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
In-Reply-To: <20230924-ac101l-phy-v1-1-5e6349e28aa4@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 24 Sep 2023 10:19:02 +0200 you wrote:
> The Altima AC101L is obviously compatible with the AMD PHY,
> as seen by reading the datasheet.
> 
> Datasheet: https://docs.broadcom.com/doc/AC101L-DS05-405-RDS.pdf
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: phy: amd: Support the Altima AMI101L
    https://git.kernel.org/netdev/net-next/c/32030345297e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



