Return-Path: <netdev+bounces-124133-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43969968373
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 11:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7549F1C223DB
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 09:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E313F1D1F65;
	Mon,  2 Sep 2024 09:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A7klkDRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9ACD179654;
	Mon,  2 Sep 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725270030; cv=none; b=mfhqIMUCjtJFO/oMu98G3yhJp/7aY3hLFBz52+6OGdLF5RbgRvzKNEh286ByQhSfCWCTGv9gBLqH9k7XtqU1hf+yXWKcyfKvaUNvF/5n8xxijE+wqffGBTRR3+yZNiY6GaiGdZgrH0ELBg+5Ubr0vfHlvzmxTyGjfbPQEioNWG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725270030; c=relaxed/simple;
	bh=gdybJDrNjg5yzvAevTD3diZeh+qDZbL1UtLKO7Yp/ok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LJyf2WyIkz0QC3yqmJao8yCf3xMfApiA8CgViOzY02s8pOvZW0sGprvivE2hfMcBWTl/I/fcOri+4pjnXnZ91CeyaIYIBoGfHw+rq776TqGfi0Mu5GxvqGUdBZfBa2YOQeIGQDSk6l6RzzT2UMQCrnbz1miXm8itCf1ewHJ44i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A7klkDRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559E8C4CEC2;
	Mon,  2 Sep 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725270029;
	bh=gdybJDrNjg5yzvAevTD3diZeh+qDZbL1UtLKO7Yp/ok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A7klkDRnYRQZpvnT0otQWDNQb0w/JFGppIAH0cGaUGuAT9Y4cftqwZzH60wA/nOE6
	 Qo4ZRlSx8ZopwHhbCtS+Mj/84+kQ+T1T57wg4xrEgTrInqs07ZoXm9dbc3+/3TwB40
	 yDrJUZ5mxSsex5L2nnVHaruc6J6c3rFMtPnyJ9X9V8Z7rOeIvJ8VxlO+6xtspEBAp0
	 hBhpbd8ys05hH3kqAsQEm7iNfIMYLTjTp+zHQQ6J/yoRcTMh8xZs2PzZZa0MW3PatQ
	 BMgalm59xWIo9ZWtJ+fEKNjFDKN4LNcJFpHJVlA9xUv88YO6KX73Ig4v3zQK+sbmw6
	 IRh9AH84LPoUg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33F4E3822D69;
	Mon,  2 Sep 2024 09:40:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: microchip: vcap: Fix use-after-free error in
 kunit test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172527003004.3825645.3659251948161383657.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 09:40:30 +0000
References: <20240829-fix_use_after_free-v1-1-1507e307507f@microchip.com>
In-Reply-To: <20240829-fix_use_after_free-v1-1-1507e307507f@microchip.com>
To: =?utf-8?q?Jens_Emil_Schulz_=C3=98stergaard_=3Cjensemil=2Eschulzostergaard=40?=@codeaurora.org,
	=?utf-8?q?microchip=2Ecom=3E?=@codeaurora.org
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 steen.hegelund@microchip.com, error27@gmail.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 11:52:54 +0200 you wrote:
> This is a clear use-after-free error. We remove it, and rely on checking
> the return code of vcap_del_rule.
> 
> Reported-by: Dan Carpenter <error27@gmail.com>
> Closes: https://lore.kernel.org/kernel-janitors/7bffefc6-219a-4f71-baa0-ad4526e5c198@kili.mountain/
> Fixes: c956b9b318d9 ("net: microchip: sparx5: Adding KUNIT tests of key/action values in VCAP API")
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> 
> [...]

Here is the summary with links:
  - [net] net: microchip: vcap: Fix use-after-free error in kunit test
    https://git.kernel.org/netdev/net/c/a3c1e45156ad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



