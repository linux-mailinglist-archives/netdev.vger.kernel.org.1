Return-Path: <netdev+bounces-52815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D0B8004A2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 08:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEC3DB211A6
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7BF15480;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQQKBNIQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B01112B96;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0FFB8C433CD;
	Fri,  1 Dec 2023 07:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701415227;
	bh=0ApF4fRGZ4qM+hhJ6sGk60WZf3K0anlzYkqsF7HkF3s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AQQKBNIQ4QXWPmP6VDwdIOtysS5lYLn4CL++7RMS/zuAi8vsPqsar5FU6+w3vPkpG
	 /FLtT/uBA5qWBe+2LmiIJTxThOXx8W5TDGj3rF5XF6blD+pDbkqsr87sV1uyvgCXuU
	 z3Aanc9LZN0/JLlE3IiCLnsEP9am3Hk9Lfb6XYsg9zECocButGVc75jG/15txUu+5s
	 DjVACkYak+69uKUP7iZGkuEI6fZg6adm+0U7rYygOXktHgvsPEH1x5DELmrj21D34W
	 dcWEpwQOTy+gbWTJ3thOlbYy32GYCB7IEJP2XAkIBCohYhUi5OaAgMehZsY40ywB00
	 C1l45kMFLgV7w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E8D8DC73FEA;
	Fri,  1 Dec 2023 07:20:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] docs: netlink: link to family documentations from
 spec info
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170141522694.3845.15711152666700729703.git-patchwork-notify@kernel.org>
Date: Fri, 01 Dec 2023 07:20:26 +0000
References: <20231129041427.2763074-1-kuba@kernel.org>
In-Reply-To: <20231129041427.2763074-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, leitao@debian.org, donald.hunter@gmail.com,
 corbet@lwn.net, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Nov 2023 20:14:27 -0800 you wrote:
> To increase the chances of people finding the rendered docs
> add a link to specs.rst and index.rst.
> 
> Add a label in the generated index.rst and while at it adjust
> the title a little bit.
> 
> Reviewed-by: Breno Leitao <leitao@debian.org>
> Reviewed-by: Donald Hunter <donald.hunter@gmail.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] docs: netlink: link to family documentations from spec info
    https://git.kernel.org/netdev/net-next/c/e8c780a57060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



