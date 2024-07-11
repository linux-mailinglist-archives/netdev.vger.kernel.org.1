Return-Path: <netdev+bounces-110763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 888F992E37A
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2CA1C20E16
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 09:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BAD156971;
	Thu, 11 Jul 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XLytW7F4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E3F153517;
	Thu, 11 Jul 2024 09:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720690230; cv=none; b=DCD53WuZZBD8lX7g83EIfj5Ei6WKZ6TzVCUsM0cUJlXjsnE6o2oJdIvtzGEG7/AMdo36vCPOKQVnDXADxiO7wOcEuCdQFd4HKoabyrnXweosDs9U5BnIEZuC7jpjcrAGDiv7q1DGxZ0Maldr/G8k7QxDu5MP2qwfCMaIquU4wmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720690230; c=relaxed/simple;
	bh=fwng61uZXdkHe+npWT2qcYK4wFUVGgK5LbzuriidjeQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ssd3tiXe/KT3vb1Ef1dCY6wbISsaSdK1Hs9SzYngvaylNbZJY73/qGFnnkc/jQTSj6Q0JZGlfIbYFSWoIRMrMJ1A8/vC0tlUSjZW0oXiXQjh/jcWWgpyHBK5/X8jBeqRifZF/i/VAXhh79U4ZmvGDRDi7QE4zn6ta/vR0zAG4cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XLytW7F4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AEE6C32786;
	Thu, 11 Jul 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720690230;
	bh=fwng61uZXdkHe+npWT2qcYK4wFUVGgK5LbzuriidjeQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XLytW7F4L6uEf1J+XfUzOBDuyFXDt3iyFFnjCmQKNTTDpyKpcUUOwhleqwLOpTAPj
	 uLi6Xn1Nvzw/DeZGCo9RiWFRGkJMH5PelYdbocm8PdIvaXPj531HwhWHDfXYpUIaNf
	 +CmMU5ANsH8kFEys7euAC5FRwesCwYWwKTcDegCNaf4HmEqhgvu9f3KNiD3fnbbD9s
	 PK4p+K3nGwaaT8HVfQIubz6ETHXV0uop9Lzhlj4m/nrELBbRr/tyYP1TRNEpoYb3EP
	 2DBAhljCQpshcZlMYl2VfIkOSuprK4ZGyO/QB2IYwm3UyFDsWZYHgnXsRu+9MPVMzp
	 3NlezJLrqrQow==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 44437DAE95C;
	Thu, 11 Jul 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 1/1] ethtool: netlink: do not return SQI value if link
 is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172069023027.13694.7048522125418716493.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jul 2024 09:30:30 +0000
References: <20240709061943.729381-1-o.rempel@pengutronix.de>
In-Reply-To: <20240709061943.729381-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: mkubecek@suse.cz, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 vladimir.oltean@nxp.com, andrew@lunn.ch, arun.ramadoss@microchip.com,
 Woojung.Huh@microchip.com, kernel@pengutronix.de, netdev@vger.kernel.org,
 UNGLinuxDriver@microchip.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  9 Jul 2024 08:19:43 +0200 you wrote:
> Do not attach SQI value if link is down. "SQI values are only valid if
> link-up condition is present" per OpenAlliance specification of
> 100Base-T1 Interoperability Test suite [1]. The same rule would apply
> for other link types.
> 
> [1] https://opensig.org/automotive-ethernet-specifications/#
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] ethtool: netlink: do not return SQI value if link is down
    https://git.kernel.org/netdev/net/c/c184cf94e73b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



