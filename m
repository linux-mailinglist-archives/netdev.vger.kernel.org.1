Return-Path: <netdev+bounces-94644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EFB528C00A6
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 17:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A2D41F2726E
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 15:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9F6127B53;
	Wed,  8 May 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KvOMMNH5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8149784A23;
	Wed,  8 May 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181031; cv=none; b=ZeGXnniOac1HPgKPI9sfkpP1U0F/h2i9fbGPhguhXTdGpUGWc6f+3cSrKulFDOK/En5QNFzEWwsviw8TlrjHspaMVDyX4P8f4xYzgOmG3/1CpsrnKbv4mUIkOqPEhEmjbKfpTRygkhWV7BxhV6KWV39ZJwntlkz2zA7f9av4UQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181031; c=relaxed/simple;
	bh=WLx72K7UHEe1hou9M+eT9Mkgbt/eD4RGrinATt2BsOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WWxU/hWBG1s268mZbm8fErFwKRGv3WKy4aoxfd1d+mkoTsms8NyE21l+PhAWwbOqtwNWZuBUzOz1KpacAZTwOOph88Qh/x9PxYHkGbxNKflVI6T/aDiU7+Zccojd6DT/AP+arvLkgC0uNmV6SGseFkYZ23TpH8pQb/S6I63gpyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KvOMMNH5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 37D9BC2BD10;
	Wed,  8 May 2024 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715181030;
	bh=WLx72K7UHEe1hou9M+eT9Mkgbt/eD4RGrinATt2BsOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KvOMMNH5vw+5rnMQ3CPYvHe1+OgaSoFvnikoLiuJDthaOJfrnR9F9eOClcqE5jx3h
	 tGehmyMeLkxl1oSNjUDAAXazrP31Z24HOGJrg8YCITMJOp2VFIS3jWhW6cr9RWFi7T
	 ivcAaMXClGWQnqP9HA7fxHS5NOHbLIWPofjYDiDqyjNCH3ADzlUk/UgaQINOGy7Esh
	 CNjopPPuNMz4wMLstwjWScrTBJ+PCzkR+yQ92zv9KTwQHrZI535poDhWClQltbfNxR
	 cB/HCZpaPxD1bNMEH43qvaTfMlrTgpYhVgj9SBpqatmHY7VifNg28ti7TwcCm3ApmL
	 fWMAkvGFefZIg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2930CC43332;
	Wed,  8 May 2024 15:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] rxrpc: Miscellaneous fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171518103016.16796.12754313955798930000.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 15:10:30 +0000
References: <20240503150749.1001323-1-dhowells@redhat.com>
In-Reply-To: <20240503150749.1001323-1-dhowells@redhat.com>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 May 2024 16:07:38 +0100 you wrote:
> Here some miscellaneous fixes for AF_RXRPC:
> 
>  (1) Fix the congestion control algorithm to start cwnd at 4 and to not cut
>      ssthresh when the peer cuts its rwind size.
> 
>  (2) Only transmit a single ACK for all the DATA packets glued together
>      into a jumbo packet to reduce the number of ACKs being generated.
> 
> [...]

Here is the summary with links:
  - [net,1/5] rxrpc: Fix congestion control algorithm
    https://git.kernel.org/netdev/net/c/ba4e103848d3
  - [net,2/5] rxrpc: Only transmit one ACK per jumbo packet received
    https://git.kernel.org/netdev/net/c/012b7206918d
  - [net,3/5] rxrpc: Clean up Tx header flags generation handling
    (no matching commit)
  - [net,4/5] rxrpc: Change how the MORE-PACKETS rxrpc wire header flag is driven
    (no matching commit)
  - [net,5/5] rxrpc: Request an ACK on impending Tx stall
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



