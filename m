Return-Path: <netdev+bounces-128294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9CF978D61
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33B3E1C21C37
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02DA91862F;
	Sat, 14 Sep 2024 04:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="geQdDzaM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA7118049;
	Sat, 14 Sep 2024 04:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289443; cv=none; b=CuGTKcfM9XyotibKmF8kiHQ7FoMekWx+MeQGVda409h7LnetjNqQPS7IIYsLIKm7bw2ocQV5NJfrOILQWRw4Tt63gTY6khjy/2BIOn/06XniF74R7xqSXTvvywDeFqtas1wgwunSavLlCWByminJ+fkTRIvC4ypZKgAOhqe1jDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289443; c=relaxed/simple;
	bh=oz+KvsKcRk3S89JDkIWaKAKrinRu/dZo7HNOE1GQUWM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fn6SROjRwZpQmso4fLpERTyt0Te4rCL4/GykCzs4c7sF12PIpTbbRF/+ZyzkyjZ3lfRrJVGfUfQrDgoNe05dZfe6y7GRPGnkNxS+/4y4A+hU3fv4QOEXlOF29HswqHyJGQmTaybRKthhKfYB+CskR2wIDF0i4NGBo+ZdbLKdlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=geQdDzaM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FCEC4CEC0;
	Sat, 14 Sep 2024 04:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726289443;
	bh=oz+KvsKcRk3S89JDkIWaKAKrinRu/dZo7HNOE1GQUWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=geQdDzaMA98mXkn1WWJV1J0aiA3bQi+SOpnpKdQLU7xsyejjxYrsWAxtALo/6+Gd7
	 p0MlXVoQKeMTjFOPuDbCXfO+uOPow7rN8MgIer8fMD6hJamwsp82Rzj1ve3qJEsz90
	 vIUGRVM4V311v/kx6mbHxC4XsJkzvZ4nyRtSRzej7ppIQw2ERZ7xn74eoY9fnE7qth
	 Hulp+3Ea2M6ZpS+tnyvjOwijjH9nP+MdQJY+3rDIItILT6Dlo9su6AZ8DXfwZhut9G
	 aMSucsGlbX+qq89rOQCIL6EbrEKjfHHhwCQ/ZuzhaIWeWkbD6640PnQJJHltWXOY3K
	 UIH8lqv4mHdMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB96A3806655;
	Sat, 14 Sep 2024 04:50:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/2] octeontx2: Few debugfs enhancements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172628944462.2462238.18202578173097839932.git-patchwork-notify@kernel.org>
Date: Sat, 14 Sep 2024 04:50:44 +0000
References: <20240912161450.164402-1-lcherian@marvell.com>
In-Reply-To: <20240912161450.164402-1-lcherian@marvell.com>
To: Linu Cherian <lcherian@marvell.com>
Cc: davem@davemloft.net, sgoutham@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, gakula@marvell.com, hkelam@marvell.com,
 sbhatta@marvell.com, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Sep 2024 21:44:48 +0530 you wrote:
> Changelog from v1:
> Removed wrong mutex_unlock invocations.
> 
> Patch 1 adds a devlink param to enable/disable counters for default
> rules. Once enabled, counters can be read from the debugfs files
> 
> Patch 2 adds channel info to the existing device - RPM map debugfs files
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/2] octeontx2-af: Knobs for NPC default rule counters
    (no matching commit)
  - [v2,net-next,2/2] octeontx2-af: debugfs: Add Channel info to RPM map
    https://git.kernel.org/netdev/net-next/c/beb2baa9e54d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



