Return-Path: <netdev+bounces-60639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55ED8820890
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 22:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E1991C21689
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 21:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92059C2E6;
	Sat, 30 Dec 2023 21:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vBawO+6j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DDBC2E3
	for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 21:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C6AEBC433C9;
	Sat, 30 Dec 2023 21:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703972423;
	bh=Vmbb/GD5+RRbTrUnZ/3nw7nGauF1GXYbYz9HggBnboo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vBawO+6ji/BaSKsxsCklYsKFq6Cgufae1DevEODAO+XImYbYqmNICy5Uf//pHhc+r
	 ZblPqOFIDgkRHPIlfukjkI1iigygNPLfz3OKzzHD2BJPAVctb6Ma6zSk1wq3Fqdyf5
	 V948JGt0o74QB6rR2dCudR/1/fl4Dby3MCYWcYcocoxVVmDcXwhZtdEuLFypC/a0D0
	 FPFXYe9pHVclE6WrIeinCtc4BtVDe5qpZq4q+4xG6Li575rI3kwacKags0VF3uZflS
	 /e167X130G5vuWf6i0i7/RFjVB69Uzo2qLOkiyenxAK5RZFDk4Tw8C2aTsXKm2xIia
	 XdgrgPgvqlAkA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B0B2DC4314C;
	Sat, 30 Dec 2023 21:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next] bridge: mdb: Add flush support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170397242371.25031.13405288492369571967.git-patchwork-notify@kernel.org>
Date: Sat, 30 Dec 2023 21:40:23 +0000
References: <20231226153013.3262346-1-idosch@nvidia.com>
In-Reply-To: <20231226153013.3262346-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, dsahern@gmail.com, stephen@networkplumber.org,
 razor@blackwall.org, petrm@nvidia.com

Hello:

This patch was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Tue, 26 Dec 2023 17:30:13 +0200 you wrote:
> Implement MDB flush functionality, allowing user space to flush MDB
> entries from the kernel according to provided parameters.
> 
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  bridge/mdb.c      | 137 +++++++++++++++++++++++++++++++++++++++++++++-
>  man/man8/bridge.8 |  67 +++++++++++++++++++++++
>  2 files changed, 203 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next] bridge: mdb: Add flush support
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ff3e423b9c6b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



