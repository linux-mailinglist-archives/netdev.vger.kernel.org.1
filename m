Return-Path: <netdev+bounces-110716-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7A592DE52
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 04:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97D40281512
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 02:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04CB12E7C;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="drZLdtkT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 856D4FBFD;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720664433; cv=none; b=EuRs0889LVMzm63fWKYR9n48dhItgKDzCe8kYoIuRd2K74ApZJPWg/G9ifvF0porIfdMI8WG3cr3t5H1FreTESHSVBnYWWt883qebS2dm7L51IP95GRYoCmSbupQECEwQEPMHiMfw+uPxuHq72deqpIVKxf9H/3rmYGiwUfNVW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720664433; c=relaxed/simple;
	bh=8bd7pPPOOm3ktRcZKp3/W4c8geokWqw90NdNwTWwkoA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dxCHqw5mOOHR/yx0MsvgBHZ+vjDaym1kh/DlT1EUIU3/kNbHRn+v0A8Acn96zDDnYXTv6vw7kuUZT85YBMZBhFt5YQMfSlrOv3rHF6XmSOh3znQoi2/MEr7kUoMpS3+rkFFROXHWm0zasnZyhzZtcIFtuowh/+0NZB70HTRaCUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=drZLdtkT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 188F2C4AF0A;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720664433;
	bh=8bd7pPPOOm3ktRcZKp3/W4c8geokWqw90NdNwTWwkoA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=drZLdtkTtUdUhL5o+n21HDGYZz09dRQbHOkQO5jPmNd8qtLTqjALYzdIA0iRYtami
	 2355kMbgJ94GODLzr6aqJY0mIa3KxT/LnY9x+3nii74vV6S8xWQ92tCumTvgRsdee6
	 NbTgPMBYo+6fJROsDg5ILp4q6O5QvvwJYiv3Oj49m1WlrcBTTp3gnvkh3iUk8Na1jF
	 vXC2bR2vUJtQ0KeP0bJOftvUWn/r7GO9epynswJ6he7cmHzepS4+DEW5dPpHfhNU8G
	 xqyjNcchO2uVDi9wU26AWQDs2GHW+WCHhOKBhTa6xbffhlmwzFjONGI+yI4rHeTJqs
	 0DTYBdgWFbpZw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0B009C4332E;
	Thu, 11 Jul 2024 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next,PATCH v2] dt-bindings: net: realtek,rtl82xx: Document
 RTL8211F LED support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172066443304.28307.1632369692721041060.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 02:20:33 +0000
References: <20240708211649.165793-1-marex@denx.de>
In-Reply-To: <20240708211649.165793-1-marex@denx.de>
To: Marek Vasut <marex@denx.de>
Cc: netdev@vger.kernel.org, kernel@dh-electronics.com, davem@davemloft.net,
 andrew@lunn.ch, conor+dt@kernel.org, edumazet@google.com,
 f.fainelli@gmail.com, hkallweit1@gmail.com, kuba@kernel.org,
 krzk+dt@kernel.org, pabeni@redhat.com, robh@kernel.org,
 devicetree@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  8 Jul 2024 23:16:29 +0200 you wrote:
> The RTL8211F PHY does support LED configuration, document support
> for LEDs in the binding document.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Heiner Kallweit <hkallweit1@gmail.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: netdev@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2] dt-bindings: net: realtek,rtl82xx: Document RTL8211F LED support
    https://git.kernel.org/netdev/net-next/c/ab896aa62e30

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



