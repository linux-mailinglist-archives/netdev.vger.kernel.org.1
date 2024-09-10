Return-Path: <netdev+bounces-126944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0659733B1
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 12:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6619F28663E
	for <lists+netdev@lfdr.de>; Tue, 10 Sep 2024 10:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ECC196D9D;
	Tue, 10 Sep 2024 10:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q0GdzVSo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A78144D1A;
	Tue, 10 Sep 2024 10:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725964231; cv=none; b=gNoz2kkjgKrdGe4juMrcV4WYB49kMjzHU7I+47YO2O0ABnvC2pR/g4wJ/7+6aOQHNv8eF3ofVXYRCz0hxgZRjKDX8EtsuH5R+LkYRkSspYQ882+eSLhyHU2EF7DiCajwYon+aNmC/nDn+leruoHHiAdGsjC7s+aqV30XRFvZYbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725964231; c=relaxed/simple;
	bh=Ur99redDcfVEexr1zqlJXXQAm3Mqjs7lzgiNSaUIWa8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ifkARl8VPQo03gF6lsTEKxNtvKjaXQB/LBdvm/FwJLgfnqZO3Uq2JMvtdtraae4SbwW/V6kBro2uejoMXYx1TaNJ11k2X2bKLWvxpqit62KP1EvU6lZYmzoF8km3ph18SHdAAA82Mo2/Zc6Nt9biGcPYCCBrAOFct8U2CRgQQ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q0GdzVSo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0E9C4CEC3;
	Tue, 10 Sep 2024 10:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725964230;
	bh=Ur99redDcfVEexr1zqlJXXQAm3Mqjs7lzgiNSaUIWa8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q0GdzVSofNv212OKNZgYqyr5MdSYDtZW4JzFQkXP0c/AGSBt2X17nUGWU4r9VkyHU
	 NBVsrkTe1/VTk+WGW7sHW4LAkAO7PG+1v3i/E/eWaRm//pnjGc/LmQSHQEq0zdMySC
	 Qc+Spsrz1gq10dyFG+9Fd7TEuuPCGaiiNAZi2SIvxI+1wPSnTEunneTdjpqU2HrJOH
	 uMNOXyeumntCeAaP/A7CTFVa7SPS1/hTZ2m12j9QXlEyOErGSv7UK4if85kJFgQCbS
	 Q9NRAftKys2ogINfHZ3xNRrJxwxHDqp+Be4avBhUqvuI/VEqUjzEzkmNUdY+jVrBI/
	 oirpco21ecKNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA93806654;
	Tue, 10 Sep 2024 10:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: mdiobus: Debug print fwnode handle instead
 of raw pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172596423149.208623.7074249487366470815.git-patchwork-notify@kernel.org>
Date: Tue, 10 Sep 2024 10:30:31 +0000
References: <20240906062256.11289-1-ada@thorsis.com>
In-Reply-To: <20240906062256.11289-1-ada@thorsis.com>
To: Alexander Dahl <ada@thorsis.com>
Cc: netdev@vger.kernel.org, calvin.johnson@oss.nxp.com,
 florian.fainelli@broadcom.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  6 Sep 2024 08:22:56 +0200 you wrote:
> Was slightly misleading before, because printed is pointer to fwnode,
> not to phy device, as placement in message suggested.  Include header
> for dev_dbg() declaration while at it.
> 
> Output before:
> 
>     [  +0.001247] mdio_bus f802c000.ethernet-ffffffff: registered phy 2612f00a fwnode at address 3
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: mdiobus: Debug print fwnode handle instead of raw pointer
    https://git.kernel.org/netdev/net-next/c/525034e2e2ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



