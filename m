Return-Path: <netdev+bounces-46004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1F897E0D00
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 02:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D737281FCD
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709CC138D;
	Sat,  4 Nov 2023 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="POhTn5x5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE2110E3
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BBC53C433C8;
	Sat,  4 Nov 2023 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699060225;
	bh=sRc5OBFW7vNUP75ptr8iW+qZXaIhHCAuHGgra5wKjPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=POhTn5x5uMO8aqtNiykvLzfzmwuHjwPIMsbLvDd62vUpcXGQQ+QhReRpQcZZjBMVs
	 +fecnCeUUgmE5FnBcZiZdfi3l7juI+3jS9pPkW5dGJcPrJgM+rwlL9ydweyWRhiPA9
	 IBvFImPgLV4BqLKXv1rBYX7SxFQTxKRYNBNtRiKy8ApoYp/nO+DLfx8CZvDKJK+Dot
	 YO2KUHQ8dq1LsteUuR64agt21JeLbO4hLP3EBMfB6n1+rT3VebMBhvc7YX2BGjQ43L
	 bDNnsxn1J5QyyJuKVAy1XLjZ58iWrCZY28Ncf1qdP9XUz5hy501J1JFWdCHuZzgEdW
	 G2cUsMel4MC+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9FE11EAB08A;
	Sat,  4 Nov 2023 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 iproute2 0/4] Remove retired features
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169906022565.27075.17119111697400766956.git-patchwork-notify@kernel.org>
Date: Sat, 04 Nov 2023 01:10:25 +0000
References: <20231030184100.30264-1-stephen@networkplumber.org>
In-Reply-To: <20231030184100.30264-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 30 Oct 2023 11:39:45 -0700 you wrote:
> Remove support in iproute2 for features removed from 6.3 kernel.
> 
> Stephen Hemminger (4):
>   tc: remove support for CBQ
>   tc: remove support for RSVP classifier
>   tc: remove tcindex classifier
>   tc: remove dsmark qdisc
> 
> [...]

Here is the summary with links:
  - [v2,iproute2,1/4] tc: remove support for CBQ
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=07ba0af3fee1
  - [v2,iproute2,2/4] tc: remove support for RSVP classifier
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=aeb7be384388
  - [v2,iproute2,3/4] tc: remove tcindex classifier
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=bc0c1661eb22
  - [v2,iproute2,4/4] tc: remove dsmark qdisc
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=11e6e783b638

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



