Return-Path: <netdev+bounces-109586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60FA2928FCA
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:50:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 174641F2227C
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341995223;
	Sat,  6 Jul 2024 00:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JZQQe80n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6653D68
	for <netdev@vger.kernel.org>; Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720227032; cv=none; b=cdeADKbsT14dyGHwBhunJSQiWfpmPRV8rlUqts1Q4SPpWiOZ2sWszuYE3ES9Dn7D0sowN5xe6NmKDvFC4vY9iNW3yBTDVrCvMN48OGEwybay6F0jPSXRwrtbYrjiyx+o7RPApCroQbIrJCo6vnUJ54qQgbm6DqBf/wZfiN1P77A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720227032; c=relaxed/simple;
	bh=0YtTdPHUf0XABN1f88jDo0wJHwHI/jEC3QUnL2f9ObU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bh9TXY0uQyXOaoUlhvkHWJ6IWbZvohHrIRIaHUevFzSRwi5s+Ud+ZWQbvQ9gaJrxNSVeZUHPeXtJ3f9kfy/k5AReL3QS+kjNC6ktbe9gydEQ8c/Up0iBpghJiy1Nz0bNlfQR5n88r4iGuLchommR7ga0Ffuzmrob9B66U20menc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JZQQe80n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2F3A0C32781;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720227031;
	bh=0YtTdPHUf0XABN1f88jDo0wJHwHI/jEC3QUnL2f9ObU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JZQQe80nKucp7KNvAiOE9CoSuizz6dhDP/wTHMlsRI352ksPvfxiPKf4fZdVjJvnD
	 Y5bVVg3hcYZQKxwS/0oJJ/mX2TTSRzA9bWJ5ViwD5AldMaqQ1MS1jqZ5ICFeW4ee4r
	 qkXo3+EBUZaW3Zu4LAdFgqQ59v2vUODJ0BVSS5z8iUAKFMSRZzcupP7kTYVKlGPcJP
	 juki52rh3QwHPuGHNvHzzPnUMR4+7MLQototQmbc8sBss5PU/uFvjEgBp6gdJKT9z+
	 Cfo5jGME5wjiXTW7Gtm7Ip9XuCOvzVRZypg50rx1joc1Vnc2MhtRnvpaUka5dX9IcT
	 w/3VKP+fdqZSA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1EA90C43332;
	Sat,  6 Jul 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] wireguard fixes for 6.10-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022703112.32390.4312776541216490625.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:50:31 +0000
References: <20240704154517.1572127-1-Jason@zx2c4.com>
In-Reply-To: <20240704154517.1572127-1-Jason@zx2c4.com>
To: Jason A. Donenfeld <Jason@zx2c4.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jul 2024 17:45:13 +0200 you wrote:
> Hi Jakub,
> 
> These are four small fixes for WireGuard, which are all marked for
> stable:
> 
> 1) A QEMU command line fix to remove deprecated flags.
> 
> [...]

Here is the summary with links:
  - [net,1/4] wireguard: selftests: use acpi=off instead of -no-acpi for recent QEMU
    https://git.kernel.org/netdev/net/c/2cb489eb8dfc
  - [net,2/4] wireguard: allowedips: avoid unaligned 64-bit memory accesses
    https://git.kernel.org/netdev/net/c/948f991c62a4
  - [net,3/4] wireguard: queueing: annotate intentional data race in cpu round robin
    https://git.kernel.org/netdev/net/c/2fe3d6d2053c
  - [net,4/4] wireguard: send: annotate intentional data race in checking empty queue
    https://git.kernel.org/netdev/net/c/381a7d453fa2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



