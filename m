Return-Path: <netdev+bounces-156812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 07209A07E3E
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 18:01:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07CB116A3DC
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 17:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFA9191F7A;
	Thu,  9 Jan 2025 17:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TiUgDqs8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270646F31E
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 17:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736442030; cv=none; b=fYXKIRMs+Smvevwivvp81BNlP/uD02zyla0Fj0DUyNHXVUXbSYkvdYKk0CuxqRnEj0Vh9ytzxM7y0bpvctd7AwPCA/W0ZQZse50zOtmahT0GAR5N3WM88bM+mBTMKIqVi98F1IMc2yJrtvQlNUvdMjjVR5zMQ3O+itQR/ae5wsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736442030; c=relaxed/simple;
	bh=/kE4CP138gTZhMuwGi729ji6f/BLddxaY0IqjowX5J4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AZjRLVVUCheyyzzonWfIbglUwfUhIo4xrdqksQeIT3x+eW06r3BQSRyeOOHxlSF5Q7fRlHRrTPRG5l0fNFQiGgPbLkKNGyGLhQM7SgAHJVRPfs4OQVGgziIaPBdoqp/PW+X26Dq/191OdNyWfRlXBsPrOP5eX9W14mddgp1Dmk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TiUgDqs8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4BD5C4CED3;
	Thu,  9 Jan 2025 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736442029;
	bh=/kE4CP138gTZhMuwGi729ji6f/BLddxaY0IqjowX5J4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TiUgDqs8dBr5l8pN/w1fUFw1Dc2PJp1X4Dv/QrKavMup9Q5R5i5Uoqcr/qsjp4N41
	 V2SSdXkjzG55C8mdP2q5UTl8MzNI0VXYIg8ngjbFgKzYcPOxjxZ363pgJ6aaX7Gxfb
	 /zV20yTE4sbejGZRS6ReUBecnEH9q6anCemwT/OgidkTZbufrSYqTv164HwR4gjrfX
	 87E+ib5uUHHB7XqkXSh8/u7y/pC0BvEt1o4HO3g24w0KkFj5HHD3BcGwxt5o9GaPjZ
	 PWrly+tvUheV9eqEAn9clFkHYgrgJPhr6JwWR+yoA6A8Y1oM7ojA6o8TAZTslgMLau
	 Y95BM9acz4rSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 97EA0380A97E;
	Thu,  9 Jan 2025 17:00:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/8] MAINTAINERS: spring 2025 cleanup of networking
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173644205114.1449021.3681553118929629727.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 17:00:51 +0000
References: <20250108155242.2575530-1-kuba@kernel.org>
In-Reply-To: <20250108155242.2575530-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 07:52:34 -0800 you wrote:
> Annual cleanup of inactive maintainers. To identify inactive maintainers
> we use Jon Corbet's maintainer analysis script from gitdm, and some manual
> scanning of lore.
> 
> Please feel free to comment if you either disagree with the removal
> or think it should be done differently!
> 
> [...]

Here is the summary with links:
  - [net,v2,1/8] MAINTAINERS: mark Synopsys DW XPCS as Orphan
    https://git.kernel.org/netdev/net/c/d58200966ed7
  - [net,v2,2/8] MAINTAINERS: update maintainers for Microchip LAN78xx
    https://git.kernel.org/netdev/net/c/b506668613ef
  - [net,v2,3/8] MAINTAINERS: remove Andy Gospodarek from bonding
    https://git.kernel.org/netdev/net/c/e049fb86d391
  - [net,v2,4/8] MAINTAINERS: mark stmmac ethernet as an Orphan
    https://git.kernel.org/netdev/net/c/03868822c553
  - [net,v2,5/8] MAINTAINERS: remove Mark Lee from MediaTek Ethernet
    https://git.kernel.org/netdev/net/c/9d7b1191d030
  - [net,v2,6/8] MAINTAINERS: remove Ying Xue from TIPC
    https://git.kernel.org/netdev/net/c/d4782fbab1c0
  - [net,v2,7/8] MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
    https://git.kernel.org/netdev/net/c/d95e2cc73701
  - [net,v2,8/8] MAINTAINERS: remove Lars Povlsen from Microchip Sparx5 SoC
    https://git.kernel.org/netdev/net/c/d9e03c6ffc4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



