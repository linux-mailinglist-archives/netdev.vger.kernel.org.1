Return-Path: <netdev+bounces-241750-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE6C4C87EF1
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 04:21:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABE333B3FB2
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25FC330DD18;
	Wed, 26 Nov 2025 03:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFKm4wT1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F169E30C629;
	Wed, 26 Nov 2025 03:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764127263; cv=none; b=S7YeXj/xqMhCWqRbUJnWZSsJxGVGW6kdPHDoaDIQNYezEayEDNRoIQirGAv6oJkgld4y2PP3t8PqgEEkK+RJQP75h9SnJHZe/n/mpRV3o7E0EQr/pQhnZKnkn+UMsBKjXVfKvuaqJrVvR22+IjSVz2xZamYqMeKElDe5FUX7jpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764127263; c=relaxed/simple;
	bh=rSHt/uDn4584ntTxBO47Zm5EmfOuhbFclmV/EPq/bMw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R4niAMSa8E8rOuJwKo0kGJ2hRV7mxl2934JFxhVP80q/Jzr4I1K5Mt7gYv2ErobU6ZefB8723+RUyKliGAodTv3IYmjSGX0u0MlQ5D5q4zYk6dvgQK31XZfJgXOjEYU9ECC0fasz2T/21tBD1fhM0Bosy29WAOiFI4Z/NXp0dTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFKm4wT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868F2C113D0;
	Wed, 26 Nov 2025 03:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764127262;
	bh=rSHt/uDn4584ntTxBO47Zm5EmfOuhbFclmV/EPq/bMw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hFKm4wT1ID53rn0QuzGZGBKI5p28xoRmhdLHCgxMO/Pt18xmHhPTNmgIJu+VpWZkT
	 G1q/EXlLW/qpQLvI9GdFjmHHU9saoAeYyXEfyodIQxRRHxhIjtn+UbQ49nwmLhDVyN
	 1dU72d+77juTWmaYT2+coVLYP9k5OA6I7ygj9m0as/FF37tgNLdFsdyQipqStH6vz0
	 +tzZdNZC1Plz6LXxawuJmpoW+S0maW1sQKDv+AnzOKsnm1UnwW/z+PnoGu/bo21RXz
	 O6X5YxBOAAsJnKZr+gUFGSjNRsI4+BZja8dM0q5wyTbblaDZe+zv4S9YumERd0QPqt
	 31VlaaMhuceeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1DB380AAE9;
	Wed, 26 Nov 2025 03:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/4] ptp: ocp: A fix and refactoring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176412722448.1502845.1278164371012139372.git-patchwork-notify@kernel.org>
Date: Wed, 26 Nov 2025 03:20:24 +0000
References: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20251124084816.205035-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jonathan.lemon@gmail.com,
 richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 24 Nov 2025 09:45:44 +0100 you wrote:
> Here is the fix for incorrect use of %ptT with the associated
> refactoring and additional cleanups.
> 
> Note, %ptS, which is introduced in another series that is already
> applied to PRINTK tree, doesn't fit here, that's why this fix
> is separated from that series.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/4] ptp: ocp: Refactor signal_show() and fix %ptT misuse
    https://git.kernel.org/netdev/net-next/c/622cc66ed72c
  - [net-next,v2,2/4] ptp: ocp: Make ptp_ocp_unregister_ext() NULL-aware
    https://git.kernel.org/netdev/net-next/c/590f5d1fa6ee
  - [net-next,v2,3/4] ptp: ocp: Apply standard pattern for cleaning up loop
    https://git.kernel.org/netdev/net-next/c/4c84a5c7b095
  - [net-next,v2,4/4] ptp: ocp: Reuse META's PCI vendor ID
    https://git.kernel.org/netdev/net-next/c/648282e2d1e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



