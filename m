Return-Path: <netdev+bounces-27833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF6477D6E4
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 02:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EE65281680
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 00:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 096A418E;
	Wed, 16 Aug 2023 00:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4B017E
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1D08CC433CA;
	Wed, 16 Aug 2023 00:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692144628;
	bh=LCVFsQO/jpBt8rbDuqXrAfRyw1i3D+P14bNEY5FvpM4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cIpKD2BuiaCwsDNNSPVJS8WiT0PDFnXV3EVj/dZOxfpuQdqhbP9Ttj8iGhErsyQQs
	 oUflIVL/d2aedTB/djln7n5zrpw9eByWdQghqFGYJ4uPFHzdA23AOMFTk0I8kHEKcT
	 RUS/Gsw3vLl0LCepWWlaRGG7QayA6vyK3Y8tm6xvN5ahHZG78CiQhBt/If8spPPm3R
	 SJaDMaCqXJCWtVSCbnTBcqpRncnNKyooJplDextwR+hVwIER4w4vWbEdJQxawX+lqT
	 hVlGZlSKps+U9aWZlxYaoNskZWy/z8Upd2MRdt27Fbs7AexNNVW0+39rmM4WNUfTW7
	 sUFv4jygQ0rLw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E802EC691E1;
	Wed, 16 Aug 2023 00:10:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull request: bluetooth-next 2023-08-11
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169214462793.26309.7033762932004317499.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 00:10:27 +0000
References: <20230811192256.1988031-1-luiz.dentz@gmail.com>
In-Reply-To: <20230811192256.1988031-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to bluetooth/bluetooth-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Fri, 11 Aug 2023 12:22:56 -0700 you wrote:
> The following changes since commit 80f9ad046052509d0eee9b72e11d0e8ae31b665f:
> 
>   Merge branch 'rzn1-a5psw-vlan-port_bridge_flags' (2023-08-11 11:58:36 +0100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2023-08-11
> 
> [...]

Here is the summary with links:
  - pull request: bluetooth-next 2023-08-11
    https://git.kernel.org/bluetooth/bluetooth-next/c/3d3829363bf7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



