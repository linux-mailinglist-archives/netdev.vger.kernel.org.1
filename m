Return-Path: <netdev+bounces-57719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 431E1813FA9
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 009C428367C
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 02:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771B07FC;
	Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvbRfLM1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D309EC8
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 02:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 00711C433CA;
	Fri, 15 Dec 2023 02:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702606826;
	bh=txQPrRmE/50mozU8GJVEI8IYQ0VB5rXSbpPjfE83SdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZvbRfLM1cvoJIn2rclzgdfp4Ag/4wZtmqqZMQKQxmbPnKtF2zPf9jq7spmKJ0Dbk4
	 dC3nNeKvGj6LcyXsKFDkUuJER3EFpp+D82XHxFl6VX0oKnic6x2i7wVlK3RTPKnkC4
	 6CYVePKahVBleO0WZwgHv/OX9zDIfiSDQUzW/uP4GPFNCL/PDHMN/Y0dhkRZZQt87k
	 Dtv2c6tNwT0GT1cHaeaPNkb0SJ+yoi81AnIJzZriRLLFrFal1NVQo6WlOj9qszjzt6
	 fFDNPvfS9EkrCe37twn8XVO7Wh7Ay1cvpAItvImzeGWXt8MuzG53r+TmEpJjWcjZAH
	 6+Tra9xdGLmHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DBD5EDD4EFA;
	Fri, 15 Dec 2023 02:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: mdio: mdio-bcm-unimac: optimizations and
 clean up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260682589.8212.1296676173650868899.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 02:20:25 +0000
References: <20231213222744.2891184-1-justin.chen@broadcom.com>
In-Reply-To: <20231213222744.2891184-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, opendmb@gmail.com, florian.fainelli@broadcom.com,
 bcm-kernel-feedback-list@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 14:27:42 -0800 you wrote:
> Clean up mdio poll to use read_poll_timeout() and reduce the potential
> poll time.
> 
> Justin Chen (2):
>   net: mdio: mdio-bcm-unimac: Delay before first poll
>   net: mdio: mdio-bcm-unimac: Use read_poll_timeout
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: mdio: mdio-bcm-unimac: Delay before first poll
    https://git.kernel.org/netdev/net-next/c/268531be211f
  - [net,v2,2/2] net: mdio: mdio-bcm-unimac: Use read_poll_timeout
    https://git.kernel.org/netdev/net-next/c/54a600ed2170

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



