Return-Path: <netdev+bounces-24610-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3871770CE8
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 03:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F41991C216C7
	for <lists+netdev@lfdr.de>; Sat,  5 Aug 2023 01:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472321380;
	Sat,  5 Aug 2023 01:10:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E0615A6
	for <netdev@vger.kernel.org>; Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8AB36C433CD;
	Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691197823;
	bh=Hqo3DsAo56JepYRA2MoZ45lxliYcx61bW+6Dmqy7gnY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SRcDk8dPmDomNVARvwytXKhaa0dKgEPgfTHsas1IhMKuGBisBmKgvTNApM1QWFP0p
	 IWpn9tfjpQlaBBOiney5TNq9pd5kHYgfT10Bmb/nMnivLL6Vi2Q+tlJbWX8RvTt+zo
	 N92Yk85D/9tS/tIr6lzrhZIi4MYnhYTgtLhJhysfqYyuaxsbH0L9q3IACatxijBW3N
	 sO3jQDann/l5e1ZnQZmKrvOxFfXO0ra35z4fS7O/FnVgUkSJjI7+z+po1VWDq1And2
	 EK5qAjau/fm9xl6NuqlZsxgN26ZO0nfVMrgYIdsdl1/xXZgK02oyZHg5bhU43IYu7F
	 MS88+O45M1Oqw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6941CC595C3;
	Sat,  5 Aug 2023 01:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ixgbevf: Remove unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169119782342.10230.7904066616600128243.git-patchwork-notify@kernel.org>
Date: Sat, 05 Aug 2023 01:10:23 +0000
References: <20230803141904.15316-1-yuehaibing@huawei.com>
In-Reply-To: <20230803141904.15316-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 3 Aug 2023 22:19:04 +0800 you wrote:
> ixgbe_napi_add_all()/ixgbe_napi_del_all() are declared but never implemented in
> commit 92915f71201b ("ixgbevf: Driver main and ethool interface module and main header")
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] ixgbevf: Remove unused function declarations
    https://git.kernel.org/netdev/net-next/c/f5f2d9bb52f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



