Return-Path: <netdev+bounces-176773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2861AA6C183
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 18:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3591B61182
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 17:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9051E22D7B2;
	Fri, 21 Mar 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jzHSHQMl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6942022D7AA;
	Fri, 21 Mar 2025 17:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742578195; cv=none; b=L2h+Q+gtT/ql+DF/Lu3nGijrrW/f8K6ShCoIopWAXxCSLyhtH0E1d3WxyCmF4rC0mGGekiWNrV7n7e/2CVwX13ei/DSto/z90RKsHOFaFMwEUZZw1gKVS52lFlDPfEnlUwOWCu+NrTIkjTxnaWdlpDd5WyyvmifYZNo4RE2oki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742578195; c=relaxed/simple;
	bh=GSQ6QotvsD9wNVfOt39/sE6/2RqQvLffzMi+y4LBaEM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRWHxpz3HGnlnVfXFhB3steIaFkvnxORKsETacqT6i9e7yO8DsEbbFOl97OiK4jVcOOzYAKc4OFNzO7rT5Zgo7zOye2qxLEnfou7yJ8bX1fMwBh0vmbfD0RUWxQUeeItXsvOJgzZiEW++Haqaz6tqeNnaUcyy+pdTr+bwOMmoEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jzHSHQMl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BF0C4CEE3;
	Fri, 21 Mar 2025 17:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742578194;
	bh=GSQ6QotvsD9wNVfOt39/sE6/2RqQvLffzMi+y4LBaEM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jzHSHQMluOFbqvW7jYaZAseadmoFZhkeXxKlF9g59a7N18yZaWQmkMZl74V+1E8yo
	 bfzZZSYg2jlPOs8eAu9LtuteBREWhWWko4E2YjfjGguxQsYf6JYsV1iPkaReUQVrAN
	 guc6Nxm24KZxkjCjynxDR4wVDymFj0VGX3cQS3h8Mq21gUvEAusRmjixsAOBaweI2i
	 +BZ31gmTRWsBmA5ZxakSAyYy9/5uHPOCGt87204PmcLSYLyVrGOOtZFO9GreD1X12P
	 dVE5lMvu1Bk5DhC++NvwPGXsQJxYtqZYqNNd6KtArVeUwQSoTMPBMWPyj0+G87vgfG
	 fMDnfWvoUmIdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342643806659;
	Fri, 21 Mar 2025 17:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] MAINTAINERS: update bridge entry
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174257823101.2564531.334366443045899530.git-patchwork-notify@kernel.org>
Date: Fri, 21 Mar 2025 17:30:31 +0000
References: <20250314100631.40999-1-razor@blackwall.org>
In-Reply-To: <20250314100631.40999-1-razor@blackwall.org>
To: Nikolay Aleksandrov <razor@blackwall.org>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, idosch@idosch.org,
 pabeni@redhat.com, kuba@kernel.org, bridge@lists.linux.dev,
 davem@davemloft.net

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 12:06:31 +0200 you wrote:
> Roopa has decided to withdraw as a bridge maintainer and Ido has agreed to
> step up and co-maintain the bridge with me. He has been very helpful in
> bridge patch reviews and has contributed a lot to the bridge over the
> years. Add an entry for Roopa to CREDITS and also add bridge's headers
> to its MAINTAINERS entry.
> 
> Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
> 
> [...]

Here is the summary with links:
  - [net-next] MAINTAINERS: update bridge entry
    https://git.kernel.org/netdev/net/c/f653b608f783

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



