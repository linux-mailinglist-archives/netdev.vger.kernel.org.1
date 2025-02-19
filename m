Return-Path: <netdev+bounces-167575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D1BEA3AF57
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 03:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2A4F189819A
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 02:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A781C19149F;
	Wed, 19 Feb 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mlNd9s6w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DEC1531D5
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739931011; cv=none; b=ebyISka1+pRXKGIzejEvk2Jo3ArXWDl4uXN/zRFxyg7OQnHjMGePXOJiaqYGlvTATqsBZRHLzGqfU44n7jqUsPxrc9jVFZeToGJc/uxA1v3EQJbv5fG93oM/2qdfPH+T1tGn7C7Gh6PfB58+LtVmgrqf+1wic2IXVjgJxr7BAV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739931011; c=relaxed/simple;
	bh=K4N8YQbDxt6JB1TGqgsgwnJHH00ylfVGymRxAkWlCXk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nCP6tiUm9kpbpTov/dllxfIuBhSnZwNbbdtem1kC6GZ+y3VRR+zAr1wegs47cxD+3tgG2UstO4Qa9cQkNa8mw0CpTCioPbw1ORNc8f2+YN9d1U2+RCLNo9tYS16r36wzzBmcZfrsOJHfk7pOxxlkMkc1/yEY1B3l7vWTL2e80Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mlNd9s6w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5958EC4CEE6;
	Wed, 19 Feb 2025 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739931011;
	bh=K4N8YQbDxt6JB1TGqgsgwnJHH00ylfVGymRxAkWlCXk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mlNd9s6wcZAx4hxjVLQIyVl2sbWqKQG0TSGf1gvzDVda26uVX3A9RGeM3kQf34guk
	 /2DFgbnp+LzvOBjX7L3GzyFA7KLPk+UpSE0SVrim3w+apHszG1A98YSloCPMYd2u4Z
	 NGgHBLsqNKmn2YEPXlulBoEu3xXUe01vh0+4CKzWRemnwvKuGxXS35zkgDizX6zZX2
	 j/jdKDr7rlTQuNR+s9CF87uzMam854mwKFOmOLZkGlaMdo+z2THDf+kMWgUkTXPUoU
	 l+5RhfIW+XsnL8I7yaoQd7ILcU434RptwsWWbW62VD1drJTBK8c2TmRMfn/PjfeLXZ
	 mnCQT9/2jFrSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB006380AAE9;
	Wed, 19 Feb 2025 02:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: realtek: add defines for shadowed c45
 standard registers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173993104175.103969.10319831028101936624.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 02:10:41 +0000
References: <c90bdf76-f8b8-4d06-9656-7a52d5658ee6@gmail.com>
In-Reply-To: <c90bdf76-f8b8-4d06-9656-7a52d5658ee6@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 15 Feb 2025 14:29:15 +0100 you wrote:
> Realtek shadows standard c45 registers in VEND2 device register space.
> Add defines for these VEND2 registers, based on the names of the
> standard c45 registers.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 33 +++++++++++++++++---------
>  1 file changed, 22 insertions(+), 11 deletions(-)

Here is the summary with links:
  - [net-next] net: phy: realtek: add defines for shadowed c45 standard registers
    https://git.kernel.org/netdev/net-next/c/fabcfd6d1099

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



