Return-Path: <netdev+bounces-131434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 508B298E7F2
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 02:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825F01C20F80
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 00:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB6FB672;
	Thu,  3 Oct 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8pJzvlM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73A61DDC1;
	Thu,  3 Oct 2024 00:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727916628; cv=none; b=QwauqUmwB3/p0T5OZp1QAbrGyDWpLg1gdj9ZkQYWo3+60yL2CTohAnBeXXJTJTY3Y2++T5Zb0902fXiO6R7hO4fN7nwXxlUkK6iXHI+P8h2i/BC8Xfuw1JVlthJIc4MGS0xKeBl8t9XFDnJ145B9X5x02Vql1at9C6k5L2MTFI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727916628; c=relaxed/simple;
	bh=7CS+8ruNi97vFkvQRg8+CFUgLlqCp4XIqZjTp/7vlu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=unsXKa6XqDQvCZ/ZA9QwkOO1MXpNYpxNj+Zb3zmYGmARi4QiJ+BxdHpekZ4LhNc0lJMtdVw2t5chngL3qzEck8i50edS1gkfOPPlTommWvHiSaGEYwvcbBxeHe2DgGiEvQD7SDzLrVrSXdmFeWLOdLuMKZWvFIhdybxkg0CjrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8pJzvlM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F413FC4CEC2;
	Thu,  3 Oct 2024 00:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727916628;
	bh=7CS+8ruNi97vFkvQRg8+CFUgLlqCp4XIqZjTp/7vlu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N8pJzvlMbEffslMXmdwH4UBrlAjJ3BP5iWVCyLu0BLdokUxRpif2Ik4o3tJJqmvAR
	 FtzYXY61i8tYSlUHfKo8rQyUaQW3/AlYJ84AqWDK8KN4th2XUfRz8uCINelWP5Bo8L
	 w6W6PEFa0/m8VPyn8PZQhUKvJyrQ3rNxcVBe/maeqKNCKKdJUGBHsz18fLbjZ8qpsa
	 7WJ+tyOi/Tngc32QOa+Yr5/Uiid1+zZ/xkkgW0XAgKVW34z52TR3c3WSryPEJDb9Rx
	 t7RBsv+8RVhgfd28CsOysFdABwWy/5w8E2E6Ax+CxWFBmfm+hhIUWIbLHG/7JjWS4W
	 ELVFkywqKF5Gw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718E9380DBD1;
	Thu,  3 Oct 2024 00:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: phy: qt2025: Fix warning: unused import DeviceId
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172791663128.1389757.14089095197291807474.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 00:50:31 +0000
References: <20240926121404.242092-1-fujita.tomonori@gmail.com>
In-Reply-To: <20240926121404.242092-1-fujita.tomonori@gmail.com>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch,
 tmgross@umich.edu, aliceryhl@google.com, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lkp@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Sep 2024 12:14:03 +0000 you wrote:
> Fix the following warning when the driver is compiled as built-in:
> 
>       warning: unused import: `DeviceId`
>       --> drivers/net/phy/qt2025.rs:18:5
>       |
>    18 |     DeviceId, Driver,
>       |     ^^^^^^^^
>       |
>       = note: `#[warn(unused_imports)]` on by default
> 
> [...]

Here is the summary with links:
  - [net,v3] net: phy: qt2025: Fix warning: unused import DeviceId
    https://git.kernel.org/netdev/net/c/fa7dfeae041c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



