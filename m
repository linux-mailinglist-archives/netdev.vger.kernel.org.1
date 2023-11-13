Return-Path: <netdev+bounces-47398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 098DA7EA15D
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AC441C2088C
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 16:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D3921347;
	Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rczx2pAT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C4D22309
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 495D8C433C7;
	Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699893623;
	bh=S8c02+jFmVOiLuUrXGtjePreOUn2NGjtPD6kydze0so=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Rczx2pATeCURWridZlohLYFkTin3xr4l/R7PiDuv76Y3tpiFK5eu/N2umpib3SGqU
	 1qZ/1Aoea2u3SEKoE1ZsJQUgwj+XV3r2Fm3Uht61yP1adyjhEij1qiAh6ZlFDylh2c
	 rzaM4v4mWl8j4Qk22dV4I6A+XsM7wmr4RJna2omRaM12CQ/47xrQfMz/U0A2KW6hT2
	 p7APAAnFYllvpCVBv1WQLxh/LFF3BuIyAk/6g/sgs21CKGwCTzpnjNZ0r93dgosqer
	 MKgU6vYWLhLsoFvuWO6rEigR4mtMKvx/TVbGk0dnb6/6CwCUfDb3Rt6ariPa+ax2WU
	 Gg0d3iAVDMPFw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B6E0E32714;
	Mon, 13 Nov 2023 16:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] Revert "Makefile: ensure CONF_USR_DIR honours the
 libdir config"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169989362317.31764.14802237194303164325.git-patchwork-notify@kernel.org>
Date: Mon, 13 Nov 2023 16:40:23 +0000
References: <20231106001410.183542-1-luca.boccassi@gmail.com>
In-Reply-To: <20231106001410.183542-1-luca.boccassi@gmail.com>
To: Luca Boccassi <luca.boccassi@gmail.com>
Cc: netdev@vger.kernel.org, stephen@networkplumber.org, aclaudi@redhat.com

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon,  6 Nov 2023 00:14:10 +0000 you wrote:
> From: Luca Boccassi <bluca@debian.org>
> 
> LIBDIR in Debian and derivatives is not /usr/lib/, it's
> /usr/lib/<architecture triplet>/, which is different, and it's the
> wrong location where to install architecture-independent default
> configuration files, which should always go to /usr/lib/ instead.
> Installing these files to the per-architecture directory is not
> the right thing, hence revert the change.
> 
> [...]

Here is the summary with links:
  - [iproute2] Revert "Makefile: ensure CONF_USR_DIR honours the libdir config"
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=deb66acabe44

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



