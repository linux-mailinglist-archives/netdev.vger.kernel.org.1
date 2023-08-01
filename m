Return-Path: <netdev+bounces-23445-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4FE76C006
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:00:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48AA7281A92
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58287275AF;
	Tue,  1 Aug 2023 22:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2629126B7A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id B0760C433C9;
	Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927225;
	bh=XWeoERIEjZYgEFe7a0YSndjAk14lR2G26tcki8Akxjs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lOr5iuB6lGR5VVLvDKAtuYEWgvC9oDTT/yq53Gua0RvyS3CDrXQAZtuj16xEXQccZ
	 VGsYw/nPkAMqyh3ld0wR9rCOwp35buzKpP+ZfANz4NTDB2WmHE8y26k4MBFlSA0w+X
	 wRo9dBRxFFcEByASg7OrbztdnjQVBPfCByYnBzE8riE7dNhlhRaYX7J9LMm3L3DEk9
	 ku6+Q+hkzpoS3uF81ZU9pS97i9FOFqRoQyy6VhFVqGduxUigNzXJzZAjP8iIZ3gkrq
	 CRIqs0GOZVVZYGDTLkLczJSxQphRRW8twiiH8aOp7/5v322VL5Ss/HUoQISzx+AaFi
	 8ZuSTyCayX7Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8320AC691EF;
	Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/1] net: korina: handle clk prepare error in
 korina_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092722553.12287.773493123634692649.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:00:25 +0000
References: <20230731090535.21416-1-ruc_gongyuanjun@163.com>
In-Reply-To: <20230731090535.21416-1-ruc_gongyuanjun@163.com>
To: Yuanjun Gong <ruc_gongyuanjun@163.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 17:05:35 +0800 you wrote:
> in korina_probe(), the return value of clk_prepare_enable()
> should be checked since it might fail. we can use
> devm_clk_get_optional_enabled() instead of devm_clk_get_optional()
> and clk_prepare_enable() to automatically handle the error.
> 
> Fixes: e4cd854ec487 ("net: korina: Get mdio input clock via common clock framework")
> Signed-off-by: Yuanjun Gong <ruc_gongyuanjun@163.com>
> 
> [...]

Here is the summary with links:
  - [v2,1/1] net: korina: handle clk prepare error in korina_probe()
    https://git.kernel.org/netdev/net/c/0b6291ad1940

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



