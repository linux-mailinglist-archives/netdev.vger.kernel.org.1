Return-Path: <netdev+bounces-117974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BC2950230
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:14:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87F3FB21D3A
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618A6168C20;
	Tue, 13 Aug 2024 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpxl6OBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BB919470;
	Tue, 13 Aug 2024 10:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723543910; cv=none; b=V4FCJXosBJVXSaWPS20Uuahwjee9af6tPS7n6QA1coL0484O9FLoS4qs6qvs5fn/C5DWQJyLPziL1K0HV/QQqJbSZHrxM6a39oKpj0Hgbzs4TdUq5F56DQ+lItbMCs6y/pxJHQYy22RaiMKHcH5TYJN1LF4G6jwQJuM+MZCCKl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723543910; c=relaxed/simple;
	bh=xrmke/+b/gAxykS4+WeRwGdZZ4PMCdrJIMmEVeoTptc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eZZxFp2jw8f7hlUv5aV1L2V/2NOr0aaVaCR+rhmG/wVh5v62Kr4CWcuUkMwozZyq52sDq6V+1ZiXq8JSAybsKDYJR+oe7IEG9O1lYJHaPYbucfkjJ5eLAa9PGD6SIlhSiq95SG7gnhMeHqcB0JeUhZ1+mZCQ+Udru23UWtEpdwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpxl6OBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F81C4AF0B;
	Tue, 13 Aug 2024 10:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723543909;
	bh=xrmke/+b/gAxykS4+WeRwGdZZ4PMCdrJIMmEVeoTptc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cpxl6OBBW77UCCY4B+O96lYk+JpiJZ2Btlmoz/de4kBd4FxN23VDvlajOeNULkjvG
	 TSWUc/fybcg+bd4WesQlKgDiWgeN8aY7gZ3P/LuM8eOwYsaolDSSXLYEGtGJ5IOqSu
	 C6j++Vntujxn526bLXMEsoVhctw3dgnPvG+sV3Nyb9aOC5nuIBnGNwsslxDPHTodYm
	 94SOaF04IXZAY/tvzc9XOF3o8fHpZNkZASlObIadhLcyjuGpIoZJbyiP3OxiQD+uan
	 vM941FgTE7UWRYOcWdCBTusWYCHuyZqidHWdnOo2oIQde3go1QkEFc64/1KtpG4OJp
	 1M0a1vdXQAZ4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4A53823327;
	Tue, 13 Aug 2024 10:11:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: hinic: use ethtool_sprintf/puts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172354390843.1583477.16089493956028109034.git-patchwork-notify@kernel.org>
Date: Tue, 13 Aug 2024 10:11:48 +0000
References: <20240809044957.4534-1-rosenp@gmail.com>
In-Reply-To: <20240809044957.4534-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, cai.huoqing@linux.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  8 Aug 2024 21:49:51 -0700 you wrote:
> Simpler and avoids manual pointer addition.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  .../net/ethernet/huawei/hinic/hinic_ethtool.c | 33 ++++++-------------
>  1 file changed, 10 insertions(+), 23 deletions(-)

Here is the summary with links:
  - [net-next] net: hinic: use ethtool_sprintf/puts
    https://git.kernel.org/netdev/net-next/c/dd1bf9f9df15

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



