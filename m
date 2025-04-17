Return-Path: <netdev+bounces-183568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CA03A9110F
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 03:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D33E45A3353
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 01:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C34B2185935;
	Thu, 17 Apr 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uhUjR2St"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9807C1494BB;
	Thu, 17 Apr 2025 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744852829; cv=none; b=LNUwNa1ASQJ5pEgIJqyUnvV7n0neEwHnmIUkOk6XKupXl5gsuINXsovGd2AuO7ICOXmJDJDKAXz7m6EHsRDhu5/Vv4Xclw2P9i+BSd8wGfMyFePcA8TyxotPFw7olfwtzBTttfgh0oDWGcptK0DsB/ARbPOkomK48q53ZwrhE5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744852829; c=relaxed/simple;
	bh=HrsgfIKn+UzmmpDCQZdqj2kTeP/jZdyNwEi1kO/oBaw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=atYZKBuBMdqroHachvEDfcx4BYkSmL+noU9ANEMWgz24ANVui8pb4cjRJPRrRqkrnM6Kxb8ezwGbpbJ8IDB/Ot8UBvoznQSnolZSRQCuIPjxdxce/Yq4fQ562+u4fNfoSJQCtaUHRhT1Tiqecu8LxDdpXBJgK1ik6Apjl0W6Sb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uhUjR2St; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67CDC4CEE2;
	Thu, 17 Apr 2025 01:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744852829;
	bh=HrsgfIKn+UzmmpDCQZdqj2kTeP/jZdyNwEi1kO/oBaw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uhUjR2Stf0vSLX7bXyHEMMy/uJ5+aqUWEAjhUJIoJdzqtrdg13mibdm1EMS0EaxHE
	 MGTNCWm0d6PRxx1BsO5fRiso3FNeMoKno9hhCgjA8D3T/yfyBU+rp32Jf8zVm1Xt3v
	 JSk8kR8mSoit59dWFgFcMO+j0CwAyCCCfOepNa4dOOdFnjA/OFDBRLt6gAeGDsRHD+
	 UshvX9NHoelpPSbeHvOUCaA3tIQFmUdCo1+DeROLzr8C/cN7IpSI9FubeDlABFrrXG
	 OQKCzXST3SCKVFogtIebyEx3o2XsYAgj33y3C0tfWkN1Bgi7soL6ZcCbIH3HHt0V5B
	 kRpMVe2ZHUYVA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DCF3822D59;
	Thu, 17 Apr 2025 01:21:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: b53: enable BPDU reception for management port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174485286700.3555240.23676030459979617.git-patchwork-notify@kernel.org>
Date: Thu, 17 Apr 2025 01:21:07 +0000
References: <20250414200434.194422-1-jonas.gorski@gmail.com>
In-Reply-To: <20250414200434.194422-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 22:04:34 +0200 you wrote:
> For STP to work, receiving BPDUs is essential, but the appropriate bit
> was never set. Without GC_RX_BPDU_EN, the switch chip will filter all
> BPDUs, even if an appropriate PVID VLAN was setup.
> 
> Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
> Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] net: b53: enable BPDU reception for management port
    https://git.kernel.org/netdev/net/c/36355ddfe895

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



