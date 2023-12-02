Return-Path: <netdev+bounces-53213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1919C801A42
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 04:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C066A1F210F5
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 03:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EA79D8;
	Sat,  2 Dec 2023 03:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iz/Dx5Dz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1B23AF
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 03:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 13132C433C9;
	Sat,  2 Dec 2023 03:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701488424;
	bh=vZxBipH19Gjg17dKBRsDB0Gs4uZStmVNI9tMPhOax6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iz/Dx5Dz5yenPKzCsoA2E57wyO65qy2AiXsib/YpqZYoUPCTkxtZcZz+QzpNWmj+C
	 3H0Jpt9XhjzLJ6kaDo1OW+QSQ8n10MJxZqWY2tPHliQI963W5qsOKALmB1OrPnO81A
	 7fAMNaaa1/aDwHf8cLtGCAjkaV9D+oT1kQZgtxpPypi+7BLeEqeNj8Ha2FaaBXRWky
	 +z/N/RXX1esKPx4Co6PA7H5EKwhxqhdoUJsNrEP9ph+kNP4+LFV7a52RksytfJ5NKh
	 qyeNSgumpXzzUChGx0Ay/PfGemnSrG8VZwlfuKg1YNwebgZwA0SlsKF1z2kpgbSaJR
	 7tW/KiOwzaCfQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ECE81C64459;
	Sat,  2 Dec 2023 03:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: tcp_gro_dev_warn() cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170148842396.13520.2541912983542148159.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 03:40:23 +0000
References: <20231130184135.4130860-1-edumazet@google.com>
In-Reply-To: <20231130184135.4130860-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 18:41:35 +0000 you wrote:
> Use DO_ONCE_LITE_IF() and __cold attribute to put tcp_gro_dev_warn()
> out of line.
> 
> This also allows the message to be printed again after a
> "echo 1 > /sys/kernel/debug/clear_warn_once"
> 
> Also add a READ_ONCE() when reading device mtu, as it could
> be changed concurrently.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: tcp_gro_dev_warn() cleanup
    https://git.kernel.org/netdev/net-next/c/b32e8fbeace6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



