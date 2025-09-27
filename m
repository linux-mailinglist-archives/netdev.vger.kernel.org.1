Return-Path: <netdev+bounces-226831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8464BA5797
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 03:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B3217DFBB
	for <lists+netdev@lfdr.de>; Sat, 27 Sep 2025 01:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7CA207A09;
	Sat, 27 Sep 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iYWK5buy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7CD20299B
	for <netdev@vger.kernel.org>; Sat, 27 Sep 2025 01:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758935425; cv=none; b=g0eMxDe/bQYqY+BOWKD7Vm2fWCLg4Bsl37ZPyKoRse1qHOZxnI1QY10nwbHw6tKfo2hLMGeFBAyUZi3QLIAUlkIjOGmnVO1Hte3cXfWpLlYM7d1gPHFCKKGpJ/dhMdx1gCzBd8emVonVeoyO1RCalz0644pcUCHpzHM0ZdpO1IM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758935425; c=relaxed/simple;
	bh=ICUHaMjv8Fl1W2FOvFeNYFwC3M2xi136tmMAKMyt0dU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uAFAKjp58juzSgkv+gTLvYUx4Q7XWHmo2fpwlmq7G8vYVL/TWIa+I3nsMHstRmgDCgqEQztBbSb4AUIvFL1idBpXW262TYNTkPsJJ3WTUbxjoDoGqP8Fjr7ZBfMLCVcz4jndwjOBPLkVSHiWu7NS62EPnyjEKJrmISU463bWLJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iYWK5buy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A485C4CEF8;
	Sat, 27 Sep 2025 01:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758935425;
	bh=ICUHaMjv8Fl1W2FOvFeNYFwC3M2xi136tmMAKMyt0dU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iYWK5buyHKPAO89RctRGWTpGUdB+wgzld7hNcTZ1HRMxfcKXpcZwnvXVTdMFi8bvN
	 ZN7mGg9Zo7VdZqSZq0jhSa27/ymBChAlw68bxCznsdlU/13XibkKzbEJm4KxVGe1Sk
	 /6EuRnsUJfZC5u0b2uAYDORqU7GX6W95f9QDRmvGneNTWI72eSH0qJv2xQFZTBf695
	 9zSqPC6bBEk0ZuWNC3MZX5nDiNfKFF2wDsuv5QIZLXG0GKyXERnE0xj91a9RHxol/L
	 Tjjov1dnDI7cLuZrT9h/g1JCP65D1QAbPVjb3kUjSsC7jmAZ3B4Mg8tvl6Zu07QA2/
	 HaxNdS/fzHUBA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD4239D0C3F;
	Sat, 27 Sep 2025 01:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Wangxun: vf: Implement some ethtool apis for
 get_xxx
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175893542049.113130.7661448077502721391.git-patchwork-notify@kernel.org>
Date: Sat, 27 Sep 2025 01:10:20 +0000
References: <20250924082140.41612-1-mengyuanlou@net-swift.com>
In-Reply-To: <20250924082140.41612-1-mengyuanlou@net-swift.com>
To: Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@trustnetic.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Sep 2025 16:21:40 +0800 you wrote:
> Implement some ethtool interfaces for obtaining the status of
> Wangxun Virtual Function Ethernet.
> Just like connection status, version information, queue depth and so on.
> 
> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
> ---
>  .../net/ethernet/wangxun/libwx/wx_ethtool.c   | 33 +++++++++++++++++++
>  .../net/ethernet/wangxun/libwx/wx_ethtool.h   |  1 +
>  .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  4 +++
>  .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  4 +++
>  4 files changed, 42 insertions(+)

Here is the summary with links:
  - [net-next] Wangxun: vf: Implement some ethtool apis for get_xxx
    https://git.kernel.org/netdev/net-next/c/e556f011e2df

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



