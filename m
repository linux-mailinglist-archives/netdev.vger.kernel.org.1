Return-Path: <netdev+bounces-120931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B7CFF95B3A9
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 13:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5A61F220E2
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 11:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104491C93A6;
	Thu, 22 Aug 2024 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HpyzUIT+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DBB183CC7;
	Thu, 22 Aug 2024 11:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724325633; cv=none; b=hicOs7VMqe37JMj5O6UGsjq2a8ePq9LkSM51WxSnrRgrQUorn5knsgSpj7YCSDYALOMVG5nyABVpHNlY6Mm1VNnEllL7NDK9nudv9aHJHjgz/T2Mcpjfd2skf888+QBGI7Ae3afl2kBfkselGIHJxWq2bUIFFYWIxmeRrRrGeNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724325633; c=relaxed/simple;
	bh=W9zzyC79Di5ouv9UwCv0oBYTSnRehCS2jEyLnu2TMLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ci5iZpfvC7CNFuvABS3kPwThqjaR5hNw4gxWQTgHz7731eIqQqiXkb6OFqrFZ1i9wNiHl1nxd6atmK/AUVVK2WDCKtCaso30gF3SrwO7k1pDr6iy6Ev3pymr1m//xQD3U//yReUqcMy0sn3HVNiDhDLa+pyTdjyHtvOFInLK2Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HpyzUIT+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCCDC4AF09;
	Thu, 22 Aug 2024 11:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724325633;
	bh=W9zzyC79Di5ouv9UwCv0oBYTSnRehCS2jEyLnu2TMLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HpyzUIT+Q8tZjC66wxIUsObAn4JkSDNIZ0V6CzPy8KyHBO88YcQoStPTe/boflyUn
	 IGnnyi8FhcEFGC8iPz+cy9xDVPsaSEvYRFjCK49PenMUL38P0et622+KNl88SD3raD
	 85XftUsGN/YtlLBI8pSSvNtKLBvJ5ev2E4d6giirjg8kdAy35FL/5k669Oumsa8YP1
	 kfYgn8YC7/wav71eLn5JsCG/yBEur0ILm2vIiz6NAGGwPYSIXA9u3oUo5nQi3oviwO
	 QoJRjL/kdZFoK3phB02txovHWFSAlZ2KGDHWy32gqUQDdAeeBpT8pZnG2PKtHB+TGU
	 5vS7Krtp8XKew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B763809A80;
	Thu, 22 Aug 2024 11:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net PATCH v3] octeontx2-af: Fix CPT AF register offset calculation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172432563290.2291309.15266043095086207002.git-patchwork-notify@kernel.org>
Date: Thu, 22 Aug 2024 11:20:32 +0000
References: <20240821070558.1020101-1-bbhushan2@marvell.com>
In-Reply-To: <20240821070558.1020101-1-bbhushan2@marvell.com>
To: Bharat Bhushan <bbhushan2@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 hkelam@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
 ndabilpuram@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Aug 2024 12:35:58 +0530 you wrote:
> Some CPT AF registers are per LF and others are global. Translation
> of PF/VF local LF slot number to actual LF slot number is required
> only for accessing perf LF registers. CPT AF global registers access
> do not require any LF slot number. Also, there is no reason CPT
> PF/VF to know actual lf's register offset.
> 
> Without this fix microcode loading will fail, VFs cannot be created
> and hardware is not usable.
> 
> [...]

Here is the summary with links:
  - [net,v3] octeontx2-af: Fix CPT AF register offset calculation
    https://git.kernel.org/netdev/net/c/af688a99eb1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



