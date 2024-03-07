Return-Path: <netdev+bounces-78241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F59874777
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:50:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE450287A6A
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD90171CC;
	Thu,  7 Mar 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUKi6MGe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64EAF1FDD
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787028; cv=none; b=XkAA/2iQY+M45wC/5JrjkeDri+ijCfk+etFtMtZ+ICJ7d+3VJ0DjzanEFv//1ZmVVTqLZo6zOBVE5Bod86qCtdym6QG6Bs3NB0XOWQ/HZEwfFXA/fjgKV7k1fnUp2ut347NNRcQJRAf7YH3O8X2JILnYSzGZKp9D3+80qWtLPWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787028; c=relaxed/simple;
	bh=Zj6dh6eeudHQP5tRUOM3jBeogM0Qx0639x+7a7/mD+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1X8DVo/djhzekCwU2ZOiTnOsslgCXZnWTgfFLENG+ipG02o6X9RgSMdFYwn/ezyUNe8763ug0EwA9C9iPrr+OQHVqhOPk7cMoxszPVC7YePSQvJrLLEf0GidTitOuXxo6HZGZW3OkKn+vV9aqm1eIoVxYZhTLC0gvHzypv9Zbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUKi6MGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 091AEC433B1;
	Thu,  7 Mar 2024 04:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709787028;
	bh=Zj6dh6eeudHQP5tRUOM3jBeogM0Qx0639x+7a7/mD+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iUKi6MGeWpXbjho/iFkMoig/FudM3bY7DpI0IDW8DqtARVFrVLqJSBfrCXfhtKQZ1
	 CGlcbyOk5TF3JZE+M/uGUTeaLy589pZQ0TOE8t6ESQFMqtY9YVHbJ4y3Kvm8/egZQV
	 BeE1J3nKqNQk82b2YMjtnJjngiYZoELt45LP3J0aDGKtB9sx4ALGad4vAcXvBQAGCY
	 /pGF6F1GT+lKKK1ExqcrURkH5JkhB9yfILiLCMIntST1NmDDw7eTjw0ayudIzjaptG
	 kfulaNybTUu1XAmkJRuJZlIjKPbSKrPu1FvvCS9ysAUBw1/D9ISZ5LMlYCUOHNwE58
	 xIRq8L1CS2FQA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF9DFD88F80;
	Thu,  7 Mar 2024 04:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ethtool: remove ethtool_eee_use_linkmodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978702790.12804.1091007834113053374.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:50:27 +0000
References: <b4ff9b51-092b-4d44-bfce-c95342a05b51@gmail.com>
In-Reply-To: <b4ff9b51-092b-4d44-bfce-c95342a05b51@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Mar 2024 22:26:10 +0100 you wrote:
> After 292fac464b01 ("net: ethtool: eee: Remove legacy _u32 from keee")
> this function has no user any longer.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  net/ethtool/common.c | 5 -----
>  net/ethtool/common.h | 1 -
>  2 files changed, 6 deletions(-)

Here is the summary with links:
  - [net-next] ethtool: remove ethtool_eee_use_linkmodes
    https://git.kernel.org/netdev/net-next/c/d7933a2c7f87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



