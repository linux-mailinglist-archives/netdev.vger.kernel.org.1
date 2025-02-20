Return-Path: <netdev+bounces-167982-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 095E7A3CFEC
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:11:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D0483BB55F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05D11E3DD3;
	Thu, 20 Feb 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oqC65Rp9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C475D1E3793;
	Thu, 20 Feb 2025 03:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740021015; cv=none; b=f1j4bR444lcSww7U8mWjNfZKk0hla4O8qf/Ex4IHMzyZg19YDpgwP//idCKGCScPnwjcWSkgRG9qkaYzwQBdrIZzhHRvIULEiLUEODvxCV3W8MoR84gqLzB6wcurtLsDssNU1YmjzdPOyPyfP17lZK1k8SiEAG1mnztumeuOMXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740021015; c=relaxed/simple;
	bh=MD9ImpKOVvcg2zEGkV4nzRzJTxiTyqlpvcL2LMQIukw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=c/0zEFyJ6Z3pwH34MRoj2waAE6LslEF6+0JEdH15i/OqsOn2YItvyAyTPCHWYvEhAaxHCcLmwjo6m7+2k4X+tuozp92z42HxBITQm6LPzn5l2f7MpHcUThL0imdmlpDDBgQxCJkNQDdXrmoegWqLPjHqLoyhe0jEIAnFcR0IfqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oqC65Rp9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93496C4CEE2;
	Thu, 20 Feb 2025 03:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740021015;
	bh=MD9ImpKOVvcg2zEGkV4nzRzJTxiTyqlpvcL2LMQIukw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oqC65Rp9GX5CH+H8FCMdKXtkXZXED/vgx1joOy+nbIWGTsY7dTGanW/6LD3jWGRYo
	 l6L4w7HQOIb/BXCsKe+NGe1U1BgAZsLe+V87xoudBvYqOwnuwWUGpEsDvY5CZHY1zi
	 nGpJ+ic7A9ZxIeEP76CXbVrQIlccc/NZqcmZTseREeT2oGcZfoTwHD1/VEUwviDoMw
	 pM2avQCTfGT5VKJ2UWo3B/4/O79Sf8TzhRZEuIL1PpvdGGdB6eANEbRw0can8dkVLX
	 5Y166FIC0RhAHIeHVyC1o/S10fFS2JLjJ2aLGv4SOY3IvoCRdP4xfLlJHWb3hkOTig
	 cHE0uD2K0EI+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D0B380AAEC;
	Thu, 20 Feb 2025 03:10:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: mana: Add debug logs in MANA network driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002104600.825980.5206357990869586849.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:10:46 +0000
References: <1739842455-23899-1-git-send-email-ernis@linux.microsoft.com>
In-Reply-To: <1739842455-23899-1-git-send-email-ernis@linux.microsoft.com>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.swiatkowski@linux.intel.com, mlevitsk@redhat.com,
 yury.norov@gmail.com, shradhagupta@linux.microsoft.com,
 kotaranov@microsoft.com, peterz@infradead.org, akpm@linux-foundation.org,
 schakrabarti@linux.microsoft.com, kent.overstreet@linux.dev,
 longli@microsoft.com, erick.archer@outlook.com, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 17:34:15 -0800 you wrote:
> Add more logs to assist in debugging and monitoring
> driver behaviour, making it easier to identify potential
> issues  during development and testing.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
> Changes in v2:
> * Change "debug statements" in commit message to "more logs".
> * Replace dev_err with dev_dbg in out: label in
>   mana_gd_create_dma_region.
> * Use dev_err in resp header status check.
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 50 +++++++++++++---
>  .../net/ethernet/microsoft/mana/hw_channel.c  |  6 +-
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 58 +++++++++++++++----
>  3 files changed, 94 insertions(+), 20 deletions(-)

Here is the summary with links:
  - [v2] net: mana: Add debug logs in MANA network driver
    https://git.kernel.org/netdev/net-next/c/47dfd7a72257

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



