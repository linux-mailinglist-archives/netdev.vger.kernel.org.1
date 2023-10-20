Return-Path: <netdev+bounces-42837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E5D27D05E3
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 02:40:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C2977B21197
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 00:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BFFA375;
	Fri, 20 Oct 2023 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tMoUkk/a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8229361
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 00:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3F9A1C433CA;
	Fri, 20 Oct 2023 00:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697762423;
	bh=H3/cGCGm5Lcth5PGgrinf5iAWAJdIj6emJBvsWuPRVg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tMoUkk/abpGKzLpfHr6ADL7K9dmJ1jz7PoeVcwmZ0odPLjJs7EkOLI6IiX1EJUZLP
	 vuvdq/PMylDLihCSjZ/AlOtILqehjKoR5jPLqfWZ439o7EUQN3g8t5B+oyJhlOC+rR
	 aHNAB9tpEYcTB+S6/gmtgvg2G5n3QnxQioCJFQK97r/BqOyJo5/ZhQviZyxclciAZH
	 ttQo3V4HHrogUj5udfewhevy1vb4F7T01YLtkYNRq1zacTAaJuCzExo3Hs6a7dffT9
	 FjwmoFwurWfMuoD1kmq87+TFp7W3uYuuqDqrBj+q5m/dGpoJk7rOQ5SPW3qymx2V/r
	 KmGTEFZccYlow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D8C7C595CE;
	Fri, 20 Oct 2023 00:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] i40e: xsk: remove count_mask
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169776242311.19903.7725017864610807952.git-patchwork-notify@kernel.org>
Date: Fri, 20 Oct 2023 00:40:23 +0000
References: <20231018163908.40841-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20231018163908.40841-1-maciej.fijalkowski@intel.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, magnus.karlsson@intel.com,
 jacob.e.keller@intel.com, tushar.vyavahare@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Oct 2023 18:39:08 +0200 you wrote:
> Cited commit introduced a neat way of updating next_to_clean that does
> not require boundary checks on each increment. This was done by masking
> the new value with (ring length - 1) mask. Problem is that this is
> applicable only for power of 2 ring sizes, for every other size this
> assumption can not be made. In turn, it leads to cleaning descriptors
> out of order as well as splats:
> 
> [...]

Here is the summary with links:
  - [net] i40e: xsk: remove count_mask
    https://git.kernel.org/netdev/net/c/913eda2b08cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



