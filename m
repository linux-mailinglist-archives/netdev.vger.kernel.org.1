Return-Path: <netdev+bounces-202073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96945AEC2AC
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B53A562DCF
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E99028FA91;
	Fri, 27 Jun 2025 22:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZUp+rSQz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C7628F53F;
	Fri, 27 Jun 2025 22:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751063991; cv=none; b=TdA22tMpnrYWrTEcyj6h/wFTlFkOnAKTJgaWhC97sIcW9lMNwU9JukCIjDJpf/ro1XIISSnqZVvxkbt9S8w3PpzPUH7VV4GMR7r850VwvdmH1PIeYwpvvezMAzIENxYV0EfnA0v9bwKevddwQhbUtHBuSSshfpWMMXuxsBgg9qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751063991; c=relaxed/simple;
	bh=z8f9aWk8yGtQixJ8Z4YfCx407+0w1mz+aF5kHovQ8gA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KR35RpBLawMoeWKq0Zht/Le24W0TKQgL3ef2ay9LmR7YRqOF02CEEOz+gfDIiOcRRb8w8MNyDSEYQjI6gdrAd7CSqDCAGgvt7kkk2faqvHNmamufxdVyptNe5U2rdjoz0Yef8ia6PxI/8hPgTxlNMXWN8WDELVRffBr5jjq1Vow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZUp+rSQz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D6DC4CEE3;
	Fri, 27 Jun 2025 22:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751063990;
	bh=z8f9aWk8yGtQixJ8Z4YfCx407+0w1mz+aF5kHovQ8gA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZUp+rSQzzZ5eGwKUQ7Qn6bclfqGSeuJ8gxlo6+kFDn198zWdkz/AR4HDLmSCskXaN
	 QHVNOIKlx1cS01KHTgRwEiod99L+U6OAkHVvFN6uPOuMbaZWdfz0nBV/7JM+B1t+e8
	 DjA0eYQ+KB2FQ8bLjkhv6+HchZErdLwIyzPt0oVcvOTY4QMBXRUZ4GyHXKiScavsEq
	 Dw6WBQOdFMp05nm0sf9mc/fiRJgzupmR/za3SDX7qbKP4O5iF8veYkd8t44RulE5Xl
	 LX0jDpb2oDP/NCVSQDfXi/vcbQ8484vhcZbpbr3FvFdUCNmGtwn1uRKr/gBnAI8cnm
	 RAjBka8YoM18g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD9E38111CE;
	Fri, 27 Jun 2025 22:40:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: dsa: ks8995: Fix up bindings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106401649.2079310.16035106613106076029.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:40:16 +0000
References: <20250625-ks8995-dsa-bindings-v2-0-ce71dce9be0b@linaro.org>
In-Reply-To: <20250625-ks8995-dsa-bindings-v2-0-ce71dce9be0b@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, kaloz@openwrt.org,
 frdrc66@gmail.com, juhosg@openwrt.org, p.zabel@pengutronix.de,
 netdev@vger.kernel.org, devicetree@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 25 Jun 2025 08:51:23 +0200 you wrote:
> After looking at the datasheets for KS8995 I realized this is
> a DSA switch and need to have DT bindings as such and be implemented
> as such.
> 
> This series just fixes up the bindings and the offending device tree.
> 
> The existing kernel driver which is in drivers/net/phy/spi_ks8995.c
> does not implement DSA. It can be forgiven for this because it was
> merged in 2011 and the DSA framework was not widely established
> back then. It continues to probe fine but needs to be rewritten
> to use the special DSA tag and moved to drivers/net/dsa as time
> permits. (I hope I can do this.)
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] dt-bindings: dsa: Rewrite Micrel KS8995 in schema
    https://git.kernel.org/netdev/net-next/c/a0f29a07b654
  - [net-next,v2,2/2] ARM: dts: Fix up wrv54g device tree
    https://git.kernel.org/netdev/net-next/c/c9cc6b6a7d23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



