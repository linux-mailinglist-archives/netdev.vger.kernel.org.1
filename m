Return-Path: <netdev+bounces-38532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6D87BB569
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 12:40:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C1A282226
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 10:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D97FC14265;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g7ub6xXT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AACA628E3
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7CBD7C433CA;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696588824;
	bh=9XVJLQXgaic23NsLf1Cw4UmqjclTlbhXRwulqHp9LhI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=g7ub6xXTUo+aFjpZP3LX8wkIuS9p378vGUP+SxjEelXNdm7+L09ndltNEQIVneU/b
	 n8F41U+v8FoShVqvYpaKoiI8KUWXd0H2v+ieslG+CO422vYVe59Xd2h7gm4JvW3cmc
	 njdH6MB7doCRO/wMPAqee71bW5U0nADDPVgJi/N6X6sWg9ql5jzWPJRzEvMreYhUxG
	 hliFDDj/gVaZV1z8CaB5to9V8UDPFhq8Aj7hGtm5Ph63mRQelM4OXdG6ys2QvBrLcD
	 GQ/jUDcHOPvJFy5HBVjZYp1RqpUIvjW7uZIvveHFaVtED3I/FTa5KxV8jZl4oeeQoN
	 saP1mLmyUB7tQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5AFEBE11F50;
	Fri,  6 Oct 2023 10:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: phy: dp83867: Add support for hardware blinking LEDs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169658882436.10984.4124464343607752178.git-patchwork-notify@kernel.org>
Date: Fri, 06 Oct 2023 10:40:24 +0000
References: <20231004084026.2214537-1-s.hauer@pengutronix.de>
In-Reply-To: <20231004084026.2214537-1-s.hauer@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, linux-kernel@vger.kernel.org, kernel@pengutronix.de,
 michael.riesch@wolfvision.net, alexander.stein@ew.tq-group.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  4 Oct 2023 10:40:26 +0200 you wrote:
> This implements the led_hw_* hooks to support hardware blinking LEDs on
> the DP83867 phy. The driver supports all LED modes that have a
> corresponding TRIGGER_NETDEV_* define. Error and collision do not have
> a TRIGGER_NETDEV_* define, so these modes are currently not supported.
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com> #TQMa8MxML/MBa8Mx
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> [...]

Here is the summary with links:
  - [v2] net: phy: dp83867: Add support for hardware blinking LEDs
    https://git.kernel.org/netdev/net-next/c/1a4890878241

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



