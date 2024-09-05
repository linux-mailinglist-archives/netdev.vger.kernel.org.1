Return-Path: <netdev+bounces-125322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A0AFD96CBB9
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 02:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20274B22AED
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E2DEAFA;
	Thu,  5 Sep 2024 00:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBiaPZb5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6395DDD2;
	Thu,  5 Sep 2024 00:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725495633; cv=none; b=gVkvwH81BAsWQxr/FoWsiL/gt5YDyJDoQ54kr9BZf0qEFvULfd5Sq9nwg5Du4u4jPTnjKccbB3zIvbRcm0cN4+GdKELHI/ymtWVwk0ihLSAl48dHd4YZ5SfXRNBxC7fBqPpyxgvld9hqhWL3PLgHwlBG0KJ8vBO7rMCvS2sc98c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725495633; c=relaxed/simple;
	bh=TevuT01BbunlpjDk4Ntbhq5bux9u273/gOsv6IKPO38=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c31eJlrdKkzrEGnESF4TCix02SUWozKLXiEphnlKi7/p0B3IfN9PK3Ft3Nik3ZN68icLULy7247LOmcnuZhBcKhRyfB3kEURqQ4BQ/ZXIj7mKsNXWreycd9D3OPZL63sjzmMm9zCx/zhNXvGxeetOZZwA5XQH9PEm8zn2dd1zP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBiaPZb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA437C4CEC2;
	Thu,  5 Sep 2024 00:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725495633;
	bh=TevuT01BbunlpjDk4Ntbhq5bux9u273/gOsv6IKPO38=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LBiaPZb50jOZXwUtglJRcFDErpyfe7Jbjso5crhW1wM4fSvBqq5TgeJVCOifsOHMP
	 XrlPyaKnyiS118M38Sg9AjTu2I+w/2yb04eNtVm11oVkuCp75CMT08xIcHmHW3ntqa
	 C+PkhyDj32wArYTcVRNfhxVFV2yKl1nk+VvCoZtvEkW7bUEw7YwIW81coKp75/RMyv
	 cIV+Jo+OUzx8RKVsJE/zHumih9EUT8QQc+4AtIRh+wyYVBQOXMKYuAXqow6Ms7F2Oq
	 4STPp6hFv9bD8zSCaM85DvIoEc2ENvTc6Y0ves6uJG7gLNHjY9Eg6B/FTERIzb0SXG
	 snBVaL92CJyAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD1B3822D30;
	Thu,  5 Sep 2024 00:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: cadence: macb: Enable software IRQ coalescing
 by default
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549563449.1208771.15485016023468889956.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:20:34 +0000
References: <20240903184912.4151926-1-sean.anderson@linux.dev>
In-Reply-To: <20240903184912.4151926-1-sean.anderson@linux.dev>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, michal.simek@amd.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Sep 2024 14:49:12 -0400 you wrote:
> This NIC doesn't have hardware IRQ coalescing. Under high load,
> interrupts can adversely affect performance. To mitigate this, enable
> software IRQ coalescing by default. On my system this increases receive
> throughput with iperf3 from 853 MBit/sec to 934 MBit/s, decreases
> interrupts from 69489/sec to 2016/sec, and decreases CPU utilization
> from 27% (4x Cortex-A53) to 14%. Latency is not affected (as far as I
> can tell).
> 
> [...]

Here is the summary with links:
  - [net-next] net: cadence: macb: Enable software IRQ coalescing by default
    https://git.kernel.org/netdev/net-next/c/d57f7b45945a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



