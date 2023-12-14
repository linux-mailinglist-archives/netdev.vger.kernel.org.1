Return-Path: <netdev+bounces-57236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 920458127DA
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 07:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0083EB2124C
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 06:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD8EC8F4;
	Thu, 14 Dec 2023 06:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bD57LKX1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F1CDD260
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 06:20:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6557C433C7;
	Thu, 14 Dec 2023 06:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702534828;
	bh=V8+mvp2tHK886vD0aGKuCjohwv8jaCme4mhV2C6XeYE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bD57LKX1kxqgCoe6XNGw3LiGvbhC4ebCErKoSo5BkO1qPHOG3jhk/BNEBIL9/3t0m
	 Vaw/jZ+ERSHF/FxLjrNSYSnLKJmvrnOZlePNd891+IFnsXDGNBDj1ruNMVbudtLYnq
	 1joNoixlwpQ7kRlOAbpH8k+uVfbcKsNcaJZrWzt6dRQIHbqdqJBkHJfvcEysLE6hO+
	 9qwjSsUDXk8bRXcRuevhjAUfeeoHfzXzxBLTqswLgY1ugD0q+1LyaK8AU+09AQh/p4
	 HVEjfQ32L7DkQjsXYjZuFa4MF6wmUJ3w0m2F1vUbe74S4y+xYkI0VX8TbLCFO/pTj3
	 U6QZhaAI2kyaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C994BDD4EFC;
	Thu, 14 Dec 2023 06:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3][pull request] Intel Wired LAN Driver Updates
 2023-12-12 (igb, e1000e)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170253482782.28524.17079894571846314196.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 06:20:27 +0000
References: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231212204947.513563-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Tue, 12 Dec 2023 12:49:42 -0800 you wrote:
> This series contains updates to igb and e1000e drivers.
> 
> Ilpo Järvinen does some cleanups to both drivers: utilizing FIELD_GET()
> helpers and using standard kernel defines over driver created ones.
> 
> The following are changes since commit 609c767f2c5505f104ed6bbb3554158131913f86:
>   Merge branch 'net-dsa-realtek-two-rtl8366rb-fixes'
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] igb: Use FIELD_GET() to extract Link Width
    https://git.kernel.org/netdev/net-next/c/4f6011678d38
  - [net-next,2/3] e1000e: Use PCI_EXP_LNKSTA_NLW & FIELD_GET() instead of custom defines/code
    https://git.kernel.org/netdev/net-next/c/4c39e76846b2
  - [net-next,3/3] e1000e: Use pcie_capability_read_word() for reading LNKSTA
    https://git.kernel.org/netdev/net-next/c/bf88f7d920da

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



