Return-Path: <netdev+bounces-13246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E40F73AEC7
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 04:51:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB0442818D6
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 02:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C318139B;
	Fri, 23 Jun 2023 02:50:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6DC7FC
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8EA54C43391;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687488626;
	bh=sDFv30dGg7EfZAzWSqSQ2hBGiMPx8UYU1hFHRYt/9lw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OCjE/joJNLkCkbIR3Y45iRj87aZtkh4VYQhbQjJjn0g8VBQXzftEPWnLI73Ob3EnJ
	 eik7DJsEFTjeNWuVtdJ/91nY+dHpu5u5ZzbH+Q0vs8Or6UUvxrdwFMb9TTzS1bJMJu
	 1cyVDr/Djd7WrLbrDXQEqCKgeHhWTVI1wJPSEIfS/1DQhweb5FLKIyAlJTmTr7rb6k
	 XadmC2RH66EmhzOszj3pPAK6KOWMLjWCkfDq9Va4hhFTiQrhbS2j8M0rxj4nJwbbl4
	 VEqLtm5qlmLc+g5ghEXVLDohbn7WJcaNAlqOZ07eEJDOjYsqyyAJEFhUKpt5oO/HGp
	 hFZQ9LM2dykyw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A038C691F0;
	Fri, 23 Jun 2023 02:50:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] tools: ynl: improve the direct-include header
 guard logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168748862643.32034.586420294417192683.git-patchwork-notify@kernel.org>
Date: Fri, 23 Jun 2023 02:50:26 +0000
References: <20230621231719.2728928-1-kuba@kernel.org>
In-Reply-To: <20230621231719.2728928-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, przemyslaw.kitszel@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jun 2023 16:17:19 -0700 you wrote:
> Przemek suggests that I shouldn't accuse GCC of witchcraft,
> there is a simpler explanation for why we need manual define.
> 
> scripts/headers_install.sh modifies the guard, removing _UAPI.
> That's why including a kernel header from the tree and from
> /usr leads to duplicate definitions.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] tools: ynl: improve the direct-include header guard logic
    https://git.kernel.org/netdev/net-next/c/0c3d6fd4b89c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



