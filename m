Return-Path: <netdev+bounces-134006-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1730997A8F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAF3F1C2160D
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2A1186607;
	Thu, 10 Oct 2024 02:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sUMDBubS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C56D813D8B2;
	Thu, 10 Oct 2024 02:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728527428; cv=none; b=tKRyL0rfgidjxzZnEJjli0TgWFk8Frx8siKHN3jriltYg7PBI+7k97y2FxGkGYfiAgFSOySoZyUhYaRTzaK68lWkqKXsFJF3UVqpDlvErzmsLCGXalk/71fJTjV4qpcjanf4vf9ryqkTIp8tDoSA/gtz5LQNABRehSkRfcMru2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728527428; c=relaxed/simple;
	bh=1ZsreGx5NCV539gYczKPvlN1OGp8bG2he7Uvu59CAVQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f6bsmGaol0Gx/Wzia8kRDn7rdIrc2f0WNDYJg1l/EQQ6NgN+GpwclK3yW+8xa9QujcWGiMv+K4stoZcu5pzoB7EcQMoQdZolmgKTumZinuaQMvuvEt33EQ9YXOFApEFzXpVDJYLk0QsOU64c8C1Fi466aJ7PlNX2fVWBbbKHavc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sUMDBubS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B984C4CED1;
	Thu, 10 Oct 2024 02:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728527427;
	bh=1ZsreGx5NCV539gYczKPvlN1OGp8bG2he7Uvu59CAVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sUMDBubSVflfM4W/KvhmT/Osq4S7l65dMa3kobuRRgfUOpr1otPJoVPQ4YRdwwVLq
	 NmV5RRdxifUZbl4iI2PhQRiQbb/nHNkoPe+HNAJQTSw5f+RYF9U9TTvVYKPJiC6Ra5
	 DbDqy7qbTulzHC1FCkeLC2gK0E/d7UZknHSpTzl6mKDdLuXxUo/YNTIlEV7iuFdei8
	 JkW17j+j3Ha4582Pc52Dcn2tre4XGX2c0PTXUJnOxtR4aUchy9iuY9u162dAQ1SibM
	 qHCUOUqb1myur/AfaAosyIqpL/aihMGluOkq65DVFJraO/JpyIgtC8+tr86ylSLToE
	 XAiw5AJtLy/Vg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF0B3806644;
	Thu, 10 Oct 2024 02:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: liquidio: Remove unused
 cn23xx_dump_pf_initialized_regs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852743148.1542036.15677070275258972494.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:30:31 +0000
References: <20241009003841.254853-1-linux@treblig.org>
In-Reply-To: <20241009003841.254853-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 01:38:41 +0100 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> cn23xx_dump_pf_initialized_regs() was added in 2016's commit
> 72c0091293c0 ("liquidio: CN23XX device init and sriov config")
> 
> but hasn't been used.
> 
> [...]

Here is the summary with links:
  - [net-next] net: liquidio: Remove unused cn23xx_dump_pf_initialized_regs
    https://git.kernel.org/netdev/net-next/c/3325964e995d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



