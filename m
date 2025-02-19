Return-Path: <netdev+bounces-167583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45FA3AF73
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08C1C7A6097
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05841922F8;
	Wed, 19 Feb 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Il+Dr8Nd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AF4191F72;
	Wed, 19 Feb 2025 02:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931613; cv=none; b=RDImCNN7epK44SEjrUSohaKdmcIM5IXqwH+nail2SP1q0HeVox7gALxcfW3HYyhCErm1N1m4+5x/g6IDT2nasiYin+zjmvQHQGmp//JYRZhRBv5D4KbGAx7vV29/Qk6aSvJsSXE9ciANnvUnVPr3h3NPvfRst/FnMn7M4h4lvIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931613; c=relaxed/simple;
	bh=0CyhWYhXDBlIB6Qh2fGk05QwoUJ2RZHUJnVpXYQBqwA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l1yLhq/kzB4fpu1EjXT7xNj+sKqHOwYjOznoiQNGng1vSJ49sQGweHD+PPC1maI6RaV2cHLmf/kF6PLT8YV0aKNN5/Rr7t57YgiWJ6zD3M9f9m/Tft1y5KGggCAS0r2YRZy4GiHAI2mCX6WEFrbGhSkjLx2Ug4OMWMBT4iFQ99w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Il+Dr8Nd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54185C4CEE6;
	Wed, 19 Feb 2025 02:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931613;
	bh=0CyhWYhXDBlIB6Qh2fGk05QwoUJ2RZHUJnVpXYQBqwA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Il+Dr8NdQfuUvY05MSV16sGLzKBHYhg5eedR3VJUC86DKgwUa6I/u/M5UDnlyjy96
	 NVs47Xuw1omZ38o7OqU5rciKOcxMbl9LU2lWrvaXrCkVJz4SwOvvz5ZdAQJYkKz/NU
	 qX8bBCER6rY9i7cry7egoRFiV2OgVwqk4aENNLiMahdD70JMKw1bLrXi9H6g+YqzPj
	 PlaxE75+x17PTDSK34ObHjjM4DbvwXlkBIU8xyaFzaPMsLhm71DwbgjpKrdpQn4Kio
	 58bGbXAWjL5Aob34zatKTdMnPwWE/u33ruZqjS5FncXv5YIZe4HxDMdygRWSilMcod
	 +6TzwcGpM3DnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBC380AAE9;
	Wed, 19 Feb 2025 02:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] net: freescale: ucc_geth: make ugeth_mac_ops be static
 const
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993164374.106119.1367597441437405463.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:20:43 +0000
References: <tencent_30122FBA93E93911578208176E68AA00C807@qq.com>
In-Reply-To: <tencent_30122FBA93E93911578208176E68AA00C807@qq.com>
To: None <xiaopeitux@foxmail.com>
Cc: andrew+netdev@lunn.ch, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, xiaopei01@kylinos.cn, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 09:29:30 +0800 you wrote:
> From: Pei Xiao <xiaopei01@kylinos.cn>
> 
> sparse warning:
>     sparse: symbol 'ugeth_mac_ops' was not declared. Should it be
> static.
> 
> Add static to fix sparse warnings and add const. phylink_create() will
> accept a const struct.
> 
> [...]

Here is the summary with links:
  - [V2] net: freescale: ucc_geth: make ugeth_mac_ops be static const
    https://git.kernel.org/netdev/net-next/c/9faaaef27c5d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



