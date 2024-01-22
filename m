Return-Path: <netdev+bounces-64524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3739F835927
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 02:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A556281F43
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 01:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9BE936E;
	Mon, 22 Jan 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvJ127Bz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832FC36B
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 01:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705887255; cv=none; b=iBslyPdfDUd+qHdguhf5a8zzY0cdRZaUpIXzwuD5yWthRS18f1nEOiB3lzamfBAwCy8oOMbJK2Wi87YVOXIAeWdnCVIzhHJaH/6mrXGoIhoQx3gf/u78gM7nxnTaOv8jX3HTPpoidKn61/wxDRgsmQf1itA44VSGJT6J4JpxF3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705887255; c=relaxed/simple;
	bh=7FwLLMxlg4iJodLZj2B4/co13TMcA2FgzbpNsXTtQLc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3u1SJ/6xLxyJbXHh2tplBBNJzglNIz156ewdhmjPD6W76C9t/Lm7IAqVSU1GJmduS/I6k7KDJ4zBG/gwKJ+NPN3YqjwpSKA1IffPO1m1vqyGlx89yurBbipTVb2GUkA870hXKq9jyGtK5M4qaCbXjFoqhj9QgFmZ1rVwF2D8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvJ127Bz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E6992C433F1;
	Mon, 22 Jan 2024 01:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705887255;
	bh=7FwLLMxlg4iJodLZj2B4/co13TMcA2FgzbpNsXTtQLc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YvJ127BzOUKzjUaYl4USCa2MXUmbxzo9mX7zjUhr9dI2dLY8KIZ7105JTV6a2SJYF
	 kpmQ5P3WZXHvaCLzxQ+fcSa0BShbMqA7kK66zXPQN5kYYvhZ3ph57MO171UgppjkAn
	 poTPktxx34FeUq9Hetawl+1uUU8BcMMQ7PLjB9WjjKXMm+Zdzxx0t33CUQw71MCYAu
	 rJdNvBaJEn6tLM1wo7CasSelEH1RiLnjS1Tf6AQSWurG7e+aBqAbNhH4rNyUaIi3g9
	 uVp4xebZZjiYaMp2tU+WAi+agDmkpuK0JP02Cws0xru70DojWVNdEgn9uuVCkEz3OB
	 O5WCLtGuGAJAA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D4E0DE0B630;
	Mon, 22 Jan 2024 01:34:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: fix removing a namespace with conflicting altnames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170588725486.2038.9136571291070168243.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 01:34:14 +0000
References: <20240119005859.3274782-1-kuba@kernel.org>
In-Reply-To: <20240119005859.3274782-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, socketpair@gmail.com, daniel@iogearbox.net,
 jiri@resnulli.us, lucien.xin@gmail.com, johannes.berg@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 18 Jan 2024 16:58:59 -0800 you wrote:
> Mark reports a BUG() when a net namespace is removed.
> 
>     kernel BUG at net/core/dev.c:11520!
> 
> Physical interfaces moved outside of init_net get "refunded"
> to init_net when that namespace disappears. The main interface
> name may get overwritten in the process if it would have
> conflicted. We need to also discard all conflicting altnames.
> Recent fixes addressed ensuring that altnames get moved
> with the main interface, which surfaced this problem.
> 
> [...]

Here is the summary with links:
  - [net] net: fix removing a namespace with conflicting altnames
    https://git.kernel.org/netdev/net/c/d09486a04f5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



