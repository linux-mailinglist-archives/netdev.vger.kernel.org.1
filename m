Return-Path: <netdev+bounces-203118-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D781AF088F
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 04:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E798171160
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 02:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67111ACEDE;
	Wed,  2 Jul 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Bf/eU3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D92714A62B;
	Wed,  2 Jul 2025 02:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751423999; cv=none; b=ulcoCWjy3VeA0QdH0CB1lJfBJfTsvByaJrXPfmgzgTMoWBSXlDdCTOKdneg1aXGtQuzgZVYPVm25CdLV9XOcLWPTO5WB1Not9P3FyWxhv81xsKrpHb7Tglipzfy3Y5EtN4AWX+OkJ8TDO7WvaCVg4TXALBqctMcdCWyixXYlfe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751423999; c=relaxed/simple;
	bh=mmwcxFS8M6BVCedb3hMbZp6UScETxHWyOl9HJAxO40s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B9p6M9oghV+d6hLjBgpglBGPQSca5STL9+1oeV1Zq74Plt/rCN5xNdLXagbflHiQh/UwuCCU5yW4pGXSTwspwOi0aacNatexZVfvjdq5B2D7k9PvrziUo8ht2PVv7GcQ32f3Kuhq0HfJ4i41cU9FUjJuHR9Eulj8CKFjvQ3G6zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Bf/eU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7175CC4CEEB;
	Wed,  2 Jul 2025 02:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751423999;
	bh=mmwcxFS8M6BVCedb3hMbZp6UScETxHWyOl9HJAxO40s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n/Bf/eU3GH5kqN6/P4xhXUz+CJD6ND+K+pLKPupMzivmzFJ1cGY8UtLQRsVcMpzNL
	 i/QsrfI17ioj0i9Wr4zRIyVvTU1iMoKK8sWyPQFOeNW7TwnFGG7Fwh9/lcFy5LEZxI
	 AHL7ErcMutJc/s8zMdWX8O9gWS6V8FYbmqkqYTJ0NpRpL89de1OJ+yL5tMfwZFAxLd
	 kSmm4inheufYpyMsWPhX3Nbdj5r8GGgqi6XObdbUJ4xq3dUgRHlE9l/qr8e1OVgGA9
	 0KSi7PQM8YuHDE//NY/nGsLxpXJvfBraVlec7DVkv/XvoITspUOa40W2RpbW+VXZ/h
	 TdNul3qS5Q/8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E81383BA06;
	Wed,  2 Jul 2025 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] seg6: fix typos in comments within the SRv6
 subsystem
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142402424.183540.7987068313674190464.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 02:40:24 +0000
References: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20250629171226.4988-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, horms@kernel.org, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stefano.salsano@uniroma2.it, paolo.lungaroni@uniroma2.it

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 29 Jun 2025 19:12:24 +0200 you wrote:
> In this patchset, we correct some typos found both in the SRv6 Endpoints
> implementation (i.e., seg6local) and in some SRv6 selftests, using
> codespell.
> 
> The patchset is organized as follows:
>   Patch 1/2: seg6: fix lenghts typo in a comment
>   Patch 2/2: selftests: seg6: fix instaces typo in comments
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] seg6: fix lenghts typo in a comment
    https://git.kernel.org/netdev/net-next/c/db3e2ceab3c7
  - [net-next,2/2] selftests: seg6: fix instaces typo in comments
    https://git.kernel.org/netdev/net-next/c/3bedaff19bd8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



