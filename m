Return-Path: <netdev+bounces-17337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 549A47514FF
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 02:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8517B1C21046
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 00:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A68B366;
	Thu, 13 Jul 2023 00:10:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8FB7C
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 00:10:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 877D0C433C9;
	Thu, 13 Jul 2023 00:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689207021;
	bh=xGEaUsqozgevUfLV+96DfUme87ByIwulFGJnjgArtCc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mpsbenbyW1wjGkr4ZVBjwZh/2vL7ISYDQBLAW+OhQb91VgRQAbxoaeBDpPsO8eOWr
	 4jCk0F7WPB7AkHag4nV7JdGpB63wq7/J5LJebxz6f2q3nqP5SVSr+8jw7ndiwMY73z
	 9zg3VsSBuyLwdc+rQd+yDCfrYWaun/kCyIZcxGnt7+vOY5UgPlSvkDzQNje+GgUgMm
	 ppT/E8xYwzRJqbbuT0ASCoT4M1I8f3/mmtFuWcS3Mr3WfUmR3GePsEYSHQ1hOD/e2E
	 nq/bi2w/hdeTdU/RRMHkYrg6eXIvNyarK2CmzN/jfp/xDXU7+o7AFzY7/zHavm/XMM
	 Xur3v7uCHMO9A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6FDBCC4167B;
	Thu, 13 Jul 2023 00:10:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: txgbe: fix eeprom calculation error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168920702145.12941.913608507417226640.git-patchwork-notify@kernel.org>
Date: Thu, 13 Jul 2023 00:10:21 +0000
References: <20230711063414.3311-1-jiawenwu@trustnetic.com>
In-Reply-To: <20230711063414.3311-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, mengyuanlou@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Jul 2023 14:34:14 +0800 you wrote:
> For some device types like TXGBE_ID_XAUI, *checksum computed in
> txgbe_calc_eeprom_checksum() is larger than TXGBE_EEPROM_SUM. Remove the
> limit on the size of *checksum.
> 
> Fixes: 049fe5365324 ("net: txgbe: Add operations to interact with firmware")
> Fixes: 5e2ea7801fac ("net: txgbe: Fix unsigned comparison to zero in txgbe_calc_eeprom_checksum()")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: txgbe: fix eeprom calculation error
    https://git.kernel.org/netdev/net/c/aa846677a9fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



