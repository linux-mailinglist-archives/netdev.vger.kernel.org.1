Return-Path: <netdev+bounces-193468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5063EAC4283
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 17:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CA967ACF12
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 15:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA87215193;
	Mon, 26 May 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbXqeYok"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A237C21507F;
	Mon, 26 May 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748274000; cv=none; b=vAKga6ZM6AOJkJUYDvI6nC3CfiEgU63n9hMDyfOrVZTAIZ2rOeQU34RLoXloaWSkpcwAg8mgslQ2UfvqYIcwrxDuAo/I3xl+d04XOGbf6opcpyX13LvdRxvt9mUUGM4sssxCD6tsbOiSqb6BnbXlf1lzldaFYLyh0+f9nv1LDNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748274000; c=relaxed/simple;
	bh=YQ6Ly+xBPMeVJ+JVo7f3xRiXkboBAQ6F9hhHJQEGf84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=V8E0r6PMLNkO7IKY+gBo55mvsdJz9545w3oIvjxqk0c5jKoQ6hZt9AgWCdGFysMKth4Yckq6btwEH/AZtAlZPqOgEo9pFrqcAVNIwdqcZKPd4qtLhPHrsn8r4Q++TEf457l8BXxfYNVUdwOjTVXiOgMtFU7UID1EIaslWQb31+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbXqeYok; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75709C4CEE7;
	Mon, 26 May 2025 15:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748274000;
	bh=YQ6Ly+xBPMeVJ+JVo7f3xRiXkboBAQ6F9hhHJQEGf84=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QbXqeYokd7wqEyGnBYiB9sPwODzrPB4IFKF0PgR3A4lfNgAluaiXjUelPqTaKHnNU
	 56ZmkELpxAieLx0x+uWU0m4U0jhpTf9kWAbsRrb1x9FdyznBKc8LboD8l259dGN4br
	 6KeSYRfQWl08zyq5cTWCtMVRQ0qtfF92XgdtCBsIp8b9zeOcmsJndbkym7yHm79GA1
	 OcJSZD0DjMyENQ0HdvrQjo3UdVcXwL9nq0FVKz251IsHvhsF9i259oijQ759/dBPJu
	 tdsj1L9l64hPKxcS9GlavrMF5NKN+5aMi5bZ5O5zDBPBSSJciFR3dgEZwcVH5qVylB
	 QFs14TJ5FGuRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B263805D8E;
	Mon, 26 May 2025 15:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/4] Add the capability to consume SRAM for
 hwfd descriptor queue in airoha_eth driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174827403500.961666.15762374544120433912.git-patchwork-notify@kernel.org>
Date: Mon, 26 May 2025 15:40:35 +0000
References: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
In-Reply-To: <20250521-airopha-desc-sram-v3-0-a6e9b085b4f0@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 May 2025 09:16:35 +0200 you wrote:
> In order to improve packet processing and packet forwarding
> performances, EN7581 SoC supports consuming SRAM instead of DRAM for hw
> forwarding descriptors queue. For downlink hw accelerated traffic
> request to consume SRAM memory for hw forwarding descriptors queue.
> Moreover, in some configurations QDMA blocks require a contiguous block
> of system memory for hwfd buffers queue. Introduce the capability to
> allocate hw buffers forwarding queue via the reserved-memory DTS
> property instead of running dmam_alloc_coherent().
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/4] dt-bindings: net: airoha: Add EN7581 memory-region property
    https://git.kernel.org/netdev/net-next/c/2d13b45f8086
  - [net-next,v3,2/4] net: airoha: Do not store hfwd references in airoha_qdma struct
    https://git.kernel.org/netdev/net-next/c/09aa788f98da
  - [net-next,v3,3/4] net: airoha: Add the capability to allocate hwfd buffers via reserved-memory
    https://git.kernel.org/netdev/net-next/c/3a1ce9e3d01b
  - [net-next,v3,4/4] net: airoha: Add the capability to allocate hfwd descriptors in SRAM
    https://git.kernel.org/netdev/net-next/c/c683e378c090

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



