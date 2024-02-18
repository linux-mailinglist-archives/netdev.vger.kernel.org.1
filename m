Return-Path: <netdev+bounces-72730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3A9859642
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 11:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358D11C21A87
	for <lists+netdev@lfdr.de>; Sun, 18 Feb 2024 10:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDD3E38F9F;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VOgJohYQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3B5383AB
	for <netdev@vger.kernel.org>; Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708252226; cv=none; b=BPuDbN2Xv3CKn8rVGDq/MQyBxsOiWvqSUcw7Vc5g++uil66dz1V6I4ESAji3/+rmY6xqR9yN5JHZ7N6JT9AobI1Wym+4kUnXRf2K8Kpa8p4SfwwnCMNMflA82E/Ko84m3CjTBtJSbkOOjsE3YVfXekxO7ml4XoFd+cOlafv9YXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708252226; c=relaxed/simple;
	bh=ad6kGbBz1tU8Em2AabLs1qm15/29ase8YWeuEmb4PPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VIs9v5eMhWCTrPyIRDEqzwulA4YKkMWDPAVKaa2LzsaDvZKyPGVr3g8yIgqQgIlmDUdw07DebZWbe9iif6Ch0fhuA6eTtHo0l0i9REoH9xjYcLHkwDpHoY/ZDZd6ff3JiYB9Y8pC7d7zbtI57849PJ1vWEGSIemYM2anHUl0Ta0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VOgJohYQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66C34C433C7;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708252226;
	bh=ad6kGbBz1tU8Em2AabLs1qm15/29ase8YWeuEmb4PPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VOgJohYQaVNX1av8FVQ9JkEdowTUqXYwJXu3Ft6OluZ1hle/ujZNYbm7oqE/N2vMp
	 RSMNFdjxE5i831N03eX7rZXBTm8pmmVOp2U/ZvRcnlrblFCSWpD13ADTkU7Lt9T6PS
	 FcXya4vlLMPAUjyIRxi9FYAWjB90nAJOe0mx1UCS0oHbTNDCE/8HFccbwUHJSIuPWE
	 rJmO29I9UKhCGAQdfQiPxU6e7fGJTikdH0qOyniWJUvsk5hWkZ7M4ukxJ4K1xYuOkC
	 08No8Ofb9xzNHwuZDxB+ejuSqCojaFU3zVz+DBRvJ5PX6hCFYSFVFjOlxF/Bn1rfE3
	 ngR5Yome1WlFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4D400DC99FF;
	Sun, 18 Feb 2024 10:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] inet: fix NLM_F_DUMP_INTR logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170825222631.22893.4883215355646209691.git-patchwork-notify@kernel.org>
Date: Sun, 18 Feb 2024 10:30:26 +0000
References: <20240215172107.3461054-1-edumazet@google.com>
In-Reply-To: <20240215172107.3461054-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, nicolas.dichtel@6wind.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 15 Feb 2024 17:21:05 +0000 you wrote:
> Make sure NLM_F_DUMP_INTR is generated if dev_base_seq and
> dev_addr_genid are changed by the same amount.
> 
> Eric Dumazet (2):
>   ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
>   ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv4: properly combine dev_base_seq and ipv4.dev_addr_genid
    https://git.kernel.org/netdev/net/c/081a0e3b0d4c
  - [net,2/2] ipv6: properly combine dev_base_seq and ipv6.dev_addr_genid
    https://git.kernel.org/netdev/net/c/e898e4cd1aab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



