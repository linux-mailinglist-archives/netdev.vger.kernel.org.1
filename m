Return-Path: <netdev+bounces-29745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E947A7848EA
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 20:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA1E81C20BA9
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 18:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6423A1DDC3;
	Tue, 22 Aug 2023 18:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90CD2B577
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7DC3CC433CA;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692727224;
	bh=dO7qQ9bDHnVf4s5BRyHnVITB425xgJnsP3lzdvYNyes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GdDGTCvDWMh4mkUgTxoQ5gKdBOdMWuTLMtiiUDHj8+iDCVSGGJ5YxIamPKlWSPcTf
	 IG8M2JJiACSBo1QLLBxGrGkNu+v5coKu1SeBq8fNvCuL75KYZmodagOU5xd9y+CBEj
	 naXo98UEizvUvkgdsvMPGRpP722UgQeej3fV01s+kQm2T7U1Q9kiwNgH6ncIMoGJF1
	 nI5GARPrBQcwmLd2gE9r5bilRqyOzhpHYsjLq6ZPIwvVLZ+DO3tmPF9pNtJxzEZC4H
	 0WsbFSemDH2xA13aqaaxy2KSY/gPm48hPhrs4D7+Yd9FNkYpTvO712VbXmQ2XzVjyj
	 8FTFrIqL/Lplg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 617ADE21EDC;
	Tue, 22 Aug 2023 18:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: microchip: Remove unused declarations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169272722439.9690.5447976597631105113.git-patchwork-notify@kernel.org>
Date: Tue, 22 Aug 2023 18:00:24 +0000
References: <20230821135556.43224-1-yuehaibing@huawei.com>
In-Reply-To: <20230821135556.43224-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Aug 2023 21:55:56 +0800 you wrote:
> Commit 264a9c5c9dff ("net: sparx5: Remove unused GLAG handling in PGID")
> removed sparx5_pgid_alloc_glag() but not its declaration.
> Commit 27d293cceee5 ("net: microchip: sparx5: Add support for rule count by cookie")
> removed vcap_rule_iter() but not its declaration.
> Commit 8beef08f4618 ("net: microchip: sparx5: Adding initial VCAP API support")
> declared but never implemented vcap_api_set_client().
> 
> [...]

Here is the summary with links:
  - [net-next] net: microchip: Remove unused declarations
    https://git.kernel.org/netdev/net-next/c/dff96d7c0cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



