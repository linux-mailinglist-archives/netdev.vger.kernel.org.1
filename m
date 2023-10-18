Return-Path: <netdev+bounces-42155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291347CD6C4
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 10:40:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEBD328131B
	for <lists+netdev@lfdr.de>; Wed, 18 Oct 2023 08:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E88BE1119D;
	Wed, 18 Oct 2023 08:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FRdVEGQc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB93E8C0C
	for <netdev@vger.kernel.org>; Wed, 18 Oct 2023 08:40:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 25AD2C433CC;
	Wed, 18 Oct 2023 08:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697618423;
	bh=GDfbvZk3KEL/2OiP0+wJBNdzV07Kq7LZeX1sJq5NRSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FRdVEGQcO5oZ3Pszg7eozW4THnumQY5R+cIefaOFwSy0jYzqcy5OsMR6c8uxViKK3
	 Z/pN+geFvN4eTGxBGL5mAwW62mbcMZLprGCafLpHRqrL1SFr8zmOo2vaxol8jLRgs0
	 nt+a7MlkwSLgxLnNaA7er6FLV4fVHpPwr5A3Soz0OY55o8wFxM+fqzzmS/+e5hq4NG
	 Znfs01thHGsX7I7JWpyIhoyLB/ee+dJ52O1QjouhC1rFKdcqRiGCCI6ExY/FZIqDuP
	 +3SRXmk7smqQmBS25Y0H2R5SXc75t+vh4tcQTBjROYdkMqErkw63HAECACgVgJ4NPt
	 jVpnyr6KhrQpw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0BF96C04DD9;
	Wed, 18 Oct 2023 08:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 0/3] ethtool: Add link mode maps for forced speeds
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169761842304.32286.14718578238275474190.git-patchwork-notify@kernel.org>
Date: Wed, 18 Oct 2023 08:40:23 +0000
References: <20231015234304.2633-1-paul.greenwalt@intel.com>
In-Reply-To: <20231015234304.2633-1-paul.greenwalt@intel.com>
To: Paul Greenwalt <paul.greenwalt@intel.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, aelior@marvell.com,
 manishc@marvell.com, vladimir.oltean@nxp.com, jdamato@fastly.com,
 pawel.chmielewski@intel.com, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, horms@kernel.org, kuba@kernel.org,
 d-tatianin@yandex-team.ru, pabeni@redhat.com, davem@davemloft.net,
 jiri@resnulli.us

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 15 Oct 2023 19:43:01 -0400 you wrote:
> The following patch set was initially a part of [1]. As the purpose of the
> original series was to add the support of the new hardware to the intel ice
> driver, the refactoring of advertised link modes mapping was extracted to a
> new set.
> 
> The patch set adds a common mechanism for mapping Ethtool forced speeds
> with Ethtool supported link modes, which can be used in drivers code.
> 
> [...]

Here is the summary with links:
  - [net-next,v5,1/3] ethtool: Add forced speed to supported link modes maps
    https://git.kernel.org/netdev/net-next/c/26c5334d344d
  - [net-next,v5,2/3] qede: Refactor qede_forced_speed_maps_init()
    https://git.kernel.org/netdev/net-next/c/a5b65cd2a317
  - [net-next,v5,3/3] ice: Refactor finding advertised link speed
    https://git.kernel.org/netdev/net-next/c/982b0192db45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



