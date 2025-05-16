Return-Path: <netdev+bounces-191223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD235ABA6A7
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 01:40:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B6201740F9
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 23:40:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 411B2281356;
	Fri, 16 May 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUenkWS0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BEC615A864
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 23:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747438803; cv=none; b=YZPyPlBUiYUSuFRtUUjacpA6Fcvve/KQespKD3c8yhfVsFiZIij/P6qw1eKZvFd/ZNdpv3L56vUPOLNNn4eGkoPU9ShXQGvuCHLB5xotpOnVXqMIVUmjjTYIdgeYLSPB3yb09gNBnm8DTlOxaRR2MatONpCu9ztlEtBxeUtw6XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747438803; c=relaxed/simple;
	bh=TMpKlKOhdiEeO2fccA5nhqzbh3hccMNeseHDLQM+7Fw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FHIr5oKytAfXVoPsrWo8IPz/Oq+9d/fTX+A+u0ez/irlJPqiopvUUzRMgD8R1hIyM9b7nTWoG4jFWdzkbAzQzkYfyGlDkaHB/+kBfOC/rM1yvGWWk2R77vKL9IgCgzWNBJiuw25YPNnUTHSI/34V++x5wh2rvqfhiU4gfCDgoD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUenkWS0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0EC9C4CEE4;
	Fri, 16 May 2025 23:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747438802;
	bh=TMpKlKOhdiEeO2fccA5nhqzbh3hccMNeseHDLQM+7Fw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KUenkWS0hlMvtKUQ1dBeSnyEEJSNtlC4pWoNaJjP2CHVOEUQ1aIHOfjCYrFLFscdD
	 ifOjspoKoFO1RHXHLfNFgG/6oDbborz5PWXRtQoIY4JWsL6KAwozXqEsA00cRS5uLn
	 AIhjEiaGMYoX+oEcuZgujP5miL+nOz7K1gizNRwq1FpZbaZNIYtDUSjsdeJM67c3Kq
	 AX0w3SGXI8FWxcdsZHZEIOWic8s9avXFAQp9GjFxcrpbefafCX6RhK6Uckp5n5g17i
	 dHfrHsgWOp1LHI9cXpjfoQgdh1ymCR89Pn0GleiUEYDNASoCXSyCsGF2LXp37Nlx/x
	 ZbcDN90LrCR9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACC13806659;
	Fri, 16 May 2025 23:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/9] tools: ynl-gen: support sub-messages and rt-link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174743883976.4095375.621150157070551330.git-patchwork-notify@kernel.org>
Date: Fri, 16 May 2025 23:40:39 +0000
References: <20250515231650.1325372-1-kuba@kernel.org>
In-Reply-To: <20250515231650.1325372-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, daniel@iogearbox.net, nicolas.dichtel@6wind.com,
 jacob.e.keller@intel.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 May 2025 16:16:41 -0700 you wrote:
> Sub-messages are how we express "polymorphism" in YNL. Donald added
> the support to specs and Python a while back, support them in C, too.
> Sub-message is a nest, but the interpretation of the attribute types
> within that nest depends on a value of another attribute. For example
> in rt-link the "kind" attribute contains the link type (veth, bonding,
> etc.) and based on that the right enum has to be applied to interpret
> link-specific attributes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/9] netlink: specs: rt-link: add C naming info for ovpn
    https://git.kernel.org/netdev/net-next/c/dc3f63bc3e33
  - [net-next,2/9] tools: ynl-gen: factor out the annotation of pure nested struct
    https://git.kernel.org/netdev/net-next/c/c9c048993d4c
  - [net-next,3/9] tools: ynl-gen: prepare for submsg structs
    https://git.kernel.org/netdev/net-next/c/99b76908a7a3
  - [net-next,4/9] tools: ynl-gen: submsg: plumb thru an empty type
    https://git.kernel.org/netdev/net-next/c/3186a8e55ae3
  - [net-next,5/9] tools: ynl-gen: submsg: render the structs
    https://git.kernel.org/netdev/net-next/c/6366d267788f
  - [net-next,6/9] tools: ynl-gen: submsg: support parsing and rendering sub-messages
    (no matching commit)
  - [net-next,7/9] tools: ynl: submsg: reverse parse / error reporting
    https://git.kernel.org/netdev/net-next/c/0939a418b3b0
  - [net-next,8/9] tools: ynl: enable codegen for all rt- families
    https://git.kernel.org/netdev/net-next/c/6bab77ced3ff
  - [net-next,9/9] tools: ynl: add a sample for rt-link
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



