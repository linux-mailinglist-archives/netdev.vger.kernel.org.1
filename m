Return-Path: <netdev+bounces-148261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5CD9E0F69
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 00:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E144282FE1
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 23:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DE1DF972;
	Mon,  2 Dec 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YP6HBgd0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D5061FD7
	for <netdev@vger.kernel.org>; Mon,  2 Dec 2024 23:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733183416; cv=none; b=iURVmF26zPoXppjpMFAeX5KHu8GreI4MUplqL+ab0JcaCDzT3pBtBVLkJQpWTSDTVCcdJP/BopbZQ8H44uJcwWiFu4eSgdyodOFsq1AyLfRXHgXuky6q/yGX6WY6XsgHKxsjE3YI/rkCdSMbegl/YFB8OubUrsgnfGNwTDxK5mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733183416; c=relaxed/simple;
	bh=5GZeT/yUuHSE7I9T5lJCyiL9fkfXvuA+4PxIR0Ii6Is=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AVNcDB+zK9S71hYkkMdX+0FzGGFC20E0BBrQFi0dSKqZCi2c/+rc4fQwBjAMaOt4NSmN9t3xqDsrc4Qa9HzdLbqsPNbK20fUacIMpFTxneF1CccrLXRwiWwFOI3yCni21QKUNr+4+4zd9J0L1AhM6/iBZcLbXvNaCTVI5Pu6zgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YP6HBgd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E91C4CED1;
	Mon,  2 Dec 2024 23:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733183415;
	bh=5GZeT/yUuHSE7I9T5lJCyiL9fkfXvuA+4PxIR0Ii6Is=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YP6HBgd00v26Q612tICcrWyJ5RtY8//kR00dCQMd6BM6RXyHgTmMUnsIb4wzNiR/e
	 Sy+t8UyR4nePrqKHKBhrw1oT3+bm4/ZPrPfc3++GdarYKRRPB4NfZf9REl9FpTesn9
	 3YnnA7BhNebjH2nVIBgsnXjlLh2pyRVfnxL/PoYeUvRPpo1mrrLToN06MA4fbylLVb
	 82ld2fJbH90FMZmapnKr4O6BQD7AlUR+n2h+Dxb7TmH9n5sMYpjZ5PDpQ5UPuX4qyv
	 EDluw0GbXqATCGVqm7wT4Y1OiYo1jlAkcTeSxxOrBvSo03QQnZiS+W1ybQSP4Nqo3E
	 y+w8Sclipjv3g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C413806656;
	Mon,  2 Dec 2024 23:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: list PTP drivers under networking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173318343002.3956451.11228010903258244880.git-patchwork-notify@kernel.org>
Date: Mon, 02 Dec 2024 23:50:30 +0000
References: <20241130214100.125325-1-kuba@kernel.org>
In-Reply-To: <20241130214100.125325-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: richardcochran@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Nov 2024 13:41:00 -0800 you wrote:
> PTP patches go via the netdev trees, add drivers/ptp/ to the networking
> entry so that get_maintainer.pl --scm lists those trees above Linus's
> tree.
> 
> Thanks to the real entry using drivers/ptp/* the original entry will
> still be considered more specific / higher prio.
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: list PTP drivers under networking
    https://git.kernel.org/netdev/net/c/c889aa2e7c2f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



