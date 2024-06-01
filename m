Return-Path: <netdev+bounces-99952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D958D72AF
	for <lists+netdev@lfdr.de>; Sun,  2 Jun 2024 01:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2410E1F21572
	for <lists+netdev@lfdr.de>; Sat,  1 Jun 2024 23:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52E893CF51;
	Sat,  1 Jun 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8sgymg5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEDF2594
	for <netdev@vger.kernel.org>; Sat,  1 Jun 2024 23:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717284030; cv=none; b=ooyY2TBfWPkmU+qiripVS8tVyUdHtgFgRLCPkkk1zHiEvQkDxt2CZJ+UFRXm3ndnnWp79qzE9a2ErYAWlbXOSDwWxyXEugBcKQ2HWpE/6nrjBatggG2A2JzuokeKddQO1rt1OpQr6mf1gg7IySSkGPpPUHXi7djOXpXo6u2ir+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717284030; c=relaxed/simple;
	bh=9qEUcZmHFQxUWTsxTkTlTh1kiwifmC+9/OEH83kWtsc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jkX1/X8es/PejTalK4Ne6eL+9eoWPvoYKQgaVb2ULMTKSkTJAA7lwFuWmp9WivD6/dDIV1y+Sj0v3YrOaYJNjYd7NiWcah0PwD03gvUD0U+Sz7XNg5EH0ckg8uj+yuGKKu6gT0xlqB/CMP1eTnnUYgtSxwr/T8Wccyi0ugy1rDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8sgymg5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id C1C78C4AF08;
	Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717284029;
	bh=9qEUcZmHFQxUWTsxTkTlTh1kiwifmC+9/OEH83kWtsc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O8sgymg5rTSCVNFV2NZZZSFX8G40HdpZyYATlp4VV3E9Mhuf3yoiecxeazkRl7iHz
	 1K6Mc/hckR3b6+4oPywvDKzEKcMqLN8Lnd1MN5pzz2r1Iuxr1wC+9qg77oAlow/fLb
	 VY7KLX5Vcm+23C3v50WKUsRnIJx9eWSGmMZM+VQV6/mmZ5SMgRBOAkyVhJkbkxejJ3
	 ZcOyUW6PRtcjoxvfKG85JOt98bzzWgvvQKEPFD0yoAuuq/28pjFBL2/fpvCyLMXuJD
	 5bNvB5iQUfX0m3wI8cyTZRDO+UB2HHIN0ca04eKp/yKZACwtWfGuNbDjSB61b5xgFE
	 6miBfq/E3trZA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B372FC4936D;
	Sat,  1 Jun 2024 23:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] bnxt_en: add timestamping statistics support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171728402973.13922.1317395584285366882.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jun 2024 23:20:29 +0000
References: <20240530204751.99636-1-vadfed@meta.com>
In-Reply-To: <20240530204751.99636-1-vadfed@meta.com>
To: Vadim Fedorenko <vadfed@meta.com>
Cc: michael.chan@broadcom.com, vadim.fedorenko@linux.dev, davem@davemloft.net,
 kuba@kernel.org, richardcochran@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 May 2024 13:47:51 -0700 you wrote:
> The ethtool_ts_stats structure was introduced earlier this year. Now
> it's time to support this group of counters in more drivers.
> This patch adds support to bnxt driver.
> 
> Signed-off-by: Vadim Fedorenko <vadfed@meta.com>
> ---
> v1 -> v2:
>  - embed stats structure into ptp_cfg structure
>  - keep ethtool stats untouched if ptp is not enabled
> 
> [...]

Here is the summary with links:
  - [net-next,v2] bnxt_en: add timestamping statistics support
    https://git.kernel.org/netdev/net-next/c/165f87691a89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



