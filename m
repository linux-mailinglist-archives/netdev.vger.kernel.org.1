Return-Path: <netdev+bounces-20731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AA0760CB3
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 10:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7DD1C20D14
	for <lists+netdev@lfdr.de>; Tue, 25 Jul 2023 08:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F107A13AD0;
	Tue, 25 Jul 2023 08:11:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F59111AF
	for <netdev@vger.kernel.org>; Tue, 25 Jul 2023 08:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08853C433C9;
	Tue, 25 Jul 2023 08:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690272693;
	bh=Hsq1BTa1Ec9/kLW6xNjo47BpeAL4q6A/z/L6FcGo7uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iMcHIcH3D0wstzCnp9RZxEgaYKp3otMecmcbhmGPEvPJADMWfLaNzjAKGl2j2Y8k/
	 rY/8rKYj+8F6BCwN9LQmKuwJNZNpLurtzMXOxHkGZgKy5cPkqQN5UeSKhRunAZBii+
	 QvqCqgp10Hnm0aocsPQU6siC8ylQYyvA19E2PN4pn5DJ3/PJRYqEXZQLhqmW6NMphA
	 /Ivh2Y7I3uhnZ1h8eXJReXbjlm4ThwoltgwgM3LgbxrQW96XS1xWZLSFqXbuIRVcns
	 hJmPIfwxZWTEto94RUjP7c9ThLJC0MkcgWsTfH3i7ffD76JoXwh/oxjET9quMJf/6y
	 0syx/nQQmoN3Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E06A7C4166D;
	Tue, 25 Jul 2023 08:11:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH V4] octeontx2-af: Install TC filter rules in hardware
 based on priority
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169027269291.22574.17481774547860913294.git-patchwork-notify@kernel.org>
Date: Tue, 25 Jul 2023 08:11:32 +0000
References: <20230721043925.2627806-1-sumang@marvell.com>
In-Reply-To: <20230721043925.2627806-1-sumang@marvell.com>
To: Suman Ghosh <sumang@marvell.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lcherian@marvell.com, jerinj@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 21 Jul 2023 10:09:25 +0530 you wrote:
> As of today, hardware does not support installing tc filter
> rules based on priority. This patch adds support to install
> the hardware rules based on priority. The final hardware rules
> will not be dependent on rule installation order, it will be strictly
> priority based, same as software.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V4] octeontx2-af: Install TC filter rules in hardware based on priority
    https://git.kernel.org/netdev/net-next/c/ec87f05402f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



