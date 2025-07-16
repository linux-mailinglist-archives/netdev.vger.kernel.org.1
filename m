Return-Path: <netdev+bounces-207613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E2FB0803B
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:09:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9E863BBA07
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF2E2EE5F5;
	Wed, 16 Jul 2025 22:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddaxRduz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5D7EACE
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 22:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752703790; cv=none; b=K2tYmKE43tt/5lxCI8YmmYtItWtsjfPjqWJKd+9Y1p3+15h6pqQNQnyIZvfNpokJYG9znqncqul/KGkGSISH3X4g/+AqHHS4n1ZfYwLvNnNK4ur1B96mDWigRjLQ0PY8vSV3uHbIyVPdi7XDDbxUP1PeeZ5YqzHJuoL0MbDD5t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752703790; c=relaxed/simple;
	bh=rlUz/kaxak3J1pPfpYV3L3s2Lurbn0F7E0kj3+py0cY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kcD7oBgAJxIGvErU0zQjEBMgaHd/gHzHcyWjJ4n0OuddyqEYJzjZf5uy+evBSuv+ZeuED/H+7/63/pM/2PZW/ZpErp5UIZrdNfInzvKRF4TAvPMLMbdED8iUjjsDpfDXSSlLzZ0RiNmlWgnUJoBQktCsuHMT+V2Ux165ztN3fn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddaxRduz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B596AC4CEE7;
	Wed, 16 Jul 2025 22:09:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752703789;
	bh=rlUz/kaxak3J1pPfpYV3L3s2Lurbn0F7E0kj3+py0cY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ddaxRduzI8DPGaq5XrooYnm5iezQiUNhZqJPrafAQMXsGMd0Wp+UQ3p0IGiVO3/Ds
	 88VPd7V7Fc4l7pLqot8BXlW4ci4VTxeljTWfJOJcxEXhPH0fHIS0Cngdrz+yWrBi8Q
	 jW7w++z/7PI8CKIJqI6IgV5NACpcnua62fJ0C2uznTjHIGdmycRvHOAB53zNWztnMK
	 KXhLO990QWrGr37O1O7D4W5YPSjSeA5Ay0xcfct7dTxuBVysoHfzoCv3otlN4VIgnX
	 DIwHfcK0qyrSd3t+aAOkMWpKo+HE+wphRMbFoiycfVvYKbll5lxSxqwu8YQewkyLQP
	 hLFVzUr9DoIYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33EDD383BA38;
	Wed, 16 Jul 2025 22:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] ethtool: Don't check for RXFH fields conflict
 when no input_xfrm is requested
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175270381000.1341865.15234146068113913299.git-patchwork-notify@kernel.org>
Date: Wed, 16 Jul 2025 22:10:10 +0000
References: <20250715140754.489677-1-gal@nvidia.com>
In-Reply-To: <20250715140754.489677-1-gal@nvidia.com>
To: Gal Pressman <gal@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 andrew@lunn.ch, horms@kernel.org, dtatulea@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 17:07:54 +0300 you wrote:
> The requirement of ->get_rxfh_fields() in ethtool_set_rxfh() is there to
> verify that we have no conflict of input_xfrm with the RSS fields
> options, there is no point in doing it if input_xfrm is not
> supported/requested.
> 
> This is under the assumption that a driver that supports input_xfrm will
> also support ->get_rxfh_fields(), so add a WARN_ON() to
> ethtool_check_ops() to verify it, and remove the op NULL check.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] ethtool: Don't check for RXFH fields conflict when no input_xfrm is requested
    https://git.kernel.org/netdev/net-next/c/410b0ace8891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



