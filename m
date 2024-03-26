Return-Path: <netdev+bounces-82213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D76088CA99
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 18:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C3521C658E8
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 17:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3D841CAB3;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QSIGRrZY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A000A1C6BB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473631; cv=none; b=awq8azq6MsKH5e41V8pgFEqt+7OddHPhZhXnjcncInP4U7OyELdWuBiBXomIpBv6b30ooXKMEuNqQOGbgVz8GbLU6wZ6oRizaxFgLZtmtyQ4ImdxDsEaYLJ5d/o9JjAK2cXN2voejTv71wrGjKIeJrQeUU09u0f5gjPZxO2sAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473631; c=relaxed/simple;
	bh=/rHwIm1deK3wilJYf4JGMKVmiAfgUh423UZkZsb00/w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WTPNzoy1Y/2LgJGVm0gft/d3xlkEWhTU46kO1peWpOPiO6M3clxGIDwjXeughSZNq0/lPYMUn04/ycox9paCBco9K7wG92IySAu4WQzN5MCR5PxQq+O5FgPiHiwuK8WpvUhFRq3USbDSp4AiZfuaqEwHQG3ETpzLdrbBdQVMfa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QSIGRrZY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 40C80C43394;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473631;
	bh=/rHwIm1deK3wilJYf4JGMKVmiAfgUh423UZkZsb00/w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QSIGRrZYgW/lo2/XAg9TCDhAIjvuf8Tkr0CqAuz2Xbvcy+FyxBZ7vap3Gi7OdPYvL
	 o/lrBlvJpRjgW942xeKsoa2TEe8lNZ/fWPHd4ekBTQemMJQklquSANvYs2N2RXWm6W
	 FggiNVqFf7WoUsERKxsuC/MVJeNLQ1E144EGJ/ZvGoOgaOfXKrVIG2A0sBMl22TyCy
	 I08B7Cyei/f13aHoo+rOJn8Y0C4eDAhY19UHkSn+4SKMNUMe3dDyYCa7eaOMbHB+xi
	 rNsS7Le0JBmgsABMroncbJ7WbjA6qRkM9l29ZscevQgIZUnFFeVzgKLt80FObmmv9K
	 LLTseblJawqdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 316ABD8BCE8;
	Tue, 26 Mar 2024 17:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next v3 1/2] bridge: vlan: fix compressvlans usage
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171147363119.25319.2119573742630649233.git-patchwork-notify@kernel.org>
Date: Tue, 26 Mar 2024 17:20:31 +0000
References: <MAZP287MB05035FBFC9A954A55A67790BE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
In-Reply-To: <MAZP287MB05035FBFC9A954A55A67790BE4362@MAZP287MB0503.INDP287.PROD.OUTLOOK.COM>
To: Date Huang <tjjh89017@hotmail.com>
Cc: roopa@nvidia.com, razor@blackwall.org, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org

Hello:

This series was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Mon, 25 Mar 2024 13:49:15 +0800 you wrote:
> Fix the incorrect short opt for compressvlans and color
> in usage
> 
> Signed-off-by: Date Huang <tjjh89017@hotmail.com>
> ---
>  bridge/bridge.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [iproute2-next,v3,1/2] bridge: vlan: fix compressvlans usage
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=43b53968634e
  - [iproute2-next,v3,2/2] bridge: vlan: add compressvlans manpage
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



