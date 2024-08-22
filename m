Return-Path: <netdev+bounces-120938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9522795B3DA
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14D44B20C1C
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC00C1C93BB;
	Thu, 22 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOvG0IcW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E75184554
	for <netdev@vger.kernel.org>; Thu, 22 Aug 2024 11:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724326230; cv=none; b=oaSlvdfoMQZYp+dWQDtpPRWes/ESwM9Yg7255YfzehqmWGraatwIy6oLvsI6Vcfix05KFw8ytn4p/luCAgZCy2MFDzmx4O3iJiewjN58UzPa22LX0NnVIBthSUEDF5uGgU9RNu33QdJ1e3tdBrcskXPmgQ5n4FGZ9mEiRtbrkQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724326230; c=relaxed/simple;
	bh=732TUHJsVCkB+VsewfPuoLbr/UQnDzzjBPzT+7YBOvc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SwwtRwqZ/xOOCCZn+wszQYFWrwBG6tcCrEOC0CWEajE8KESXcV4fZKFjx45TnM2OprLTxLThofnF7DNOwjkU1Mkwj2QxJxfNzAKQw7d1C21uWfixBUFLNXQtczs7WCrKmG9JlwYV/iuAUXaWRHRe8RKgLKd0wZkgSENiZHz6JPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOvG0IcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7CAC32782;
	Thu, 22 Aug 2024 11:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724326230;
	bh=732TUHJsVCkB+VsewfPuoLbr/UQnDzzjBPzT+7YBOvc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XOvG0IcWK2OLjQKhi7Akhp6uS93EqMf210IFl8tGyG3xXaMIQg+vQb+bkdlzp2VKi
	 J9mxVjRR1wcxeSNIBuoq7DXA8bYuLCTBa4ofNguztJ0+pspo66aud5l3YzyvFZKiTM
	 BNl+skEmVf4evFSLM6a2B0pZz90ugfhkvxf0CJuqDXPkfArS7IqnJ1bJlzACOqGQ56
	 if6zC0LeFKowOnvUhsYW1+yFzlrf0s/P4cKDd80QmoVeXPZ2NvwVSCCw6kbVx+vC6N
	 8tn88ETRHmCpO5Yb3jOITml0vqeYLVi7FlBeIw1lC7aHtKjVohI5fabl9v55w3V7Do
	 PzI+Fsc1avsuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE3D3809A80;
	Thu, 22 Aug 2024 11:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: airoha: configure hw mac address
 according to the port id
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172432622976.2293429.5896662227992279102.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 11:30:29 +0000
References: <20240821-airoha-eth-wan-mac-addr-v2-1-8706d0cd6cd5@kernel.org>
In-Reply-To: <20240821-airoha-eth-wan-mac-addr-v2-1-8706d0cd6cd5@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: nbd@nbd.name, sean.wang@mediatek.com, Mark-MC.Lee@mediatek.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org, lorenzo.bianconi83@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Aug 2024 09:30:14 +0200 you wrote:
> GDM1 port on EN7581 SoC is connected to the lan dsa switch.
> GDM{2,3,4} can be used as wan port connected to an external
> phy module. Configure hw mac address registers according to the port id.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - improve code readability adding reg offset for {LAN,WAN}_LMIN and
>   {LAN,WAN}_LMAX regs
> - fix signed-off-by tag
> - Link to v1: https://lore.kernel.org/r/20240819-airoha-eth-wan-mac-addr-v1-1-e8d7c13b3182@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: airoha: configure hw mac address according to the port id
    https://git.kernel.org/netdev/net-next/c/812a2751e827

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



