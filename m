Return-Path: <netdev+bounces-40204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E8CA7C61BA
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 02:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBC261C20F96
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 00:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 152AA806;
	Thu, 12 Oct 2023 00:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHbBrB+H"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDC481F;
	Thu, 12 Oct 2023 00:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E91E5C433BC;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697070626;
	bh=ic4p5FL8H/WP6cBu+eSyU2CbFtqrAwAUjqHHScIInSI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eHbBrB+HGSkIEqg/nHyZD2Y/EQEc9ernguzbYLykDMDTDNwrlQNRDk1/EkoEb63gc
	 f0QeGFZvov/tEQ+8wZGJqO8kbKCrNyPTSTMaYfn3bbg81r+Jmtbru3M9EU8+DXpsVy
	 pjXdNV9uCxUuDBUnJZ1qYxk7SnFrdye9ijgXdz24fz5AK+L1zA09oJTYHMHxYdOmWk
	 J3MIGDvseXy9tfmGE0ZIokUKyM91yVDTvpirudVz6jclG/ey9Hu3OplJ3KFQOS01xj
	 AIkvQXpsmjAVfzzI9JrIHxnUOj1h9I5x6TNVna6+wWu+s7KvHgwjdZqBgstqJALAf1
	 1wQbIx3/fdHGw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D64C9C595C5;
	Thu, 12 Oct 2023 00:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: lantiq_gswip: replace deprecated strncpy with
 ethtool_sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169707062587.15864.15415155248488674538.git-patchwork-notify@kernel.org>
Date: Thu, 12 Oct 2023 00:30:25 +0000
References: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
In-Reply-To: <20231009-strncpy-drivers-net-dsa-lantiq_gswip-c-v1-1-d55a986a14cc@google.com>
To: Justin Stitt <justinstitt@google.com>
Cc: hauke@hauke-m.de, andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Oct 2023 18:24:20 +0000 you wrote:
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
  - net: dsa: lantiq_gswip: replace deprecated strncpy with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/ed9417206de7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



