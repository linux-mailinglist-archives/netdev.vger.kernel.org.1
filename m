Return-Path: <netdev+bounces-40906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 427D37C919C
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39D8CB20B5B
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EA726E12;
	Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdhuWIj/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605A112B87
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 00:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id EC706C433CC;
	Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697241625;
	bh=VsIUpqefnf71mMlgC6Jl9mJd4GFzyW8fQmFd2shl82E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kdhuWIj/8is5C5CEBY2iv8c4urgz3gaU2gue93fPE0575jNcb3+aaJrIfWuKR7LIg
	 sbQL4+FPMN3KGcwVdfdRbBX9IUArsDWgC/uL4srZHmtQOrdNYPQQr6cG2NdExtlsRV
	 IWLIsoOkGJFmFeaWN94rDCIvTtFKZomoTJHiSsM4uHiBVYtqu4OCJV6T5Foy2CVMsR
	 vcP5vA/N23Qfm23QlLlt6vL890nEOuwGDy8qOve4lB+dk1nAmeRv+iSSkzoqMCcStl
	 S60CHu+suPUMXtqUgBa1DSguQrbLTW3mwOnbAEM2wHKsOtKAWkS93gA1UPXyrjZRUH
	 REwOC0/BlcwPg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C18D5C73FEA;
	Sat, 14 Oct 2023 00:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: fix over-shifted variable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724162478.10042.15458001965222573833.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:00:24 +0000
References: <20231010203101.406248-1-jacob.e.keller@intel.com>
In-Reply-To: <20231010203101.406248-1-jacob.e.keller@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 jesse.brandeburg@intel.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org, horms@kernel.org, himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Oct 2023 13:30:59 -0700 you wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Since the introduction of the ice driver the code has been
> double-shifting the RSS enabling field, because the define already has
> shifts in it and can't have the regular pattern of "a << shiftval &
> mask" applied.
> 
> [...]

Here is the summary with links:
  - [net] ice: fix over-shifted variable
    https://git.kernel.org/netdev/net/c/242e34500a32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



