Return-Path: <netdev+bounces-110979-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5729292F308
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 02:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E634282DCF
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 00:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABC910F9;
	Fri, 12 Jul 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exdgC39P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5C8E391;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744279; cv=none; b=uBspjGl17WzusQMFIvCc9oz0Or1KxFmwAdG0PW0d60QEvuURMXEzhCof2esrvVjcQFqoRjNoxTD5FP5mhM/MSMtrW7GgyHqWi4DuiL4iYq1MgZ4t+pti9dy04LPSmmETuBokhKBFXE3DAqPN3/ef0mV7PJS2cX8bb9nmnEKc5Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744279; c=relaxed/simple;
	bh=qjaE9orXsJN5GtTPXYD8SOsWN0AkROfEE4nLAMNUV4M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nGhRqcjDeg+xXyuGh1y+nf1nAICQNsK2xE27DzSgr42xBpi2UqxVOT5X7hGrGDTzHypzJ4Z8NfJLr7tDvFuywwMWnGIAxQyk5hf74A8Dly+wjAN6wu1ahen4m17DF6fjnHrI0bEUA7gMwBVxMsUqsGnERz8SI4N826D/BFFOWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exdgC39P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9A2BBC4AF09;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744278;
	bh=qjaE9orXsJN5GtTPXYD8SOsWN0AkROfEE4nLAMNUV4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=exdgC39PYsdtU36YyaJ77kgsi9B1O7OmX2W7ANp4DdJ1SCz8/Zy9fqsQTVw1drzWf
	 AbZTiDF1/Hq+B3or8vdv21xrd1GUdesFK+wNyUS2ZdvqhiZ5Cy3hAp9bcBAr4tYQBv
	 LzG+1ICAqAvWS1J5dkuindF9oUuBSIGoBSET1IuLOiYfrU5bKhUCBqacNLTfUaLtls
	 euEY8HkXix79Foe5Y00fFftEzrd/w4y/H4J2pEOqImN2k2fydUAvf8jIekK/Skfyei
	 Yr8ylx6VKwRSfAxHM5BJi/T1fTRIiNARL90JQIiIIp0qHPzgkvr7Qx3zgh58/3nVaf
	 Lz+fULoXO71Rw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 860DCC43468;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: act_skbmod: convert comma to semicolon
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074427854.19437.6754797911324663420.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 00:31:18 +0000
References: <20240709072838.1152880-1-nichen@iscas.ac.cn>
In-Reply-To: <20240709072838.1152880-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jul 2024 15:28:38 +0800 you wrote:
> Replace a comma between expression statements by a semicolon.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  net/sched/act_skbmod.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net/sched: act_skbmod: convert comma to semicolon
    https://git.kernel.org/netdev/net-next/c/b07593edd2fa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



