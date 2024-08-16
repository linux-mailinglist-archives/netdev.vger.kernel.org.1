Return-Path: <netdev+bounces-119071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B26DD953F63
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 04:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E561F1C2204F
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 02:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F57535D4;
	Fri, 16 Aug 2024 02:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VPiUfMVQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CD55028C;
	Fri, 16 Aug 2024 02:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723774235; cv=none; b=K0heIG4WvOk06uoimayAAZAGh30roRt5cKP+KmuszjiNfjXcydJ23lzBWRjXrAdEo1nbt1AOsq5p4Hkwfc2XMI550J2wDDZw3RQnC74Q1u9eOu6HM3b2g0mKRgdqXSGokTlyv7rzsy0KVBtqKjEU2AscYhE2gT6zhtwPCvaK8hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723774235; c=relaxed/simple;
	bh=zEcssglqUNdV+RjTdBixIHSGezAg7y4P0jgbBCEHIhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y+cJejssIU0Zn1Xab1yb1uAOEaTFd9AuhNAcOVmW3ymH1i3MOtoXwlapCE5sDyXClF4Up5wUHvZUyGyS+V+0GjAUWWTQZNPZ2SBZaObY/d+3N/N8HH23z1xcv5blH9wSpZP4OfiqQUvM8fqpD6W/u/3EB4zA2/PZqBIjsUcHD7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VPiUfMVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0653C4AF09;
	Fri, 16 Aug 2024 02:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723774234;
	bh=zEcssglqUNdV+RjTdBixIHSGezAg7y4P0jgbBCEHIhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VPiUfMVQod/UXWpHVALEwvP6Dxy7lf8bRdexLP/lTH/ZWmIGX0ajoorenAXxGMaTR
	 KOZ3//kKW5K7O/KE9kBjR9YNLCCadFUuNWB0BV1OST4gWw9s8GQepNwZygpxxpGrQz
	 oscv2jX7dZqR5X91b9IgUGXKvQpJK5atoXwJCzPQ9LVX6bgmniXKxsNPqUCEN0kdzh
	 mMAQz8C1NRU5TZFlHKerF3nlNaBJ7QVXmHgs1ZrLTespsmD5j0nGQMwzlsi5/tt26M
	 mmRkvq5YoWEN4PnlUKCpk2Xs1U493hWdPrDs+fC/4h+zdveZLiKaH4a8xBHYq8LVgF
	 5DLDU4zW9OuWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C75382327A;
	Fri, 16 Aug 2024 02:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/1] net: macb: increase max_mtu for oversized frames
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172377423374.3091787.10992012609091393104.git-patchwork-notify@kernel.org>
Date: Fri, 16 Aug 2024 02:10:33 +0000
References: <20240812090657.583821-1-vtpieter@gmail.com>
In-Reply-To: <20240812090657.583821-1-vtpieter@gmail.com>
To: Pieter <vtpieter@gmail.com>
Cc: nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 pieter.van.trappen@cern.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Aug 2024 11:06:55 +0200 you wrote:
> From: Pieter Van Trappen <pieter.van.trappen@cern.ch>
> 
> Increase max_mtu from 1500 to 1518 bytes when not configured for jumbo
> frames. Use 1536 as a starting point as documented in macb.h for
> oversized (big) frames, which is the configuration applied in case
> jumbo frames capability is not configured; ref. macb_main.c.
> 
> [...]

Here is the summary with links:
  - [net-next,1/1] net: macb: increase max_mtu for oversized frames
    https://git.kernel.org/netdev/net-next/c/7cb43579641d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



