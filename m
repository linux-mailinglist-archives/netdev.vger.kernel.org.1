Return-Path: <netdev+bounces-29030-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 518A67816D4
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A7C8281C95
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:50:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D079DA4F;
	Sat, 19 Aug 2023 02:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A42634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 05AC7C433CA;
	Sat, 19 Aug 2023 02:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692413425;
	bh=REZcT6OCq8rKpZyNV8QPKgvyY2ocm/CsTmMQlPPBQKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dIjXKAA/pWwPrlse9G0EJFA4i1V3EeaHCp+8wuGcp9pDG0CfLIEsbgtYEVka6qZA2
	 QKa0PaX+gnouhxsQoTcF4ocboxvTq/mIWEcx8E14qdd61GYnGOr7N9MkCsU250yHQN
	 FfHJRN5ir/gJgOI1zDwIpbVXTjyUFgrfCTaRjLLrzQHUZteMvo8JTCHMoA4O9kR3PG
	 eA9GcYXx8fZu01J78Q1+DFDZ2I38In79/edgxlKjRmwnbBwUclv4Vx+/JvJWLcXEgk
	 kui37v4XrsF3vg+zYRXAOZ7El3ukJg0wTiRTVRgdvEXSjPpQOE819aNt5GqDkp90hK
	 D6u8MWo6vlaJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E3CC1E1F65A;
	Sat, 19 Aug 2023 02:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dccp: annotate data-races in dccp_poll()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241342492.21912.15469319930098215627.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:50:24 +0000
References: <20230818015820.2701595-1-edumazet@google.com>
In-Reply-To: <20230818015820.2701595-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 18 Aug 2023 01:58:20 +0000 you wrote:
> We changed tcp_poll() over time, bug never updated dccp.
> 
> Note that we also could remove dccp instead of maintaining it.
> 
> Fixes: 7c657876b63c ("[DCCP]: Initial implementation")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net] dccp: annotate data-races in dccp_poll()
    https://git.kernel.org/netdev/net/c/cba3f1786916

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



