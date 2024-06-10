Return-Path: <netdev+bounces-102250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59BE290217F
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 14:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CCCA5B26AAD
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 12:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D33C180024;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pw8BhUag"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA9E7BB13;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718022033; cv=none; b=gTYJ5Pu5jTp5YqH/pWZOjgO56XZGvnhJ9CHpfJTiFIb2jUYcYMOIyNMDTEyN7xvjBG9u831dWz2hkg2vP/g0pVwm9NLcvjWZcXRdwA1Ts4W64YOEoI0UpPkIfX0OpUrW0rbWXsfmCqVTNrz1kPjVWFNjiFsrq2IBSqqRaSJcUZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718022033; c=relaxed/simple;
	bh=1OuZml5USsmYoEs1/r0Su7k3UDbGKKRBRcGAZhqHhl0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jUse/dsQJADrqcGm2YNIjq4wyegEeTL9q8bXv040QiSa2m/GFYfgrxEBGH5oFqeTfrCImQl1/GshiKoJeAfptarmGaQ9HHg6ylNNIRPlZTqWY3pgNvUFK//BDOI/zMQm366mTrapjgxwuJRmw57/4aP9q+oDJEn1fetPIJVvi2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pw8BhUag; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 51879C4AF49;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718022033;
	bh=1OuZml5USsmYoEs1/r0Su7k3UDbGKKRBRcGAZhqHhl0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pw8BhUagEoI3utHICFWxDz6/0xQHsMh+/SjpRlAY+T63opiX2xm1qwcLrx95R5voE
	 /mxzIj+Upk/ckkovRiw7b0+pKwKdfgaGn8dsB5OJxouroNrjmpXaB5P2qlcVKSNb8C
	 IZsZlsXaRQf4c7zX0iQMo2QPywxBlg4NH5+WX4yZc0a339E/bn9behep0lHf7eq1V5
	 M5gLsr198+MwnUzl8UobuLVaIwKvhHBed7DeUJLjZ2lxhGHO306Wle0woT61QRpjdM
	 OLeLB0R8F8dAjJph4X4lhGUg10jjLTz0z5fnB0xvv54OgdSRLf4UbR8Q2GgrN7in+1
	 G4EUK6zs9pp5w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 417F7E7C770;
	Mon, 10 Jun 2024 12:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/1] net dsa: qca8k: fix usages of
 device_get_named_child_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171802203326.2008.17101566039398967862.git-patchwork-notify@kernel.org>
Date: Mon, 10 Jun 2024 12:20:33 +0000
References: <20240606161354.2987218-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240606161354.2987218-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
 f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  6 Jun 2024 19:13:03 +0300 you wrote:
> The documentation for device_get_named_child_node() mentions this
> important point:
> 
> "
> The caller is responsible for calling fwnode_handle_put() on the
> returned fwnode pointer.
> "
> 
> [...]

Here is the summary with links:
  - [net,v2,1/1] net dsa: qca8k: fix usages of device_get_named_child_node()
    https://git.kernel.org/netdev/net/c/d029edefed39

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



