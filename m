Return-Path: <netdev+bounces-238069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FF54C53B59
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 18:35:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F6424219E0
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 17:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651DB328263;
	Wed, 12 Nov 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WNl4CBpu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA782BE650;
	Wed, 12 Nov 2025 17:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762968038; cv=none; b=uilYzTHvIjv70NU3G/wxsv0x7J1gB+s496QlvG76/XBby5RcA/xZhjNR6oxpEpbGnNZS0XxomoaftSZyVdY8/kzaW01JFhbTwCWR8j0gU97GTMTTE2rzqB+mUKLekJEEz1m/5SnmAjTS0+3XQweX2u3MLNv37imBXaJmwbFjHB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762968038; c=relaxed/simple;
	bh=nW3H/DwEWgKnHgIH5rXpU/yUG/VcFQxcP/8RtuTjMsk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VEv9RFxXlUX0WM1utGOEI7rr6roE+TKftTwJtlAI6np2DOss/KRW+fhc0YS15wonZSkjXrdSFVGKtAqv9ySLDYlP37z4pP+rXrWZaocpgPcEKmpobqoOClU3K1BiJgEJS6pj51gaYzAwNvaXmuul0+cICv+tzUtDR96PIfZqjI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WNl4CBpu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11F68C4CEF7;
	Wed, 12 Nov 2025 17:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762968038;
	bh=nW3H/DwEWgKnHgIH5rXpU/yUG/VcFQxcP/8RtuTjMsk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WNl4CBpuS20B7vVmRJQ0e6wJfRyRb+9V7SJZ9jvkr/qIFrXGSFDenHOLV+dpSIGEp
	 z+aQAuS0eM82PXUu6VkfElNNEi5TZn7/m2voNWUPolS4256YRyhyD88DMeqgtbw2U9
	 cPxJRrHgOfC+g0UjDf9BMmH2Z11b7aI9FhyIyBt5Dc1V9iDSlt3IDujWoGokXg/EhE
	 8qOGpsdYDGm2N4jsxA1OW+j/7Jo6gT6yhazq7Ff/2ZjDX/cUFiyDpZmXw75u8JIn1N
	 2PU+nRAaVllbKRXzoRF+Hr79knF4eXtiLYOX7+GlDpJcEWZweE00yShebV+EZwaxnP
	 r2qBJMwrr1/ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB13639EFA62;
	Wed, 12 Nov 2025 17:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] r8169: add support for RTL8125K
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176296800777.91007.9216007329700190108.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 17:20:07 +0000
References: <20251111092851.3371-1-javen_xu@realsil.com.cn>
In-Reply-To: <20251111092851.3371-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Nov 2025 17:28:51 +0800 you wrote:
> This adds support for chip RTL8125K. Its XID is 0x68a. It is basically
> based on the one with XID 0x688, but with different firmware file.
> 
> Signed-off-by: javen <javen_xu@realsil.com.cn>
> ---
> v2: This adds support for chip RTL8125K. Reuse RTL_GIGA_MAC_VER_64 as its
> chip version number.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] r8169: add support for RTL8125K
    https://git.kernel.org/netdev/net-next/c/1479493c91fc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



