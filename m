Return-Path: <netdev+bounces-109581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331B8928FA4
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 02:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 638431C2197C
	for <lists+netdev@lfdr.de>; Sat,  6 Jul 2024 00:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E27C819;
	Sat,  6 Jul 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEvUM6ro"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537BC360;
	Sat,  6 Jul 2024 00:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720224632; cv=none; b=e35O/d+6eBuiHV96557bwjMO2D80Jugd4beigtpr7QOvuYqwvRwKa5Y8hFfK5AWRKhJYAsn9Pft6Sw3vre4mYEQW0WxXpFXrS2eEl8QWH5hz0mybIJ0BCe8Tc1GB+FaIwLrDkYpbj0sLtM3fzdZ8y4phhmf6giZjVRzcpSrAGM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720224632; c=relaxed/simple;
	bh=EyrESrbQ0zDI+Y5SHe0vRDpivvBCBKo/evBIfAJkHQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o0gTQnYKyEx+r/3CbiXPUyTWeQNjnJ+TSsyppQ85Q6ofFanwNk3fInkyF4ETjheRX2e6209PgKXaA53BBf8RTYNrLdcWyUH3AsEJHWWTZqUjAkZFdaiMFq5owXvOonUT711TYu1sOSG0mA0Ajq1clp4qc/63n76aWh7iYPS9KQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEvUM6ro; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B1722C32781;
	Sat,  6 Jul 2024 00:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720224631;
	bh=EyrESrbQ0zDI+Y5SHe0vRDpivvBCBKo/evBIfAJkHQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SEvUM6roPRaywIs4vOcoWT9V7kZ+nTaqim3WHMUpxEeElcdsE5ywGprx2V1ibri7H
	 MfOpfqw3imtu3WOUJx5tbkQZRnFXS77tjI0s1+71edKcFI2DOmc6woqgUwONOD0rTM
	 ON7kSd7uADXJxrm+7tR7HJKroHqDEp1ZTuLro3lUH0BEVOBKa8ZmMlzm36V7/6RJ85
	 rY5i9tspPtudIHLQ17A5of0cjupgzZnOwt//sAKX2v1xuVp7iAvDXj9H0Xfe8IH87y
	 0FtuSmUr3k6YhrLlFxpRf5396t9srITH79Iu1lcF1BEFbitYKfE1NvVL/oA3j+uEop
	 IwPYJQl6121bQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C541C43446;
	Sat,  6 Jul 2024 00:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] net: constify struct regmap_bus/regmap_config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172022463163.12418.2723355853775989531.git-patchwork-notify@kernel.org>
Date: Sat, 06 Jul 2024 00:10:31 +0000
References: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
In-Reply-To: <20240703-net-const-regmap-v1-0-ff4aeceda02c@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: andrew@lunn.ch, f.fainelli@gmail.com, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 danishanwar@ti.com, rogerq@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 03 Jul 2024 23:46:32 +0200 you wrote:
> This series adds the const modifier to the remaining regmap_bus and
> regmap_config structs within the net subsystem that are effectively
> used as const (i.e., only read after their declaration), but kept as
> writtable data.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> [...]

Here is the summary with links:
  - [1/4] net: dsa: qca8k: constify struct regmap_config
    https://git.kernel.org/netdev/net-next/c/8dfbb068a4e1
  - [2/4] net: ti: icss-iep: constify struct regmap_config
    https://git.kernel.org/netdev/net-next/c/7f805f6396d4
  - [3/4] net: encx24j600: constify struct regmap_bus/regmap_config
    https://git.kernel.org/netdev/net-next/c/9969163c4472
  - [4/4] net: dsa: ar9331: constify struct regmap_bus
    https://git.kernel.org/netdev/net-next/c/3b05c7995cae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



