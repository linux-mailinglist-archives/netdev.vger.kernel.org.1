Return-Path: <netdev+bounces-197298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B18CAD807F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 03:50:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F45B3A5A05
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89A21E32D7;
	Fri, 13 Jun 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QIYSbhH3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADC1E1DE7;
	Fri, 13 Jun 2025 01:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749779401; cv=none; b=SeDWN6xRzM6ykqMd5qa36Q3OuKSm9TKQCgnHT5T+mCF65QCC2CtVcaS6kDxkKfkTbgNJtCiD9OOKhOYLVb7UOa1U8msjTT+5LOg9HmcQXxIcGWQh3S5CDAFar+a5y/Sr1iiMuBBlMcKSmKmrGDUwIeSIQYnzjti47RKaLHd2Nt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749779401; c=relaxed/simple;
	bh=UcydmQa51vACTBdzRyC4Efyxmq9tVi4S+GDuV6XI0BM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BMpSrgyez7V9gxrsy2h/7iBet0qecMcmpAGLQbBN1Wn/t9bRlvPyKSM7lLBQy+w5UaHOdPpxUDjrqphrAdHYFvt12d7Tcy7qPH0eGqi4QnPFNrEAxET5kFtPV9G8l5YJ7bCOhCwJ96beKmpSG4g6XhLeWrkFAqDMxHADMqonSPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QIYSbhH3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3917EC4CEF0;
	Fri, 13 Jun 2025 01:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749779401;
	bh=UcydmQa51vACTBdzRyC4Efyxmq9tVi4S+GDuV6XI0BM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QIYSbhH3xVPLGne8IW3nV0YPBeO5gWQtq0lWZlSFDSBVMUCc41i/8BFnoOEE6g5XU
	 ifJ7zPzJzJY3V5O/2WWdXa9iWFbwVsp1BtRxaoBkJ7660cK2VSO8zE9cjH4rkHh322
	 eBG0akwkKG2lJFpU7d9fZxlMCqeZbHaTb7IMGnnTT57pwN7Tlt+IQA71azu6M10Ezo
	 7z4e2JVzaXfuV5tZHBW4MFMEb4LaIVzJJrMcRPgWrg2wkrJYDbr4qdqO5jQyF71B9t
	 nZ14aomoFAJz/ne5KXFcXwVZB9TcS7IPA3eCrdUGGObwVA+Iy1HFYNrlEydYbNC6je
	 DFSo+EmJ6RURQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BA839EFFCF;
	Fri, 13 Jun 2025 01:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND] net: mdio: mux-gpio: use
 gpiod_multi_set_value_cansleep
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174977943074.184018.17302036184025742769.git-patchwork-notify@kernel.org>
Date: Fri, 13 Jun 2025 01:50:30 +0000
References: 
 <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>
In-Reply-To: 
 <20250611-net-mdio-mux-gpio-use-gpiod_multi_set_value_cansleep-v1-1-6eb5281f1b41@baylibre.com>
To: David Lechner <dlechner@baylibre.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linus.walleij@linaro.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Jun 2025 13:11:36 -0500 you wrote:
> Reduce verbosity by using gpiod_multi_set_value_cansleep() instead of
> gpiod_set_array_value_cansleep().
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: David Lechner <dlechner@baylibre.com>
> ---
> This is a resend of a patch from the series "[PATCH v3 00/15] gpiolib:
> add gpiod_multi_set_value_cansleep" [1].
> 
> [...]

Here is the summary with links:
  - [RESEND] net: mdio: mux-gpio: use gpiod_multi_set_value_cansleep
    https://git.kernel.org/netdev/net-next/c/ed2cfae6b845

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



