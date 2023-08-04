Return-Path: <netdev+bounces-24593-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEC8770BFE
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 00:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 804E71C2173F
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 22:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9831DA37;
	Fri,  4 Aug 2023 22:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFF31DA3F
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 22:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id DD1D1C433CB;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691188823;
	bh=hQgZYVY5KwTTBy2stmitbyTuBxHPukcuDekTrDCDA00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=brMeVlHlcLMq06UKPwEiDfqn1EyNay7FbHjX0TenLx+kAbyDGHY3wREBOdbItjWK6
	 BiG+UytmOE4pDgXxbta620kBpRub+pTJBylkQUldLqfEu6/sWd5rUtaPX2rGJfd1WG
	 /18rfgWU6t8CTJo0ZgvAvOEHKJevu5ddkAwctBu1v541wYc+Jv+CRbBNwELYtzqNlF
	 D4quvLWeEsKUfbyrET7KDn9loCxkXONxXwpK698U0x35wPWQmuVonckyTJnbrmB07M
	 M0vLu6o6be41wEbZVQ9K1z2bqA/CgAvNkyDFTuR20YYuFv1396dvMPm5AT9bgmSM+O
	 L9JDPwA/pGBIA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5722C6445B;
	Fri,  4 Aug 2023 22:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: 802: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169118882380.4114.10711786799076281440.git-patchwork-notify@kernel.org>
Date: Fri, 04 Aug 2023 22:40:23 +0000
References: <20230803135424.41664-1-yuehaibing@huawei.com>
In-Reply-To: <20230803135424.41664-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 21:54:24 +0800 you wrote:
> Commit d8d9ba8dc9c7 ("net: 802: remove dead leftover after ipx driver removal")
> remove these implementations but leave the declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  include/net/p8022.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] net: 802: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/2f0e807bc2f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



