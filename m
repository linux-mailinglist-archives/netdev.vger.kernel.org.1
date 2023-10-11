Return-Path: <netdev+bounces-40139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE48C7C5E8E
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 22:40:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77811282635
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 20:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F8981BDF8;
	Wed, 11 Oct 2023 20:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tD727yjU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306CE1BDF0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A705FC433C8;
	Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697056824;
	bh=dATi6SPbmsK0LyfUa10RJymcqKJG8ssjHMQLlLmvz9k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tD727yjU5klHfhmEJXhbH1ASzu6q1/7D8bRfMrrQPHro+f/qgk1ljYHlJGiVPZ+/Y
	 EfqDMxJztsfdsBM8yksiGw5r9xOxVfQReJJPJQWVwwqNLnwFT9aSoHGS+dBV3AMywD
	 x+xMmgCgC3ofnqiezt89raWBNRECSylEdN9W5c/Ykf0ccyrKWd4V3qxyg5lIo/e7bI
	 vZKSlOfEjy0E8JG2rLWAqKsq7ntx1N+00fGbokwtrq1BohPrE9ag434H4FVCpVrEp1
	 sQBtLqKdWCIndGPDx70MWqaSt8xt0owGpPJp5OBFYJ5ACc0gPq82/GMRvn9ZZP83EP
	 VOGiwGMNDkmxg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 929B3C595C5;
	Wed, 11 Oct 2023 20:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: use ynl-gen -o instead of stdout in
 Makefile
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169705682459.25671.5732476278583655578.git-patchwork-notify@kernel.org>
Date: Wed, 11 Oct 2023 20:40:24 +0000
References: <20231010202714.4045168-1-kuba@kernel.org>
In-Reply-To: <20231010202714.4045168-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 13:27:14 -0700 you wrote:
> Jiri added more careful handling of output of the code generator
> to avoid wiping out existing files in
> commit f65f305ae008 ("tools: ynl-gen: use temporary file for rendering")
> Make use of the -o option in the Makefiles, it is already used
> by ynl-regen.sh.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: use ynl-gen -o instead of stdout in Makefile
    https://git.kernel.org/netdev/net-next/c/cb7fb0aa3cd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



