Return-Path: <netdev+bounces-226799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EC7BA538E
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 23:31:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BC123BF7CE
	for <lists+netdev@lfdr.de>; Fri, 26 Sep 2025 21:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E0A30F53D;
	Fri, 26 Sep 2025 21:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kb1kZsGm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE64D30EF81;
	Fri, 26 Sep 2025 21:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758922219; cv=none; b=fJRa3CdB+/UI892up2DaLbDdKXHmjW7uTl46JKaIrfrCibR1oQGNpEJWMWhYHRk2hSxIWZY3g0+5kLAzUJchObkS0mi6iUAdd+3hZ1T4xo/3KbnwUcU0gekX5W0GtrbDP3OGo6lfvx+j0J+0mBVi9GzLnXJcXhwfKksYFkN9JCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758922219; c=relaxed/simple;
	bh=vJRvNHlUyxJM2/QCBFGJK3xtYb9Txki3VIvUAgKBbuQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aNgU06qAvSIM2fVFix5Otw1YsH+GjOlHpljLn94HN49p+UvlBXALPBOX4tUP6br3iQb0fxO0s4jo/IjhPU9VB0VA4pql4lxN5t1HFUTZ3iq14n+DUSYSLekXn/Dnt5AVjgQvJ1Nqnf8/4eAuDLk0tr9Cd3FMSEEFKiIVsE/sy7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kb1kZsGm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77CC2C4CEF4;
	Fri, 26 Sep 2025 21:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758922215;
	bh=vJRvNHlUyxJM2/QCBFGJK3xtYb9Txki3VIvUAgKBbuQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Kb1kZsGmnvwufEzmJkk6u/CRYBW8dFJBgDp24E9B8fatIlQl9fK03C3m35121z+3G
	 Mjrtj7poay6kow5siv/7CALzYQht4zXz4cz/dNAL3bA0g9+ypU0UJVaqo33jJ4UqAL
	 iXMxokZvp9LYi11HK8qbsBUtzzmkxgCP156CGst1uffyI9f6E+iRd9ORja1199EAe4
	 8PNn/miI9zKcZ/pKhkX0tAjeKK83H9TeQW1URmWWG6eHJCHEzJY0uaVaehFkasZxrE
	 yTfQCLZpYZaulbs4gD9iFGHcyBoALSKEQkXP8iMQqACKFRde5AyUGNsVUmSjBMCbC9
	 0ys6vcTvB8peA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADFA39D0C3F;
	Fri, 26 Sep 2025 21:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dt-bindings: net: sparx5: correct LAN969x register
 space
 windows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175892221049.64518.18391583917554709725.git-patchwork-notify@kernel.org>
Date: Fri, 26 Sep 2025 21:30:10 +0000
References: <20250925132109.583984-1-robert.marko@sartura.hr>
In-Reply-To: <20250925132109.583984-1-robert.marko@sartura.hr>
To: Robert Marko <robert.marko@sartura.hr>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 Steen.Hegelund@microchip.com, daniel.machon@microchip.com,
 UNGLinuxDriver@microchip.com, lars.povlsen@microchip.com,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr, benjamin.ryzman@canonical.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Sep 2025 15:19:49 +0200 you wrote:
> LAN969x needs only 2 register space windows as GCB is already covered by
> the "devices" register space window, so expect only 2 "reg" and "reg-names"
> properties.
> 
> Fixes: 41c6439fdc2b ("dt-bindings: net: add compatible strings for lan969x targets")
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> 
> [...]

Here is the summary with links:
  - [net] dt-bindings: net: sparx5: correct LAN969x register space windows
    https://git.kernel.org/netdev/net-next/c/267bca002c50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



