Return-Path: <netdev+bounces-68790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B5C8483FC
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 06:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20CCE1F28305
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 05:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E90FA11188;
	Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qdbZaYOR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54E710A3B
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706937646; cv=none; b=iQPayrtXiTCVwLNGrfg5d5ojG0D/qmmyiW+25YhAIjqJHXL/hFkuH/QaZBsQahrx6Bpu3N20yMVKrcZKG2g8UEHYe7Jq6C7hf0XbDgt4HQw/UWiCEpEOA+6fFDb9U3WoNxYIphSS7+xTBc8vDIivO4Mcumvz8hhjVgB4eW1MqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706937646; c=relaxed/simple;
	bh=zCx63igvgBbPr2TuXUGdgi13+Lq6XHgaVqRhDo5sFt4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DVlYGfMUBHidbXeMqfPLWUgG9QU/ygn/9LUtm+0TcLGd5RvMYxy0y+8ZuaSN5b5NkRg0EwhQxSmuxys9LdanfYJh/KwI6VcWyi5DoObozbE2HHDukYabtLPwdS2TPHhIRyhepgWjaMChwRk1275eugdihSxqTDhH9e+Y1GocBlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qdbZaYOR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 548C9C433B1;
	Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706937646;
	bh=zCx63igvgBbPr2TuXUGdgi13+Lq6XHgaVqRhDo5sFt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qdbZaYORPUgEz/rtlbntlo2l+U3oTas3IG67JFp1RMXYSeDpc9ogqxMl8H1XiSLVR
	 iQeA1sY/HvBZwpQ4hjlXr7f+ggKJ2y7h89ejSZY+2r8ZECdghVdeKKmgWVxFH++BM3
	 1/JdlnAj4xs0aoYMqTES2U3fUP8C0wbZlx877iimNXa0+bYHYs3VL+MsknKk0UnOpi
	 KdaLv8omO6hg0x0CGnU9lnPt8PqikctbjxY4wCE1C1ywkcwJpq+i1J7ou5/PU4YDCz
	 BZZHNUtZbEnSSmZh0gvCWHiww5HFTsMl//RgQYh1D3on5G6EYPNK2vfO8jq7q+LOpT
	 /RSaI7QP/Jmnw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4077CD8C970;
	Sat,  3 Feb 2024 05:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] tools: ynl: auto-gen for all genetlink families
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170693764625.3207.259576350018044927.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 05:20:46 +0000
References: <20240202004926.447803-1-kuba@kernel.org>
In-Reply-To: <20240202004926.447803-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, donald.hunter@gmail.com, sdf@google.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 16:49:23 -0800 you wrote:
> The code gen has caught up with all features required in genetlink
> families in Linux 6.8 already. We have also stopped committing auto-
> -generated user space code to the tree. Instead of listing all the
> families in the Makefile search the spec directory, and generate
> code for everything that's not legacy netlink.
> 
> Jakub Kicinski (3):
>   tools: ynl: include dpll and mptcp_pm in C codegen
>   tools: ynl: generate code for ovs families
>   tools: ynl: auto-gen for all genetlink families
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] tools: ynl: include dpll and mptcp_pm in C codegen
    https://git.kernel.org/netdev/net-next/c/8f109e91b852
  - [net-next,2/3] tools: ynl: generate code for ovs families
    https://git.kernel.org/netdev/net-next/c/7c59c9c8f202
  - [net-next,3/3] tools: ynl: auto-gen for all genetlink families
    https://git.kernel.org/netdev/net-next/c/d2866539df7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



