Return-Path: <netdev+bounces-161078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 616C9A1D35F
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B806164D8D
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F181FDA9B;
	Mon, 27 Jan 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKpiRAgI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F961FDA7E;
	Mon, 27 Jan 2025 09:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737970207; cv=none; b=T1hhxWHiNF22xVmSgfHN0u0OHRoIa23OU1pCSPYPabCTgcdW5eLLEnB0/Q9ARonZ9AEUeLc38KcI9rnfoluHiNiQ4hMq6H82RwkML4qBvmP/tghdnc1Z5lOwAyw/jeFTPrkaOXHuPFM5938iEq6MQKrGuJeWpSO0PECWVUZ/ScQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737970207; c=relaxed/simple;
	bh=W4mxrPjJjnxZSSmQEbEPXvDXQbxv3P0KB7MZONpwbkI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q6+6IXXsVQMjdZjm6PkqbJVhFtlr2IST1jWp3FBSxnMCKrh7OeuCJ3aNgZ9tD67XFFLPsnlgdzF8Dgyv3d1sqPAL7Zopk0vAbcZiR432r9XLJ60SozXlyX/5GG0oTBOlrAeNSfEYUc9/4FJbev2sg39RY3Ab0QURmMDLkWujSFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKpiRAgI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C8CAC4CED2;
	Mon, 27 Jan 2025 09:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737970207;
	bh=W4mxrPjJjnxZSSmQEbEPXvDXQbxv3P0KB7MZONpwbkI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eKpiRAgIj6UmazCyV/2TITg/ChM0lPxW9KLNbCTRwISbDrckogWvUjYlktNsTu73U
	 Vw5dLJRJxxym/FcdFZUZbqw3YRDd6NDmXKVTlh8pD/mEBdQrJNjVnd4aymKE4kZib+
	 HCxqB0YkjOL0r6FD0Tv3VCnMjAh+qiAAsZ4qZz0zjvgylnzZoWuJ1zTgoPOUYjg2vL
	 NXs0NtmtNutbeqh1UUOk6AlelDrCi7TIcOCBoKdlnxYikYVazMghpCG2Fmlsojb1AU
	 wuOpaD61GlI02JGHEQlnz/mXIn3hwNhBWZc/EyIsc26yBk+Pmsi2Pjm2cKKYPhy+A1
	 qXWsVx/t1jU2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB7F1380AA7C;
	Mon, 27 Jan 2025 09:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/ncsi: use dev_set_mac_address() for Get MC MAC Address
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173797023277.3033895.7914269313592549651.git-patchwork-notify@kernel.org>
Date: Mon, 27 Jan 2025 09:30:32 +0000
References: <20250120133536.29184-1-fercerpav@gmail.com>
In-Reply-To: <20250120133536.29184-1-fercerpav@gmail.com>
To: Paul Fertser <fercerpav@gmail.com>
Cc: peter@pjd.dev, sam@mendozajonas.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, fr0st61te@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 20 Jan 2025 16:35:36 +0300 you wrote:
> Copy of the rationale from 790071347a0a1a89e618eedcd51c687ea783aeb3:
> 
> Change ndo_set_mac_address to dev_set_mac_address because
> dev_set_mac_address provides a way to notify network layer about MAC
> change. In other case, services may not aware about MAC change and keep
> using old one which set from network adapter driver.
> 
> [...]

Here is the summary with links:
  - net/ncsi: use dev_set_mac_address() for Get MC MAC Address handling
    https://git.kernel.org/netdev/net/c/05d91cdb1f91

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



