Return-Path: <netdev+bounces-196384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6201AD46E5
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:39:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32BD189BCC4
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0BB28AB07;
	Tue, 10 Jun 2025 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CEYCrXMr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080882874EA;
	Tue, 10 Jun 2025 23:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598755; cv=none; b=bRA6KZkePbQF5N39ptL8M2N0hOlSOTliqyBiooqHg7uJWpd7J0XsbXb0eb3LoJI12mnQ6qqBN3nlsU4gjIOm+IwHLWLVi8NfcaJ+XEIImCMOurie8cGcN0b/QmTOKrLm6sNLv4p6rpONT2EIS5UTIMGRTiEFX0zy7low/1j/QuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598755; c=relaxed/simple;
	bh=10WbUgtzsY1CMRTE82SNLw4hOV2yiXyOh2QY0mR9Gns=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LtNwrbe3LMnHLtIR4U99oCyeTKFg3/pok4ew7XQZ34dEr5Tv2jHiEQUmS4+9gJH73SfJJ9YA/wOy5JKH/V9PW02Swou2cWydZgSZq4pWJvIJtu7Z1BSfx8nIDWsUPE2iRcgOXHks87mDymiMdK417m9lV8XV2EuV7Wwu909WEuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CEYCrXMr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977D7C4CEED;
	Tue, 10 Jun 2025 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598753;
	bh=10WbUgtzsY1CMRTE82SNLw4hOV2yiXyOh2QY0mR9Gns=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CEYCrXMrfNLXbMDVL4QSQGIIT6oKPFS/WfzM2m6+ClcIWMz0/McMThySwmF6p+rRS
	 HUDVtc8F7Ytv6bgMgPFTsdjj0WSZm6IbTBMxBSwG7dHrPDRX0nMtLPXcuArwNx2PAx
	 o9EAl9DWP4O00ZUlNcw3cPTYgS7WzI0Z+vcA5bQ3ln60G80OhhelYNNCXJPcxhJ9k9
	 c3L2/ZlILPNUmkWqtT8Qa9by7uZ4W9BFhd6nkB0Jroq5LpozeEMgiS6H6+UnD+1dGW
	 OpNGY6kOsUeroMLQr4jzDTvD4jgDou1BsfcvLOza6gqXT0RXD3+TiO2dPatBm71uJn
	 0F+lSX71rmpYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 305FA38111E3;
	Tue, 10 Jun 2025 23:39:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/3] hinic3: queue_api related fixes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959878373.2630805.15421085974228981333.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:39:43 +0000
References: <cover.1749038081.git.gur.stavi@huawei.com>
In-Reply-To: <cover.1749038081.git.gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 gongfan1@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Jun 2025 18:07:51 +0300 you wrote:
> This patch series contains improvement to queue_api and 2 queue_api
> related patches to the hinic3 driver.
> 
> Changes:
> 
> v1: http://lore.kernel.org/netdev/cover.1747824040.git.gur.stavi@huawei.com
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/3] queue_api: add subqueue variant netif_subqueue_sent
    https://git.kernel.org/netdev/net-next/c/2bc64b89c4c4
  - [net-next,v3,2/3] hinic3: use netif_subqueue_sent api
    https://git.kernel.org/netdev/net-next/c/eb89bc3744f3
  - [net-next,v3,3/3] hinic3: remove tx_q name collision hack
    https://git.kernel.org/netdev/net-next/c/48b9ce0a7c72

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



