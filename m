Return-Path: <netdev+bounces-208736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23CFAB0CEBD
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 02:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 609E116F888
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 00:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE04D12CD96;
	Tue, 22 Jul 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EP6NuL+3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A3030100;
	Tue, 22 Jul 2025 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144206; cv=none; b=srTGdYEcP+xB6g64lReGZ5LOjbdjPVKg/25aMBgjLqmPbHllWjnqiMhV2ngsKl+TVhMjtWM1y9SbMar5h7uz8Sa3NEZlrBCP/bpscjB6hk9j7GCYtLOE7xsaENgSznQlrpV9dJcWnik1MvWZ1142OxIOwHsktkQb5yz1/bU6V50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144206; c=relaxed/simple;
	bh=Lll+xb2CuKaezj+ykHPk3aO+vWOXMbcSPYMbwtv8OTc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WB2uwYDvJxxr6P9Vd4urcEC7JzNwrYmrB4pvAPRR9N3JfB1bqs09KHaz7rX/Ba0SL6pK7ieZaz6G/gNl2pvZWzA5iflAaafIXtXkg8h9s07mor+hWdYH1zYXwF6NzqXS65UvaLi5ar425jQdp7lB7P2Cf29FqrsDiEwQfmByLj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EP6NuL+3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 829F1C4CEF5;
	Tue, 22 Jul 2025 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753144206;
	bh=Lll+xb2CuKaezj+ykHPk3aO+vWOXMbcSPYMbwtv8OTc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EP6NuL+3jcVkjW9e1vWW/6YHKB30Iv3nqmIhap7wjtHiGm5cuR+j0OdNsRgEl4Tx5
	 dgtShF38Glthx+a3V90FAxecSMcXsQ/TNJQN5eokwWjt44PhLL8c/DzcepTYgQXrtl
	 QoBDtFyhNgkbPsvYSXEQVEOnbPSYBc4w/tifWpEPlwKnmuafV0zlUPobQi72LHG/mv
	 3ZMOZq4KOHH8vz1iNAciSBGjsQfWnUnrtxR/KB48egPa4aX4fqsygSiYryWIfoSWKK
	 6OZsHXq+L1lNY0aN4TyqHhYU5hJ+RtOhml/ohtVtS6dV1MNYNAiDScBrqVnmpxP0pM
	 0Hpm61CC+hjqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70BF2383B267;
	Tue, 22 Jul 2025 00:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: usb: cdc-ncm: check for filtering
 capability
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175314422525.243210.8477234294491199351.git-patchwork-notify@kernel.org>
Date: Tue, 22 Jul 2025 00:30:25 +0000
References: <20250717120649.2090929-1-oneukum@suse.com>
In-Reply-To: <20250717120649.2090929-1-oneukum@suse.com>
To: Oliver Neukum <oneukum@suse.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Jul 2025 14:06:17 +0200 you wrote:
> If the decice does not support filtering, filtering
> must not be used and all packets delivered for the
> upper layers to sort.
> 
> Signed-off-by: Oliver Neukum <oneukum@suse.com>
> ---
>  drivers/net/usb/cdc_ncm.c   | 20 ++++++++++++++++----
>  include/linux/usb/cdc_ncm.h |  1 +
>  2 files changed, 17 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-next] net: usb: cdc-ncm: check for filtering capability
    https://git.kernel.org/netdev/net-next/c/61c3e8940f2d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



