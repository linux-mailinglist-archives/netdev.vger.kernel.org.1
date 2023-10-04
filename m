Return-Path: <netdev+bounces-38087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86D777B8E9A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DB8EE2817AC
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 21:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E3A23755;
	Wed,  4 Oct 2023 21:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vr7s+8HY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3917A23753
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 21:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 86C55C433C8;
	Wed,  4 Oct 2023 21:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696454425;
	bh=vCDsYJ5xVt4Ez1p0mhyJNNL2hHtuRq9Cdm7oVL9/si4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Vr7s+8HYyFIb18fcAc+MHva+cwZWo8xcMCMK2/9jmbFz+0Ua1wTo2XWy4OcoRrb6P
	 XIjz6m35VpZF0bA2IL4GhUyf4jQhupzmSntEE8xue7j7+9RrmnwEsbCDfZm6SIMIBI
	 kcji3HiB+KRfXhqsao2Oqn58R/WIZdOAAV8Jw/59DzgQHtf5HycBgair0uzT41coyK
	 oig2HWVbnQO1xv1j8DovY0VeoK0zNPNoxeEMzTMUDUj670gppBirCe4kSTTlpkpNQ7
	 FZ9hsgVbBrLp1c2bLvS69/kTtUdCKRF8+ZB+7jRYILuvNZHF/Fvm/WgM/IwLTw5uIk
	 NcbkUUhmqIJAg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6B61FE632D7;
	Wed,  4 Oct 2023 21:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] [net-next] sctp: Spelling s/preceeding/preceding/g
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169645442543.1877.367473311797088363.git-patchwork-notify@kernel.org>
Date: Wed, 04 Oct 2023 21:20:25 +0000
References: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
In-Reply-To: <663b14d07d6d716ddc34482834d6b65a2f714cfb.1695903447.git.geert+renesas@glider.be>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: marcelo.leitner@gmail.com, lucien.xin@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-sctp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 Sep 2023 14:17:48 +0200 you wrote:
> Fix a misspelling of "preceding".
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---
>  net/sctp/sm_make_chunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] sctp: Spelling s/preceeding/preceding/g
    https://git.kernel.org/netdev/net-next/c/2b464cc2fd57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



