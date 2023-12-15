Return-Path: <netdev+bounces-57763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FAD814099
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 841C2B22016
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9B846B1;
	Fri, 15 Dec 2023 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXh2emIF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620AC79DB
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2C62C433C7;
	Fri, 15 Dec 2023 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702610425;
	bh=8qLw4bLujG74Xv39mrIzHYbaxHiv6opQGDyKNS3OYt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bXh2emIFsDuNGkckchIPehvsvVLyA9J+oM7cXphdVQCqYvA5j3Lc5u0LB1I4w/iwV
	 Dg34SFD3eQ4ng2pm2KUmM0x985NCLFbQw2qZhnQFUvk9SVC8KTL3kE+barkvKbSWjE
	 QJ2hsta+qy5/KZJnYcblJcMU8JWQhXaZ4cSkzuGLgLQscRhOZQiY96fLucUouS7aOc
	 yFlGt/BllKvwi9DQOgkDOYvHOIw4EP/vx8koQ010mZYf8K6AS0geeFKBmVR6kbnEjF
	 CEM9IJ1HfToOMqchrpaeSKMHnH0qCXI16QLt3mtD1w4REsuTJ/01Isrg2A860CA7WD
	 SX1pfZ34+M7KQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CED59DD4EFC;
	Fri, 15 Dec 2023 03:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] i40e: remove fake support of rx-frames-irq
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170261042584.8096.3252535841568953390.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:20:25 +0000
References: <20231213184406.1306602-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231213184406.1306602-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, kernelxing@tencent.com,
 himasekharx.reddy.pucha@intel.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Dec 2023 10:44:05 -0800 you wrote:
> From: Jason Xing <kernelxing@tencent.com>
> 
> Since we never support this feature for I40E driver, we don't have to
> display the value when using 'ethtool -c eth0'.
> 
> Before this patch applied, the rx-frames-irq is 256 which is consistent
> with tx-frames-irq. Apparently it could mislead users.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] i40e: remove fake support of rx-frames-irq
    https://git.kernel.org/netdev/net-next/c/8d182d5869b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



