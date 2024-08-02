Return-Path: <netdev+bounces-115182-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5BC89455F6
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E0421C22E14
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B5A125D5;
	Fri,  2 Aug 2024 01:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/O2DXVd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AC7B67E;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562232; cv=none; b=AqXJjQFPnYZbLXqf4SN3HKoLIpKL8OovjnY4IDHH0o4SNtmuMeMFdiPv2Vp3lAztEGZCFcja4HzNdgZOwAbm0hZk6iM+qAP2l03ED5RuD9zP9Yb8R5kKeTB2cw5wejw0Mol+yLIkTr+13SA9iBJkYl4J1N7bH1IABQ2VGj5CmLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562232; c=relaxed/simple;
	bh=xkrYb/74Qs5cMpdVVt0r26rgrh1odkjHOIgVtqsMk+c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fr0WWnqb5uSEonZf02c/sQo9/+Y9a1AK67r3zYFhnWu12ilDVr2e4mTB2mmktw/lzGVS95nxmVdhPxuYVhswIYgoZkU7DxiAQoWYY4uLHDmKAMfJQ5wyRX9/AzFWHOZqNA1aWUSzYQbhkwKlpF2bRS7AAJtxh0Cz7VihbfZ/ROE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/O2DXVd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69E2CC4AF0F;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722562231;
	bh=xkrYb/74Qs5cMpdVVt0r26rgrh1odkjHOIgVtqsMk+c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G/O2DXVd8NJDeMIRG5hQD48uqHN5rgEGg4hCPyMV79iBUg+Q1UkHc+iTbp6oxwpVJ
	 jwTIYaK7C2u8Aj+nzJCIrgZik0hiBWaSW15MzGTr3oHKXzr1Zm5StY/On+YfI/s/G6
	 1tTT7WWYq6x0TVSn+ovF5P6EGMTmkzpwt1tXJ9uYHH/7vX+3LviS4E6Q97/yPzSlu8
	 Rc5QQYvDds1849A0NV/vBuLE36+zkFjm9mWxvWbqLH9IP07+63LKQ8TojwRlSodXgU
	 LqH52sVOBnqM/AfmjAcovd9nXzZtO8VsfMdajNDok+iFND2iM3F+zzv+W6vmamdGiO
	 uOagjOoSIpA9g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 56CC2D0C608;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Use of_property_read_bool()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172256223134.32676.16343976994355296820.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 01:30:31 +0000
References: <20240731191601.1714639-2-robh@kernel.org>
In-Reply-To: <20240731191601.1714639-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: madalin.bucur@nxp.com, sean.anderson@seco.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
 rogerq@kernel.org, radhey.shyam.pandey@amd.com, michal.simek@amd.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 13:16:00 -0600 you wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_find_property(). This is part of a larger effort to remove callers
> of of_find_property() and similar functions. of_find_property() leaks
> the DT struct property and data pointers which is a problem for
> dynamically allocated nodes which may be freed.
> 
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: Use of_property_read_bool()
    https://git.kernel.org/netdev/net-next/c/5fe164fb0e6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



