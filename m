Return-Path: <netdev+bounces-105102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4B490FA6F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA475B21031
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661021C17;
	Thu, 20 Jun 2024 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKWlkCn2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBA036D
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844633; cv=none; b=OsaHTsZzjNUdE4BeS0FHTyJ0Uk28Sf7N6Sr7eRH3NpsqfmgwqC8Sh8m2BvvzpoI9jY7a8CFodAg6P08NR0pLwEilwPrtG1FSWRLlAt8A9JaYjoP+aVPmp/vR+EkEs4Q/cf55hqzAtI5jXg9vV8Czb8kRO/csLXcnSHoAWj+197w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844633; c=relaxed/simple;
	bh=UTQrUe4gLd3Ha34To1lzbeQdDdhHeJ72sbmLti7k4L4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2TMgwV5/cYikwhL1bfCnHvgoia+tQkFP1V9U9SeMp85tHq+w63vFBDIwkbfmkdvWOjcEcpgMc18dEhGL85CvhTIhTSvUmRr136fw0o68GbZEGjB46xoakjGKIROngi1aBgbdF6rIFRH04W/8EyjcI89TOmQcNG1YY8YIpHVfto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKWlkCn2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AC699C32786;
	Thu, 20 Jun 2024 00:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718844632;
	bh=UTQrUe4gLd3Ha34To1lzbeQdDdhHeJ72sbmLti7k4L4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UKWlkCn2ojijTnZx28okcaPCU6/ZbyFJ/2qnhw9s3PLfBLp7GrPvIhGp0t4hdVQ74
	 GVzRr2zfCSz2bF9iFK/hlWEq5tdGdB4/4OBIN6rGIMunOgcsPNp4zVCZzuKOqKXUqn
	 6Lfc0udp8VTEm9xgR3YVZAg+9N6MsHon7ArW7pJUXDh4UK0kMHVY3TXTLf7TZoGN/s
	 FNMdBh0dUoABVYI3kUlv6sN+h9ma1THsqKY6er0njLMuPU/nMJ7NKHmt3/y416zVc0
	 lX+0hbFzBRqbdk0RN4krv9jO89irmFVksjsMd235IrpD2KqHKZW0s06rVk9uDeAzL5
	 mogRiLe0iBZZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 95086C39563;
	Thu, 20 Jun 2024 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] mlxsw: Use page pool for Rx buffers allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884463260.1669.4829676069080394428.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:50:32 +0000
References: <cover.1718709196.git.petrm@nvidia.com>
In-Reply-To: <cover.1718709196.git.petrm@nvidia.com>
To: Petr Machata <petrm@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, idosch@nvidia.com,
 amcohen@nvidia.com, mlxsw@nvidia.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 13:34:39 +0200 you wrote:
> Amit Cohen  writes:
> 
> After using NAPI to process events from hardware, the next step is to
> use page pool for Rx buffers allocation, which is also enhances
> performance.
> 
> To simplify this change, first use page pool to allocate one continuous
> buffer for each packet, later memory consumption can be improved by using
> fragmented buffers.
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] mlxsw: pci: Split NAPI setup/teardown into two steps
    https://git.kernel.org/netdev/net-next/c/39fa294f580a
  - [net-next,2/7] mlxsw: pci: Store CQ pointer as part of RDQ structure
    https://git.kernel.org/netdev/net-next/c/7555b7f3385f
  - [net-next,3/7] mlxsw: pci: Initialize page pool per CQ
    https://git.kernel.org/netdev/net-next/c/5642c6a08693
  - [net-next,4/7] mlxsw: pci: Use page pool for Rx buffers allocation
    https://git.kernel.org/netdev/net-next/c/b5b60bb491b2
  - [net-next,5/7] mlxsw: pci: Optimize data buffer access
    https://git.kernel.org/netdev/net-next/c/0f3cd437a1d8
  - [net-next,6/7] mlxsw: pci: Do not store SKB for RDQ elements
    https://git.kernel.org/netdev/net-next/c/e8441b1f6b64
  - [net-next,7/7] mlxsw: pci: Use napi_consume_skb() to free SKB as part of Tx completion
    https://git.kernel.org/netdev/net-next/c/d94ae6415bec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



