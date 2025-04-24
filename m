Return-Path: <netdev+bounces-185359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 860C1A99E84
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 03:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F10FC444A32
	for <lists+netdev@lfdr.de>; Thu, 24 Apr 2025 01:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9400A1DDC2C;
	Thu, 24 Apr 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tVo/a5qa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BF681DDA14;
	Thu, 24 Apr 2025 01:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745459412; cv=none; b=JgPuXn7g/5UMQrE2JdfoeTmUY3rfAGUa1VogDT+xZEN42kty1PjbcdOp8CXZhyuGO0VZLvc4x1jz7kuq6xsAVnB3xD+6HRvXJucb4aN/9ypJujgL3nyNwuUB4TIbICvJIR7KK62OUGA4TBmaCbTP8Nal3+RSvcRvwlCHupviuyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745459412; c=relaxed/simple;
	bh=SGnBAo1AC0EKZj7K2iz2ohBGdPq4rA3kL/ltg9HTzmU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Rh8jnHSyNgMLS3blODnukXmfOrvDgMHNGp1v8ckfIje9NwlQrNGX7B7gxTVzRc32jH3a3ZFmIW9NgqWnsZyd0hzjqcVIn8G8+HXnUAooM415/a3TLWWqKYxwk1m3+zNFx9dN/rZV2b8qNGs1zkV92LF6Ws5tt/Ppjf9o80QrwiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tVo/a5qa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6AAC4CEEA;
	Thu, 24 Apr 2025 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745459411;
	bh=SGnBAo1AC0EKZj7K2iz2ohBGdPq4rA3kL/ltg9HTzmU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tVo/a5qaxy/WYiEouDfeQi5Ei9A94G9cj8hGb39zey8rEjqNpIVRBgkFrPpg+HYW1
	 hjeyECy3/zW9ORZtXWVcyQ4MxiP1hAWetnJiUYE45P39j/58HWznhNgQ8nKPjegtQs
	 tmF1nXQ6VngIo6qH36PHHmfLVhUYVONcf3m4srA2czs74Lnij8EPJEUWh2Dv+5L/kB
	 gK3se7usNYVxd6AnUozjD9RoVVkkDQw4A/+tih1lyDLCVql/9xdwqFvCU0zl7fx08j
	 kZRBBytQmTiTG69pny5dowuXwWvUcu//uHmxBmGmmYX5SqP4nPDhz7LgwxibwCtYon
	 vUeSHBOnXZwiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5A380CED9;
	Thu, 24 Apr 2025 01:50:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: AF_XDP: code clean up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174545945025.2829412.5574764696344129535.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 01:50:50 +0000
References: <20250420032350.4047706-1-hkelam@marvell.com>
In-Reply-To: <20250420032350.4047706-1-hkelam@marvell.com>
To: Hariprasad Kelam <hkelam@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
 bbhushan2@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Apr 2025 08:53:50 +0530 you wrote:
> The current API, otx2_xdp_sq_append_pkt, verifies the number of available
> descriptors before sending packets to the hardware.
> 
> However, for AF_XDP, this check is unnecessary because the batch value
> is already determined based on the free descriptors.
> 
> This patch introduces a new API, "otx2_xsk_sq_append_pkt" to address this.
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: AF_XDP: code clean up
    https://git.kernel.org/netdev/net-next/c/b5cdb9b3113e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



