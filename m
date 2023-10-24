Return-Path: <netdev+bounces-43776-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 230327D4BCD
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 11:20:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D12B1281217
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 09:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF22F224F7;
	Tue, 24 Oct 2023 09:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ocaz5KYD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E09C33D0
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 09:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F203CC433C9;
	Tue, 24 Oct 2023 09:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698139223;
	bh=zF2/iQq0LgEinTw9z1FURusMG9SsNO7Ov6RH+huvW8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ocaz5KYDczYkRstA0gUbGfpRGgNnId2OYdmsYMbzOMxOQI2r+XCFZuuAjrvoQ+iS1
	 30t58Qb2roxv5njqPdLTfO4MK0N8PXV2cYs6UsWtZjgxOKP8XajXtnshLAAJ4YeHAB
	 Ufktd2XZX8PgtrFBCGDbnYRZZMI7oEqoEz0JeEjeHkwV8XPzDKC92K2bJ7HAg8wfTz
	 ZkyoiloKuSaxeuOESb+mvFSvvmlvkjN0CA8IilAh+BSxczvDSflB2aPca+2Qt325Lo
	 NgZz0RDHNJfu035Hz/FgWg5pp89yE4rfVC9OkXnqTp9LRjKg/OG/9TpSyaOtXwOe8m
	 6lm+VBfBmpvWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D8EE6C3959F;
	Tue, 24 Oct 2023 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Fix NULL pointer dereference in cn_filter()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169813922287.17100.10372385661953821118.git-patchwork-notify@kernel.org>
Date: Tue, 24 Oct 2023 09:20:22 +0000
References: <20231020234058.2232347-1-anjali.k.kulkarni@oracle.com>
In-Reply-To: <20231020234058.2232347-1-anjali.k.kulkarni@oracle.com>
To: Anjali Kulkarni <Anjali.K.Kulkarni@oracle.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net,
 Liam.Howlett@oracle.com, netdev@vger.kernel.org, oliver.sang@intel.com,
 kuba@kernel.org, horms@kernel.org, anjali.k.kulkarni@oracle.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Oct 2023 16:40:58 -0700 you wrote:
> Check that sk_user_data is not NULL, else return from cn_filter().
> Could not reproduce this issue, but Oliver Sang verified it has fixed
> the "Closes" problem below.
> 
> Fixes: 2aa1f7a1f47c ("connector/cn_proc: Add filtering to fix some bugs")
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202309201456.84c19e27-oliver.sang@intel.com/
> Signed-off-by: Anjali Kulkarni <anjali.k.kulkarni@oracle.com>
> 
> [...]

Here is the summary with links:
  - [v2] Fix NULL pointer dereference in cn_filter()
    https://git.kernel.org/netdev/net/c/9644bc497057

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



