Return-Path: <netdev+bounces-82552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F14188E8E7
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 16:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B05C306E03
	for <lists+netdev@lfdr.de>; Wed, 27 Mar 2024 15:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C5A130E37;
	Wed, 27 Mar 2024 15:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="caMfhXc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F263512FB39;
	Wed, 27 Mar 2024 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711552842; cv=none; b=ZpRUMPdojBSvuRPWFnVkwYeLohhCq581kH1pVLLWSANXVPoWIavgsBVg+Ca5vFpno+4TjaYnzXcUjHUNtqNaRxwkWbKiplJWpu9+dq9iOjJdhMA2nJN4hPMCqIJm6Y4Rp9HKTS0K2Sl/RtInDmOAdPbV6o30nXvzFd1ZFRCIEHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711552842; c=relaxed/simple;
	bh=90ro7OkwkGORt7wcw/Ar/xaZpMzn24uWtb8pOKNG3hM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gtuefzcgVGcrpDINviJVD+h8n421ZMSWY3uRd7EHSbe2SX4rREfZPThvVi9RVInHeU6Bmf2Q6D2rGhjYXJH/HCPXs0d/a4CeDjWLiugkBLaN5TNxiq122/bya+GpaHlFyq94KQfRryQEz3LCcC/qWbiHqcN4mki+niEvV5iLj+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=caMfhXc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 73754C433C7;
	Wed, 27 Mar 2024 15:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711552841;
	bh=90ro7OkwkGORt7wcw/Ar/xaZpMzn24uWtb8pOKNG3hM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=caMfhXc4qePqC+/DQnwRq3bAo+B/+3gknf+tGAHa23i5beyK9VOjLJFGBsPIn3yE0
	 +jzLHPOl16Vw+6yyIO9lY/BF9PDsMT+GCFBsLO5MI59HP1NcI88umEDVGzmy3t2YJF
	 YEic4ahsqMaxn7mAKFNn7fjiPcqKsBORkQRO4VZyzI8MOFQ9NIJGn2LyV7DQ/Ygtwq
	 SrcqpwDuNbC7DES9+mQCRyObARhiOlXz5UjhyVf+t2HQeJtv3CWeuG/f8zB5d0l5+r
	 Ypfe7C4pg3r3ES5fltckXJ7fFkb+Jb2v2p9jGoJsEFkxOW76wrN+YexhwshSx/OIRh
	 Fvi4zxJPhDLEg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AA2BD95061;
	Wed, 27 Mar 2024 15:20:41 +0000 (UTC)
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
 <171155284136.31915.5947105189002698344.git-patchwork-notify@kernel.org>
Date: Wed, 27 Mar 2024 15:20:41 +0000
References: <20240325233940.7154-1-daniel@iogearbox.net>
In-Reply-To: <20240325233940.7154-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, ast@kernel.org, andrii@kernel.org, martin.lau@linux.dev,
 netdev@vger.kernel.org, bpf@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

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
    https://git.kernel.org/netdev/net-next/c/2a702c2e5790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



