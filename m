Return-Path: <netdev+bounces-173882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F279A5C183
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EED223AA8A7
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1666255E37;
	Tue, 11 Mar 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGTUr/Db"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955A523645F;
	Tue, 11 Mar 2025 12:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696798; cv=none; b=VvyOaRI1aVxmgBOCFPdv8yc+sOQ+LSXM1fRYJCpRTyU0IHu+w5C02K6dgvm5TPSFfkf2Mq6EQWJBn6SmmVqjRGVu/zuAkHE+osDXUPDlX7kNBGS5rS16yTvCqmyIGb3jEtTRIfWDRCYQ01mCDiALDHuBuYp9ifD53TDtU3B44Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696798; c=relaxed/simple;
	bh=QHwchZdS8Fx6znfWcSG9A9XrRlYiMGvm1z1sG2KpEiM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MOMDiKpGa0Bp6Gke8N6GXkOjMn5xjtgoYKfX7ZZ2XXqs4dzh3R1HiUjPCNLh2ZIoNlnqS+p9UkVCAWjBbiuBKH2o07gTLevKuqupKm3EgeY1EDZJ0yyhUxmkDm3ngnzDAyp6RNMKS8gA56tRNhaZwa2BYhtYocIGCBQ9OTYgVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGTUr/Db; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F68BC4CEE9;
	Tue, 11 Mar 2025 12:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741696798;
	bh=QHwchZdS8Fx6znfWcSG9A9XrRlYiMGvm1z1sG2KpEiM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kGTUr/DbcleBYh4tuDbd/C/hNPcEiqmJLOkHn/e4McdGGWq4d5YbmU1y5lAusd+Zv
	 SwL8BdIDv0NFO0Zrm8P27Jek0fgsjm2fdDSwXyD+VQjae4sBbl6KxQXfi20HlqkN06
	 BxFgpF4tNrrQxDJxtVm3CR0z9Xsm5+VyShpUbP3/je7X7G7BhN4JnHVPF1Kd1SoIiJ
	 0MNRAnDOp3+WdT3VZVjR79wqvkWOmSJC96Kf+z+Vsym4dw/eQispSDCu2UPo57gvDU
	 PKyoheE4podced/ZbvaYOIDtrLjQsFHV09NP9tVbNliJLC2hupd18L1DtCY0iUGPV3
	 QUYQFXh5a1bwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70B46380AC1C;
	Tue, 11 Mar 2025 12:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] docs: netdev: add a note on selftest posting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174169683226.69619.6026876663171562977.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 12:40:32 +0000
References: <20250306180533.1864075-1-kuba@kernel.org>
In-Reply-To: <20250306180533.1864075-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  6 Mar 2025 10:05:33 -0800 you wrote:
> We haven't had much discussion on the list about this, but
> a handful of people have been confused about rules on
> posting selftests for fixes, lately. I tend to post fixes
> with their respective selftests in the same series.
> There are tradeoffs around size of the net tree and conflicts
> but so far it hasn't been a major issue.
> 
> [...]

Here is the summary with links:
  - [net-next] docs: netdev: add a note on selftest posting
    https://git.kernel.org/netdev/net-next/c/0ea09cbf8350

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



