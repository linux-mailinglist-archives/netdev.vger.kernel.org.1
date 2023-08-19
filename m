Return-Path: <netdev+bounces-29018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0862178169B
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 04:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4AAD281DF4
	for <lists+netdev@lfdr.de>; Sat, 19 Aug 2023 02:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEAE2809;
	Sat, 19 Aug 2023 02:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89817634
	for <netdev@vger.kernel.org>; Sat, 19 Aug 2023 02:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F3B3FC433C9;
	Sat, 19 Aug 2023 02:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692411628;
	bh=GrIH0c4O+fZGerztqff1j45eANuysbklV2a0eDZzv88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZsVoNhJIDSRW3YoZk4owxYlcANQ8KEEpn0rMsw8IJSKk16enuDNObb4b0Z91xTqiE
	 FU1jiafkVNY9UCmk2o0MP0QltaR6caXPhu40nvhXbZyFSXk7CRyoLAg51oja/mCC56
	 CMJXip52G5IoELyy+tjodL+bzXo3WP8ixu3AP0FmH//4YKWRny9jcoPLfvoEW9fePF
	 Crn3EUrdGvHo1AiMLPaE0J8WiD3E6HnA89BLTDxl0YHDIpifEbYi61KygI3GxigcgK
	 nbHH/58HJ3Vrb00Ge9kNbVmS+XvoUm3XHE4KgFwhfqod0Q1nTrySZhAqfqq0mmQUlg
	 C7N6XV9/VP4eA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8B63C395DC;
	Sat, 19 Aug 2023 02:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/6] bnxt_en: Update for net-next
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169241162788.7451.8695266309121637560.git-patchwork-notify@kernel.org>
Date: Sat, 19 Aug 2023 02:20:27 +0000
References: <20230817231911.165035-1-michael.chan@broadcom.com>
In-Reply-To: <20230817231911.165035-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gospo@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Aug 2023 16:19:05 -0700 you wrote:
> This patchset contains 2 features:
> 
> - The page pool implementation for the normal RX path (non-XDP) for
> paged buffers in the aggregation ring.
> 
> - Saving of the ring error counters across reset.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/6] bnxt_en: Use the unified RX page pool buffers for XDP and non-XDP
    https://git.kernel.org/netdev/net-next/c/86b05508f775
  - [net-next,v2,2/6] bnxt_en: Let the page pool manage the DMA mapping
    https://git.kernel.org/netdev/net-next/c/578fcfd26e2a
  - [net-next,v2,3/6] bnxt_en: Increment rx_resets counter in bnxt_disable_napi()
    https://git.kernel.org/netdev/net-next/c/d38c19b13b10
  - [net-next,v2,4/6] bnxt_en: Save ring error counters across reset
    https://git.kernel.org/netdev/net-next/c/4c70dbe3c008
  - [net-next,v2,5/6] bnxt_en: Display the ring error counters under ethtool -S
    https://git.kernel.org/netdev/net-next/c/a080b47a04c5
  - [net-next,v2,6/6] bnxt_en: Add tx_resets ring counter
    https://git.kernel.org/netdev/net-next/c/8becd1961c73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



