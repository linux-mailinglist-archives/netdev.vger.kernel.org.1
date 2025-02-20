Return-Path: <netdev+bounces-168087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB76A3D62B
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45457173C07
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 10:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 438CD1F03DA;
	Thu, 20 Feb 2025 10:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HiLXZoYf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF521F03CB
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 10:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046200; cv=none; b=Sel4Bb5y8IETD82mp7BJyWuFYMmra3sfCCLBv2x32ivcuOqd4og/rYg7SWRtH249hDiw0VRYxsR884hWqzN6z4aLNcW8KuHa/YRFp0Rb/CaKLraQFS6FcbvBypjBJ2VkybZ/fK/CC4v3xoCJN/usq+BBvhXaZ8/Ymfo1AKUDGO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046200; c=relaxed/simple;
	bh=hCW1Rm7Yjuomn1fItL1s0sZVpCJiw/ZUQR8yN5wQEYA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nZBHFlkOl8sFSfSn5MFcgeOSGqK5rer/g8DzahJGsvnWXmOn3s+va66R/a4lTTMMZftDH7Ow+mxT+a90Y38cPFySjlyozVJJkb8fYaZqZquCyAmEkAqQcZo9SxljyjQmLuqRreVK/zTds4W53NwCkEyWQ81SgWa6H3dCmoCCp+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HiLXZoYf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B900C4CEE3;
	Thu, 20 Feb 2025 10:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740046199;
	bh=hCW1Rm7Yjuomn1fItL1s0sZVpCJiw/ZUQR8yN5wQEYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HiLXZoYffnURTtoxrSnUohIAIlr3lrLMEQAtpj9HL/vC84D5dvqANMZ8vPZWnVJ4W
	 BIALa3tvm7EusE8r/diFsYf6q9coBx30zUaRTf8HRy2HmXWFvXTNSvBhNlT4n2JbPB
	 IoovKhVpFWvk5eyGGTd+id/nyWmdefXA/O2Y1KSPGm07crfj1qJ+0KiAQWp53Asp0y
	 9frPaO4DTGd6H/ctLIB0BEEfvcZVqEUre+lvI7YEPXp91gAc1PM3HNkpTvYrc8vLtt
	 7uT/gxlGxupj1lt+UP5jcrEY3q3aNQIufvaPF+JzYlV4JLQuku8YwUK7lOpfN40E+S
	 EAAPxiJRHTjVw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7128B380CEE2;
	Thu, 20 Feb 2025 10:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] net: remove the single page frag cache for good
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174004623026.1237752.7422488683679437676.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 10:10:30 +0000
References: <cover.1739899357.git.pabeni@redhat.com>
In-Reply-To: <cover.1739899357.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 kuba@kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 alexanderduyck@fb.com, razor@blackwall.org, kernelxing@tencent.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Feb 2025 19:29:38 +0100 you wrote:
> This is another attempt at reverting commit dbae2b062824 ("net: skb:
> introduce and use a single page frag cache"), as it causes regressions
> in specific use-cases.
> 
> Reverting such commit uncovers an allocation issue for build with
> CONFIG_MAX_SKB_FRAGS=45, as reported by Sabrina.
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] net: allow small head cache usage with large MAX_SKB_FRAGS values
    https://git.kernel.org/netdev/net/c/14ad6ed30a10
  - [v2,net,2/2] Revert "net: skb: introduce and use a single page frag cache"
    https://git.kernel.org/netdev/net/c/6bc7e4eb0499

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



