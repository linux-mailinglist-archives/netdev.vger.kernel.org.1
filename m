Return-Path: <netdev+bounces-244111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D9673CAFD41
	for <lists+netdev@lfdr.de>; Tue, 09 Dec 2025 12:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7A3130202C1
	for <lists+netdev@lfdr.de>; Tue,  9 Dec 2025 11:53:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D832B3009EE;
	Tue,  9 Dec 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2aZ1K5Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FDD2BDC29
	for <netdev@vger.kernel.org>; Tue,  9 Dec 2025 11:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765281204; cv=none; b=lE1g34UQpwkD1kzH+pk+B6uMApjJoplrVhGFQcXU++CHOVrQ/4vhqGbOVBP8YrvfVg1WWVuxOvaogEj4SfzW5j3qZgeBev6Psw3CgpP8+esog7T0KFINpJqKn7ReL474Y6FDcONqW7j1cDp2qVewiiRfcuP4okINasevEw2LELs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765281204; c=relaxed/simple;
	bh=7rX/OcJhWeZ+B67qX2pLWOU9MLrRh/oqQXc7eRFHFyI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dD5Qdi6MJxbqC45SeWtHgjrPj5hwI2keyHvGIvzHv8+IMC6mBlTxjztIrt/wVVpR2PVmM/qhL6SK3i2A9JbJ2LCN+zQexj5pex8Oai/b9bHzZtah0sHjGdKFs7Rpim5XRTTnShLo27ZrRzZUvKJy5Bzhzyl9kwOuBsdFeZjtxjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2aZ1K5Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40010C4CEF5;
	Tue,  9 Dec 2025 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765281204;
	bh=7rX/OcJhWeZ+B67qX2pLWOU9MLrRh/oqQXc7eRFHFyI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X2aZ1K5Y3KmTFo7Vx7LJNmZ/kShMfKiKpoKVg164QVvXjOF7yWbBVmycY5ZH5HLzb
	 KcRDfbaK4Cpl72ReoLw5Yee3m5nrSpZ2EbpKIIQOtAATuUByB1vtkkizE2CZy04y+1
	 VyHiyOmrf+8KkshCoh2GDCB2+/9pfg3+cTgmyampvIfApHQkoZaFku+OUmHSic6GJI
	 P7QAYIvhR+ETIyNRgpf4J0rkFLKErKaN/dE/XHV6Qpz+aVfCOqVnW3Jr+ibKHdD+EL
	 maGN1VnFap6kyZ2vuFxJTa2Ti4iaeYV7ObRJY1F+AJk2ljTUPMJTZrIU2DsQrPEgmQ
	 sohlI2SwxLfeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B595A3808200;
	Tue,  9 Dec 2025 11:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix build on systems with old kernel
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176528101952.3919807.3378977959516486088.git-patchwork-notify@kernel.org>
Date: Tue, 09 Dec 2025 11:50:19 +0000
References: <20251207013848.1692990-1-kuba@kernel.org>
In-Reply-To: <20251207013848.1692990-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, ast@fiberby.net, Jason@zx2c4.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Dec 2025 17:38:48 -0800 you wrote:
> The wireguard YNL conversion was missing the customary .deps entry.
> NIPA doesn't catch this but my CentOS 9 system complains:
> 
>  wireguard-user.c:72:10: error: ‘WGALLOWEDIP_A_FLAGS’ undeclared here
>  wireguard-user.c:58:67: error: parameter 1 (‘value’) has incomplete type
>  58 | const char *wireguard_wgallowedip_flags_str(enum wgallowedip_flag value)
>     |                                             ~~~~~~~~~~~~~~~~~~~~~~^~~~~
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix build on systems with old kernel headers
    https://git.kernel.org/netdev/net/c/db6b35cffe59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



