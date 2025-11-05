Return-Path: <netdev+bounces-235667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40762C33A99
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3CD84642E4
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9C927470;
	Wed,  5 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H2Q4I6WF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B29017BA1
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762306240; cv=none; b=TSFukBmAnyVTUcT1GgkjcYSrb5C5HEZkf9VOwQpugqsJeAqEbOQkgAmZDx6KILkMVvFgDU7ey1DVLdOA11RtPO/LIRilJcw4YZzPyeXYHYuq2VapGTWKnekWwb6Ng2DUrQUC+84DZSwCcUHlkwOBa8SIuswqozndBV9APc3/Y6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762306240; c=relaxed/simple;
	bh=Z9SOFl9TWbPUfDznK9UZRrZ6UgqGvGr4fPkMRvzh3CM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hewk9/U4dW/H+SjNFIFJPyDQCZtYf1VuN4Uwr3OG5RnFQX9nfeUy8hOm/gBYG2jwa/Hhrd3i19ck82ERsip6M0qmGDHgcMF9j+m4XD/DBBqMqLJTeUo6IHS23GumBzmtjr/7YMDhEZEEjdjm0EUYo3zmohZLZGlKu8geZzYO5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H2Q4I6WF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF81DC4CEF7;
	Wed,  5 Nov 2025 01:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762306240;
	bh=Z9SOFl9TWbPUfDznK9UZRrZ6UgqGvGr4fPkMRvzh3CM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H2Q4I6WF6/NAckZ1FbqRk8uVEkn2yq80yjH/kxnqrMUdVAzzyYYURF9XvuXLCU5cP
	 hnyTlNhVLIUcmFVaDPvIyYYKiofq9wgB3Hz76IhW6tkz85f0K4/wef3QjQrX49Db0Z
	 LrF20/XJ4B1gISzJQ/KrQ5zNHTLXQLQ5clH0NuZk2erZzXs9ZlZwHpfYVOTkAL6W3s
	 ZzDJshSrJMhSZ/xPOpS9HUl2Bkah6auSFW+JIGevw30IwOMcv5IxJKY1jLew1/fBNw
	 tIT4iq2htkjdT+wGeVelXX3ppfZc7Jlh6Bwc9n79MJHnT6R9lc1+ghiF7iiT9g3tJR
	 7SnvAIlItNqNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADD1380AA54;
	Wed,  5 Nov 2025 01:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/5] bnxt_en: Bug fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176230621375.3052151.17929781326033696958.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 01:30:13 +0000
References: <20251104005700.542174-1-michael.chan@broadcom.com>
In-Reply-To: <20251104005700.542174-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Nov 2025 16:56:54 -0800 you wrote:
> Patches 1, 3, and 4 are bug fixes related to the FW log tracing driver
> coredump feature recently added in 6.13.  Patch #1 adds the necessary
> call to shutdown the FW logging DMA during PCI shutdown.  Patch #3 fixes
> a possible null pointer derefernce when using early versions of the FW
> with this feature.  Patch #4 adds the coredump header information
> unconditionally to make it more robust.
> 
> [...]

Here is the summary with links:
  - [net,1/5] bnxt_en: Shutdown FW DMA in bnxt_shutdown()
    https://git.kernel.org/netdev/net/c/bc7208ca805a
  - [net,2/5] bnxt_en: Fix a possible memory leak in bnxt_ptp_init
    https://git.kernel.org/netdev/net/c/deb8eb391643
  - [net,3/5] bnxt_en: Fix null pointer dereference in bnxt_bs_trace_check_wrap()
    https://git.kernel.org/netdev/net/c/ff02be05f783
  - [net,4/5] bnxt_en: Always provide max entry and entry size in coredump segments
    https://git.kernel.org/netdev/net/c/28d9a84ef0ce
  - [net,5/5] bnxt_en: Fix warning in bnxt_dl_reload_down()
    https://git.kernel.org/netdev/net/c/5204943a4c6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



