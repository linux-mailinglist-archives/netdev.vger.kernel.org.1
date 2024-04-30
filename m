Return-Path: <netdev+bounces-92450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3148B7717
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 15:31:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC8D91C20F47
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1B17167B;
	Tue, 30 Apr 2024 13:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBgDothg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7415817165A
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714483832; cv=none; b=h9PrX/CNTVt90sFBGOJHU4ryg8jLeFE7JpkK+mdFE6Sq6RP0BSUZv63Cmp3cW9MY5IVkSZHJm4eCfg7V3qtpJ3+TE2MvySpke6Yuwn9QoptPdJr/9LIgCKE1goMEO5tBzHZjL6Lwm5K7A+Jqhm1PqUe6Kn7EI6Qh+1m0HHWadEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714483832; c=relaxed/simple;
	bh=7aDS4Rk4a6ngfgXrqffWf6OvoFlNs/DwzAA9NJ7LN0A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MGxXLPDwKPJFsbSHoj1eRBpAZNO3VFDYrsP8K+vRiZjy3RYBD5k9lwZdSb8RfBuyffN85UbGY4V4FvQCQBCyxK8yl5y9PAlgHwZlQT3yBoqrxu+QPlQk/tgn+NGJ2BU15yBX8EW1OxGipu8cnmxfNI2QPtn0yo6q2bS9j2RugSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBgDothg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB770C4AF18;
	Tue, 30 Apr 2024 13:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714483831;
	bh=7aDS4Rk4a6ngfgXrqffWf6OvoFlNs/DwzAA9NJ7LN0A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gBgDothgIcGnr2EboovVmDUxg6HKt30IENgSGDcxceqfhC1jMKCUsv+0acudWfA6K
	 dNCnLBT83Vvgt9X/TP7+mnsSuZG5dEpnw0BBGGtwMmw9pWnIbTEPXFh4SOq2u5nxYw
	 bLMD9A50hkM3JvDWBJztLUB4nWp3WQGMEIhqE6vCWqZYWRD1rxnc/ZWJ2CQa6MY7ev
	 rp3kMbfx5aa02lRt5WQKDkfuvrXKh6UXAqdtk0PCdEkyb05KYdpEyYON6EZIaR62+J
	 0I//ker+5ql42bi8puAlpsC2sG2CNOboxXDzll1k/YHHhhNPB8YaoXkxZD1ftcxzkv
	 REkhqzEDhKJaw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC50DC43617;
	Tue, 30 Apr 2024 13:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: add debug print for empty
 posssible_interfaces
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171448383089.15823.16620547598211880007.git-patchwork-notify@kernel.org>
Date: Tue, 30 Apr 2024 13:30:30 +0000
References: <E1s15rq-00AHye-22@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1s15rq-00AHye-22@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 28 Apr 2024 15:51:02 +0100 you wrote:
> Add a debugging print in phylink_validate_phy() when we detect that the
> PHY has not supplied a possible_interfaces bitmap.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>  drivers/net/phy/phylink.c | 3 +++
>  1 file changed, 3 insertions(+)

Here is the summary with links:
  - [net-next] net: phylink: add debug print for empty posssible_interfaces
    https://git.kernel.org/netdev/net-next/c/0041cd3799e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



