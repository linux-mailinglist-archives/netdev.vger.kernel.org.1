Return-Path: <netdev+bounces-77892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FBB873613
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8FD71C20CF7
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A26A780025;
	Wed,  6 Mar 2024 12:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uepCfJxO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64D80022
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709727032; cv=none; b=srR/gbyCB0c2NYCE5cWQYl+Day2Q1ZbueBos56hlKoUvcPEds5mVaa9k3Y/jY4fnUhxVaIUMQyLFRGfD65fSARxEAXsdKELO/LCBf91aMYFSwCNUda6rcmMpVlP8OCbzfmR9kTtHBRyBnWrpb3tl0fLLeIavPvm+2bb4dr/eXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709727032; c=relaxed/simple;
	bh=3g5om/K62YlldTRZXmtNN4uLI9BEqTJiLXXQRhlu/mo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UKutefltWC1JRYOjDSfe27ChhO042ZUI73NMxzRJlhB9yIHTy3aPsXOimGA8+n6rXn3ctxE51d9VAUbwTyf+KoUt02VTyJLTiNLtafrPpaYxuozC7luKjcAfts2m6lXcsKX0yJfD61GjUI2LzaqwUYdnA0EjSZaEIqpCf7GHg7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uepCfJxO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9D22C43390;
	Wed,  6 Mar 2024 12:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709727031;
	bh=3g5om/K62YlldTRZXmtNN4uLI9BEqTJiLXXQRhlu/mo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uepCfJxOprTRgZtfbSONcOp1IKbVYJ67UFki42MUG0Q+nSZdqNneY3EzD9yfuFJfn
	 TuPYy3XSSl75De/I0gPj2KVgIjX+sKRei5IyTViYQEbo9MVea3IfA45jMQKwTKRYPd
	 nUxpGtOcIedf32FrtiAbM8pcXwHELiXMe+N/KIUA5wJVFFy3zrMzQYeA4864HgAHdo
	 uedoUDH8LsepeR9hZMFDleGJ8eRQKqO2JTjdnCP0GEO/J7Q/Y0Aqkhb8eAi8EpP5Rg
	 rs2+Vw6Tpdf76+Qm2p69DQDEnKiQ6pC7bxrXzCWCGp4O0dUSapcK/BZfP29iVPcXne
	 F/lFba+duQz1A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CACF4D88F81;
	Wed,  6 Mar 2024 12:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] tools: ynl: clean up make clean
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170972703082.11436.1378265551301206913.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 12:10:30 +0000
References: <20240305051328.806892-1-kuba@kernel.org>
In-Reply-To: <20240305051328.806892-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon,  4 Mar 2024 21:13:25 -0800 you wrote:
> First change renames the clean target which removes build results,
> to a more common name. Second one add missing .PHONY targets.
> Third one ensures that clean deletes __pycache__.
> 
> v2: add patch 2
> v1: https://lore.kernel.org/all/20240301235609.147572-1-kuba@kernel.org/
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] tools: ynl: rename make hardclean -> distclean
    https://git.kernel.org/netdev/net-next/c/4e887471e8e3
  - [net-next,v2,2/3] tools: ynl: add distclean to .PHONY in all makefiles
    https://git.kernel.org/netdev/net-next/c/1d8617b2a610
  - [net-next,v2,3/3] tools: ynl: remove __pycache__ during clean
    https://git.kernel.org/netdev/net-next/c/72fa191bfdf6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



