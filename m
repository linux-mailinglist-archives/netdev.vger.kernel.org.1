Return-Path: <netdev+bounces-40921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7E177C91CB
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 02:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1C26282E8D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03801104;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BaZ0vWOz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF691102;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1986EC43397;
	Sat, 14 Oct 2023 00:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697243427;
	bh=7xfhkf9yKZYMHOIzM0/KeKtAWNEDZuqpW4TLaNUbC3I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BaZ0vWOzlGSp31B8JlmVTwapr2a0Mo97l7+hK0tri0ir1J6gqyIzgH85Js5opU+Gl
	 KM3dleWDeen1ajefQA7T6vXRXeTQ5jaJ+ooEk/l484tZ77XdjJSx8+F230RIQUxnpq
	 n4xMXLE7K94GMnizujnT+/XA804xi8WyiP+uBic7VkHSSURf6n0p9z49mwkgLCMYPN
	 F6F7TQMdmwgpSfz8uEPLzcOLNBIFftH72/7zik3E2fxFvAxzRNjmwMmW+Xnp/f7ZNK
	 EF39PwqOf3cuVYbEMN5vyNjvT7vTHGF4VUh1JV53afrkz9iixr93nvGXGLCKKetM9A
	 n7NVOoMcftugQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id EAE60E1F666;
	Sat, 14 Oct 2023 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ionic: replace deprecated strncpy with strscpy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169724342695.24435.11221830253130686654.git-patchwork-notify@kernel.org>
Date: Sat, 14 Oct 2023 00:30:26 +0000
References: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
In-Reply-To: <20231011-strncpy-drivers-net-ethernet-pensando-ionic-ionic_main-c-v1-1-23c62a16ff58@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, drivers@pensando.io,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Oct 2023 21:53:44 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> NUL-padding is not needed due to `ident` being memset'd to 0 just before
> the copy.
> 
> [...]

Here is the summary with links:
  - ionic: replace deprecated strncpy with strscpy
    https://git.kernel.org/netdev/net-next/c/ad0ebd8b4457

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



