Return-Path: <netdev+bounces-108073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AEA691DC4B
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 12:22:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC7F6B22DBC
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54681494BB;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOC+SJTB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3365A0F5;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719829257; cv=none; b=TLrTDCQ0iXpKxDOEoKITG9nUwaRsWjKwavCKRVXIJvGiIOeunrqWRHdridO6XEsXm50wtcrv0wPQE4CncY7n5BXS4Qi12fLHsU2AZ3BATFbsTqKrMY6KKehgvYU2pQRUEcLaw4eWPMKuXgGDvVJypkgJx4zJOulHOX/tNI8rB/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719829257; c=relaxed/simple;
	bh=s1m3nFqH4deUmEt1uvVGLE5ilSUewc0ZUqW5fFnHeqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cH3lu4xW/3VLl6oDmUI1M7EsGdETRsSf/BBUyz5D3QfOmBAWBykYjwRsIa/VXRF1nL/r7Yml1u9hc2GP3hR0LB+Dr8gpUO9DqQewQ67NRGOSwJE5NTLWRKLa2IsHytO6V86WEdX5t84gPDDQmpjPnysSSzj3frvkbXXLEp+fAyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOC+SJTB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6B081C4AF0D;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719829257;
	bh=s1m3nFqH4deUmEt1uvVGLE5ilSUewc0ZUqW5fFnHeqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YOC+SJTBZfWH6ZoGYpww3v98s9UhN2SOQtzWWzXTf2mhVDbk7rgGFxjFbpfWj8reO
	 OiX35Yss4nt4eQfjWGC9XXPFfqkb1uNE53llZ/3iPl6N4RaCj741Nc1Vb5ZOZcy1Jz
	 4/P7T3MTgjFlYRddVaaYxQA5SdAjT0OdBaxX9HBdNPszoPR6CLjdwDvv31zmZuWp7C
	 k6BlVQZRw052aa2V8+60JvzzNpR2sGo9QZ1GHfJaE8tDrCCbuBoL8T3qIxW3ZIkLj3
	 6GebtC9E+A8xhU0hCXRAhyffCkxRhMLjJ58z55a8Rxc3u+tuttOdVxw4F4meAzfciD
	 lGCPTmNfVMnjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 537FBC43331;
	Mon,  1 Jul 2024 10:20:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-af: Sync NIX and NPA contexts from NDC to
 LLC/DRAM
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171982925733.8939.9678984506930226937.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 10:20:57 +0000
References: <1719592286-24699-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1719592286-24699-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ndabilpuram@marvell.com, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, jerinj@marvell.com, hkelam@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 28 Jun 2024 22:01:26 +0530 you wrote:
> From: Nithin Dabilpuram <ndabilpuram@marvell.com>
> 
> Octeontx2 hardware uses Near Data Cache(NDC) block to cache
> contexts in it so that access to LLC/DRAM can be avoided.
> It is recommended in HRM to sync the NDC contents before
> releasing/resetting LF resources. Hence implement NDC_SYNC
> mailbox and sync contexts during driver teardown.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-af: Sync NIX and NPA contexts from NDC to LLC/DRAM
    https://git.kernel.org/netdev/net-next/c/42c45ac1419c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



