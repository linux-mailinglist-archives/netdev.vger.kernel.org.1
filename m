Return-Path: <netdev+bounces-71601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9DA8541C2
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 04:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22159286B93
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 03:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89FD1945A;
	Wed, 14 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RtRjoxx8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6549423BF
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 03:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707880828; cv=none; b=lAcUS4EEMqMh05BhQPA+XvRsWSDxY5atBU/uuEcJs8G0ikQsyfXmJKaRAGFibz3iM25pOzcuwNnBMSNfa30QToVddtvX/JcrinixqgfMvdV3Gj28ZlWCHpNSl0urB5QUk21txmehK2QAjVoe/VWHRsQotv9dpdsG7zY6z139E6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707880828; c=relaxed/simple;
	bh=IdGOrYKDcDubuplUDq4Y5PBykFD5jFIjnMtDLhqQXHc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m41FwVHYYUNfKIWtQOA/AzvSKoXn/Q3avPmfOQyz4g26gUWncaN7tcSGemCq087UKCuBSW6xmscKH4OxS1YTfU0ibjBpjyBZS8nIjjnMZKrU4MW5GZ0CZ524Mn2cjOZ8fIM0xSPfktse88AP6xQyLKB/3wIynwk79kSYmT1vTK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RtRjoxx8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA107C43390;
	Wed, 14 Feb 2024 03:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707880828;
	bh=IdGOrYKDcDubuplUDq4Y5PBykFD5jFIjnMtDLhqQXHc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RtRjoxx8700r87k+Q7ePRj5S+T8R446ieDYw+RQWOO4M4IPtRQNQuOo90c1qaXHS4
	 z/B6CLWHeBQdWRMN+eKv19D7i6f3S29d9Sxe8x0txmFXkEJFLVvflQfrKJ79EkfnMA
	 uhBB1Tmw2+ZvTHKP3N4AkhsY+XWpAPN8rL9WVtqkD51wtACw3lhuF6Kycdxqh4mUq1
	 PTJBDfXzMe4N0Zo4jhgwz4xzHHYxTvPnGaAlaVImN2MPBP10Hej6taVVfgw8OGg0oF
	 gz8TjmhJGo56MbIJzyVzX/GgaaOk0pw05amja2HPE7iQlnStu9F4KF1nQeEBtGcWlc
	 EqkGUisLGdE5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CAB70C1614E;
	Wed, 14 Feb 2024 03:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] r8169: extend EEE tx idle timer support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170788082781.27530.11111418536505549992.git-patchwork-notify@kernel.org>
Date: Wed, 14 Feb 2024 03:20:27 +0000
References: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
In-Reply-To: <89a5fef5-a4b7-4d5d-9c35-764248be5a19@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, edumazet@google.com, pabeni@redhat.com,
 davem@davemloft.net, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Feb 2024 19:57:09 +0100 you wrote:
> This series extends EEE tx idle timer support, and exposes the timer
> value to userspace.
> 
> Heiner Kallweit (3):
>   r8169: add generic rtl_set_eee_txidle_timer function
>   r8169: support setting the EEE tx idle timer on RTL8168h
>   r8169: add support for returning tx_lpi_timer in ethtool get_eee
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] r8169: add generic rtl_set_eee_txidle_timer function
    https://git.kernel.org/netdev/net-next/c/2ce309938310
  - [net-next,2/3] r8169: support setting the EEE tx idle timer on RTL8168h
    https://git.kernel.org/netdev/net-next/c/57d2d2c8f132
  - [net-next,3/3] r8169: add support for returning tx_lpi_timer in ethtool get_eee
    https://git.kernel.org/netdev/net-next/c/9c5013972726

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



