Return-Path: <netdev+bounces-82047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A1188C346
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 14:21:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58C381C20B51
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 13:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5139971756;
	Tue, 26 Mar 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a2ELrMB9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B705C61F;
	Tue, 26 Mar 2024 13:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711459304; cv=none; b=Ki9YvdRTREK3aCevoTGoGVDGyCT1T4cPL+faXq3LgK5iFxmnuosWcsmzGwjHSbYkMOhpdj00hYlZBiVL6poD02DA5GNtGQI5Q95iIM8sYf1UMeBnYktJaZGFLINOUoLjr5B3BiHSMg7B+bH71QImwFTeoTlABOLJbTQEC5bpgSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711459304; c=relaxed/simple;
	bh=7nnW/SYUsTIjbiy2s0XB4S4ws24rmjDUYBUn3jc+Px8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mzMRnHfwBVeuc8BvOLCT5dhIUe3YSP9sCqc1JFyUbxfgVU7ZTWMpXfes+9Af63+mON1pQTiBZF2vRs0ChWuAPf0h+rUn1A8g7WYOMo6RbUYTu6WT9ZLHErbbd4VOMtlAOcnes2hppZJAKpjnwhrs9fZm3qkzDFmG0NKNB6xVbEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a2ELrMB9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D3AE0C433F1;
	Tue, 26 Mar 2024 13:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711459303;
	bh=7nnW/SYUsTIjbiy2s0XB4S4ws24rmjDUYBUn3jc+Px8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a2ELrMB9YXmxIK9kirijo9QEu9FrYjDD7tzj/CNx59KPZJlLofkpLP7CvrY3BkgII
	 B6QGX5AnrCI20lZP7fTaLiBDFrV35sspRGZGz4B0ul/WLjS61/ASOE/ND0uWcUhwDw
	 LV3b/HB6zHiu32jR3x7BBKoB15WjgoLEhe6ukE3moBf2HStYlxtq9TTH4ZDKxzL6NQ
	 875r6gDvzqBhQr+fVjO36rC7MhuhslvM+9Jj5Fhw/VoSSN8tuRdnoBMoxDgF/i+TkG
	 t691C3/skkiX0/29DeAmIGXKTG2sGvvQNCnQvZlZ2DDWvGY7muhmdv7sQZ6V5/vpk9
	 7X5K0BuAIKsrw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B3661D2D0EC;
	Tue, 26 Mar 2024 13:21:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: bpf-next 2024-03-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171145930372.31773.533192202512296878.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 13:21:43 +0000
References: <20240325233940.7154-1-daniel@iogearbox.net>
In-Reply-To: <20240325233940.7154-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to bpf/bpf.git (master)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 26 Mar 2024 00:39:40 +0100 you wrote:
> Hi David, hi Jakub, hi Paolo, hi Eric,
> 
> The following pull-request contains BPF updates for your *net-next* tree.
> 
> We've added 38 non-merge commits during the last 13 day(s) which contain
> a total of 50 files changed, 867 insertions(+), 274 deletions(-).
> 
> [...]

Here is the summary with links:
  - pull-request: bpf-next 2024-03-25
    https://git.kernel.org/bpf/bpf/c/37ccdf7f11b1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



