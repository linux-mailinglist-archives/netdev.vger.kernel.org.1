Return-Path: <netdev+bounces-152492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFE09F432A
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 06:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E61D16C27B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 05:50:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AE5414A60C;
	Tue, 17 Dec 2024 05:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oi2b1ovS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06E9183CC7
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 05:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734414613; cv=none; b=P3cSedSHGEOnrhsV5uQCt1MkAGUIWI+BJQU6KbO2L2R8G2cm90jUfdy7hL/V2fZH5WdTifmTV4yQoP5IA6qjVwYd6le6PTgOMdQYIi1jypi6TGkRzCjw/EvBe4LeCaehTjn467BmHP5nR9jqcKfe/XaS684LzSBDq2m9ZzD+d1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734414613; c=relaxed/simple;
	bh=U0SuPUHIzHkt9aIV18XVJN1/siR8LLE04ZJqSMLFo7I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KzrLTCnOAh84iyZb4I8AdborZ288gKiWVXyjKGbgVK7WfsRXiMef6kNGLhIDSSCl8XvEGwDz+EK7srUjtw1DQexlADxv69YD9MtdcW0ItkqEFF/y2ojIQewyqKBbLWIiDVeDqSJqRZQ00zbfGwLq9MqsJ2wctRILXGcE0FojrxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oi2b1ovS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B0E3C4CED3;
	Tue, 17 Dec 2024 05:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734414612;
	bh=U0SuPUHIzHkt9aIV18XVJN1/siR8LLE04ZJqSMLFo7I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oi2b1ovSKlF4dTwykCybNN1rLCdv41x8QZAFbpTZEGYkuwz7ZBzHAY9sOlfnbcymd
	 Nneeretpg1AI/C94KBNt4QVjMsfykj30HR+8tiK6xKh3ULVVw79uiIkSNk99Oy41MC
	 Pbq3QhCo0XFj+ZVAdz79dMccbNUkVHqMcn2FUt43KKnsVsk3Uoz1C8lhRPziRP0Glq
	 Vai7n7MUPdr2D3PPdOK0BCu0pMiR3aCjaE2pDalgTe1dgsTQ5iiPipg7Pgn67zeCfn
	 Zi2eg51jpy3Fsu3NjvIkBzAuO4FtqqRlAh4FXwf++FAQlYvi9/QyGHxsqmPvq2wmsY
	 ukAEpUTxb+6Qw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE333806656;
	Tue, 17 Dec 2024 05:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] r8169: add support for RTL8125D rev.b
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173441462963.773743.7062631677114171458.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 05:50:29 +0000
References: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
In-Reply-To: <15c4a9fd-a653-4b09-825d-751964832a7a@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 hau@realtek.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Dec 2024 19:59:43 +0100 you wrote:
> Add support for RTL8125D rev.b. Its XID is 0x689. It is basically
> based on the one with XID 0x688, but with different firmware file.
> To avoid a mess with the version numbering, adjust it first.
> 
> ChunHao Lin (1):
>   r8169: add support for RTL8125D rev.b
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] r8169: adjust version numbering for RTL8126
    https://git.kernel.org/netdev/net-next/c/b299ea006928
  - [net-next,2/2] r8169: add support for RTL8125D rev.b
    https://git.kernel.org/netdev/net-next/c/b3593df26ab1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



