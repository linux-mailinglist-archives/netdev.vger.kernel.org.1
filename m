Return-Path: <netdev+bounces-135818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5831E99F49D
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 20:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C5DE1F20FE7
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 18:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD39B1F76C6;
	Tue, 15 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UjAFuyJt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2681F667F
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 18:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729015227; cv=none; b=KMTJyMqejgIYsUQ1jxE1koZsMr68dgSGO+kn+4Saknk1jZTKRX+amcskKy7okwpp/s/8uzWqGaIYrL1U7i+H76Wngb0ehgKpDlZiv3fGQ93jAmsthhiudCvfGNn9kHy45VaYQptR9NrHEnNmkie0fnuNiUWR+yhvrBvBxgwJJak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729015227; c=relaxed/simple;
	bh=0p98d/AHPU0UsUtJ/arYUGIr19bFIrqlmQgJkrW5dio=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ilhZ6qLBnJBPBkMz8hJSWtJqgYpgX9RhC8QKF3gVCq7h+/sO2KonVlQZDgr+orKfhTgMi2CX02Hhv+BzNVUEQfjkNI8emH713YUVMo8ofRrK4J8Ni49CUZGpNSsVmUHGchG3H6EaNsKEF2Ntd6M88YaGj+BTQ8p4/JiVIgZ6m4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UjAFuyJt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A52FC4CEC7;
	Tue, 15 Oct 2024 18:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729015227;
	bh=0p98d/AHPU0UsUtJ/arYUGIr19bFIrqlmQgJkrW5dio=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UjAFuyJtRJYGNCQGwls7pdoCS2FG6gpjzHXjFoF0bQd9F+T3Ct+dUX3T+PUTEER8M
	 MTDi8Vrkh8ohDNqx/zDSVzlNEMegTACUB76DeWOZX2LP7i3V/flaOYflTUSiEHdb+V
	 WpNcQXNBC4IFiDp0N8kJBNK2TnqNm/ta9KamC5qmYCCR9WTnKwEwRy5M32dA9C9NTG
	 aBORlmoNbAEz+mLZ8zMBWCt42DQ711YH/FyOJPZ81ayZGeXvGoxUwfS0wrhnVgm4bj
	 tsasj2lJ40R5gavjeEZgSFEkVNyCOEofjInKHJbzrzH954UeAHcTP2g6yVC7PWwPv9
	 DGuzIeZgw9yMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718033809A8A;
	Tue, 15 Oct 2024 18:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH][v2] net/smc: Fix searching in list of known pnetids in
 smc_pnet_add_pnetid
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901523226.1243233.7228096119002502353.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 18:00:32 +0000
References: <20241014115321.33234-1-lirongqing@baidu.com>
In-Reply-To: <20241014115321.33234-1-lirongqing@baidu.com>
To: Li RongQing <lirongqing@baidu.com>
Cc: netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Oct 2024 19:53:21 +0800 you wrote:
> pnetid of pi (not newly allocated pe) should be compared
> 
> Fixes: e888a2e8337c ("net/smc: introduce list of pnetids for Ethernet devices")
> Reviewed-by: D. Wythe <alibuda@linux.alibaba.com>
> Reviewed-by: Wen Gu <guwen@linux.alibaba.com>
> Signed-off-by: Li RongQing <lirongqing@baidu.com>
> 
> [...]

Here is the summary with links:
  - [v2] net/smc: Fix searching in list of known pnetids in smc_pnet_add_pnetid
    https://git.kernel.org/netdev/net/c/82ac39ebd6db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



