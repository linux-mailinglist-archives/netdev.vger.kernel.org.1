Return-Path: <netdev+bounces-204977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 036D7AFCBB3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC403BCA4D
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 13:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610332BF001;
	Tue,  8 Jul 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YwoB7yKW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 392AE2676DE;
	Tue,  8 Jul 2025 13:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751980783; cv=none; b=XXAIK658q7au83Sxi1Tk0Ys0zOxh/eDFiAJF1NbOiZ2jbkKPUEX77mPHJhg/DS4ELc2xdJjpV/XQkUmJ1skNSJj6aJpg7y+2b81gF9VRWfTp56EXwsx4IGHOz4GWd4/1Mpz7Kuu10nKRVctc9ddf3PR37f7bfo5XifWtDI+S8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751980783; c=relaxed/simple;
	bh=F8c977p8EYNxBipgtTYkpJqxcsMaCXY02NkkHhb48wA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=juAxWQF9ptyXymGZdgy1AXbT/0l9IGKqk//WZfRNpRxH0q4yo2zCk2ExC5ujWLGGkJJMMS93ecF5RO3COZQtGI6HZ9ficNpbfwyFAZhYt6URBSbey2UKQQaQLpKR4jpqmmRXpxoxvfx4l5Hi1R51L6xe8kRdnjMV/m5pxc9hRcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwoB7yKW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E2EFC4CEEF;
	Tue,  8 Jul 2025 13:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751980783;
	bh=F8c977p8EYNxBipgtTYkpJqxcsMaCXY02NkkHhb48wA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YwoB7yKW3QUO2FzQanytUBu9kfvxqaoId32M/Czoy8Wwki7HmPmAasBG/Buiy/bpD
	 eLxpNsYnEQ4PuwQLTmOk74arqEan2BDaEjFxlNjD5aaiIcz7Z/kSoL2AQROnIilFt6
	 5zFt3g6NXuFhKLcN12tnBa1xiKx84lQYU/9VFyf/J60xJWni22J8OLaYtgs1kndzlG
	 X/0pbYbhoCLNL+Aeir72i0sUETwEpn59usTC1sRzBL+W2z03k23MZfIQqCtOp7AUJX
	 1TjEHqdUjZEaDb7aedsngeFhiiJfdf+QbhVCVto+4UPjRjMlv5H6x49hI2qaVhQ6Xp
	 cRrD4nDHrrNmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A99380DBEE;
	Tue,  8 Jul 2025 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: replace ADDRLABEL with dynamic debug
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175198080601.4063193.10235961533622301288.git-patchwork-notify@kernel.org>
Date: Tue, 08 Jul 2025 13:20:06 +0000
References: <20250702104417.1526138-1-wangliang74@huawei.com>
In-Reply-To: <20250702104417.1526138-1-wangliang74@huawei.com>
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, yuehaibing@huawei.com,
 zhangchangzhong@huawei.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 2 Jul 2025 18:44:17 +0800 you wrote:
> ADDRLABEL only works when it was set in compilation phase. Replace it with
> net_dbg_ratelimited().
> 
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---
>  net/ipv6/addrlabel.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)

Here is the summary with links:
  - [net-next] net: replace ADDRLABEL with dynamic debug
    https://git.kernel.org/netdev/net-next/c/5d288658eec1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



