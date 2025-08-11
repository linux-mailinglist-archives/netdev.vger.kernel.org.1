Return-Path: <netdev+bounces-212530-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90364B2123A
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 18:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D545619E6
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 16:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84B52D47E0;
	Mon, 11 Aug 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OEPARwde"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 898F029BDA5;
	Mon, 11 Aug 2025 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928959; cv=none; b=VhBMGCOUU/8JagB84LmQK1m2PiMEM+cVUgKyZELSwvHZe3k8HDYgaEjcRb57wQJoqam5hpbpFCmzWzbYu4BAP8aei1iARIreLVklWCZ87/fF00zQnqxtgNyAURXNsAFSOOPx9OGLB+PlQflnTy1Yb8af2l5GNfaNjOIwfmDGN6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928959; c=relaxed/simple;
	bh=1vEfyoyVXrCAidAKaIIQbVmNtX0PWFu3hsUQxAbmAsw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ShCRMNs6V6VU6OZvGEZoM+D2SebD1AhwPW2jVQPLB51f0dwnAfC/klOVGOiS5gesK5t0rYu6ESXWzu3DOBy5PrkIb43MzjwlKW0VveB9yzeXBrqE0Ue9VL19kjGi+SaCLdtGTEwE6l1R7/y+Q277ZB/st9BPMC0DiRCpAcwyvw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OEPARwde; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58DF4C4CEED;
	Mon, 11 Aug 2025 16:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754928959;
	bh=1vEfyoyVXrCAidAKaIIQbVmNtX0PWFu3hsUQxAbmAsw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OEPARwdeIRZguQ2AQc/RNl528mBLHTynfGfxvGEuf9AxIhEhEFZj1WUyL/h6Oz2rJ
	 XNYQvRov1OIXiG/C0QTlJw8IamKbzo9Su5CYvs3z7h2SN1Wd3fyzbW9rH6GpVxo3xW
	 0ajoPuGZ8C/LVe2u94dU2SNLZ5tywAqm2icO5IeP1RZTTIznPUl3HYQ8eX4J6Os25d
	 +dTYGSCoq57tuvaohuWn6WEYFoVfpJ3UZB1Luhn12qxaChbzj12wQgxfIzKEFdklQ9
	 juovPSA1asxz0CyGbLmIk0B2neriDrHnhVJFBd3FjIem2UapmLb4jwogp8Hziavq/z
	 WZGQxoFliDVXA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB03E383BF51;
	Mon, 11 Aug 2025 16:16:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: Annotate struct hci_drv_rp_read_info with
 __counted_by_le()
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <175492897149.1716045.2789511846520664235.git-patchwork-notify@kernel.org>
Date: Mon, 11 Aug 2025 16:16:11 +0000
References: <20250810215319.2629-2-thorsten.blum@linux.dev>
In-Reply-To: <20250810215319.2629-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sun, 10 Aug 2025 23:53:20 +0200 you wrote:
> Add the __counted_by_le() compiler attribute to the flexible array
> member 'supported_commands' to improve access bounds-checking via
> CONFIG_UBSAN_BOUNDS and CONFIG_FORTIFY_SOURCE.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  include/net/bluetooth/hci_drv.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: Annotate struct hci_drv_rp_read_info with __counted_by_le()
    https://git.kernel.org/bluetooth/bluetooth-next/c/af4ae40b525d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



