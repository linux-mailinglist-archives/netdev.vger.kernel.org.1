Return-Path: <netdev+bounces-134736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B82F299AF1C
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 01:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78AC2286EBC
	for <lists+netdev@lfdr.de>; Fri, 11 Oct 2024 23:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F641EBFF4;
	Fri, 11 Oct 2024 23:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvyfOZs+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217F1EBFF1
	for <netdev@vger.kernel.org>; Fri, 11 Oct 2024 23:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728688247; cv=none; b=rgXu8guJ7aRxIpB+wIheNFF2ikc4ifIxcXb1lE8iMNkzxlEhTgsMxJdFD5TO+0wK+PUd396ogVW14fW4qa6wXi8wiI8bn7mQaSvRNuK/0cT58d+Uc1kMgRiuY67ODg5Sy8gI/tA+NSX+K1+ybvMd1mj3z+X1wbVPl3lA1B4GFjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728688247; c=relaxed/simple;
	bh=zgFrzn2om3DJ2wLjVmPkCt1pztmJ/FzYwmtvQGTbLy0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=C+VKuw2ddm3A49sxCnNAweuPUKDFVa5BuNUw49qiokS8RH9ngoIQWqk3My6vQmcpqikbDkvWN4rExht3Rfckp6C3ViNrNXiydhr7W443MliViFdBvBdPatbMgxXaRIYDO5v4Qm6fXZBNjeCTbkyBcGSljPMeHJBgN6eOGMtcGbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvyfOZs+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2025C4CED0;
	Fri, 11 Oct 2024 23:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728688246;
	bh=zgFrzn2om3DJ2wLjVmPkCt1pztmJ/FzYwmtvQGTbLy0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CvyfOZs+1X+UcvUki9+LfDXFkxhRitfnlrh/EhaN9/LNhSdMr1YKLyBTucSOpYvM/
	 FPnKKafYo0TIWK49yeyTiRZZ3/11d7JmHLPS+uTlLer4najiEspM0K3cZh6tP3Z9EZ
	 9Fcr4AtuIAIC3P34LBwq3qkB5tb9yncICgYtXL8Z/efg27EfE5sWn6sQzbdjAT9AoO
	 NWEwLDSbym8lsWCHB9rOuMRiRyqzd7ZXIt5LZOfuR2Y3en8047rvBCzKRDsO60rLt/
	 xaGGDja74oWlKP5Jk8O6ujTrHgYK8auihOMUUGBEk2u5Gj8kqJAslJuKFFGUvlOrYJ
	 uA4AF0TAUc4uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDBB38363CB;
	Fri, 11 Oct 2024 23:10:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: bcmasp: enable SW timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172868825124.3022673.9008841464887207302.git-patchwork-notify@kernel.org>
Date: Fri, 11 Oct 2024 23:10:51 +0000
References: <20241010221506.802730-1-justin.chen@broadcom.com>
In-Reply-To: <20241010221506.802730-1-justin.chen@broadcom.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 florian.fainelli@broadcom.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 10 Oct 2024 15:15:06 -0700 you wrote:
> Add skb_tx_timestamp() call and enable support for SW
> timestamping.
> 
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>  drivers/net/ethernet/broadcom/asp2/bcmasp_ethtool.c | 1 +
>  drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c    | 3 +++
>  2 files changed, 4 insertions(+)

Here is the summary with links:
  - [net-next] net: bcmasp: enable SW timestamping
    https://git.kernel.org/netdev/net-next/c/c531f2269a53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



