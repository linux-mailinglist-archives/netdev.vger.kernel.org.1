Return-Path: <netdev+bounces-17306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0D4751215
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 23:00:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30811C21057
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7211EDF6E;
	Wed, 12 Jul 2023 21:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051EADDC8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 21:00:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DD65C433CA;
	Wed, 12 Jul 2023 21:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689195620;
	bh=Nz6wZZXVaJA/3DPRWckZYPO4S5CYZoHG6/2wBW8UXk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=omhUYudrdh/IUqeZ/Pe+jpOXQi9REV3sbt6ANi+ZxgmwgIPG5152UWDBFxdKeOh8l
	 6kbVFkqJztPnCpLYMdCQ1weczBYaM6LTIbW7PnJWW2SWA9FeXdxyaFZPGtVRx46Ar3
	 n0yjNjipp/knwubM2HSFsHurSnt5krgtY1SfKd/OoIYqR1cuyC4dJ9E7SLiOjgANpe
	 kKdk9b0qHMkZ1nDlXYJRwDFCM78E3YzJJYI1QLVi1CZ7VhHLcmh/ayumLLAveL2cLr
	 eBgAWQvV2/Op2vFT7FFDPmBRmF5+uwc0OLrePqKV/A1yVVFoNV0jW4sGHDGG1OopEF
	 Z9X8ppeu97hWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 613FBC04E32;
	Wed, 12 Jul 2023 21:00:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: uninitialized data in
 nsim_dev_trap_fa_cookie_write()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168919562039.4783.10687758800247909993.git-patchwork-notify@kernel.org>
Date: Wed, 12 Jul 2023 21:00:20 +0000
References: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
In-Reply-To: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: jiri@resnulli.us, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, idosch@mellanox.com,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jul 2023 11:52:26 +0300 you wrote:
> The simple_write_to_buffer() function is designed to handle partial
> writes.  It returns negatives on error, otherwise it returns the number
> of bytes that were able to be copied.  This code doesn't check the
> return properly.  We only know that the first byte is written, the rest
> of the buffer might be uninitialized.
> 
> There is no need to use the simple_write_to_buffer() function.
> Partial writes are prohibited by the "if (*ppos != 0)" check at the
> start of the function.  Just use memdup_user() and copy the whole
> buffer.
> 
> [...]

Here is the summary with links:
  - [net] devlink: uninitialized data in nsim_dev_trap_fa_cookie_write()
    https://git.kernel.org/netdev/net/c/f72207a5c0db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



