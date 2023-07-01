Return-Path: <netdev+bounces-14975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54450744BA3
	for <lists+netdev@lfdr.de>; Sun,  2 Jul 2023 00:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4D91C208CB
	for <lists+netdev@lfdr.de>; Sat,  1 Jul 2023 22:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840FDBE61;
	Sat,  1 Jul 2023 22:30:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F06ECC
	for <netdev@vger.kernel.org>; Sat,  1 Jul 2023 22:30:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 946A3C433C8;
	Sat,  1 Jul 2023 22:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1688250620;
	bh=XKvEY1s/4NgyGawd9b7DLxASqX98ovtpZCCY9OoHgfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=huFAWafmjSsmst9RsPVQLT15CY+h/s+9zB5ouL+uvK3XI1/3k4elzVK4Eo7ro5EXD
	 QQaFEBYKnDnnInWM5qT3+1RJ0Ho70xSzXrY13+ROqaUv4JSebvoq0sfeCNuPfk/TwH
	 5DqvUYBBuPkBzLSp3sEYhF19gw0gARlQ7rYratta+roxcnYSW2duQ01Q+j9Sx9HJwa
	 XirV5/JplHw4yEqKADfmh4Yh5CSvFFxYdNmr2G69+kavFUuAlJTEIP3mFSzX2A3fpD
	 YPKvtmqJOt9IDeuII8GK6NU+1TdnRsn1KfQQDU+/xnctXrRdYJPBf6baPhkqveowMz
	 IZOLaMahnYQ4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CF67C6445A;
	Sat,  1 Jul 2023 22:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH ethtool] netlink: fix duplex setting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168825062050.15743.16961942454098369013.git-patchwork-notify@kernel.org>
Date: Sat, 01 Jul 2023 22:30:20 +0000
References: <ZJrDT9k52oFTf/vs@lenoch>
In-Reply-To: <ZJrDT9k52oFTf/vs@lenoch>
To: Ladislav Michl <oss-lists@triops.cz>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Tue, 27 Jun 2023 13:09:03 +0200 you wrote:
> From: Ladislav Michl <ladis@linux-mips.org>
> 
> nl_parse_lookup_u8 handler is used with duplex_values defined as
> lookup_entry_u32. While it still works on little endian machines,
> duplex is always 0 (DUPLEX_HALF) on big endian ones...
> 
> Fixes: 392b12e38747 ("netlink: add netlink handler for sset (-s)")
> Signed-off-by: Ladislav Michl <ladis@linux-mips.org>
> 
> [...]

Here is the summary with links:
  - [ethtool] netlink: fix duplex setting
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=f493e6381c8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



