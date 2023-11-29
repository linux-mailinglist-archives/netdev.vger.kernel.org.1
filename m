Return-Path: <netdev+bounces-52187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B457FDD60
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F998282122
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23191208DD;
	Wed, 29 Nov 2023 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gD5TvGLG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E473B2BB
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7737BC433C8;
	Wed, 29 Nov 2023 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276026;
	bh=q29AkF9tXA/foVh9Ri+FNMBQN6a+ESC5ka9D43gXBBQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gD5TvGLGgUX8WyZEztZkOxPo7Q9WobZKPPefsBSI5e3EozjAL7jIfd+ngpYEl/U7y
	 Jejh92LfC5RKEYP2bq7QfHzog9A4C7gEIcSvv7y/wWLPdpjpPk3xHahnAZiCB/aCsg
	 8RP5T0swEmCX5jyKt6xMIQGNplixgd5js4qqxJFIBeQ8ucgYAaykEt95Bgyl6Z4BGm
	 EvuAbt0yuXSqB4/DO/6XUZ09KMr0BNb2lSzJsT1Kl+jHULQctrTnbihX72Hy/FAwwS
	 fIPOs3fTMT0kc6LutWabCPOAnDN6nJL0cVSI8lYVYV0Jm3Ig5KRLSYCkCG+6XXMupd
	 a5oOa27PucyCw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6077FDFAA81;
	Wed, 29 Nov 2023 16:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] gve: Add support for non-4k page sizes.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170127602638.9321.9127222835180364530.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 16:40:26 +0000
References: <20231128002648.320892-1-jfraker@google.com>
In-Reply-To: <20231128002648.320892-1-jfraker@google.com>
To: John Fraker <jfraker@google.com>
Cc: netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 16:26:43 -0800 you wrote:
> This patch series adds support for non-4k page sizes to the driver. Prior
> to this patch series, the driver assumes a 4k page size in many small
> ways, and will crash in a kernel compiled for a different page size.
> 
> This changeset aims to be a minimal changeset that unblocks certain arm
> platforms with large page sizes.
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] gve: Perform adminq allocations through a dma_pool.
    https://git.kernel.org/netdev/net-next/c/955f4d3bf0a4
  - [net-next,2/5] gve: Deprecate adminq_pfn for pci revision 0x1.
    https://git.kernel.org/netdev/net-next/c/8ae980d24195
  - [net-next,3/5] gve: Remove obsolete checks that rely on page size.
    https://git.kernel.org/netdev/net-next/c/ce260cb114bb
  - [net-next,4/5] gve: Add page size register to the register_page_list command.
    https://git.kernel.org/netdev/net-next/c/513072fb4bf8
  - [net-next,5/5] gve: Remove dependency on 4k page size.
    https://git.kernel.org/netdev/net-next/c/da7d4b42caf1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



