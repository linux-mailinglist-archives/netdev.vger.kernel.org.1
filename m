Return-Path: <netdev+bounces-30544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9D1787D8E
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 04:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7935E1C20F2D
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 02:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD29E64C;
	Fri, 25 Aug 2023 02:10:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CD7649
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 02:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD273C433C9;
	Fri, 25 Aug 2023 02:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692929421;
	bh=I/eUBhej2L/IY/Eq2kJtIZtjJWeKtffUbgRD4v+Ukt4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MHguA6IZtGrO8eejnq0YV3eDSOhKHnHCaxKkRWZNdBxA8+k69W4+f7JHE9Ndi8R5b
	 aqY1v9Sg+6ACl68NCc/36fpMyTPGwVBf/Vc4edV8iliv9bwyVqKNZQhKIkKKkCDb31
	 2dIh2Yxpz2Al7Hk5NqRp3MlHUyrkquNEKGzE2SXJOD8KgR5SNCXDkBQQL0shuOXDw+
	 5AVMsBULsr/vSozFL4O+IXAJCBkI/a8PVLbiTWrSGQg/44wolptJMyVJgR5JmsXJ0l
	 /toy3BT9daQrLnItmHOlxFm35r0pO1yKqEoGaTwowYra+yoctVlWFRP49AJQUUYQJ9
	 NWFbLdtRGiIPA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F312C395C5;
	Fri, 25 Aug 2023 02:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/mlx5: Dynamic cyclecounter shift calculation for PTP
 free running clock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169292942158.9464.5080836993592147679.git-patchwork-notify@kernel.org>
Date: Fri, 25 Aug 2023 02:10:21 +0000
References: <20230821230554.236210-1-rrameshbabu@nvidia.com>
In-Reply-To: <20230821230554.236210-1-rrameshbabu@nvidia.com>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Cc: netdev@vger.kernel.org, saeed@kernel.org, kuba@kernel.org,
 richardcochran@gmail.com, davem@davemloft.net, pabeni@redhat.com,
 vadfed@meta.com, kenneth.jonassen@bridgetech.tv

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 16:05:54 -0700 you wrote:
> Use a dynamic calculation to determine the shift value for the internal
> timer cyclecounter that will lead to the highest precision frequency
> adjustments. Previously used a constant for the shift value assuming all
> devices supported by the driver had a nominal frequency of 1GHz. However,
> there are devices that operate at different frequencies. The previous shift
> value constant would break the PHC functionality for those devices.
> 
> [...]

Here is the summary with links:
  - [net] net/mlx5: Dynamic cyclecounter shift calculation for PTP free running clock
    https://git.kernel.org/netdev/net/c/84a58e60038f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



