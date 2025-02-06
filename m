Return-Path: <netdev+bounces-163487-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E24A2A5FC
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 11:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 158CF167BEE
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 10:40:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891E0227572;
	Thu,  6 Feb 2025 10:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqm3H4GK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6464822688E
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 10:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738838405; cv=none; b=HZe5+BQiOVKJ5tPu6LiIEKIaj3z+xKNGVPK8Hbr33C4MJTpm7XCucCT0mI3mY87XYo0Zgyrw+gRwmYAy+hy79uwomQ4lmX+W7mgR7SbY+vJXOcc7Im4zallHNIuwfU+hgHHcyuB40lH4G5w0nzbK3iAvXbM3qOJErFNLoEXLLcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738838405; c=relaxed/simple;
	bh=UkZgPuWzRNlKmGbHOVxfshbs2hKIHKbr21MhYErTri8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XDPpQI2nv9VmqmYKUxVX/zwt1VXo9GLLcI3w3/2NqNWHq+G7aPnKxOQsyvdejnHAvCB2MuLYWlH5wXalLEZ9njGcieE0i5jH5Ikdh7w5Qlr0bR5Ns7+sRh0M5K3DtA3HWSgD/f2l59RKKUzK6IKdT2rIYcNQzTmc86eR8Iivom0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqm3H4GK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2956C4CEDD;
	Thu,  6 Feb 2025 10:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738838404;
	bh=UkZgPuWzRNlKmGbHOVxfshbs2hKIHKbr21MhYErTri8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Lqm3H4GKMF25X1nzFMZjUv3T3vVCDsltuIIP7NtZgUKD78sO1JKLtJhwHPR4kKEs0
	 djByDtt9nktg9p55/CmImCi2D2qqs6xmDIDaokL1HGcUeb8CHZ+MdS4Xeoi7uyEhNY
	 YWLva/1WBZTFrgSLIM6RjNnYzAJbpKgbbdgJIwhHWvjzqPFiaHL2/kJHWHcueFSYpq
	 KcuNaCbbRfM4fbKAeiJ9D+CLZjbXtEPs9jBBIIut+pRF5a9pTn4u6K6+NbmsxLGu6l
	 zii5cemKkNAAOcMRn6MVklyKbZtPLSjaLN/DGPcF2BuryFy1rPFNaw3k4NANUWTaFQ
	 bzKPfcGuxzHLQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBB1380AAD9;
	Thu,  6 Feb 2025 10:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] tools: ynl-gen: don't output external constants
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173883843252.1427982.13885311367700150420.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 10:40:32 +0000
References: <20250203215510.1288728-1-kuba@kernel.org>
In-Reply-To: <20250203215510.1288728-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 cjubran@nvidia.com, donald.hunter@gmail.com, nicolas.dichtel@6wind.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  3 Feb 2025 13:55:09 -0800 you wrote:
> A definition with a "header" property is an "external" definition
> for C code, as in it is defined already in another C header file.
> Other languages will need the exact value but C codegen should
> not recreate it. So don't output those definitions in the uAPI
> header.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tools: ynl-gen: don't output external constants
    https://git.kernel.org/netdev/net-next/c/7e8b24e24ac4
  - [net-next,2/2] tools: ynl-gen: support limits using definitions
    https://git.kernel.org/netdev/net-next/c/fa796178e5eb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



