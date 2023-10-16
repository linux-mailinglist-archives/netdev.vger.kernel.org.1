Return-Path: <netdev+bounces-41608-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6937CB6EF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 01:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60DC61C20AD0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 23:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF3B38FAD;
	Mon, 16 Oct 2023 23:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JxDCc/ZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48DE38F93;
	Mon, 16 Oct 2023 23:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F07A0C433C9;
	Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697498422;
	bh=lOIpGqgibN8/nbIwE0LnrrmupkivmhXyXtxTDswu3IU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JxDCc/ZRxj55oYIWPMqbVlMhSI1jAk/wVz34Cg8X+aDwT9mCxprAAEQEddTPjsx0U
	 LpmgMjzE7Lt1UV/btjCLfcT2PJB/nQaCj3dMzHb7ui/ni2lY6VX0TA+HbekE1nJnFO
	 prj1PMRtVBGjGYQgzb/SdB/Gew0x4zeDogDkomtZg/dZmXHwm4pYHH38BwvGdANhsP
	 bKuWgd/r+rmMJnMPaOR6UYNZ138HsloqwKaVIWMRqMMOBOHEDQJyBA+NA+aRSdWtp2
	 dnpTYrjcT7GJJbPFSMH+uC8mfCEGvehd+OOdWLLJzdDHAo1Mqr7TDm5WARmEK/nijh
	 6ukjPUV92obew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D57B3C04E27;
	Mon, 16 Oct 2023 23:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: smsc: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169749842186.17995.9195946058362636123.git-patchwork-notify@kernel.org>
Date: Mon, 16 Oct 2023 23:20:21 +0000
References: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
In-Reply-To: <20231012-strncpy-drivers-net-phy-smsc-c-v1-1-00528f7524b3@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Oct 2023 22:27:52 +0000 you wrote:
> strncpy() is deprecated for use on NUL-terminated destination strings
> [1] and as such we should prefer more robust and less ambiguous string
> interfaces.
> 
> ethtool_sprintf() is designed specifically for get_strings() usage.
> Let's replace strncpy in favor of this dedicated helper function.
> 
> [...]

Here is the summary with links:
  - net: phy: smsc: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/4ddc1f1f7339

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



