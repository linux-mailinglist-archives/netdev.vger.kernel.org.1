Return-Path: <netdev+bounces-104711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B07BA90E154
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 03:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5ABA51F231DD
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643111097B;
	Wed, 19 Jun 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgu76WH+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8E8F9F5
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718760632; cv=none; b=MTfKYS8Toy859Bj0fGyzbhsBBijNb5oVyeFyuZrmAPRxLyZu6WERKOJPyaW6uFBV6nWBH6QaSU9NrcOTJT15OiFgNTJkMFORgNzzXooNAzs8dw16QPWTrlphQO4Ue0mYJXM0zDFTXoMaVoOlZRWZuhafL/TpsH7JByCQKQ1raEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718760632; c=relaxed/simple;
	bh=VGaZvwnGIS6ReIZSwoQANhAsPWh2FXZAEvKLYptMFDM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1p1qF2KXoz6opz+lr4sVSH6f3/rRkoZ2I3vKNSrydovrQM+E+KqqR89ak/+51dCspOwiZ3Ueg7Nu2FQifhjQe8+vggkTZ/2gTOdv/Huqy1Mc9UkwYwXJlwiBF/CjB0b60mU8k1xCMOJg+Pi6MwCJDjPOqzgZl7B1zx7NZoCYfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgu76WH+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A7338C4AF1C;
	Wed, 19 Jun 2024 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718760630;
	bh=VGaZvwnGIS6ReIZSwoQANhAsPWh2FXZAEvKLYptMFDM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kgu76WH+d5mWTVg065ZqEWRwdqvxcc23ewtbYyKgmqrC+BM0a67MLlhsgRqMlMRVl
	 JZT6J6Wuv1CYQf6Z7Fez1CRKbcoEy+fL6SqWwMHmRCeVFhqAURjToRBWHQq/Ou59/z
	 wXEYlQZvxiNVDBxoBk+WvASL7G1fp7aEUDqGSDc1zMJvwsvRDwRyTm3xheZYGEKYHO
	 sMt0gLfSzj193YaQDimjNK2Du4PPb6v8Yd9dImMPaUXdAlF7BMGPoioS+f/tjrJuak
	 K9Y0YQQjedM2ljapCptSye+NrT15VCK7WVQGOWKZ/ud3XeD/y78bVXWVIHo3od9lJg
	 q6tD6b9oX52hA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8ACB0C4361C;
	Wed, 19 Jun 2024 01:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] net/mlx4_en: Use ethtool_puts/sprintf
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171876063056.16543.3395527709194506163.git-patchwork-notify@kernel.org>
Date: Wed, 19 Jun 2024 01:30:30 +0000
References: <20240617172329.239819-1-kheib@redhat.com>
In-Reply-To: <20240617172329.239819-1-kheib@redhat.com>
To: Kamal Heib <kheib@redhat.com>
Cc: netdev@vger.kernel.org, tariqt@nvidia.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Jun 2024 13:23:26 -0400 you wrote:
> This patchset updates the mlx4_en driver to use the ethtool_puts and
> ethtool_sprintf helper functions.
> 
> Changes from v1:
> - Remove unused variable.
> 
> Signed-off-by: Kamal Heib <kheib@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] net/mlx4_en: Use ethtool_puts to fill priv flags strings
    https://git.kernel.org/netdev/net-next/c/e52e010395dc
  - [net-next,v2,2/3] net/mlx4_en: Use ethtool_puts to fill selftest strings
    https://git.kernel.org/netdev/net-next/c/4454929c345d
  - [net-next,v2,3/3] net/mlx4_en: Use ethtool_puts/sprintf to fill stats strings
    https://git.kernel.org/netdev/net-next/c/6c7dd432dcbc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



