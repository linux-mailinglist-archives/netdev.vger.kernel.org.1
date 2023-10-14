Return-Path: <netdev+bounces-40907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6079F7C919D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90E5C1C20A12
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330536B1B;
	Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLbE/Xrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B79347DD;
	Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10424C433B9;
	Sat, 14 Oct 2023 00:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697241626;
	bh=2Cwm6LisU+P9GUP96QYZ7Q9NvdOC7Vh28XyKKYvVGZc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rLbE/XrlMcyajcNIas0Ah3tA53LrR9kXnNeUanCVaIKdMxwgBQ1NnqKpUaCQ2HrvP
	 wbUrO0cP/19kUrYoHn+unf1E2eVU6eDJ22LsiIb3VDzTsZc8tQg60H6MSZXYx2gg6R
	 oGCx6G0c0CADcjOA+gV2uxxyJeZdTI2sQa20M25/E9Ca0O4rS/3qeVDzCMdtxAAd1V
	 1mtruKPEQvBFHv8tp2CG1yewrCqd4/aq/DOuxzQu+nb7yaBKvr/I/expxW9bfEWegr
	 /JCXz3Pow1yzhLQwc9qPbt1e8HVd0zhZ+2Ca3zJHFQKGUl5HUACAtNeLkewu4bsnZY
	 lR+QP3eiIPjMw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id F2A81C73FEA;
	Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: dsa: vsc73xx: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724162599.10042.9303043491352873770.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:00:25 +0000
References: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
In-Reply-To: <20231010-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v2-1-ba4416a9ff23@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 22:32:35 +0000 you wrote:
> `strncpy` is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this more robust and easier to
> understand interface.
> 
> [...]

Here is the summary with links:
  - [v2] net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/e3bbab4754de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



