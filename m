Return-Path: <netdev+bounces-137299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 868309A54F7
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174E82827CB
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6E0194AEF;
	Sun, 20 Oct 2024 16:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUTIiEPG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C152194AEB
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440630; cv=none; b=dTzpSk3weXxMzh1nMjJCxgLZ7la6WXBCo1LbWtT3Lxh5oSaNjRvZkl7Z4K3RXqMEWlANncZGb48VATFs4nDtQzOJXtpDDSoGRldj2xfWupjgdxAUy0/4xXtZXa+yx0Pn6O50L/RODj1Qj0/bF63kmQiRwpnNTC7eDoUnXCfegfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440630; c=relaxed/simple;
	bh=gTJ+MuJszw6iWzTEO5P834IxOzmuI/lltEM4YoouRrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rvNa5neCBulzM68XEMr+rKu+sPVAx2RrQSy9ckAbTRVGcZZDesrBynTbsbx4/xdJi1y5l3AqJg9y6MSMielROkIQNkq+HVJOLXRp/GMhNYZynuD7vjW3w0nb+o78hwNpBJSe9Beetyl27UvQjIS2d7z405J3OK1+8gvi5X5PLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUTIiEPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F3EC4CEC6;
	Sun, 20 Oct 2024 16:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440629;
	bh=gTJ+MuJszw6iWzTEO5P834IxOzmuI/lltEM4YoouRrk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GUTIiEPGNhoX0jTjVo8mGXjNl/zkOvkcEcrEfXG/utiRPpi22lMDC52YLsr0Aw9FE
	 h6wBKW6PZf0Kt+XBs5CJpmxKaoiU5GLle4ip/DNUVl1p25ZdeJbcEz+QzRKRkGf4js
	 xM/VnqOWzXRepdrQWAtCDk0RKhgbU1sOBKyvQhMFaS5FROc1rPzYQH1sSXlWxTLP67
	 29BOUeJ0k8raa1nT38FHNbalUQA49qID6qHF1ADdbBr1BeFayqQLbizNRt2DiG9HkI
	 iFa49sbf784ZuvRoHrt/xP5Iomaed/B4G7UcOdoGinGlg5yaByp7h2qMHjzfKJHufP
	 h0yeMHWnYmQOw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE4E3805CC0;
	Sun, 20 Oct 2024 16:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: enable EEE at 2.5G per default on RTL8125B
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063524.3604255.12272226658336668551.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:35 +0000
References: <95dd5a0c-09ea-4847-94d9-b7aa3063e8ff@gmail.com>
In-Reply-To: <95dd5a0c-09ea-4847-94d9-b7aa3063e8ff@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Thu, 17 Oct 2024 22:27:44 +0200 you wrote:
> Register a6d/12 is shadowing register MDIO_AN_EEE_ADV2. So this line
> disables advertisement of EEE at 2.5G. Latest vendor driver r8125
> doesn't do this (any longer?), so this mode seems to be safe.
> EEE saves quite some energy, therefore enable this mode per default.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: enable EEE at 2.5G per default on RTL8125B
    https://git.kernel.org/netdev/net-next/c/c4e64095c00c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



