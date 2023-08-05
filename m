Return-Path: <netdev+bounces-24616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E257E770D26
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:40:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D4661C212CE
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:40:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373DB15B1;
	Sat,  5 Aug 2023 01:40:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CC57E2
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B059C433C8;
	Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691199637;
	bh=XCUr0dKLtrl7HBjElkry07NJ5TXTAWpkkaBV01A/jLE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=No7vnOczUirzs8/P4M1lt4AAIktAT+xRVMsgaUhEGSk1qapBf8V3NGo2MfEilYouD
	 rDxSSePv+fJiQ9dx6rFtwkM7IT+9ud3Vl6I5AFNy+QBVIXqzDZTi8hJ6YT7GpX9+cT
	 +lwfu0aYXuv80pJPDy3z4G+KBGkwR0YnGngoHqaq6Jio5KFnZfl4Wrm5LBnkz5GcUW
	 p95ljyvzAh/7jdVEWma9fPJjUjiAF2h0zrMSGJu7tiW4dXNO+3YR57qIs04Fq7Srih
	 xssgjl9IRR0AzKccmIUmX8nb8+RD/aufQZjAGE0qISNdou5ZtRknB054OGislZVgNE
	 iT4H77GAvG+2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A345C595C3;
	Sat,  5 Aug 2023 01:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-08-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119963742.24799.10292849293616747808.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:40:37 +0000
References: <87msz7j942.fsf@kernel.org>
In-Reply-To: <87msz7j942.fsf@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 04 Aug 2023 15:16:29 +0300 you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-08-04
    https://git.kernel.org/netdev/net-next/c/81083076a007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



