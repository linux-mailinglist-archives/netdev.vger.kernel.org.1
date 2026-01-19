Return-Path: <netdev+bounces-251224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90CD3B56A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 19:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4455B3000B25
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 18:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C7D30F52F;
	Mon, 19 Jan 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MfHTsFU/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8640830B512
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 18:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846808; cv=none; b=mS09G4o9wjoDN9GNZr3Ga2qt8F/Xmkx+5yPFT2S0nJqJ8eFSbN7uZn1fDv4z4qqftfScoIzLG0PMgotuy4oG0d69RnPXpv0kuwXGhbGRHoF7LUL4EwDg+WUnW//Q8KtwLM+vY+1hTY3Hi538J1aOaJU6orbOERpLBNTxfR7rOnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846808; c=relaxed/simple;
	bh=faPOCLZKJVU/zamNNsx72NQDAHgJRXZ/aEAuEYR70Ls=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TPB2xcXzVCQZa9JembQVu2bS2lFM064UhBnd/ffMfyM8X4aHebnAE3h1usjXcx+o4EsQWYlCkjqPg2+bhyB6fn4Ej3QQ4CdDl5RA2FK8AW/9Gt64lZu/BPzxcyKjRr34iTNEF6cidFI22GL/te9NhJCgtwxC9mtrNGmkIh2aylQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MfHTsFU/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218FCC116C6;
	Mon, 19 Jan 2026 18:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768846808;
	bh=faPOCLZKJVU/zamNNsx72NQDAHgJRXZ/aEAuEYR70Ls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MfHTsFU/FQ+53v5IOrUasNGCLvDD1fAybXBm516D3uKfUnPL9ASrh1LgmslTwqXKZ
	 s9pgCz6Xk0fU2LTUtR3O7zTwEyP5UNQ+u6gMI+Snq4v0IeNuSq7zjIH0QjLz036JmE
	 6OtiaOk1EgYxCL7cbdn8muUcZi0Oukko8DApzxgsIWiPSHjDnhZ1A4IzUvjsajTEZ3
	 +/1pqr1NQ9qw/9LFd77698wGOUW9reffQBk9yZRgf2Om+cpsqiJisUnLqgCst3NxVh
	 H5LXnXkdQZfig5WcLpe9ruITfcJPamI7TXTJF+4xV6dW2bAA3iHk7tYRbkAsAWbSyW
	 LYvrIbDkksH2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3EC1B3806905;
	Mon, 19 Jan 2026 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] octeontx2: cn10k: fix RX flowid TCAM mask
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176884680604.87873.3267605677897414797.git-patchwork-notify@kernel.org>
Date: Mon, 19 Jan 2026 18:20:06 +0000
References: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
In-Reply-To: <20260116164724.2733511-1-alok.a.tiwari@oracle.com>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: sd@queasysnail.net, bbhushan2@marvell.com, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, sbhatta@marvell.com, jerinj@marvell.com,
 hkelam@marvell.com, gakula@marvell.com, lcherian@marvell.com,
 sgoutham@marvell.com, george.cherian@marvell.com, netdev@vger.kernel.org,
 alok.a.tiwarilinux@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 Jan 2026 08:47:12 -0800 you wrote:
> The RX flowid programming initializes the TCAM mask to all ones, but
> then overwrites it when clearing the MAC DA mask bits. This results
> in losing the intended initialization and may affect other match fields.
> 
> Update the code to clear the MAC DA bits using an AND operation, making
> the handling of mask[0] consistent with mask[1], where the field-specific
> bits are cleared after initializing the mask to ~0ULL.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2: cn10k: fix RX flowid TCAM mask handling
    https://git.kernel.org/netdev/net/c/ab9b218a1521

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



