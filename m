Return-Path: <netdev+bounces-93162-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 206BA8BA535
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 04:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0A5D282A1E
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344D91B94F;
	Fri,  3 May 2024 02:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NZCm8Mmn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFC9175BE
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 02:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714702230; cv=none; b=BU9N7zsXDnVNzglINJ7miamM9ICIKcMGeyOo9UlRWbPQFdbEFEbK5g5UBbyMVF1OLjG2gg66YWQ56RVkNfQivs0PnIrqyz4t1JKfMH9k6zJHCSbVfZOpok/XXHc1VGH6TbSJ87vkEQ2UcduhfVQuzMBaWaRILOSUF5lnrr0yAR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714702230; c=relaxed/simple;
	bh=emXmMiWUSey8zWPLIjmAhqNT1WnnpVHBYWdZLFmDjbE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B878dUlEHNgwGbk9cChKhYf5VVUlAdQ2U7a74ryOPNLuwUiHMMt3L/Ytdhz10pYKzPL80DmLcvco727sD1J99Aa7WR5AURwl4LmIz7sZeqUDoc/rJeDvQq4DbL04cZDYUb+LC/Ku/79t6IlSmbWCHXNZqFe5n0jrTM57opEBa8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NZCm8Mmn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A5BABC4AF50;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714702229;
	bh=emXmMiWUSey8zWPLIjmAhqNT1WnnpVHBYWdZLFmDjbE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NZCm8Mmn40JHBXabZpwvNvu99wr8NfaLVFufPZFkYoiTSuTwueh7orXr5jqtjtlZb
	 g6Xw574Xgc6pmiUz9gwUAoYMVBYd4OXwIoK+m3PR+xJDrsfVAY9QaLtyYuo1eH99P/
	 3TQI9qp7GVWKIaKeMAhuYsPfpswmIiU4CbHvf43lf9XQlslZnsZZn4wlH8uPAeZixr
	 ViCMZyw+dsq9GstR2UXhccMreWEJxlndVApoUkbcNbnC6IjX7J/Ift1IC/A6Ud1vaA
	 QLVN8gcfiM22YhdsXFcCU0bIlWwdgm67ZYt6F6UxiwdG1uj2cO2SF4CfA5+/ubT16Z
	 UvcUatByoP1xw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9AF58C4333B;
	Fri,  3 May 2024 02:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: dsa: mv88e6xxx: Correct check for empty
 list
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171470222963.28714.8387425953604501803.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 02:10:29 +0000
References: <20240430-mv88e6xx-list_empty-v3-1-c35c69d88d2e@kernel.org>
In-Reply-To: <20240430-mv88e6xx-list_empty-v3-1-c35c69d88d2e@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 dan.carpenter@linaro.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 30 Apr 2024 18:46:45 +0100 you wrote:
> Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
> busses") mv88e6xxx_default_mdio_bus() has checked that the
> return value of list_first_entry() is non-NULL.
> 
> This appears to be intended to guard against the list chip->mdios being
> empty.  However, it is not the correct check as the implementation of
> list_first_entry is not designed to return NULL for empty lists.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: dsa: mv88e6xxx: Correct check for empty list
    https://git.kernel.org/netdev/net-next/c/4c7f3950a9fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



