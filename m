Return-Path: <netdev+bounces-156124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCDCA05088
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 03:20:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C70E7A02C8
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B71156C71;
	Wed,  8 Jan 2025 02:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="it49xM0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4123E16DC3C
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 02:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736302818; cv=none; b=FyiMZ96L2tYOp4PXenvNxB9zbXOz5F1umKqXarwxIMsgh0HAxC4gtRSlbiobaoK04pivlRa8hWwsBQRlz+77jl4c01qI1Um0LhSqEJdxskaDnGPD4CjQswfDlzpfnqGl4rMiuDImGafZ+sQWdU8wvb9RNrD4vBL1q/ImfbVKWWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736302818; c=relaxed/simple;
	bh=RzlV2rKKmvTn5FTC/fVSi/qLpt7sHztCur9FtE9GYJU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fRmj9Ql8rhptHI75VSsssaaqUtsQQ59qv5V4FP47M/UM99imanN2/ly182a8ZpRVrTDXYNZip7eUMYVb8iINTf8DZGQ6Pe+jd4lpscGqlo07VKeyYGYCn/tYDd6AxwiHgVlFRcvcXif1uUYEAfPR9UJEia5BiTtdAW4bYPQvGdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=it49xM0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C802BC4CEE1;
	Wed,  8 Jan 2025 02:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736302817;
	bh=RzlV2rKKmvTn5FTC/fVSi/qLpt7sHztCur9FtE9GYJU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=it49xM0BJSeL8KeQSw/GxYn5PaNKBPQhFPmjPnTU7bgGjbK+zWogZtDmVBDLDUBLZ
	 nBp8Zw7FDe9Mg1xEiim8aOs02dePkoiXuAqYoe9x0OB/JiWFM6FSIcGilWTe/C14ii
	 NWPBL8qIjUepkC1O+EKP5uXU2M+zPdE2fHneQCfioIsP0dFl3QUDOUQuLahIxe3ghx
	 rE+1vRJrsLf7jsKKxpoX5APSZM+TzU0NE15AJHASX9MuTLowjkX0HzXk3+6XdeMcUx
	 BNBIUhhnwddnIHXCUWxB051uNd5cGvNDz6Jbw83O4LOn8jbBPSQHLFF/Ou261oYxmt
	 hfnqjW+5gmUxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D10380A97E;
	Wed,  8 Jan 2025 02:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] if_vlan: fix kdoc warnings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173630283900.168808.4568881845307634743.git-patchwork-notify@kernel.org>
Date: Wed, 08 Jan 2025 02:20:39 +0000
References: <20250106174620.1855269-1-kuba@kernel.org>
In-Reply-To: <20250106174620.1855269-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  6 Jan 2025 09:46:20 -0800 you wrote:
> While merging net to net-next I noticed that the kdoc above
> __vlan_get_protocol_offset() has the wrong function name.
> Fix that and all the other kdoc warnings in this file.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>  include/linux/if_vlan.h | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net-next] if_vlan: fix kdoc warnings
    https://git.kernel.org/netdev/net-next/c/d8c2e5f33ace

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



