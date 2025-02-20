Return-Path: <netdev+bounces-168047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F55A3D32F
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 030EE3A8044
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5771A1EB190;
	Thu, 20 Feb 2025 08:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oA3toarV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9F01EB189;
	Thu, 20 Feb 2025 08:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740040199; cv=none; b=Opu9tVOSGAbBRkjuWYqO9Jc4nbYMYwl+W58YzsL2adPAK0b+uXrbyRlMqRdMezF9URBFBbsRxKxPMkmYcggzIDB0xJa91wAn1U7wmCeSsMygRsnEyHD1fpuXXIMZFlL6OMZicBkkimmwtbqtaPmIWu/YREBaw8jeSzpadGrK3o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740040199; c=relaxed/simple;
	bh=649fmmAckJtxvn8+vL75y25cRWSc5bs5KxYHmJ1yOpg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jq0yQCuJwtTIz6NzguCb4MUQTHnLXXznraXXgVF6gjEuwheqPdt8eEwIZDPEY7Hk4u/N5cVIQ57A2QCnxw4qgRecpUehwb+LTCrU1WmRm4EB38+dNfqGshzhusB85F6zitXfQs545n0LxB9O3th7UbCitS/pUunpfKbLiFDFpgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oA3toarV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E2BC4CED1;
	Thu, 20 Feb 2025 08:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740040198;
	bh=649fmmAckJtxvn8+vL75y25cRWSc5bs5KxYHmJ1yOpg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oA3toarVAuJk2LHZAZKldIRQWCA4CuBaOfPcoagwTAYwYtkP8Ej+10fTiP8YCrSy3
	 l76beFxXcmlzJs3dybFrxTFaMKASlGAp7UiiKnfOFzuITkPjaPEi+uOxbgw2SKED0A
	 bHdxFxfJeY3smckD8e86knrPv3dwb1CJ0qxsu4+YeI3b+Cz3Ht9N9QBWcaY3aHppJi
	 iDEq8caRmQYJ3zUXSqlBUfW4qRb3XEd//Z3pwzCdc6hJsLkzty9lIbADCgEy8LVEZM
	 XdljJ+0IxEbDlOmtdPKDPv8j7PqAuwDQrHYpRMxMl36SdhClyegKUzDElaHZHagmuR
	 F1nx0aslHM6bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 717F4380CEE2;
	Thu, 20 Feb 2025 08:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: axienet: Set mac_managed_pm
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174004022926.1208713.2604562776709725855.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 08:30:29 +0000
References: <20250217055843.19799-1-nick.hu@sifive.com>
In-Reply-To: <20250217055843.19799-1-nick.hu@sifive.com>
To: Nick Hu <nick.hu@sifive.com>
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 michal.simek@amd.com, linux@armlinux.org.uk, francesco.dolcini@toradex.com,
 praneeth@ti.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 17 Feb 2025 13:58:42 +0800 you wrote:
> The external PHY will undergo a soft reset twice during the resume process
> when it wake up from suspend. The first reset occurs when the axienet
> driver calls phylink_of_phy_connect(), and the second occurs when
> mdio_bus_phy_resume() invokes phy_init_hw(). The second soft reset of the
> external PHY does not reinitialize the internal PHY, which causes issues
> with the internal PHY, resulting in the PHY link being down. To prevent
> this, setting the mac_managed_pm flag skips the mdio_bus_phy_resume()
> function.
> 
> [...]

Here is the summary with links:
  - net: axienet: Set mac_managed_pm
    https://git.kernel.org/netdev/net/c/a370295367b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



