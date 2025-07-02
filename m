Return-Path: <netdev+bounces-203136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C53AF0908
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 353941BC3336
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D970E1DC075;
	Wed,  2 Jul 2025 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skV6/QK7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11D51D8A0A;
	Wed,  2 Jul 2025 03:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425787; cv=none; b=Ti3IlmVwsfgC5piDyEuONuOVujQCU8UD228KrcIVYKzqapDZop3rVPhzQtOJZCJD/7T7Sr0isOyZQL8veoFAWo67Vv0fE0yo9yErAFexjbZmxt3Zp+eivf2frC1X6M/l2uwlKAjP7Ttszirwaay/Jb1foJf90f6G6JK0Xw+Uk10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425787; c=relaxed/simple;
	bh=a1WHH6GvX6A5Qz/oi49Go91PBWZjcgPorcwPK9elZV4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qRbeskr4ENgJG/XGbrW/i8O4FWwK0YpvxOh08r/giI2vPdFCrQfntikpP5acfCDFmx63eWY914J/me/PhKacDVMEEOuHK4E/o3jFVPpAkUZa5XnQLquC2pOoGtXGbrqwc/WQSFGLJ2czdcLUcEETL128gXp6Lf3KHrLw/uq44oU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skV6/QK7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 370CFC4CEEF;
	Wed,  2 Jul 2025 03:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425787;
	bh=a1WHH6GvX6A5Qz/oi49Go91PBWZjcgPorcwPK9elZV4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=skV6/QK7ci6HgCZPW6lfiPobk1jxgxQXokcvknjmPrM2tt3bxpylQFj7CeYCiw1Z2
	 3/PyewSSIXWVSlO2T5kcDV7tkf1XlsPXApm8cm5vPi4VhWrGvU9JHT6+P70IzZB1nq
	 4VI35CS162eQ/x22ZkYw0jo8c41eDS5njm75Ri3ZV67Fk0YaTadm7/UWUZasybYTTO
	 IgYk9D3dXEdpQTVtDd8kFJPGFw3MGnFpHAN9qnuWm+X7PIjyJX811GvtJG8v+joNUO
	 2c7/HF5lhwL0j8f8tTjG1pljdVD8Yblmf1+IGrwiC2xVTKu4Gxpg19UOIuPX6LSeAR
	 oDWCk6/cZ48HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33A2C383BA06;
	Wed,  2 Jul 2025 03:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: tulip: Rename PCI driver struct to end in _driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142581175.190284.13977299189348468817.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 03:10:11 +0000
References: <20250627102220.1937649-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250627102220.1937649-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-parisc@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 27 Jun 2025 12:22:20 +0200 you wrote:
> This is not only a cosmetic change because the section mismatch checks
> also depend on the name and for drivers the checks are stricter than for
> ops.
> 
> However xircom_driver also passes the stricter checks just fine, so no
> further changes needed.
> 
> [...]

Here is the summary with links:
  - net: tulip: Rename PCI driver struct to end in _driver
    https://git.kernel.org/netdev/net-next/c/e96ee511c906

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



