Return-Path: <netdev+bounces-154078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB9209FB3C3
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43895166555
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7891B6CE9;
	Mon, 23 Dec 2024 18:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pP5QjW2G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8DC1B413F
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734976820; cv=none; b=D0eMHNdBFJlx4Pf9gLpWx/86ffHNZKBOpX9DFojKRXeIRTcIaB7lRBljBvAX9KlyrtP/vBI2UVwb/hC0FmpOF2jUXPFo7hl2TJH/Fgrv/zv4acZ+0Dl3vmHX542wSOcU+sHGCw91LPQ/ajKiwvGCdodjaEK5W4uyggBko0nmtFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734976820; c=relaxed/simple;
	bh=O0RLNc+lSLsjNO4qX4Oo7NPtInH8AJ2isJ3r6lJ8p5w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ww5vDyptOGJiQaaoiv3RBzSE91N+soIzOdmsGqrSoAEyBW4Xu5ciiY+qS0YyJZDhb5EvmKFJSC7TvOxeAkxL/UetBvzhr4lAdnsaGaK8UOo5fUNf6oMlL0Ino/Kihpqh0cLE01gWI/BzQptX3uEcOoC9Yu6qrk76soshkijzF8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pP5QjW2G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE2BC4CED3;
	Mon, 23 Dec 2024 18:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734976819;
	bh=O0RLNc+lSLsjNO4qX4Oo7NPtInH8AJ2isJ3r6lJ8p5w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pP5QjW2GKXz066tJj+GHKjVYlKoPWD3iZEmO7iO0+uhDr7R04oAFOtiYlntSSSBQA
	 IsP166cocvxIQXDTXIFCVjP7tfpzaC39rcYkKvlo8ogWEkfwaU1Z5k7ZtfHWro++yP
	 2EpNtMitFqumfUoHPCdOgbbtq8KP7GeIBZW/tAxYAwMB+6R7xfGRSLkO6FyBpj21Ix
	 Da6VHVw6WDGh14Bwfn1ecanQ9SfW1ugVqkzScqmtwDaab7EE0fbQVuGBr6Lt7Rsql0
	 U1wRSgTsJIhhthzrxp+PdbrozsupzFYorOypvyGD6nsybqWyY41nPQFsF2IjmoXOkI
	 en+erO7VgK9wg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DCC3805DB2;
	Mon, 23 Dec 2024 18:00:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: stmmac: restructure the error path of
 stmmac_probe_config_dt()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497683805.3919340.5019937159859105100.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:00:38 +0000
References: <20241219024119.2017012-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241219024119.2017012-1-joe@pf.is.s.u-tokyo.ac.jp>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, dan.carpenter@linaro.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 11:41:19 +0900 you wrote:
> Current implementation of stmmac_probe_config_dt() does not release the
> OF node reference obtained by of_parse_phandle() in some error paths.
> The problem is that some error paths call stmmac_remove_config_dt() to
> clean up but others use and unwind ladder.  These two types of error
> handling have not kept in sync and have been a recurring source of bugs.
> Re-write the error handling in stmmac_probe_config_dt() to use an unwind
> ladder. Consequently, stmmac_remove_config_dt() is not needed anymore,
> thus remove it.
> 
> [...]

Here is the summary with links:
  - [v3] net: stmmac: restructure the error path of stmmac_probe_config_dt()
    https://git.kernel.org/netdev/net/c/2b6ffcd7873b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



