Return-Path: <netdev+bounces-28693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA2A780436
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 05:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC7322822CB
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 03:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681879E4;
	Fri, 18 Aug 2023 03:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB700380
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 03:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 39BFFC433CA;
	Fri, 18 Aug 2023 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692328222;
	bh=vejoCbByuD05t2z59HGrF8afSXw487/jFTp8aOWamsY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lyQ9CXQfERgvWAqEmtDbH+wN61tkyXI3AeJ/xQJY02F2ic2sKQ3iV01sD8AxJ6Ki/
	 XOvZg4O3wtMaJ8Lf9Ro2QDERDzlX4wcE7ENHH3H0KwtaqXKU7q/WUoJ9ZLR2rvnTR5
	 ylT1rbxNHBrZRzzzvoQOPCIyRw7PGdUlGw7y+TRECo1chFPyX2bH03l9NOPFd8SQ0Z
	 V0idCB2f2R4vWm+KcWLTfOJJvv9t8aykxTAujSbBAX2Z8lp4TIsrYKgyMB71XwXbde
	 hfbKFM4NiKLJ06nADApmwDga/dPQhwQlQrLIXyCcc/jXtv/ZuuSnwMHZe6aWExtQw3
	 pUbio/APhGgIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1FE73E26D38;
	Fri, 18 Aug 2023 03:10:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v6 0/2] netconsole: Enable compile time configuration
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169232822212.13423.2096693792687967762.git-patchwork-notify@kernel.org>
Date: Fri, 18 Aug 2023 03:10:22 +0000
References: <20230811093158.1678322-1-leitao@debian.org>
In-Reply-To: <20230811093158.1678322-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: rdunlap@infradead.org, benjamin.poirier@gmail.com, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Aug 2023 02:31:56 -0700 you wrote:
> Enable netconsole features to be set at compilation time. Create two
> Kconfig options that allow users to set extended logs and release
> prepending features at compilation time.
> 
> The first patch de-duplicates the initialization code, and the second
> patch adds the support in the de-duplicated code, avoiding touching two
> different functions with the same change.
> 
> [...]

Here is the summary with links:
  - [net-next,v6,1/2] netconsole: Create a allocation helper
    https://git.kernel.org/netdev/net-next/c/b0a9e2c9a99f
  - [net-next,v6,2/2] netconsole: Enable compile time configuration
    https://git.kernel.org/netdev/net-next/c/fad361a2ee90

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



