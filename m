Return-Path: <netdev+bounces-23456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46FF176C038
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:11:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77BC61C21057
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A65427736;
	Tue,  1 Aug 2023 22:10:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8800275C5
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:10:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 203A6C433A9;
	Tue,  1 Aug 2023 22:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927825;
	bh=OB2BuILBrB63J/2p/HPepeCW+Ln+vVokGPAj+8DheL4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=F78ksUcZ6BGfvdIcssrqfNnVa2T2ThExePQ6d7WYtg4+9oNMTD2+6lDfqm7YmauoF
	 0lYxaT36UM0M0Z47TRrL3P7JsZyjh72X4YdAPrXcMEn1wi/I1Xw0cuevMkRm+wrFEs
	 2zMsGBu5RUsNQ50JAUiVWNP2nOTNH+0asHLd8Ds5/l8eEjUlSwNAkJB5ucL0H2QcZB
	 /cjWK4Tt+AdaQTVF+jPMKSFPk973s0E8n4Pt6OQPEETxHqyjxpeedPDakWKNboDDEW
	 KugS25Wj4CYAkFzBJTX37NVh1E2HsvEp8IvcbPllr13FgfU1StFpdi0/oJnuy7h/Jw
	 oUpYMrpErcDzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B1B9C691E4;
	Tue,  1 Aug 2023 22:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: make sure we never create ifindex = 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092782504.18672.1715588793858109062.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:10:25 +0000
References: <20230731171159.988962-1-kuba@kernel.org>
In-Reply-To: <20230731171159.988962-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, stephen@networkplumber.org, leon@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 10:11:58 -0700 you wrote:
> Instead of allocating from 1 use proper xa_init flag,
> to protect ourselves from IDs wrapping back to 0.
> 
> Fixes: 759ab1edb56c ("net: store netdevs in an xarray")
> Reported-by: Stephen Hemminger <stephen@networkplumber.org>
> Link: https://lore.kernel.org/all/20230728162350.2a6d4979@hermes.local/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: make sure we never create ifindex = 0
    https://git.kernel.org/netdev/net-next/c/ceaac91dcd06

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



