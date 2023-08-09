Return-Path: <netdev+bounces-26047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0819E776A8A
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E9981C21341
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F039A1D2FF;
	Wed,  9 Aug 2023 20:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9C31BB2F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F1A7FC433CA;
	Wed,  9 Aug 2023 20:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691614221;
	bh=r0lM1eN0UO2rxKrzbNuPaRkJqwtCS66PEo9o86GLwsU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PQ/Ip2uJIPP7eyDed7+sM5C/CzKM5ec4SS2fHvvnsb70R2TtSPEsrmuIcboA33lg2
	 mNcWVssQIelZojH5I7ElItRTS2yC36AnvcYtOXa9i1e536BmH7uknaYixqDKXnHeb8
	 jbRBn/nNNbSe7/i39kiqVVquJyiLuYLQefKTb7CcyK69Ll18OZfB5YXyRfIbbr6dNe
	 JzifOFhe/xXqw18T3EfAj5dgsm2st1N1XSR9MOuJJpTKpP+enir6o2r1FoomYf1YR2
	 MwtQ3PjkQ9C1HFk9QS31nCyz3xCySKWGDbDiER4XnDRsD/Biq8GsPtPvJUbiri8aua
	 ReDaGvR02cDvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4D7AE33090;
	Wed,  9 Aug 2023 20:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [iproute2,v2] man: bridge: update bridge link show
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161422086.352.8750290247459279461.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:50:20 +0000
References: <20230804164952.2649270-1-nico.escande@gmail.com>
In-Reply-To: <20230804164952.2649270-1-nico.escande@gmail.com>
To: Nicolas Escande <nico.escande@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org, idosch@idosch.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri,  4 Aug 2023 18:49:52 +0200 you wrote:
> Add missing man page documentation for bridge link show features added in
> 13a5d8fcb41b (bridge: link: allow filtering on bridge name) and
> 64108901b737 (bridge: Add support for setting bridge port attributes)
> 
> Signed-off-by: Nicolas Escande <nico.escande@gmail.com>
> ---
>  man/man8/bridge.8 | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)

Here is the summary with links:
  - [iproute2,v2] man: bridge: update bridge link show
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=cb93753e1042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



