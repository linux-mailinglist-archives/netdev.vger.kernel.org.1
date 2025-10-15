Return-Path: <netdev+bounces-229438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EABBDC279
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 04:30:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 823053522A2
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 02:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646261E2834;
	Wed, 15 Oct 2025 02:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sw7US6ts"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A34B15A8;
	Wed, 15 Oct 2025 02:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760495421; cv=none; b=I10PPICzVRYHucjkNSeYYnd6f2qxYTQwpHrfJbDMJg0aqB1170Fnv2EGITuy+dg1e9J+tU48FOBNTEQ2oiHnfU4u0+sEtJaYBMNn7vl5xJbzE69ngLYl/1lCZCdTg1BeqUTomH50mdfFzzN45Upjv9XIGa96OiDh7YZeCO7YptM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760495421; c=relaxed/simple;
	bh=8tgZX8AkBIQf/0n77LhON7hpmoBHJ6eXEd2HBa0TB6c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DKxk0HkcVIkAnjqn2mdxJb8YvP/vyreVQVOgOWzdvLbumIQCBIuPeKvrZXBfOLxaYtEqc1ee5tLm7AlqzlVhvqeCx7g8I4kSkGxEGmZwQ8AlV/myNSkNN6obGXNt74KgqF6pUyJru7pdi5sk4G0r/STmuTqTH8xfLIBvbHYcTzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sw7US6ts; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB8AC4CEE7;
	Wed, 15 Oct 2025 02:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760495420;
	bh=8tgZX8AkBIQf/0n77LhON7hpmoBHJ6eXEd2HBa0TB6c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sw7US6tsJHQy2JGomvrNP1bOJEqfG5NYHWBJSaxCZbPNY+a2CnesIfLEvZ86dCY3i
	 8Org+0DspUe4YkawIKGU/RKCVwzfhajrs5HVUitLljc/i2j6HrfXTOpMBNYwm4qILV
	 MkI4JsOXJddeVDbX3m+lSjFEr9w/RQgmiQl4OJ689Px4WELNUW+cSnyyxwBvU0RMRS
	 PdDpi88UTflEUxM7rQ9j+MMDf4b8rtXIu9eDwUiB7066LuGH3IjdHIOY7QBkHd3Zb5
	 YiAY3aKLLzzbOV8V1OrQGa5UJyfGTjp4rlzvCkS3T/CDM2KgAW3H10b0Doft8cc8A7
	 KGh9BDEFm9vEQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB4DD380CEDD;
	Wed, 15 Oct 2025 02:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] eth: fealnx: fix typo in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176049540576.191548.10075388837298884434.git-patchwork-notify@kernel.org>
Date: Wed, 15 Oct 2025 02:30:05 +0000
References: <20251013183632.1226627-1-benato.denis96@gmail.com>
In-Reply-To: <20251013183632.1226627-1-benato.denis96@gmail.com>
To: Denis Benato <benato.denis96@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, mingo@kernel.org,
 tglx@linutronix.de, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 13 Oct 2025 20:36:32 +0200 you wrote:
> There are a few typos in comments:
>  - replace "avilable" with "available"
>  - replace "mutlicast" with "multicast"
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> ---
> v2:
>   - also fix "mutlicast"
>   - tag for net-next
> 
> [...]

Here is the summary with links:
  - [net-next,v2] eth: fealnx: fix typo in comments
    https://git.kernel.org/netdev/net-next/c/c3527eeb65cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



