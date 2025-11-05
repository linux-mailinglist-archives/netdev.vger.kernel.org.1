Return-Path: <netdev+bounces-235703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF94C33DBB
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 04:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECF9B189F1F1
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 03:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5408226CE2D;
	Wed,  5 Nov 2025 03:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rcmOsQnx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A799262FD7;
	Wed,  5 Nov 2025 03:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762314035; cv=none; b=MYCl1dOD0RnFsqg0Teba6oeTwRklQB2WGfg4OkVXuXVxqUZnZlDvfoGhtl9Dvj6z5Yxj6DXfT7s4dfxZU2MjS+Rem+62Kh8jejHhv1Sw9J9giftng8Fryx/mxAk+cKg/HJXDK6ZGc906Ze0HwK7V2xExkvYID26C2x1s7EdygVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762314035; c=relaxed/simple;
	bh=5B5kQnMCAaWVw6WGeGQS9dS3UoKKKIwVg3qwHZW/Rzo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HY8g5oWE7NnJOE/RNZ8VeQyIO9kZudRIx50Uh2061H+P0ZqR0kfagKAeqJKZzV5MzAdJER89ENLMFI4YLbwnw71Lp9ncH5SkGAZVOCBGfyTytXXjCI98BeK/UGRMLpd5i6B962dFgA8uRmvBz8WzgDr5N4RUuyA8+ikEbYFOz3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rcmOsQnx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0929C116B1;
	Wed,  5 Nov 2025 03:40:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762314034;
	bh=5B5kQnMCAaWVw6WGeGQS9dS3UoKKKIwVg3qwHZW/Rzo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rcmOsQnxU6GqycZ44lCyEMzcsIfGIOEAfGQ+IWy1um/EKQEOqLKNil7+dksg/Wij2
	 fDZB0Aax/h+S/4smnkltZUXemjg58Mu43RNGYb0bqTkyBhvdf6XWY532EIJ2JD9lXz
	 8FJlqmzjEZL4ZvQsHDl/+xUiPaCtfjaSQubQr2CCQwztLjQ94/GNaOwxbWovnJOjvF
	 2rK+FOnfolQnBEicV7vp1gylfKFilzHvfI3uOr6N4FraXVcxTlTAOWx6Nra7z2ANxO
	 WjCGIZiu51xzpVD38XA+8u1rvoO5OkPUwZCqJ/ZNKd/AHIvbFI9hMGEqxeaVg3zspx
	 x0o1JNWPKnwuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B0656380AA57;
	Wed,  5 Nov 2025 03:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V4] net: ethernet: ti: netcp: Standardize
 knav_dma_open_channel to return NULL on error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176231400849.3077655.12135200578922215083.git-patchwork-notify@kernel.org>
Date: Wed, 05 Nov 2025 03:40:08 +0000
References: <20251103162811.3730055-1-nm@ti.com>
In-Reply-To: <20251103162811.3730055-1-nm@ti.com>
To: Nishanth Menon <nm@ti.com>
Cc: kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net,
 jacob.e.keller@intel.com, horms@kernel.org, u.kleine-koenig@baylibre.com,
 edumazet@google.com, andrew+netdev@lunn.ch, ssantosh@kernel.org,
 s-vadapalli@ti.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 3 Nov 2025 10:28:11 -0600 you wrote:
> Make knav_dma_open_channel consistently return NULL on error instead
> of ERR_PTR. Currently the header include/linux/soc/ti/knav_dma.h
> returns NULL when the driver is disabled, but the driver
> implementation does not even return NULL or ERR_PTR on failure,
> causing inconsistency in the users. This results in a crash in
> netcp_free_navigator_resources as followed (trimmed):
> 
> [...]

Here is the summary with links:
  - [V4] net: ethernet: ti: netcp: Standardize knav_dma_open_channel to return NULL on error
    https://git.kernel.org/netdev/net/c/90a88306eb87

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



