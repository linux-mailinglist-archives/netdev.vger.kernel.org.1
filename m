Return-Path: <netdev+bounces-166071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC9AA346E7
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA8273A66B5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AE713D8A4;
	Thu, 13 Feb 2025 15:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq/uwLjT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E9B26B0BC
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460006; cv=none; b=H5VG5aG5yWovVP3UTtWFrKJZiSKolodPilydzpTEuXa/C27NDVEtYFRgLr9/YvYZ6SAg/ShVsgmBJ4VLUf6HKOeGj6CI0Uwb1nBZx35NmigzFLJe6auhu3jpoawtGoj1bNbreFNs8X3IETZ/pIN7LNs99JOTlkxnqbj6npNDgRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460006; c=relaxed/simple;
	bh=3g1MOaAvKve880aLvbMyDxo2vIWYuSsRN9efKJg2+SI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AO/Unwc4ZjNqPDoexyNBuSj4KfpRgWGJEUJLjQ7BSsoU35zJ6lO4Zn0nNdnCE0GAwN7Ly6j3e8yw2ECfoCV0TnNqV/txxw9RXtsRGSu1oCP9MTq5IulxHeFlcrUPUGnGFPiFcfZLwv7eNNQTBQVjnUinZaj6QW7Jf7Q8N6N1Z2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq/uwLjT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF157C4CED1;
	Thu, 13 Feb 2025 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739460005;
	bh=3g1MOaAvKve880aLvbMyDxo2vIWYuSsRN9efKJg2+SI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bq/uwLjTi+gRgwcdR8q/LzfpKCZZgNTNa9lCufa0LdbNvjtCJMk/DHkZfxpz7d62G
	 xbM2ubTbuH3YzqxJHGUqGPq7c8X1PeAHIKlryceO8hs9l4oQTJIq+EZzxcyyRkDwcY
	 nDQ02rh73v7hqd+QSZpl+gkBv9UVxD9QV7X/b6f2mGTEgfo3R1TZSOF7eKMHc8zGEO
	 QZFvC3woY5KyezWWOzKHmcios2nJvwcAfSgASyDoLg337kYxH6PqPCX/QiPHxPa281
	 dKif8ZrKiT/bKuMFpgzjtGPYZsQvqtbM2M1LyLoQrfaMszEEVPdgo7yynm/og9X9bV
	 E6B9K8v/AlILA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34719380CEEF;
	Thu, 13 Feb 2025 15:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: dpaa2 ethernet switch driver: Fix
 spelling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173946003499.1263852.7850021844003173151.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 15:20:34 +0000
References: <20250212021311.13257-1-ritvikfoss@gmail.com>
In-Reply-To: <20250212021311.13257-1-ritvikfoss@gmail.com>
To: None <ritvikfoss@gmail.com>
Cc: ioana.ciornei@nxp.com, netdev@vger.kernel.org, skhan@linuxfoundation.org,
 linux-kernel-mentees@lists.linuxfoundation.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 12 Feb 2025 02:13:11 +0000 you wrote:
> From: Ritvik Gupta <ritvikfoss@gmail.com>
> 
> Corrected spelling mistake
> 
> Signed-off-by: Ritvik Gupta <ritvikfoss@gmail.com>
> ---
>  .../device_drivers/ethernet/freescale/dpaa2/switch-driver.rst   | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] Documentation: dpaa2 ethernet switch driver: Fix spelling
    https://git.kernel.org/netdev/net-next/c/c3a97ccaed80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



