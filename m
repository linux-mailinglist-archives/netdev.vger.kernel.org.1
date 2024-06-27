Return-Path: <netdev+bounces-107494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA2A91B2F3
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 01:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AB2B282F22
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 23:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8468414A604;
	Thu, 27 Jun 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDysd5v9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6AB13F42F
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 23:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532239; cv=none; b=IQ3RWofkcdn4++rk65/+pFEUcFJ08xsko2KqzUtoUhqTo3YAyEfk2NmodApEXPBralpQoSngyzFxgsLjlkU/JDD2TG/P+qEOBDjZqlXSDVmCNKQ8DIKnaufAw/M+VA1ImqrUon4zNRoY2UaYwYTW9Y8zmt9HOmJCBHfhuKu3ptA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532239; c=relaxed/simple;
	bh=4v6lBmjJQqr03KdyVfpM60Buo3/oOePz0EGLl9l130Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KNcPQ/oXtvon8sllzzonSjc9ElltprgXQv9+fEDVRjks1SwD+bkX+3E9FNhrZRLCYRwwTlTRF4A5Oo7FzwcbP7tDy54l8I1iAYAaiU7AE5oxsZaIxZ84nyc0012d6MZ+PGAemN2AVpD2bNue/ggWjcJmdnNdfzhhJRAEWXNh9rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDysd5v9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1DD2BC32789;
	Thu, 27 Jun 2024 23:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719532239;
	bh=4v6lBmjJQqr03KdyVfpM60Buo3/oOePz0EGLl9l130Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UDysd5v9kh7poEJ2RL4Nd2n8PDtlx8lwR6Fpg7MM9bDD2CCJsRm5SomeZJZeO5Wk9
	 6YHTspPFMbu12SVDew1e+EO8f7dg7xVsn6k13DxxC51utxS7w+JDmX1BoA70MJP+bd
	 htY1Nygo3aAK5a2ZBua0PGX6k4TSSA6gvannNrEMMIzmujGZdZ/mB8apqfyNP7LAFj
	 NLtvZXArXz6MiCCra7Bnzj/00ZZkiAKSsTBp3YTOOSBl8EuOhcO3OeEU6xtji1Y3kY
	 4yZtHguS2iDe2b+A6AIt7e3HBsEMnG8z1Z6wnBl5jXaxfLm3dnoS8TGMoy3pcSgf7t
	 8WazwhWYCi36A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0F90EC43335;
	Thu, 27 Jun 2024 23:50:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] Revert "net: micro-optimize skb_datagram_iter"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171953223906.22793.16596697996029784967.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 23:50:39 +0000
References: <20240626070153.759257-1-sagi@grimberg.me>
In-Reply-To: <20240626070153.759257-1-sagi@grimberg.me>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Jun 2024 10:01:53 +0300 you wrote:
> This reverts commit 934c29999b57b835d65442da6f741d5e27f3b584.
> This triggered a usercopy BUG() in systems with HIGHMEM, reported
> by the test robot in:
>  https://lore.kernel.org/oe-lkp/202406161539.b5ff7b20-oliver.sang@intel.com
> 
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] Revert "net: micro-optimize skb_datagram_iter"
    https://git.kernel.org/netdev/net-next/c/2d5f6801db8e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



