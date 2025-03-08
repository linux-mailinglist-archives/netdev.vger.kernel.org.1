Return-Path: <netdev+bounces-173137-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC803A577F7
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11693B6679
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 03:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4A617A2F6;
	Sat,  8 Mar 2025 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ujVdmuvv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E3515B54A;
	Sat,  8 Mar 2025 03:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741405216; cv=none; b=eYyc+VS3tsyXvKStEpujS28QF0b4bJ0b1YDsWq1nrw3pxDzorkLiBJERKLOUFmyRRaPJSHAOjpqaRu/Xk4NRaywqiRDro1T7Av4DOlYHJy6MEa49TIRuTqW1w4lEaBwL3lXWJ5xUIARBvefhhqf0X2XYnyYzT8PiS912AKcqcgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741405216; c=relaxed/simple;
	bh=tNdZnQN3DKj2QztuZLJeIBNKvSQQ+s87os7ruXPbIFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAOJ+v0gj3igKuYbSKc857ejLq7juLxT7uqxIf7PQx2GEx7BauyjVsw+7pUfEfm5mz6KsFja+qNIkvJpSjLO1IxpivfMNMu3KMAjFMQUlEDjBJ2L9cdWx2TD5kqXme7rK2FuEQa/7Upj5TP6VhuDVtsBiXkqEJmtsxAcfgWkvnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ujVdmuvv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC412C4CEE2;
	Sat,  8 Mar 2025 03:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741405215;
	bh=tNdZnQN3DKj2QztuZLJeIBNKvSQQ+s87os7ruXPbIFw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ujVdmuvvoVc9JoJHZLwFVGRCELe7bUb8p25LmtWsz0vnchWXKCQihaljlHvWdQfwi
	 eYNKew93Q0DCbTlZchYNFnNLU6KMNh4kXUQF4E+MzIwyA7AMcRSreylNeSoH0D3qkP
	 p5IL28hXZlYtIWvyWK667nRsrhvMnbLOB6Rmf+KKjoEz6VwGB/yxHMnL/6lHtOocM7
	 QYu7KOINyfk8S78yl+RskjTBVFxnib23nqYUm6ZUcSOlElcJZ8fgqhwxGPUuqoW9k2
	 1/ph1+rnnM8rF/rxhWVe1fdICIDFe9zlpFBB7TdDhIpc5+qLAGq38dXmZoFu0MezF+
	 j90F9qpjUhmrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADDB7380CFFB;
	Sat,  8 Mar 2025 03:40:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: Remove unused phylink_init_eee
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140524924.2565853.9888349135574832319.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 03:40:49 +0000
References: <20250306184534.246152-1-linux@treblig.org>
In-Reply-To: <20250306184534.246152-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Mar 2025 18:45:34 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> phylink_init_eee() is currently unused.
> 
> It was last added in 2019 by
> commit 86e58135bc4a ("net: phylink: add phylink_init_eee() helper")
> but it didn't actually wire a use up.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: Remove unused phylink_init_eee
    https://git.kernel.org/netdev/net-next/c/c8be7018d47c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



