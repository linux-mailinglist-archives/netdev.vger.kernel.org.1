Return-Path: <netdev+bounces-99251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19498D4341
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8E911C2333B
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E12F6219FD;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PngpXuC7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B74C720DD2;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717034434; cv=none; b=aD+bW6cVSw3APHExx5RX1sagNykBisF/Hoqye+Fm/yhN8NL591ZNTyuIf4kQJG+37UpVL6H7ifzqQ5PsyOWLTySYYPX6uks5JHfFGVOXT/HPZWrr+LshTvVwqbzsTl936sa+ygP1r3z3wg2lBrotGddPLJabN0aNPaXKVT2S9oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717034434; c=relaxed/simple;
	bh=IFd9cPSRVhkFQcxydps6seRUoVuDDN4LTFZoMSfLRhk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EQ8odkdBYk+vgHj5ld7hQ3B2wQoicP/ctWnQiOFR+TK6WXgtOYMn7GXzLnYpL9dMEdOpai2sjTEj8a2vzC4Yla90Lhj2jW/MnnvwVuOmGrG8cWgFJVm4k0Is9nwg/qH2+allPFX8BGWN1tTBPxlqraF3h3LO5QRONhjNJIoLXXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PngpXuC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57F84C32782;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717034434;
	bh=IFd9cPSRVhkFQcxydps6seRUoVuDDN4LTFZoMSfLRhk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PngpXuC7tvf66S1ktNsF7OZlO8r7VR89mkSAs5atLyBqgeJfB8kPfajjuHi/fWl6G
	 b+8id40/zIEM8WsUJSLselTbpwkrGKvhIENy1yAOQtS97ap+X+AlvXXsvTM9h/u5Bi
	 EwPfc7CEI5IOy7cwf8qfSVMrdy5GxZBicYrsG9+AwLPjHCZFwral5MQfozMPDDdckD
	 f9q4gAxlDY82DJIdqP96kSZPl2vG+iyLGN996te+1c5boRMIpKINsxz3gtmSehha4b
	 USPcWIPNS7JF8PxNu0KiMgyp1uo2iFnzULZVRvsWXVTfRzTY7f93ZhhDm6NnYaFmlK
	 74mjgWMkHMG4A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 49D9ED84BD0;
	Thu, 30 May 2024 02:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: smc91x: Remove commented out code
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703443429.3291.7994063407236758002.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:00:34 +0000
References: <20240528160036.404946-2-thorsten.blum@toblux.com>
In-Reply-To: <20240528160036.404946-2-thorsten.blum@toblux.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: nico@fluxnic.net, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, u.kleine-koenig@pengutronix.de,
 leitao@debian.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 18:00:37 +0200 you wrote:
> Remove commented out code
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  drivers/net/ethernet/smsc/smc91x.c | 4 ----
>  1 file changed, 4 deletions(-)

Here is the summary with links:
  - [net-next] net: smc91x: Remove commented out code
    https://git.kernel.org/netdev/net-next/c/c53a46b16ce2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



