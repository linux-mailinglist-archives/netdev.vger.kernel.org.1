Return-Path: <netdev+bounces-136831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B36219A32E3
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 04:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 534F41F2439C
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 02:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7D4155312;
	Fri, 18 Oct 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kHneq8h2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82CA381C4;
	Fri, 18 Oct 2024 02:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729218633; cv=none; b=hYGkWRr6g1w8pGbfKID5nEecMpVV4n4z47KS9yAQEM0Fdu1YikrDL60kfreytJERo+nAi+/jG7MFfUlber3KOoQ1dzRKJ9ruujqA2UMo1VH7lOjxhQQxdqh3x0KozQx1lR7miNc9Drp30+KbsyEiQZeEropsxCZs2uDHSZ3rZ8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729218633; c=relaxed/simple;
	bh=JQu0sj8sp9EhssfbMu5rzTPp/O/qW5+5sojW4NSJesM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NwmNsXJmMPtiiT9+u79PY/+LjPNqfxwPmNPha913dz8Xaf31VNG6mdBhjrvdvzyomCq5JqxydJI4osU+7z/2oKNq46W5ZMY6tvuXIPUnfFzo7kzFxZmo9FGHVIX7PnZ5/DLkkVUZDr27/JIbm1yl9H8RNqaIZsNZRbKfAvtmJNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kHneq8h2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D344C4CEC3;
	Fri, 18 Oct 2024 02:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729218633;
	bh=JQu0sj8sp9EhssfbMu5rzTPp/O/qW5+5sojW4NSJesM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kHneq8h24xfOSr/7TvethFmbKqSMgoTfcbPJAgJYh2WtHw9my9aZOM4EBoNmYsR+M
	 mzsYjo5OhAFPNhQcC7JB/f+FjNnBgGkWIln4l7MVl6gMwiEirVenggNEOUeJOwMRPa
	 SYsItK6dpKhKvgpaVrGIA+EcQs2EKu0EFX9Bxrq4URzaAT2soaHK/3TziKKzkyOmLl
	 mgHbX1m1VobHw3wrosEPs67NVpFAlO16FdCRuYapL/7apT8/aPJxhZXHQywoGY9vfR
	 ZYDaXur6F2uqdmf18lu/lWLAP6qIRhWdYCiWPr8TPl1QCCNBQEg8zSRksMkcR5sJJF
	 t2SvOvb9Frlow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAED93809A8A;
	Fri, 18 Oct 2024 02:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 1/1] net: ks8851: use %*ph to print small buffer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172921863853.2663866.1605837331453014009.git-patchwork-notify@kernel.org>
Date: Fri, 18 Oct 2024 02:30:38 +0000
References: <20241016132615.899037-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20241016132615.899037-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 16:25:26 +0300 you wrote:
> Use %*ph format to print small buffer as hex string. It will change
> the output format from 32-bit words to byte hexdump, but this is not
> critical as it's only a debug message.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> v2: wrapped on 80 (Simon), elaborated the format change (Simon)
>  drivers/net/ethernet/micrel/ks8851_common.c | 20 ++------------------
>  1 file changed, 2 insertions(+), 18 deletions(-)

Here is the summary with links:
  - [net-next,v2,1/1] net: ks8851: use %*ph to print small buffer
    https://git.kernel.org/netdev/net-next/c/92cee559dbda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



