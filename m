Return-Path: <netdev+bounces-182514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDB4A88FD2
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 00:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 247531894BA0
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BAB31D7E4A;
	Mon, 14 Apr 2025 22:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bCP7Ub04"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3BD01B4227;
	Mon, 14 Apr 2025 22:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744671414; cv=none; b=KhdJXy1l5koKg7k1N9WgWWV0+Th1a1RWimOL+eDMlHLgUGikaOnp6iuqu77vR4j3Des3EB0ZVQVcHjN/WZd3b4ID/oYnMZxP0V2sRtR66IJC64KAmwabDXpEqz0X9gUnEybTPqh5KI5VH5Xr2EQF0LnL4J/KiS4YiToaAZ/tLkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744671414; c=relaxed/simple;
	bh=9dOB00mbNdEpXCfLGqQBL8FyU1h2QW4RK9S1ITUV7eE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CjkaiHqakYmgEcK0KIYNcsyWqfqXbvR9Fzj1Ee8NICG9EvQOmZRIKQ0VUY1xzvS1jVdYLuu+UaFSG/1fMwUa81glJtXomQ5lFGfOY3phYrkNKwvZJPL5uG9y2zNlbDvWFY8wyUz9Y8bXBMZ3dNe5FlcGySfsSaBF67w6E8mT8Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bCP7Ub04; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52016C4CEE2;
	Mon, 14 Apr 2025 22:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744671413;
	bh=9dOB00mbNdEpXCfLGqQBL8FyU1h2QW4RK9S1ITUV7eE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bCP7Ub04h7RQj7T3kb6a1So8V5NraEjQC5YmaVQzrNbYoaZi4JV78IprXxOuV1oAi
	 AApgUPkxtQ21l/Ty83+RxYNokW88Cnsd9d6lyd2FQgfQrDYMOkxDgTir0JW1YMZkFL
	 M1+Xt3UBEqN74a/IO/QqxyrWvwRMp8Abq5oOycMlTiDFwfq8HIhGLEztDS498NrYjZ
	 3EOTeTuWnW+AwFiCinW3Erc+4RSL/w8/N1I01W2EArGIRtZlSeSL96sIW3CK58IgDB
	 H4v0O4UOi2pnhOS5fLFUvjH3GJpAt4B/tBGTPfH2BU9r+om3QiP+iPFJ2hnE2UtabE
	 cDQT4JsH1Okjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D313822D1A;
	Mon, 14 Apr 2025 22:57:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 00/11] net: pktgen: fix checkpatch code style
 errors/warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174467145125.2060374.9049368694354111896.git-patchwork-notify@kernel.org>
Date: Mon, 14 Apr 2025 22:57:31 +0000
References: <20250410071749.30505-1-ps.report@gmx.net>
In-Reply-To: <20250410071749.30505-1-ps.report@gmx.net>
To: Peter Seiderer <ps.report@gmx.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Apr 2025 09:17:37 +0200 you wrote:
> Fix checkpatch detected code style errors/warnings detected in
> the file net/core/pktgen.c (remaining checkpatch checks will be addressed
> in a follow up patch set).
> 
> Peter Seiderer (11):
>   net: pktgen: fix code style (ERROR: "foo * bar" should be "foo *bar")
>   net: pktgen: fix code style (ERROR: space prohibited after that '&')
>   net: pktgen: fix code style (ERROR: else should follow close brace
>     '}')
>   net: pktgen: fix code style (WARNING: please, no space before tabs)
>   net: pktgen: fix code style (WARNING: suspect code indent for
>     conditional statements)
>   net: pktgen: fix code style (WARNING: Block comments)
>   net: pktgen: fix code style (WARNING: Missing a blank line after
>     declarations)
>   net: pktgen: fix code style (WARNING: macros should not use a trailing
>     semicolon)
>   net: pktgen: fix code style (WARNING: braces {} are not necessary for
>     single statement blocks)
>   net: pktgen: fix code style (WARNING: quoted string split across
>     lines)
>   net: pktgen: fix code style (WARNING: Prefer strscpy over strcpy)
> 
> [...]

Here is the summary with links:
  - [net-next,v1,01/11] net: pktgen: fix code style (ERROR: "foo * bar" should be "foo *bar")
    https://git.kernel.org/netdev/net-next/c/81e92f4fb825
  - [net-next,v1,02/11] net: pktgen: fix code style (ERROR: space prohibited after that '&')
    https://git.kernel.org/netdev/net-next/c/eb1fd49ef660
  - [net-next,v1,03/11] net: pktgen: fix code style (ERROR: else should follow close brace '}')
    (no matching commit)
  - [net-next,v1,04/11] net: pktgen: fix code style (WARNING: please, no space before tabs)
    (no matching commit)
  - [net-next,v1,05/11] net: pktgen: fix code style (WARNING: suspect code indent for conditional statements)
    https://git.kernel.org/netdev/net-next/c/1d8f07bf4aab
  - [net-next,v1,06/11] net: pktgen: fix code style (WARNING: Block comments)
    https://git.kernel.org/netdev/net-next/c/870b856cb478
  - [net-next,v1,07/11] net: pktgen: fix code style (WARNING: Missing a blank line after declarations)
    https://git.kernel.org/netdev/net-next/c/ca8ee665211a
  - [net-next,v1,08/11] net: pktgen: fix code style (WARNING: macros should not use a trailing semicolon)
    (no matching commit)
  - [net-next,v1,09/11] net: pktgen: fix code style (WARNING: braces {} are not necessary for single statement blocks)
    (no matching commit)
  - [net-next,v1,10/11] net: pktgen: fix code style (WARNING: quoted string split across lines)
    https://git.kernel.org/netdev/net-next/c/08fcb1f242b9
  - [net-next,v1,11/11] net: pktgen: fix code style (WARNING: Prefer strscpy over strcpy)
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



