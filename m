Return-Path: <netdev+bounces-26037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C13B7769C0
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 22:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD9FA1C20F48
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 20:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45AEF1BB2F;
	Wed,  9 Aug 2023 20:20:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B622452F
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 81EADC433C9;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691612422;
	bh=uqu3I0gj6RwxG3myLwe++FyfZ0nGkm3ML9r+Vn6xx00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tD7pKhCi5TWp9g4acHDI9sKMUtWq5x++bwoEQPSw5FxzsQbMVEVuwXlFF+kKRDtrN
	 i/ZnVVQl9whvsbgFYe5CaZHqgUD3STUrIdJr9eTfU4EDLae1SbGEZd3IKj/AWUI0CO
	 GjRKnuVSR0FUct07kA+t4ymDpE4R3nDKaEal1I7or1FXEsMubhRAjnO6bin283tc0A
	 aJGr0x7OKus7nAvc4+vqbALjRzjhKEupM/TgwSaeVhpr22bXYcOdlAxiMu790IyEI2
	 xWAgRA/CSMhl8dRc0HckZfQqWzcCEdDhiEdH/AMsqUcwJ/MMJJCauE27/ViR1hbGaF
	 vNMWN/7X5VeSg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6A1FCC64459;
	Wed,  9 Aug 2023 20:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mlxbf_gige: Remove two unused function declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169161242243.16318.1470663097638364900.git-patchwork-notify@kernel.org>
Date: Wed, 09 Aug 2023 20:20:22 +0000
References: <20230808145249.41596-1-yuehaibing@huawei.com>
In-Reply-To: <20230808145249.41596-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, asmaa@nvidia.com, davthompson@nvidia.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Aug 2023 22:52:49 +0800 you wrote:
> Commit f92e1869d74e ("Add Mellanox BlueField Gigabit Ethernet driver")
> declared but never implemented these.
> 
> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
> ---
>  drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige.h | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] mlxbf_gige: Remove two unused function declarations
    https://git.kernel.org/netdev/net-next/c/98261be155f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



