Return-Path: <netdev+bounces-132025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E41990283
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 13:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 894541F2110C
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 11:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D726B15958A;
	Fri,  4 Oct 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dttuV6LB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4D9157494;
	Fri,  4 Oct 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042632; cv=none; b=oDJn2he4jQ+f9Hvz+RNPixMmlXslimcC/hP+dVlKR3JDjugvHoFba9eQWnL58dAzfJ7dvlZJ1w+hdSjC3c9M3oHb/rOGmvbeJ1qoPKyV2qkH2lyXipMK0pKgwCs1owHbzhdHiQ31Ppk7HBSb3+k1zNTbULwuXHHJb3FIv5weHYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042632; c=relaxed/simple;
	bh=yrU4SmnThROhv/VIOrb6tzYqfWLeTYYn9ETxxYiGRtw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+x/0elY0Aly1kx+YCi86ULmXhy4+tv/aXXcnKgDFVT8lw6B5HFJbT2JLjn/sjSgUwk+54n/Xs5+gfYA8sBCka4+4c5wgyZ90/8VnmMwdn/1GxZcWi0Ndfih3MeingPxdCL7ln7Qi7Ii/9Ryzbv+I1RIyV3l/WRvj+0eUn60jVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dttuV6LB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3477CC4CEC6;
	Fri,  4 Oct 2024 11:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728042632;
	bh=yrU4SmnThROhv/VIOrb6tzYqfWLeTYYn9ETxxYiGRtw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dttuV6LBsQdkxcVVhDIP5gq0dUeiXXFg97gL2oQtjcwg5ag4efJJuWrjx/aklXp4j
	 Y63IxJsR6vyzeLMBakzGS417/YYtJDynazdi97292Ga3rkmBM95nqUuW7Y2LlgTz6F
	 Rg0EfBjFu8d8G6ERFSqmD4OErKMQdrtBy6abzPpfUsmhpCSmlrJyD9XkUqmrNFjf5w
	 5JRk37Ql15O45IO7rXK//oEdnPR+1nJCrjW7Xl9/bq1tHIpc6jMfwHVwRPEp95f0Ba
	 0CmJyE5T5NAikUmcRgSOorEMmyWtsuB7g9i/Zpp2oGJmmYMAKWHgemP3aNp3/AYr7t
	 /LgWeBErU4YHQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC08B3809A90;
	Fri,  4 Oct 2024 11:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] appletalk: Remove deadcode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172804263576.2562339.322346723742676921.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 11:50:35 +0000
References: <20240930132953.46962-1-linux@treblig.org>
In-Reply-To: <20240930132953.46962-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: willemdebruijn.kernel@gmail.com, jasowang@redhat.com, davem@davemloft.net,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 willemb@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 30 Sep 2024 14:29:53 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> alloc_ltalkdev in net/appletalk/dev.c is dead since
> commit 00f3696f7555 ("net: appletalk: remove cops support")
> 
> Removing it (and it's helper) leaves dev.c and if_ltalk.h empty;
> remove them and the Makefile entry.
> 
> [...]

Here is the summary with links:
  - [net-next] appletalk: Remove deadcode
    https://git.kernel.org/netdev/net-next/c/b63c755cb65d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



