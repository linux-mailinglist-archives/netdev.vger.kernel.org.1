Return-Path: <netdev+bounces-249383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7642ED17DDF
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 525B0300E7A2
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:03:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB99F34402B;
	Tue, 13 Jan 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OZ3rDIAO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990F933F8C5;
	Tue, 13 Jan 2026 10:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298615; cv=none; b=OiSHlxvgR45UCKoNp4QN4XqAf2c26jXFObYPryzRI8ht1EdVfHLrqaK1IueR+cASzUi4hyoayhNFU/AzN00ahO5JfsPNftaIysO6lmJs8prflkPJLUCQAwzI8wJGqGKniEffU4EnAqGjaPl/yl0Q/GGb1BvZd78gYyuErmIA3wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298615; c=relaxed/simple;
	bh=EAvGdCgC6Y7QZ5BpMT7lTdbXqfTu4aZ4EUD1ioOKm9s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Apy5P16DZUQeokLenEQmtVrXHxhNV0PzoF4NIOUwY0pj+yZEKL/PM3vwXSu0MH7h6ub6JHsre3KsCe6pwai7YaYvKcogNGXsIsElpA0z9JSnOvptXDN83A7W5xtjzoR7CI3C0dGNesH4W2Al3M4Ekt3f1tyyixjyAA248nTBVyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OZ3rDIAO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C44DC116C6;
	Tue, 13 Jan 2026 10:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768298615;
	bh=EAvGdCgC6Y7QZ5BpMT7lTdbXqfTu4aZ4EUD1ioOKm9s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OZ3rDIAOWQsFkHdhuvs+ty0/53kEdnIVYgE8NlQSCgaTGuEYNV4sCmMcBZA+FNtUY
	 24rvgyIhDb0zqXX1sA4X2qcm/HKk2aQpzNtRVO4WSEztMHkOCcYwExnjmb+VrCsosY
	 fbBIbDBYwj0bDsyPdMwRKZa4dZucRY2tkhFResJiOoLvgPCu7VsYYYU0SAo5FTs9A+
	 8qKw5W0hIHiHvKvXs8MMCXnxP6npCcpwDFTyBiiky/geBDxEFGr5df4q1lARM6ulFV
	 oZoVshaCABcdnVsot5NGcq2+dmQSzm/i5jploCSatZyFEMDNzTin55SXpX07ZHDAMQ
	 aKeglIvhXoSCg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3BA093808200;
	Tue, 13 Jan 2026 10:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] r8169: add dash and LTR support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176829840911.2162163.10508690250538159049.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 10:00:09 +0000
References: <20260109070415.1115-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260109070415.1115-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 9 Jan 2026 15:04:13 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds dash support for RTL8127AP and LTR support for
> RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127.
> 
> ---
> Changes in v2:
> - Replace some register numbers with names according to the datasheet.
> - Link to v1: https://lore.kernel.org/netdev/20260106083012.164-1-javen_xu@realsil.com.cn/
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] r8169: add DASH support for RTL8127AP
    https://git.kernel.org/netdev/net-next/c/3259d2cf9427
  - [net-next,v4,2/2] r8169: enable LTR support
    https://git.kernel.org/netdev/net-next/c/9ab94a32af70

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



