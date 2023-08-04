Return-Path: <netdev+bounces-24476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 148C577043D
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 17:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB964282705
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 15:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BD915AEF;
	Fri,  4 Aug 2023 15:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B177015ACC
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 15:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30D0BC433C8;
	Fri,  4 Aug 2023 15:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691162423;
	bh=TiLIr69A5Q5llq+A4lhw3lgA5vk7zpCOCiCVOfo4oIE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rzQu9HJT/2pvuVl1C8kRf/QiTjZWrYtO5PSueT0RZUnMdVZcM7GLgbuT57Vw81c6T
	 kp0JF7uBOI+L52Zpp86jgdsELzA5TajI0qBVaU3fpq8f2HJpNhyg2HuimJkrOJw4EO
	 ggG8MMJHpfJhHj3jyB6q4K35CRgdngZ7nLahLHQBQATLqHyHmvzZG42Qhsk30QveQI
	 y6QyQG4pZ05XEGRIQvHZYkzZvC/QejE92fPdyY226/IuoWWmTDu9Hg4PfpkGMV98IB
	 jjhHlnGNihWATppuw58B7RrxJRE3v0LSYJN7ppezoC0Q7F+yMM60PkeqMWAdSclJVh
	 NkwpXzmUqtF1Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1623FC6445B;
	Fri,  4 Aug 2023 15:20:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 iproute2-next] tc: Classifier support for SPI field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169116242308.18058.4208875314108054288.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 15:20:23 +0000
References: <20230802154941.3743680-1-rkannoth@marvell.com>
In-Reply-To: <20230802154941.3743680-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: dsahern@gmail.com, stephen@networkplumber.org, netdev@vger.kernel.org

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Wed, 2 Aug 2023 21:19:41 +0530 you wrote:
> tc flower support for SPI field in ESP and AH packets.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> ---
> ChangeLog
> 
> [...]

Here is the summary with links:
  - [v1,iproute2-next] tc: Classifier support for SPI field
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=8cff77fdca12

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



