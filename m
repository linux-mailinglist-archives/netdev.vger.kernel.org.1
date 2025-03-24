Return-Path: <netdev+bounces-177230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3827EA6E5D2
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 22:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F10B3B33EA
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 21:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B71EA7DB;
	Mon, 24 Mar 2025 21:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAM6ok8b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAED41E7C28;
	Mon, 24 Mar 2025 21:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742852399; cv=none; b=lfqZfVIgHpYyLRL31P8Y76DeziWV0xuPUoj80U53sAPyrO9dHuQWY4YYfBSjVGHdd+nlbIb2GR++LgrDJtN/J8YSN0hh9dtORTeWRKi6B/gMj079c1EU7OhPf2NhO+O8U4q23DOyhxia+6WPJFxCrxQIkQ1q1/4LxDqOrvZRuyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742852399; c=relaxed/simple;
	bh=ruhoY9NpX0dDbmIEcJWyohdrH0Le0+g2wu9SJ7FF5dI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q2NMHznE04QjrLHs/mrL2mWuoRCaZXmQB0bWlovk6lYNhenkNbyam+nT77oZHYY/m+5Jxe7/3Kha/1z+bPb3sZkF3KHIdDG3gfT1B7uPO7fhWT1kjK2X1HJ7c321cSCkUFcobQsAv0QCZ9H+v2ueKQQorciGeGRzw1dH0jAAuSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAM6ok8b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CDB7C4CEE4;
	Mon, 24 Mar 2025 21:39:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742852398;
	bh=ruhoY9NpX0dDbmIEcJWyohdrH0Le0+g2wu9SJ7FF5dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eAM6ok8bIxOBIvtXQFUjm4Ircec7SeIl4gkkMC4b1olPE5yRMWK6GH4/CWOBH0XBi
	 W0+TrZVeP0oaUecxt6l8i1TQOcNQM2eReVYg0Iv15tYq58C+BSG/faZP0kJF0LFvB3
	 zHvGs1XVrMCs0+J0XzWAtSWKtyUqlp4oJI0Wum7svqkuCOG6vjxj6bpsSXa+YWMIKK
	 CI6O5CP3PwTSUQum9oxB55AqjgSBm1Sq4htD4Vq3J5mcLwtFOsNMGkQyc67SFuxzgj
	 VgoNJFZF3N2nszkAdeq8pIaEr4t8wMg9GDaOp42nRfGDoOfX3OXHa4RfGMvnZpJf8Z
	 ZP+vbRmWRZi3w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD85380664D;
	Mon, 24 Mar 2025 21:40:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] tty: caif: removed unused function debugfs_tx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174285243451.4187423.6488718508780973419.git-patchwork-notify@kernel.org>
Date: Mon, 24 Mar 2025 21:40:34 +0000
References: <20250320-caif-debugfs-tx-v1-1-be5654770088@kernel.org>
In-Reply-To: <20250320-caif-debugfs-tx-v1-1-be5654770088@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: gregkh@linuxfoundation.org, jirislaby@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nathan@kernel.org, ndesaulniers@google.com, morbo@google.com,
 justinstitt@google.com, linux-serial@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Mar 2025 11:19:20 +0000 you wrote:
> Remove debugfs_tx() which was added when the caif driver was added in
> commit 9b27105b4a44 ("net-caif-driver: add CAIF serial driver (ldisc)")
> but it has never been used.
> 
> Flagged by LLVM 19.1.7 W=1 builds.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> 
> [...]

Here is the summary with links:
  - tty: caif: removed unused function debugfs_tx()
    https://git.kernel.org/netdev/net-next/c/29abdf662597

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



