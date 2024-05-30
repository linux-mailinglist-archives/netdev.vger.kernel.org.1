Return-Path: <netdev+bounces-99254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9186E8D43AA
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 04:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB00E1C21934
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 02:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2201BF58;
	Thu, 30 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQPjuz3p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6615017C64
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717035630; cv=none; b=SboefP3vaEV7TnjipBCMW/pCrqA5iF2VKuSOXv489mlQD1ZGpot36p/D8SWoMXRxCSW3TBEltsZNfwYrW2J9ncEhgKLRmdkvhEV7gJGcpLkNAW9aQwih/Jfd3TTJRzhnt84BlNbnyWsjqYIsRgNumRb2uG0INxhT6yPgUimgUVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717035630; c=relaxed/simple;
	bh=EBj0Nz7dl/6WJcb3jAGvsJP/OJTFmI9Fcw9mMMU+UWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pc1cTCjlFrwT1v4aPhKTezzrzVUfN3da36HXOiCGq5rv/sMJsMkbXpD17A22D+Uc8A4iEDLNdoKnzx7n37XQQmoglo8erqxmjNgUCjOZr6qpIRVzJ7s25InJakbNcBjpDATJe8HJOfld0Al4PrTwac0gdElhgtYKSEA+RCwnEZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQPjuz3p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C5B2CC2BD10;
	Thu, 30 May 2024 02:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717035629;
	bh=EBj0Nz7dl/6WJcb3jAGvsJP/OJTFmI9Fcw9mMMU+UWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQPjuz3pZ/Xjmm2rfLWqYCdK61mmkAonORTkd+oOkdmr9XPaDzqwtPA2mZ9r38F6x
	 /9tW+tALTGeFU2d6ju/6UO+grgEaP1Kneaoray3dPdXbpLTw/L1AoQa+jjOKVMge3y
	 9CbPnYcgUCOYfAhpAf7cFf0ERSslv5vuHRavmpQSu9sWKxL4KhuO75xMtWIbsZJqwq
	 ikV7RDk/HCqIUqI00XpOXleOImC+PqbD/Ln5O/BIj0B2kLRQhXiL5D14IGN3Xry//0
	 4iJTy255J42jz8h26+xCQqP9O+L6YEcs/6l82fT7lzKYxiNZE0wDwVepNVWpPkjoUf
	 kZ2sEVO81JdcA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3696CF21F3;
	Thu, 30 May 2024 02:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] net: ena: Fix redundant device NUMA node override
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171703562973.15191.6729764557310515725.git-patchwork-notify@kernel.org>
Date: Thu, 30 May 2024 02:20:29 +0000
References: <20240528170912.1204417-1-shayagr@amazon.com>
In-Reply-To: <20240528170912.1204417-1-shayagr@amazon.com>
To: Shay Agroskin <shayagr@amazon.com>
Cc: davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org,
 edumazet@google.com, pabeni@redhat.com, dwmw@amazon.com, zorik@amazon.com,
 matua@amazon.com, saeedb@amazon.com, msw@amazon.com, aliguori@amazon.com,
 nafea@amazon.com, netanel@amazon.com, alisaidi@amazon.com, benh@amazon.com,
 akiyano@amazon.com, ndagan@amazon.com, darinzon@amazon.com, itzko@amazon.com,
 osamaabb@amazon.com, evostrov@amazon.com, ofirt@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 May 2024 20:09:12 +0300 you wrote:
> The driver overrides the NUMA node id of the device regardless of
> whether it knows its correct value (often setting it to -1 even though
> the node id is advertised in 'struct device'). This can lead to
> suboptimal configurations.
> 
> This patch fixes this behavior and makes the shared memory allocation
> functions use the NUMA node id advertised by the underlying device.
> 
> [...]

Here is the summary with links:
  - [v1,net] net: ena: Fix redundant device NUMA node override
    https://git.kernel.org/netdev/net/c/2dc8b1e7177d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



