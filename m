Return-Path: <netdev+bounces-57741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E1A781404F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 754121C2218F
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51764ED6;
	Fri, 15 Dec 2023 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+NceVxL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37626ED4
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id ADACDC433C7;
	Fri, 15 Dec 2023 03:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702609225;
	bh=rM9k3aB+qx/IQtssQlIBwXD90YMbgda6Ph39lOgUPjY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+NceVxLKS+7Bz4ir6AEh0ck1k+Etm6f66Mr7/C4LgzKjdWh3+p7hGmTh4lY5VtDO
	 zIiJ+R4H47QyzU4oo7brxV3h67vHFj7t/f6oa6L9lhemVOzOSkaaBqpqPJGAXQhIgz
	 4RdD6td3a0Y9iVWlSZat2z7w8iabx+WppRhFKStoo/BO1hiXcfgJ9xvrI8BuqbiPK9
	 GnQGKjyTNu2bNvgHoYP2iXQqPoxwRsAk0EeH+OW7ls4uhdqVJ2L3DR1lZIfdB0rPr/
	 OmzXRRcJp7de59MwLU/UrghbZE22kT2xw83t7bkGa7GqawgypAgYPELUTykitCzv0J
	 QwdwLbklMeXww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8F5D8DD4EFA;
	Fri, 15 Dec 2023 03:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: atlantic: eliminate double free in error
 handling logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170260922558.28655.14442098840507624742.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:00:25 +0000
References: <20231213095044.23146-1-irusskikh@marvell.com>
In-Reply-To: <20231213095044.23146-1-irusskikh@marvell.com>
To: Igor Russkikh <irusskikh@marvell.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 10:50:44 +0100 you wrote:
> Driver has a logic leak in ring data allocation/free,
> where aq_ring_free could be called multiple times on same ring,
> if system is under stress and got memory allocation error.
> 
> Ring pointer was used as an indicator of failure, but this is
> not correct since only ring data is allocated/deallocated.
> Ring itself is an array member.
> 
> [...]

Here is the summary with links:
  - [net-next] net: atlantic: eliminate double free in error handling logic
    https://git.kernel.org/netdev/net-next/c/b3cb7a830a24

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



