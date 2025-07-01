Return-Path: <netdev+bounces-202727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76228AEEC29
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 03:40:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825B21BC1965
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 01:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F8C1DD529;
	Tue,  1 Jul 2025 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iDQK8E0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3561DAC92;
	Tue,  1 Jul 2025 01:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751334003; cv=none; b=Q8J+r7bSVqoHPXlkW+giDGlwZvLc9+j9TTe6m/YAiIpbP6/dCMgbdtsN4788iL2Ubd/kkc7YpUVooGd+4hXD0k58yhqFkg/qU56Lqiiq1LEqElQVGCZo7p580DCVff8BuS+QEJAzK3iBDq39VcTwi0IehHMlBDfOl2SimJqdQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751334003; c=relaxed/simple;
	bh=Ax8Fs8mCGbljMAB53rmtXkX7OhWmdhkBT6P6VTaSB7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z1mG/VisDeNwzkZC16dgLwtl7OEZ3yVy7skFAcRZg3Cu3ieRj8UCAxnPgUIjRs2tQXYN3YPLJ2CZTQC/ddGxmY9kvngE2T0Z4NCIFojWINPg7pt9YeoU31bBUipKl1MsNlpE3aA8jHjb+zXkN4/4TzRCyP5jGQTXkdK+H820mzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iDQK8E0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF41C4CEE3;
	Tue,  1 Jul 2025 01:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751334002;
	bh=Ax8Fs8mCGbljMAB53rmtXkX7OhWmdhkBT6P6VTaSB7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iDQK8E0BSFygBFu1T9URj5lj647S+ODVX9+zi5SOuX5P0oXPJZnxitbX6lmwX7WEB
	 lR6MfLOMy0CsKSW9LG9vFOt0WH5Je57qBRZsp6y976vH26ymKZXoGhdggKckm7Onhq
	 ivyN9Fa7Fh5QJyc0pMuePT8ExQumc1Ck23hyU3W9QXzItODdvFEaTXMjm/Y5DZaiPL
	 AaVInz6Tl9X7dNgQUctMMmDXy11XZO0fMOE5jOzrmGbWXjNs0GQkP60Fyv+RQkKhJ3
	 wj1Cn0NPtNJ2Zi7eCNtvkf0wxXXYplO7sO3O9c5bU+y3I6+perkLoKkUfYDAitiFHR
	 Bi8Dh/R+c8BYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C4D38111CE;
	Tue,  1 Jul 2025 01:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: fec: allow disable coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175133402775.3632945.1815291289264821015.git-patchwork-notify@kernel.org>
Date: Tue, 01 Jul 2025 01:40:27 +0000
References: 
 <20250626-fec_deactivate_coalescing-v2-1-0b217f2e80da@pengutronix.de>
In-Reply-To: 
 <20250626-fec_deactivate_coalescing-v2-1-0b217f2e80da@pengutronix.de>
To: Jonas Rebmann <jre@pengutronix.de>
Cc: wei.fang@nxp.com, shenwei.wang@nxp.com, xiaoning.wang@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, imx@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@pengutronix.de

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 15:44:02 +0200 you wrote:
> In the current implementation, IP coalescing is always enabled and
> cannot be disabled.
> 
> As setting maximum frames to 0 or 1, or setting delay to zero implies
> immediate delivery of single packets/IRQs, disable coalescing in
> hardware in these cases.
> 
> [...]

Here is the summary with links:
  - [v2] net: fec: allow disable coalescing
    https://git.kernel.org/netdev/net-next/c/b7ad21258f9e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



