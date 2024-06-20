Return-Path: <netdev+bounces-105099-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 178C190FA66
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 02:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EBFB1C213D7
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 00:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48716FB9;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5Z5FezS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5464C9B;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718844028; cv=none; b=ftVqunsrsEKMsjxrjtkAaVs1jiUQ8zQjTmur5l1gpkublvZnmDA0qO3A9uvt/F9DTG2ExASvDG3mNP2HpAN7KZFVEy9Z/SaeQnpvCLwRRrTFCEw4/6S7w9faJAa9N94VNL/6w+zI+IHhVdNPYG9uLF1Pn/bnzYqBt3Jt1E26gQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718844028; c=relaxed/simple;
	bh=CzLboDBZKDjvYors6xyq/z7Jk/vz+3Gph2Jp5+WVIXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lHmFm5TEVDHyHEfvweh/K8/js/24Rg5HcGZtfknLBjBxw5E137h3yj5l7s5pUonW2yhCNXewtBeN+qLxzUV7nDB/dqIi8UlyX5hz+y9Rm9mUTNNmN5yQ/ftn4HNcsEBXEB7GNR1C5xUCqgAnbaa2geuJufi0OycqAoicG66+Ch4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5Z5FezS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14F26C4AF0B;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718844028;
	bh=CzLboDBZKDjvYors6xyq/z7Jk/vz+3Gph2Jp5+WVIXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=P5Z5FezSGtVjXJqwzXRSA6IB5m7TwI4KXbtf7xXRhm/wUXCKyi9ljqWXxZgWRC7bx
	 dvvHO1VLyO8YWxrKPGBY0xD/UaaLYhbk7Qd+4K0qkvTfanQwRcce1Lc7KJS3bVejYo
	 6YlH4q+Rynlh5diOCjKS12E9BG86glHQhua1fXsDJPtIZJZZKxA+JIe7w7wf4lXvJv
	 4iK3T5yMvBpU/r3tdzvMhCXSmfcWFRhUmw2jnTc+TsoHWxsLr6oeQzngHBFhXFboH6
	 Iyays9tRWueZe8nh/naa7B2fDfzQoc+OnAH/TfnaKb3BVsVds7uEmhrur7y8yBLOdP
	 ZVCbHYjNkgAiw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 04FE8C39563;
	Thu, 20 Jun 2024 00:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] net: hsr: cosmetic: Remove extra white space
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171884402801.27924.15889374790179078400.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 00:40:28 +0000
References: <20240618125817.1111070-1-lukma@denx.de>
In-Reply-To: <20240618125817.1111070-1-lukma@denx.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: kuba@kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 wojciech.drewek@intel.com, edumazet@google.com, olteanv@gmail.com,
 davem@davemloft.net, o.rempel@pengutronix.de, Tristram.Ha@microchip.com,
 bigeasy@linutronix.de, r-gunasekaran@ti.com, horms@kernel.org,
 Arvid.Brodin@xdin.com, dan.carpenter@linaro.org, ricardo@marliere.net,
 casper.casan@gmail.com, linux-kernel@vger.kernel.org, liuhangbin@gmail.com,
 tanggeliang@kylinos.cn, shuah@kernel.org, syoshida@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 18 Jun 2024 14:58:17 +0200 you wrote:
> This change just removes extra (i.e. not needed) white space in
> prp_drop_frame() function.
> 
> No functional changes.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> 
> [...]

Here is the summary with links:
  - [v1,net-next] net: hsr: cosmetic: Remove extra white space
    https://git.kernel.org/netdev/net-next/c/89f5e607772b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



