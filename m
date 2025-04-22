Return-Path: <netdev+bounces-184574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B761A963C7
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28CE63B2161
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 09:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE9225A2D7;
	Tue, 22 Apr 2025 09:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OcZ9E0C4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCA225A2CF
	for <netdev@vger.kernel.org>; Tue, 22 Apr 2025 09:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313019; cv=none; b=RiMWX7gJLlydMi3YkrbUdI4HU0ksiBdZxqKwq5XIjZ/+6R/YTX5EMGBqhWrcuhzdQubgST9HnCtX6D/H84l2CBMK8gp+VQXgmDrwAVc88UEtS+iwWprHKxavclvhWxA4hsKmbvG8M+qYxekYiRAXyQANYvkZ8+/fXqSxUnuTpNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313019; c=relaxed/simple;
	bh=fMg9Mjm8L1M+h1nTGfogMr1vaYIim+cL4phnPQZrObA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qHYBHPKhRr4W4Pxum9jEREF8k1P54aq0N14MhPKcHgN2Zl9BHkz2lQ4clzHLIu0Bl6WnH2SnNvsIH16vplb/j9wMCXuatGOuA+1YgN9pdQNLRuQps7TG5ElkWdINLnz1RXlkcPx6O4LQGSqNiQdjS6IbH6AmQXocqzEm8AuZPpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OcZ9E0C4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568BDC4CEEA;
	Tue, 22 Apr 2025 09:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745313018;
	bh=fMg9Mjm8L1M+h1nTGfogMr1vaYIim+cL4phnPQZrObA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OcZ9E0C4ywYXsVoucvptq9qeoU+2UpQR8VZzOHsV6zY6uG1HuOMCCDdzmClrZvKSz
	 ihU+STjQYdxRaydH+t1W5bs6FEZFSdT8+rfAd4Bav/fHYWKu5PggbWlARCMgJoRtEP
	 zrWvLMqhtLuBViNQ7AQj0ah69lddpOHmu9G0iEqTRSsU4WscJ8dmYCv0jjyxg/oRWD
	 PBzQnkn3p5bz6cTjVGe2EJcRap/uKSNQpV9IKiWScUTAO1iQotcTyw4qeqyww7KkAA
	 o73+67RKGZb36OFosLDWye5PmQb+558pE5OKAYWboQaNeTXjmMfZoQsTbDxj9QKteM
	 MH88V0j4/6wUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD4C39D6546;
	Tue, 22 Apr 2025 09:10:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl: add missing header deps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174531305649.1477965.6253645708222412732.git-patchwork-notify@kernel.org>
Date: Tue, 22 Apr 2025 09:10:56 +0000
References: <20250418234942.2344036-1-kuba@kernel.org>
In-Reply-To: <20250418234942.2344036-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 kory.maincent@bootlin.com, donald.hunter@gmail.com, jacob.e.keller@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Apr 2025 16:49:42 -0700 you wrote:
> Various new families and my recent work on rtnetlink missed
> adding dependencies on C headers. If the system headers are
> up to date or don't include a given header at all this doesn't
> make a difference. But if the system headers are in place but
> stale - compilation will break.
> 
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Fixes: 29d34a4d785b ("tools: ynl: generate code for rt-addr and add a sample")
> Link: https://lore.kernel.org/20250418190431.69c10431@kmaincent-XPS-13-7390
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl: add missing header deps
    https://git.kernel.org/netdev/net-next/c/12b196568a3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



