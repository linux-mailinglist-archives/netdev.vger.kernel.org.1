Return-Path: <netdev+bounces-40924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703067C91D7
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4B31C209E9
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CDF1372;
	Sat, 14 Oct 2023 00:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uVavqv7N"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784B836B
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:40:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id CEEDDC433CA;
	Sat, 14 Oct 2023 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697244024;
	bh=LBRj7RPpH0t4uglFprw3OonulBFR3UbaQLNWIGKmsf0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uVavqv7NwI6oHhj42YaTFmb7lwoo3iGH4auhp9kxae0cGBRYb/9URRCMGnT+0Knew
	 /Cv2vX0lxILkc5TP0lnmCfLkk0Z3eUPCnVNFgQm73S3R2+NKgxmORsuxj9EBGze0di
	 5k01Md8t17sXBj9YkcoNiThJiXo4XmpX4a0gMLAzaiLqzfo2gXwg9ZNaf9+UwZPa4j
	 KG72rIjbXzIJg5mSxwWAKYxGSDrK4axVfUxu5tNiA57rYz1MIpGg1YgMbcrNcBb3PG
	 GAyzq6z1qmprLeOaggysqblSYVaDd8SUdJTShjQFAhJr5SRetW7vgJRk3ouZjYL0uC
	 Po72e/5PBQGsg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B5C70E1F66B;
	Sat, 14 Oct 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ti: icssg-prueth: Fix tx_total_bytes count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724402474.30425.14506920247317022113.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:40:24 +0000
References: <20231012064626.977466-1-danishanwar@ti.com>
In-Reply-To: <20231012064626.977466-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 srk@ti.com, vigneshr@ti.com, r-gunasekaran@ti.com, rogerq@kernel.org,
 andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 12:16:26 +0530 you wrote:
> ICSSG HW stats on TX side considers 8 preamble bytes as data bytes. Due
> to this the tx_bytes of ICSSG interface doesn't match the rx_bytes of the
> link partner. There is no public errata available yet.
> 
> As a workaround to fix this, decrease tx_bytes by 8 bytes for every tx
> frame.
> 
> [...]

Here is the summary with links:
  - [v2] net: ti: icssg-prueth: Fix tx_total_bytes count
    https://git.kernel.org/netdev/net/c/2c0d808f36cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



