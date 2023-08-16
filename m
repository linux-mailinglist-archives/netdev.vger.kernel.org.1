Return-Path: <netdev+bounces-27924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A3F77DA46
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 08:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B333280A8F
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 06:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4578C2FA;
	Wed, 16 Aug 2023 06:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595EF1844
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 85F26C433C8;
	Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692166221;
	bh=V3LPKpZctepa52hVoRo6EPdhn4r96Y++524j4evK/1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AxMkGng91KqdDiSPifnQBwuD8IJBtEMcyE+LvblbPNZSDdXmxQ4bPSdbaSdHzFjDA
	 vij2LnGWiu6/jsOwX8cJNOeM9Rml387gaSjIoOsjYXEUWMyS4JmcjotaDYqcs2Mze/
	 S7ndDodXNxv6GJaftqZuQrLP2foiM/feDMJPlw01QZHaYCutTTVuBEYRc36ZZCeJZm
	 dZJnPnx5Vnc01RNSTmxxTNm7WYE7hEbmweazwvR+O3GlYFuKePmbyorRJI3OMOYWBm
	 6QWP19+KTGvo5JEgWfeokyrw0dyYqk+V+G+DaQzHHloQrIx/ZIA7/zqVsUJy7it+gt
	 gw8yk/4LQZ09g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 67479E93B34;
	Wed, 16 Aug 2023 06:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] broadcom: b44: Use b44_writephy() return value
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169216622141.7878.1672210323175964763.git-patchwork-notify@kernel.org>
Date: Wed, 16 Aug 2023 06:10:21 +0000
References: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
In-Reply-To: <20230814210030.332859-1-artem.chernyshev@red-soft.ru>
To: Artem Chernyshev <artem.chernyshev@red-soft.ru>
Cc: michael.chan@broadcom.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 15 Aug 2023 00:00:30 +0300 you wrote:
> Return result of b44_writephy() instead of zero to
> deal with possible error.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Artem Chernyshev <artem.chernyshev@red-soft.ru>
> 
> [...]

Here is the summary with links:
  - broadcom: b44: Use b44_writephy() return value
    https://git.kernel.org/netdev/net/c/9944d203fa63

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



