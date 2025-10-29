Return-Path: <netdev+bounces-233747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C798C17F0C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 02:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3013C4EA0C2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 01:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B952DF136;
	Wed, 29 Oct 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQ0wa4P/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22117B50F;
	Wed, 29 Oct 2025 01:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761702029; cv=none; b=cZmkGwBo2rCNO4tXNxx6wr+ZI5QNFTwyMQIKeSeRGalpaAO8E3uG+aqP6LAuAb7RWQJsDMppb4aQ3IiGsKKzAXjUB+KTY79NFKKEoofnzgUPrs97rJshRTWrcwlevMghuudz8/TT++7EvJ47TSled7XJZGPE3KZSMoPehzMuK80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761702029; c=relaxed/simple;
	bh=bkoIx5cfSNbT0j4HYKvnuvXjFNeqGny9Rm8Z3tZZwYU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BisKkvwSJlRb8EmiqNvTLd7h40sg8qkNgbWGyTrPzPPFD6MMhDp/aMjRRWquIibGFXECls0v0wD7fhALhiLoYY67EiUcXRRE1PpgmVFCx4jWs/t/gs+so319v0qdjRdkmMymz8Qb8qeXYAjvUPJW4YT+MlW6wo4b91Te+WXfQZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQ0wa4P/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA12C4CEE7;
	Wed, 29 Oct 2025 01:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761702029;
	bh=bkoIx5cfSNbT0j4HYKvnuvXjFNeqGny9Rm8Z3tZZwYU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cQ0wa4P/vFxecHrqRLdYzY3n7Tz2rq/Lh5hgtGnX8Xt/xEfbPqlpNXFOLRbMekhbV
	 9SAh4kUg9MnGVGVUkrNyjzqMBZXbUkptyTbS4DTxsJE9slYbyA8FKMAHVOiUZoEmGe
	 F/PJ57qc3WmpPN6chpVQMr1dD75sp1Ptn9nN0GyOYQfEauLysGj3w+1226GjllcPCU
	 bjxwia4bethcHtol2PVkhd/9HehAxJRb4k8A25B6S0h8jfXO+qSDAdxS/NDe3bxJHt
	 p4K1e4SIyTf08EymkvLOiocvZJGEIn1zWSWP/AsaiCB7f7dfXJcXcWVh+UoCHMd0zc
	 vD8aKIl187M3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9539FEB71;
	Wed, 29 Oct 2025 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpll: fix device-id-get and pin-id-get to return
 errors
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176170200650.2457978.16336444534158307365.git-patchwork-notify@kernel.org>
Date: Wed, 29 Oct 2025 01:40:06 +0000
References: <20251024190733.364101-1-poros@redhat.com>
In-Reply-To: <20251024190733.364101-1-poros@redhat.com>
To: Petr Oros <poros@redhat.com>
Cc: vadim.fedorenko@linux.dev, arkadiusz.kubalewski@intel.com,
 jiri@resnulli.us, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ivecera@redhat.com, mschmidt@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Oct 2025 21:07:33 +0200 you wrote:
> The device-id-get and pin-id-get handlers were ignoring errors from
> the find functions and sending empty replies instead of returning
> error codes to userspace.
> 
> When dpll_device_find_from_nlattr() or dpll_pin_find_from_nlattr()
> returned an error (e.g., -EINVAL for "multiple matches" or -ENODEV
> for "not found"), the handlers checked `if (!IS_ERR(ptr))` and
> skipped adding the device/pin handle to the message, but then still
> sent the empty message as a successful reply.
> 
> [...]

Here is the summary with links:
  - [net] dpll: fix device-id-get and pin-id-get to return errors properly
    https://git.kernel.org/netdev/net/c/36fedc44e37e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



