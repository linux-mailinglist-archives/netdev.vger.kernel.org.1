Return-Path: <netdev+bounces-105654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4895E912297
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 12:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F328128AFBD
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D037117167B;
	Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8t9UdNi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A848F16D33A;
	Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718966428; cv=none; b=qOOhC/KbkqSNn0pS9gG7BPKlerIYGNUNc2LCbZVguIAJGP0EBpcuQumf+Pkt6ho7s5/RSapdWVKTaxjPU8IKeiEH0BX4YfmZMF+fscxMUIAgzch3Nxrs+dQ5KxC17S8ArtcfafNg8Eb5+l20puVewq+DGgsBg3vgoYp7C4aXlBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718966428; c=relaxed/simple;
	bh=EbXQDV4cwCvlnWvzO7TCfsF21yNFddXHuwZYbz+n24M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jiXF6m1LRAyjBsaZs1bU2ZlYvYHjGuAZesGN5bkEqfrWrA0eF9u9BkLnDBBifnR4S72ySzUwgGG6yVOMx/OsNPPGvmV12NtCaibwZQD2Mwc6ZdgRBehpqYcFNs4UkhN1k5ErMZYYlOsyeuO7Sa04XcHBUsZysamUcecW2+927to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8t9UdNi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C8B8C32781;
	Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718966428;
	bh=EbXQDV4cwCvlnWvzO7TCfsF21yNFddXHuwZYbz+n24M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C8t9UdNiIV9qKfNlkLCtFTMUFfWOEvt8E+5fpaIFsNrFoU3F79bpobaor7qJGZCEj
	 ujWfmkdJiQOrCloDfcR0dEYpsjSFmA75nDc/1VRea/JB6BYBf25GWswsA0kmtHKeFD
	 0J9fo4LY1lRtHEoYDw6kC2Qj09VEoW0YTEF1E9I1rPgzOuGCDXjCXB0HY898G7PBW3
	 +fEjgsc8eSZrxUJjWXUnJq2zO6/Y6eNRFhTXQyu/qgN/C6dIOo8/rx8jfHOKnOsimy
	 srV07lYexpHUPXt5KG1/mwvfvaU00WWTUoof148RUvW3oxR2gFiQKijU5diF+ofHut
	 An8ttt6AeTtxw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6C3E3C4332D;
	Fri, 21 Jun 2024 10:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: pse-pd: Kconfig: Fix missing firmware loader config
 select
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171896642843.6147.2008287276840776733.git-patchwork-notify@kernel.org>
Date: Fri, 21 Jun 2024 10:40:28 +0000
References: <20240620095751.1911278-1-kory.maincent@bootlin.com>
In-Reply-To: <20240620095751.1911278-1-kory.maincent@bootlin.com>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: andrew@lunn.ch, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com, thomas.petazzoni@bootlin.com,
 o.rempel@pengutronix.de, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 20 Jun 2024 11:57:50 +0200 you wrote:
> Selecting FW_UPLOAD is not sufficient as it allows the firmware loader
> API to be built as a module alongside the pd692x0 driver built as builtin.
> Add select FW_LOADER to fix this issue.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406200632.hSChnX0g-lkp@intel.com/
> Fixes: 9a9938451890 ("net: pse-pd: Add PD692x0 PSE controller driver")
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
> 
> [...]

Here is the summary with links:
  - [net] net: pse-pd: Kconfig: Fix missing firmware loader config select
    https://git.kernel.org/netdev/net/c/7eadf50095bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



