Return-Path: <netdev+bounces-147129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B289D7997
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 02:00:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93292B21796
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555FA11713;
	Mon, 25 Nov 2024 01:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fHR7FUtw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BED2FC0B;
	Mon, 25 Nov 2024 01:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732496419; cv=none; b=SkrQY90W/luavqE0ndp3TbFmEuuzarXtL3Y5hhwocY9/l+yMzxzpWhjHcuRJ7Pd+cIHc+e0v7F5yQ9WKI5dh+BZBSh76tQtZsL70e4xsCnYmKlaEVZLBGlp3cLA2PcAxt5/ioqnKAr0XP+fMOaJBRRyFvNtnYTYW+2mOp72XGNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732496419; c=relaxed/simple;
	bh=W9sLSofs57IMCbEq/BUTGm70UcwPOIqZIetSSFDBvrE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZL6IA+y7CJMRv8aeENjgUWzMXeVS3czOOK7Pqiihfq4brOXo3RRU0DyUBlJcxBBWyMB4AuzJFJbZG7foEUbXtv+DV0YV7HVtn9PrqsQCSBVnK1SkzcxpIYyCWQQqxolcBtyFjNLQG6JuhFMHCUKXqqQfV7eGWkCRFkeP+ZhSG8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fHR7FUtw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9FF4C4CECC;
	Mon, 25 Nov 2024 01:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732496418;
	bh=W9sLSofs57IMCbEq/BUTGm70UcwPOIqZIetSSFDBvrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fHR7FUtwBAZDNueO/8+4s59fL1xWj04a/8Hxm8cS6D/R5vCNP8bnQxt4mmTEEcpzk
	 J79tgT2zCjY6yCRE7eLabYdvIjzW2JRuCRh6v02j6NpCr1eVyoYF3c68MOOInu7uMG
	 vaEfdLxhzMr0YOuQc+eDTEjCNXvKP5rENrkhh+e4TOeOBZ8s9ZCpDg6todP4XaYAIz
	 akzRRZl/T4ZPxkGWfuAY7w/c/fTLnS3pIh6hMY9WMCOT/XNWPj9DOvMkpqPwZemfYf
	 wDaCaxqUDUyI8c/ONwzXp7mWCa74PAnlLS5Hi5f8lafuqJlC0qgyuQWY3rJlkF+VSt
	 tEZzcCU2ZnXlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7330A3809A00;
	Mon, 25 Nov 2024 01:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH] net: microchip: vcap: Add typegroup table terminators
 in kunit tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249643125.3410476.13194296250572819255.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 01:00:31 +0000
References: <20241119213202.2884639-1-linux@roeck-us.net>
In-Reply-To: <20241119213202.2884639-1-linux@roeck-us.net>
To: Guenter Roeck <linux@roeck-us.net>
Cc: lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 steen.hegelund@microchip.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Nov 2024 13:32:02 -0800 you wrote:
> VCAP API unit tests fail randomly with errors such as
> 
>    # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:387
>    Expected 134 + 7 == iter.offset, but
>        134 + 7 == 141 (0x8d)
>        iter.offset == 17214 (0x433e)
>    # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:388
>    Expected 5 == iter.reg_idx, but
>        iter.reg_idx == 702 (0x2be)
>    # vcap_api_iterator_init_test: EXPECTATION FAILED at drivers/net/ethernet/microchip/vcap/vcap_api_kunit.c:389
>    Expected 11 == iter.reg_bitpos, but
>        iter.reg_bitpos == 15 (0xf)
>    # vcap_api_iterator_init_test: pass:0 fail:1 skip:0 total:1
> 
> [...]

Here is the summary with links:
  - [RESEND] net: microchip: vcap: Add typegroup table terminators in kunit tests
    https://git.kernel.org/netdev/net/c/f164b296638d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



