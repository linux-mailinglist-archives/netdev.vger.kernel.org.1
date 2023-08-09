Return-Path: <netdev+bounces-26084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A10776C1C
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 00:20:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3F5E1C20EB5
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 577951DDE7;
	Wed,  9 Aug 2023 22:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B001C9E1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 22:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86B20C433C9;
	Wed,  9 Aug 2023 22:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691619622;
	bh=csBWtvwRbziRdxXRRnz5SOtm+ubyZCH8dAcQRA2YSf4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=j3wDx3jIccsCix+gjp9pjIk9/U2nIBAWzHzCiKB0kVlyqf0FQAoTnR2OImegmR1Si
	 U1jv312VeTKRkY/kzkeqtbg+UUvKVqMAITQnrGCI76bnbDYCRUT+YzTvZe3nethL0C
	 TWSPyNPiiSJtKYvhg6nu7UsLIP5S/f/ituA6QUMSQOAWISV3qSehIb/ej7xnpFd1ic
	 5W96T6+4cNnKAfdHcoSyK2j5JwRtfRykVXMSU2MMbq0/VGaYWN+913qkhfpaJTxR8i
	 chcFC+yBTu4yCEgNw/Xjw8vUHcnkDtP7klMEZdMSAoiczuPttm769zWItKK8VvHOGg
	 6kMzici9/fAYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A744E3308F;
	Wed,  9 Aug 2023 22:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-08-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161962243.15093.7034192084083040541.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 22:20:22 +0000
References: <20230809124818.167432-2-johannes@sipsolutions.net>
In-Reply-To: <20230809124818.167432-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Aug 2023 14:48:19 +0200 you wrote:
> Hi,
> 
> So I'm back, and we had a security fix pending for an
> issue reported to security@kernel.org, but Greg hadn't
> gotten around to applying it, so I'm handling it here.
> Also, covering for Kalle, some driver fixes. Since we
> want things routed to the right place I also included
> a couple of maintainer updates, but to be honest now
> I'm starting to have second thoughts about it. Oh well.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-08-09
    https://git.kernel.org/netdev/net/c/15c8795dbff8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



