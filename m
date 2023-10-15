Return-Path: <netdev+bounces-41077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 161D97C991D
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 15:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE195281850
	for <lists+netdev@lfdr.de>; Sun, 15 Oct 2023 13:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892106FC5;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZcGzpkBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5276FB2;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 28ABAC433D9;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697376624;
	bh=pS0gakAmkGXWfwWOHapujcu8RZsQzfyFuRVpzEMQnDY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZcGzpkBBj/mJD/450Hz6T9qxBjBL22Pnnxpuq37cBKj+GmsJrbc83CTbGQPDOwOVI
	 hSxt7mmqMOW1i0g54FXKALhlcw9LwYWJEe51TqonWog5KvK5440M4VvZDRH/ry3hOF
	 9TS56sGoIjcMiSye3FXkVWwepF5AnSOtoGwGoZ8oF4AAZNwOa+LJHCDXYmL0Wcb0p0
	 wzCvsdMDu+EijnEpGVqtV9oPm9gRziMGwbqg8unzkHQVAXbMiM5ONNE1KaBVE3TxcU
	 8bVoCSYcQcZs/1D/nQ08f3kt4n/CwbB4Dv7bqOaerdfu6Vu9P8FSoZ6de02evMaUu4
	 qZLusOaZl9cTg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 13A75E1F666;
	Sun, 15 Oct 2023 13:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] docs: try to encourage (netdev?) reviewers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169737662407.24568.3374449097895161500.git-patchwork-notify@kernel.org>
Date: Sun, 15 Oct 2023 13:30:24 +0000
References: <20231011024224.161282-1-kuba@kernel.org>
In-Reply-To: <20231011024224.161282-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, corbet@lwn.net, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org, andrew@lunn.ch, jesse.brandeburg@intel.com,
 sd@queasysnail.net, horms@verge.net.au, przemyslaw.kitszel@intel.com,
 f.fainelli@gmail.com, jiri@resnulli.us, ecree.xilinx@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 10 Oct 2023 19:42:24 -0700 you wrote:
> Add a section to netdev maintainer doc encouraging reviewers
> to chime in on the mailing list.
> 
> The questions about "when is it okay to share feedback"
> keep coming up (most recently at netconf) and the answer
> is "pretty much always".
> 
> [...]

Here is the summary with links:
  - [net-next,v2] docs: try to encourage (netdev?) reviewers
    https://git.kernel.org/netdev/net-next/c/6e55b1cbf05d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



