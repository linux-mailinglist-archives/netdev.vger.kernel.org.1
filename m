Return-Path: <netdev+bounces-55822-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 069B980C610
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 11:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35B6A1C20A6A
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 10:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F232576D;
	Mon, 11 Dec 2023 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dYw1vjqQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E622320
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AEB18C433CA;
	Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702289423;
	bh=ffn8uW06JTrptlAAlDI07539aIHmkGLZC3SCDTDmUlU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dYw1vjqQ+oeyEu8j4U68mkRREvxt2WCSaV/rPMAJTc/JVeT7yshGxQEm2T6HT+wSh
	 jdh8vUXxfTioQloajvsrkz5OBXJT/bL6MaBzvCA1S8/fQl0BGYzvcktZ5ByerjE9Z6
	 SIcdzAeSIbC2Su0M+J5RqUXGQemy/CYE0In20Gbp2JAYHcRUyscBI4yZzHRb4hsLn6
	 bc0PQmpezmvMvj8ukOpKMF8DpgT29dhNlZYP6NPAOtcPt/PRboV5YJ+gfedvw4V8FE
	 QSRJvrfnWiaHjQ9R6Uo5pQyDNa3m/HE9reDTciXcqFTTxn5itEFcfYN2ec5fq+5C+D
	 AL+i6PSiTFHWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 96A3EDD4F10;
	Mon, 11 Dec 2023 10:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net 0/2] octeontx2: Fix issues with promisc/allmulti mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170228942361.26769.3231506778434195901.git-patchwork-notify@kernel.org>
Date: Mon, 11 Dec 2023 10:10:23 +0000
References: <20231208065610.16086-1-hkelam@marvell.com>
In-Reply-To: <20231208065610.16086-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
 davem@davemloft.net, sgoutham@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, lcherian@marvell.com, sbhatta@marvell.com,
 naveenm@marvell.com, edumazet@google.com, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 8 Dec 2023 12:26:08 +0530 you wrote:
> When interface is configured in promisc/all multi mode, low network
> performance observed. This series patches address the same.
> 
> Patch1: Change the promisc/all multi mcam entry action to unicast if
> there are no trusted vfs associated with PF.
> 
> Patch2: Configures RSS flow algorithm in promisc/all multi mcam entries
> to address flow distribution issues.
> 
> [...]

Here is the summary with links:
  - [net,1/2] octeontx2-pf: Fix promisc mcam entry action
    https://git.kernel.org/netdev/net/c/dbda436824de
  - [net,2/2] octeontx2-af: Update RSS algorithm index
    https://git.kernel.org/netdev/net/c/570ba37898ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



