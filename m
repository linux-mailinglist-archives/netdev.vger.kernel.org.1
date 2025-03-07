Return-Path: <netdev+bounces-172705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EE6A55C31
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 01:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCFFD188E956
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA508F64;
	Fri,  7 Mar 2025 00:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUEX908C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCA6139B
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 00:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741308600; cv=none; b=SDbl82Uoh+eBG1DXJT6SdoZhq5eTxPwOUeiOZQpuWIAhXlTyO5FZAR3HND0kclLWK+HOU5hQcd8VDEniE8uBKs4EXZ8wNFu12wmjv1cYCqpN//HLryqDWRwT1ON4x440GF62tVKPaitb8VGAyWAN5U0JFFEQ1+/6LzaJSCGGE8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741308600; c=relaxed/simple;
	bh=8r7bX74gY18Nls9e39hbHtACR9jJiDjmEh2s+Jr+XOo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mp3okjiXkeQ6Mwuwe+R+6FwnnPkHLUxC8A1ydIxt9RDK1lzA+NDh71XC5Qc8t8K7IhN9NKXZdQ3uoswLNIWTw3zCFHz4FMFQHV1s6I892SmLsc+7/XaUKtAxJeTOxEDR/zEU5FGuWsKhrobgToXlz51fvVPP2QrtPKpujWFRDjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUEX908C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6369BC4CEE5;
	Fri,  7 Mar 2025 00:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741308599;
	bh=8r7bX74gY18Nls9e39hbHtACR9jJiDjmEh2s+Jr+XOo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KUEX908CVdcp2tRw8OIQUlT2gK64wcgUy+eCnBH1ehhbP7a9c+WnfWQ5c8S2tpUYa
	 g2mb+ro+aDsIHOj/WNgLG8MJ4Ys/oF3fyT897TLEJVvF5wajCE/NycOzUta6JgC831
	 FIQxXjyqZHcUNgQb/8EV85j/Ed2AvDBCgFwD0W8zxH0vfnZPTOvli/CZR+NT6ogZo8
	 GTZBY1E+NPRpPrGISZpqNDYCaf9uAP3rVsu+/aLBtc2bfNkoAdyFR2RcO5DoL/FQOv
	 dzC7XUWRrPeB4eEN/nYMCfgRWC3//KkjHt1blsTTS8loj49W+f9htBh/NgbV7ZOyfl
	 HQvPVUM/A04IA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAEF7380CFF6;
	Fri,  7 Mar 2025 00:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] sched: address a potential NULL pointer dereference in the
 GRED scheduler.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130863276.1835493.1039599542315128495.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 00:50:32 +0000
References: <20250305154410.3505642-1-juny24602@gmail.com>
In-Reply-To: <20250305154410.3505642-1-juny24602@gmail.com>
To: Jun Yang <juny24602@gmail.com>
Cc: xiyou.wangcong@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Mar 2025 23:44:10 +0800 you wrote:
> If kzalloc in gred_init returns a NULL pointer, the code follows the
> error handling path, invoking gred_destroy. This, in turn, calls
> gred_offload, where memset could receive a NULL pointer as input,
> potentially leading to a kernel crash.
> 
> Signed-off-by: Jun Yang <juny24602@gmail.com>
> 
> [...]

Here is the summary with links:
  - sched: address a potential NULL pointer dereference in the GRED scheduler.
    https://git.kernel.org/netdev/net/c/115ef44a9822

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



