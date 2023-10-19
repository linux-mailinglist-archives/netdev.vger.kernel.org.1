Return-Path: <netdev+bounces-42478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA217CED76
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 03:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 718F1B2117A
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4663964F;
	Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7yRsKdm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2701F394
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 01:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EBE3BC433BA;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697678425;
	bh=CNs0BKDEjfOa2gcNkk744AMJR6d0l87ZEc8H5ukVQ0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O7yRsKdm44uB9FCtS4JFnCgTBJ9fWQKDSpcSlFOE8AMjXmqHambnuwV4AhXKtYtpu
	 p+OxYZGIWmMuvVq2V8kFJcaKbSV1z0xsLunTtJFDtzClugIxwNvH+Ck9UeAf380HdZ
	 zMQCr/aa51aL3m3owfGbWnuQff4hThHOZM8HP2P5XgYHAZ3V2hxYJgH7N8RQb8AEap
	 QNQjRHIUTE35f4S1pIlMMSivS4iuhbKricMFLgW4uTAh3vUcPWx2zS2lb7YWlsaEGv
	 fYrFB7Lz9cR+PgFnrgSMIWcw76G7yOx3MbMz7QMOorTkavdv/hX0Tm1aoeGM1Ybyf0
	 o+XoaiMLQScqA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BCC78E00084;
	Thu, 19 Oct 2023 01:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-10-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169767842477.18183.16659092882709250447.git-patchwork-notify@kernel.org>
Date: Thu, 19 Oct 2023 01:20:24 +0000
References: <20231018071041.8175-2-johannes@sipsolutions.net>
In-Reply-To: <20231018071041.8175-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 09:10:42 +0200 you wrote:
> Hi,
> 
> So we have a couple more fixes, all in the stack this time.
> 
> Unfortunately, one of them is for an issue I noticed during
> the merge between wireless and wireless-next last time, and
> while it was already resolved in wireless-next, the issue
> also existed in wireless; as a result, this causes a merge
> conflict again when merging wireless and wireless-next (or
> obviously net/net-next after pulling this in, etc.). This is
> (pretty easily) resolved by taking the version without the
> lock, as the lock doesn't exist any more in -next.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-10-18
    https://git.kernel.org/netdev/net/c/88343fbe5a13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



