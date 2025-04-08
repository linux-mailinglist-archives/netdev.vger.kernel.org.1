Return-Path: <netdev+bounces-180188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5E5CA80320
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ADB9E19E5B8F
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 078072690CC;
	Tue,  8 Apr 2025 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W3e/n2TK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A7F268C43
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112996; cv=none; b=lpFwyWyOQmEgoRhkOKgGONXmhDng7/6hab2MnZ83n1b1C73SZ3E/2BtBG49kvXhFnC6C8ozdCdbljzF8jwAQZX7QA7Ca1yHAApQlsYUm9NG4PTxn7nAqf++L6wMX0mMVxEMKdOYY+SDmUG6M96iVItIkKju+G50Q28EdcJpqHxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112996; c=relaxed/simple;
	bh=xTwx/TB2S7O0m8g7C+71A8fWVg9FmQpnWuIIveb45Oo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HNk2tXRfk9dR9cmVFR0DXbL0xZSEzYMy6H1Iv8jx7crT6tkwzY536DhsSr01Z+u1L1Kz98Fx5BCQYgJGVn4JFIeL6DzADlcHHqk7Q6CAE1Sb1bLu03zFST8NEGFrt7AEflQuzfUT4LLccRNnAxsoXIKYfUPy7nz5F1IYXAfpfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W3e/n2TK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC85C4CEE5;
	Tue,  8 Apr 2025 11:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744112996;
	bh=xTwx/TB2S7O0m8g7C+71A8fWVg9FmQpnWuIIveb45Oo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W3e/n2TKbm0uwO4hATWvN77A/yu1RPFAWriDZ8Acn3RSVNkasHIYQUbFi5lfChZb1
	 Wnr0yz0+FWk8WmpbHhA8d3kWOjyXlLGAXzVl8K24eoOFAm8obo/FD49R/kiqBgCtFC
	 ekcpf7Svwu8yv8Kq9GYmHcwH4zVrrkV/9IudedlkqpV0FvYHui+F8kewXU8v9+9oBp
	 1q3wLEMOGBEX2teIG2gjvc9LJlSihzffcf9FbkbKP1/zuaObhhd7/LPPplwVZsRQu2
	 IBfTq30MIMc45V3OZpJLGyUwSnpRuis1akx84qetcU0h7vCTiv+9XCztAsO0xgBZ8V
	 tv1skjKkxbB8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CBA38111D4;
	Tue,  8 Apr 2025 11:50:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: libwx: Fix the wrong Rx descriptor field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174411303400.1891756.16097597715825250008.git-patchwork-notify@kernel.org>
Date: Tue, 08 Apr 2025 11:50:34 +0000
References: <20250407103322.273241-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250407103322.273241-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  7 Apr 2025 18:33:22 +0800 you wrote:
> WX_RXD_IPV6EX was incorrectly defined in Rx ring descriptor. In fact, this
> field stores the 802.1ad ID from which the packet was received. The wrong
> definition caused the statistics rx_csum_offload_errors to fail to grow
> when receiving the 802.1ad packet with incorrect checksum.
> 
> Fixes: ef4f3c19f912 ("net: wangxun: libwx add rx offload functions")
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
> 
> [...]

Here is the summary with links:
  - [net] net: libwx: Fix the wrong Rx descriptor field
    https://git.kernel.org/netdev/net/c/13e7d7240a43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



