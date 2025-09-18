Return-Path: <netdev+bounces-224642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 804E4B8749E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 00:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6F667BC860
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 22:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9912F5499;
	Thu, 18 Sep 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IF8QR4hc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2DBF2D7D42;
	Thu, 18 Sep 2025 22:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758235807; cv=none; b=HKacN+7dx8XkKIzm1XO0lD+fNSFSKMSPnP9yw5DCImS3bLLRuwOED6MlRXg1YK3rWkotxJGytcS4HW8DpCCMhPu1KO6NHp5e3Te1/FjtD9S4GvkkggqERsx1TgxlDKraQF0Ysc7csS5gtRnEPpneJJmY6NCr64H+Sg9Jsl7prgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758235807; c=relaxed/simple;
	bh=zCNghe8wZK3YL9w7ahoDbq8yjun1A2bLTWOD7EnLmAQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m1MZv2Vv8Z0VPqQqNzyDi02mBVm7usxwmEjLZVPO7awBG1tMREnpCv3o1cVYdt1a8XPW+RFeIy1hb3AZiQG+PIZnmh0paacgY8ESwUMLoYYLvve0oPNnpw/8iwRQWeieG3xxBp38grU8w5BEonBl+J/rKd6BhPVIAewY2XU9bxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IF8QR4hc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59978C4CEE7;
	Thu, 18 Sep 2025 22:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758235807;
	bh=zCNghe8wZK3YL9w7ahoDbq8yjun1A2bLTWOD7EnLmAQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IF8QR4hcOEt6M254wM1tRuwTm4xCQNN+IbfnaHIb/t4M2N2g7BOzBWNCkS1ppp3ZL
	 RunUXLFkd89R6sAkIxg+hB99l2ZOKFmBY/+Ub39COHFXwi218Op1phTc1lsYlCsvWD
	 xkqWw34eAlJLHnhWb5nv4stiRH0gZacJDvZReSgW365Mk6cdZrjcgzlIlt/BYL9GL9
	 d1cffqXoKJ+ceOXBaWl1HdkUqM/ELXFaZpKugjo5niR56cVYhwF4hG7ycz5oud3xaI
	 V47iM49qPzFs7PN1n6BvSt4zvg9cWtlY5NlgyGlK9jnH6a9WLJF0hToT94ypmimjKL
	 5dURuxJuovnYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6239D0C20;
	Thu, 18 Sep 2025 22:50:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ti: am65-cpsw: Update hw timestamping filter for
 PTPv1
 RX packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175823580725.2978091.7418472305512609467.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 22:50:07 +0000
References: <20250917041455.1815579-1-v-singh1@ti.com>
In-Reply-To: <20250917041455.1815579-1-v-singh1@ti.com>
To: vishnu singh <v-singh1@ti.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com,
 rogerq@kernel.org, horms@kernel.org, mwalle@kernel.org,
 alexander.sverdlin@gmail.com, npitre@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, c-vankar@ti.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Sep 2025 09:44:55 +0530 you wrote:
> From: Vishnu Singh <v-singh1@ti.com>
> 
> CPTS module of CPSW supports hardware timestamping of PTPv1 packets.Update
> the "hwtstamp_rx_filters" of CPSW driver to enable timestamping of received
> PTPv1 packets. Also update the advertised capability to include PTPv1.
> 
> Signed-off-by: Vishnu Singh <v-singh1@ti.com>
> 
> [...]

Here is the summary with links:
  - net: ti: am65-cpsw: Update hw timestamping filter for PTPv1 RX packets
    https://git.kernel.org/netdev/net-next/c/97248adb5a3b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



