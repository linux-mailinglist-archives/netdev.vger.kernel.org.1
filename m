Return-Path: <netdev+bounces-24609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6C7F770CE7
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71BC02827B8
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B39F136D;
	Sat,  5 Aug 2023 01:10:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC901380
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 752A1C433D9;
	Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691197823;
	bh=izvt9FWgkuRKnkktz/JoMufeKsl0pkzrPeo35ds+xro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=K7WXbgg+uwocRXpy8lAugjZaexB32GzRE3VIqPicEDxA7gwQ8xOmHct/93FsA6O0+
	 ZuNc+xVw6LBJ53nK+C3TdqRKIkyCuzqLYdNWrzCGBH0DqfntT6KScvJC4wQC/e9WNo
	 zo+msWHVhG0OZaAbjPZzNl3cAvjoSYE4dtzEdrZNhjFm9IPwnad2qc0vDPbN8cfgGZ
	 Gye6nn301xkZ/SAtA0oijAglAN8rfP4FpP9IeN9wAV/sKAOgf4ex9cx5LUGEkBar/+
	 7PqAeexVteH4KgSu2l6OiJhc+sRCVXEpNjtDLhSchvrgXIIOlr8xf5SSc+ACFYdBns
	 LG3ZsKu4yRRYA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5F21AC64458;
	Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxsw: spectrum: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119782338.10230.5715811444362767708.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:10:23 +0000
References: <20230803142047.42660-1-yuehaibing@huawei.com>
In-Reply-To: <20230803142047.42660-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: idosch@nvidia.com, petrm@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 22:20:47 +0800 you wrote:
> Commit c3d2ed93b14d ("mlxsw: Remove old parsing depth infrastructure")
> left behind mlxsw_sp_nve_inc_parsing_depth_get()/mlxsw_sp_nve_inc_parsing_depth_put().
> And commit 532b49e41e64 ("mlxsw: spectrum_span: Derive SBIB from maximum port speed & MTU")
> remove mlxsw_sp_span_port_mtu_update()/mlxsw_sp_span_speed_update_work() but leave the
> declarations.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> 
> [...]

Here is the summary with links:
  - [net-next] mlxsw: spectrum: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/852c18d5611e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



