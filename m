Return-Path: <netdev+bounces-240622-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 416E4C77024
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 03:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id EE78E2F6EB
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 02:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDD427E045;
	Fri, 21 Nov 2025 02:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I/Z+pkG2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D0727CB04
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 02:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763692261; cv=none; b=psp6A1Q8gvMnFppekhRnNJkqnLkH3rZk/Sdj5FBeSZ7kdS43IkyqxtUHZajaFXZQiXB7RiA//d2Y7podgQwvBHVOU1G0WQJMpEZFUz3RTEEG9AQtGko9V0HUULqIxxoLNMrQmWv5Jcm/Vro9H8Te2bBcgWgj0Ib/egk1JMSu+3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763692261; c=relaxed/simple;
	bh=foWsoqPQFbgcBhIcFsmUkf7F+sEdBrJ4J6s4XKl1j0c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=J9ubxP8Ffb1laog4BuGO8GhmHtICzME8eH7cXhKqZZb8T3TsAb+T3Jn+PFo3V5rUKDMIqigKckuvcDz6wNGA0FrYeJYuWoooRiDNt3nxk+l26HJuIexZm6ZNGiQq69kOjY2YtJEVEmGdlbFuYdkweqKaiTPu4htdsePSGA2fM9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I/Z+pkG2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7488BC4CEF1;
	Fri, 21 Nov 2025 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763692259;
	bh=foWsoqPQFbgcBhIcFsmUkf7F+sEdBrJ4J6s4XKl1j0c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I/Z+pkG2foTeXTVQzrf1xa9HuK8Maw/IZAiwXWo5fgBj9DARTIdxMtLKPrRqbEjnD
	 5jy08TjCSCyugR4dy2zAh5afyaivPP2X+2fkq5FK0cfElPWnFqaJbOH6qpn4q+zM3L
	 ts7opTn0993nUhnjomyjDBdvAnrCF5XfIIRaDb4ZXbfokXAQ7Z1h8R9rwE+jmlOGvd
	 cnyAEy8LiH7rKe1gxAuyMLoxu6Ji7hBZQ1Hi15sh8kAtvWtsikv/th9rOxskzsDA+R
	 6aUhNr0rCIyRqsAso3JoTGux7da4AGtRqaCHD4xIH6Ux+ck+y3biUHJXp41M/U57mI
	 rLbr1sUZzekUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC913A41003;
	Fri, 21 Nov 2025 02:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phy: fixed_phy: fix missing initialization
 of
 fixed phy link
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176369222433.1865531.13427564398081878544.git-patchwork-notify@kernel.org>
Date: Fri, 21 Nov 2025 02:30:24 +0000
References: <dab6c10e-725e-4648-9662-39cc821723d0@gmail.com>
In-Reply-To: <dab6c10e-725e-4648-9662-39cc821723d0@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: andrew@lunn.ch, linux@armlinux.org.uk, pabeni@redhat.com,
 edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Nov 2025 08:05:45 +0100 you wrote:
> Original change remove the link initialization from the passed struct
> fixed_phy_status, but missed to add it in all places in the code.
> 
> Fixes: 9f07af1d2742 ("net: phy: fixed_phy: initialize the link status as up")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/phy/fixed_phy.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net-next] net: phy: fixed_phy: fix missing initialization of fixed phy link
    https://git.kernel.org/netdev/net-next/c/bd048f8ce6ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



