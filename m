Return-Path: <netdev+bounces-21149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED6E762931
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 05:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBD762811CA
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 03:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94681FA1;
	Wed, 26 Jul 2023 03:20:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FD83FDB
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 03:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4731AC433C8;
	Wed, 26 Jul 2023 03:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690341620;
	bh=bwbuaLtAzinqe7E9UQyxK1lVJXk9Bg7x4VEmQx8c3GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s3uf65aXLecRc2JwfzAa8ZPAtmidYJ1gpXjGPtmIQZVM8n7ZaSTW5Be2m+E26N3D4
	 V9rKwkta4XlizN6Nqmkf5iOUhwij/+5JNzNUcNkEt6gawrKy61HzrKn0vGEFlVjPz2
	 nO2hKBB+6PZkYXBJZWOf2XUjFJ3mbT/Gb/FMO8pg9EpSbzjfRJAN0Ow5x1fZknfBJl
	 G36FEZ+ePo829I4JqZFccnWReHEt8nQSXWSLQCNuU2008Q7MZsEvmzg5zbVgezzlhh
	 HGUb58jn4bruqrNbtYoXFSH6MnGngjBztySfiawjHBsebnUKUf0LBt/eI5J33proxN
	 RYvmIAGeWZQuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2945CC73FE2;
	Wed, 26 Jul 2023 03:20:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio_bus: validate "addr" for
 mdiobus_is_registered_device()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169034162016.22799.16702675199058617281.git-patchwork-notify@kernel.org>
Date: Wed, 26 Jul 2023 03:20:20 +0000
References: <E1qNxvu-00111m-1V@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1qNxvu-00111m-1V@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Jul 2023 16:57:14 +0100 you wrote:
> mdiobus_is_registered_device() doesn't checking that "addr" was valid
> before dereferencing bus->mdio_map[]. Extract the code that checks
> this from mdiobus_get_phy(), and use it here as well.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
> I've had this patch kicking about for a while - probably a good idea?
> It shouldn't cause a regression, but if it does it means we're already
> dereferencing the arrray outside its bounds in
> mdiobus_is_registered_device().
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio_bus: validate "addr" for mdiobus_is_registered_device()
    https://git.kernel.org/netdev/net-next/c/09bd2d7ddaed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



