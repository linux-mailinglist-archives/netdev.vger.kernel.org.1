Return-Path: <netdev+bounces-52193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C523A7FDD9F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3B301C208BB
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAEF3B297;
	Wed, 29 Nov 2023 16:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aAZgpqQY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1043B287
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 16:50:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AD574C433C9;
	Wed, 29 Nov 2023 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701276627;
	bh=OeHKnPh2qc4dMRZtT3RE2Jsr1xVxxUtUP23Jub9LCNE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aAZgpqQYrQHe8wXCr6uOagKyZvpFTG6gxS6AflEzVqRgGmnMg5OIBrlwf9tMSifVf
	 y0pELQM2zdTE43NSu7JcwhMUmfX+RbM1EsJVZjFUEHlubvTT0o+6v0eCHOi+yfQVex
	 3NyInYx8P07zYRXs3VTDQuj3bXG6aJp55N4j0WAT/KnQnNYswZWictQYb2WIahJbLl
	 ga8j4Mr88Sqw1qGA6WPIsoJMaQe6ETeXkQCgcSoQlBEOMU0J09tVQw96sghMrYm1/c
	 dtctzaABHmfw1+Yj+qcqT7+q0KIi/PO6mxEmK4IDjKFGqM3n8gjJtxO5z6yGdYFwyR
	 CWKjiLxuawBqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C97BDFAA89;
	Wed, 29 Nov 2023 16:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ethtool: don't propagate EOPNOTSUPP from dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170127662756.14566.12562296353020168046.git-patchwork-notify@kernel.org>
Date: Wed, 29 Nov 2023 16:50:27 +0000
References: <20231126225806.2143528-1-kuba@kernel.org>
In-Reply-To: <20231126225806.2143528-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, f.fainelli@gmail.com, mkubecek@suse.cz

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 26 Nov 2023 14:58:06 -0800 you wrote:
> The default dump handler needs to clear ret before returning.
> Otherwise if the last interface returns an inconsequential
> error this error will propagate to user space.
> 
> This may confuse user space (ethtool CLI seems to ignore it,
> but YNL doesn't). It will also terminate the dump early
> for mutli-skb dump, because netlink core treats EOPNOTSUPP
> as a real error.
> 
> [...]

Here is the summary with links:
  - [net] ethtool: don't propagate EOPNOTSUPP from dumps
    https://git.kernel.org/netdev/net/c/cbeb989e41f4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



