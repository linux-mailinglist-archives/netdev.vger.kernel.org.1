Return-Path: <netdev+bounces-190366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC73AB67D0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:42:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E98411886A19
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0BA22CBC8;
	Wed, 14 May 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gKhzFVou"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A6022AE7E;
	Wed, 14 May 2025 09:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747215592; cv=none; b=rKwvbVh3yUvxJ6x7ajYI7HyjdPwPmjuNs1XFF0QYIDsm6BJiGgKDqRx1apubfyva9tvTITfxHjflDpn+HDYRCWd8AvAke/y+psi+DQ6RkgkHHQftIjvsXdMwhVaJ7Bc9kpmx6FF02YzO2eJU7eNKw6eom2SlvSHgN0dTVapfXqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747215592; c=relaxed/simple;
	bh=BSOwJfwsX08rYLjqiSUj5Hg+z6kDiXxAstBbioDpE64=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=go/+9yQJ42oe9UlCNsnTKTt+sqLITSnegcN/lLxLZJya7ylHvikrD7X+XMI2pJrJOwTQtQn4TtiBdZL2clyMeLoNDbjwFOKiLhIozgxtqNxDXOy6a1FLtMnp/eI7H+0PQbBXlOn9Md5ADcvQc143ErnyBOdPsj1H3W7i1ntzg1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gKhzFVou; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27DE3C4CEE9;
	Wed, 14 May 2025 09:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747215592;
	bh=BSOwJfwsX08rYLjqiSUj5Hg+z6kDiXxAstBbioDpE64=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gKhzFVou+qT5/KtwpMtWK15IdFrAlRlZhMMpgnuELyWoqhQnHLnujcZ31SVHfoFFs
	 6+TX//soWHW+7QtmLPG0hL7jeLMtBGlh53QK8XZtkp0lHzkNay728w/27l0nS+R2Pc
	 og34rAIU+RIf/QuA8ZeBWq2KtdIKc1j0tVWe7gqmM4gowARlcFlL0l9vuHTJRtxTfp
	 2NBKexb99ecu7NANYGsZ40Srt2ypzDeMV+TjskX4gMbosln9bxREUUwitfYCSupLhq
	 onz9HoagOzoxwKzCT1YQezxpxMSujPXtHP+FGRHQCXvDins6gkzscl6nUVFKsQ9lDj
	 gYsi8qfi4jqdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBAB380AA66;
	Wed, 14 May 2025 09:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net] octeontx2-pf: Fix ethtool support for SDP representors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174721562951.1958614.15827171535057931019.git-patchwork-notify@kernel.org>
Date: Wed, 14 May 2025 09:40:29 +0000
References: <20250512062901.629584-1-hkelam@marvell.com>
In-Reply-To: <20250512062901.629584-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 12 May 2025 11:59:01 +0530 you wrote:
> The hardware supports multiple MAC types, including RPM, SDP, and LBK.
> However, features such as link settings and pause frames are only available
> on RPM MAC, and not supported on SDP or LBK.
> 
> This patch updates the ethtool operations logic accordingly to reflect
> this behavior.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-pf: Fix ethtool support for SDP representors
    https://git.kernel.org/netdev/net/c/314007549d89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



