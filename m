Return-Path: <netdev+bounces-210183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B20B12431
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 20:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BE7A1887D2A
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 18:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD08F253925;
	Fri, 25 Jul 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tLpSx0ua"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E39252906
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 18:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753468796; cv=none; b=TIKUMTWu5xlQEosL8mJ1EkTIe86pfRl6wb3LdtIM9O5Ui+/HSq6QjjhtbS86uXuUVsdKYMmWkV45KuKSOYY9HTKX+TQANRfeWtsuNcUGf+D7ELwPtMhWEmQlWU33yn8FPzAJC4gJuaA7DXTznV8CnuCmA9peinh0bggn8jjtYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753468796; c=relaxed/simple;
	bh=n5tD7DEnflzkYZYWl/5R90OifcJEhtbRPTBghCE0RlU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J/y1DjnXZ48INwOLyl+PpM74c4YkI7oG+P31t1Nt7yL4EsjWbYzhgllQjPcq1kMMMsNdowMeF9I9jVToBFE0BRMClvf0l67Sgpnx8Es89na5xEtEv4Ih2nu4l1yND9Vi1cHSMFo6gN6/w9S+69nHqU2BfjcwbDa9lcisfNPWW6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tLpSx0ua; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E10FC4CEEB;
	Fri, 25 Jul 2025 18:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753468796;
	bh=n5tD7DEnflzkYZYWl/5R90OifcJEhtbRPTBghCE0RlU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tLpSx0uaIBdghXpAKJ6sRIZ83ZyAwjt2nf/kv47x5WD+KpIiY+2lPceOyIe+nUsJo
	 4Cx6axx+NPW4UG7UhF7SBzwtX/UKXRd04ngL2m/KPqEJL7S9pWVy058dgKQE7fwxfX
	 ecrldXdC0UoWkikdCOwK9Hm5296KH8lZBEFYuPSl8ADDE5Zb/gP3K0GmzpjqR6wU1E
	 eCdSVIBsC3gJQ4dn2Tjl4WODr7pMLDeWA3JC9A1/wYjXPIFPc6pq0KKAgG91U4g71G
	 MysaILrWEzhM0b209VMBOyRsFiU6R6CDuasMTzl1TtORdgeBctqC6yzPmZDvGsrH5D
	 6qHReNp3rwrIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EABEE383BF5B;
	Fri, 25 Jul 2025 18:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2-af: use unsigned int as iterator for
 unsigned values
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175346881350.3231025.12712431152409017635.git-patchwork-notify@kernel.org>
Date: Fri, 25 Jul 2025 18:40:13 +0000
References: <20250724-octeontx2-af-unsigned-v1-1-c745c106e06f@kernel.org>
In-Reply-To: <20250724-octeontx2-af-unsigned-v1-1-c745c106e06f@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 jerinj@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Jul 2025 14:10:54 +0100 you wrote:
> The local variable i is used to iterate over unsigned
> values. The lower bound of the loop is set to 0. While
> the upper bound is cgx->lmac_count, where they lmac_count is
> an u8. So the theoretical upper bound is 255.
> 
> As is, GCC can't see this range of values and warns that
> a formatted string, which includes the %d representation of i,
> may overflow the buffer provided.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: use unsigned int as iterator for unsigned values
    https://git.kernel.org/netdev/net-next/c/9312ee76490d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



