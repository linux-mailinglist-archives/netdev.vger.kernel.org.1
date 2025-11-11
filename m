Return-Path: <netdev+bounces-237413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D24C4B2C0
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 177CC34CB62
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC9AC3451A9;
	Tue, 11 Nov 2025 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bo5SkH+J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26C53446DE;
	Tue, 11 Nov 2025 02:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827042; cv=none; b=HMA6ipMtFHdjmJq6Bffw3cssujAPpXuvW41SJze3aRPZMd+Ax70Vq22oKpwZ5qxNh/EZLjHT8ofRNu6pA6VvE7rCTYKRQ8z040Z459lxUvJJttZ+SZemWOj9Ljw5fZ+rc1lgsNEpkWmbtyVDt6nKeFxrrC8YXXATrtdzipYj364=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827042; c=relaxed/simple;
	bh=IKEQAlJZoREk/NrfDa65WIzZm/3aEo39YvimRdcQcW4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LGTMJxomtzRHsMPRbaoo2Nd9EgKaFDVvRZwwFwK6uPmGXJaE58sfY6wdGiAIyXGcvC1TNtIy6GqfghGuuV+bdCDO39xEOYbQFD7schL6SYVSy2r0zXIbz2M9gtnoDQThJiNPOC9x2+iANtNW9fB7AUOIIEsMsYoluxC/CSF34iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bo5SkH+J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F6C113D0;
	Tue, 11 Nov 2025 02:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827042;
	bh=IKEQAlJZoREk/NrfDa65WIzZm/3aEo39YvimRdcQcW4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Bo5SkH+Jf/7SP1OCS5FU14aMxtCb7sAB31uWTCvZ/FvdZ7/3CtAwYkwzlsfH8Fkgo
	 ZbyKl7Lk8BPzv11da9FSLkeL9bzYvUbohHAQpchq7JZUYOzyq3+2G+y4lwHba+aaX5
	 V2woENx5hOJsBVRaiYRSIFF02vNaTeQ+tTE1QdqIQECYneJgwAts4keDiu+/Ag+xxI
	 be0ST40TsXpM7FYiWgpIeMDpGgQPGiAqw9NiBEb3dtigA9ymTHlrS/VKdPgTnHQQB8
	 397krPx9aWDzqz2BH1YIMOBZzOnMw+JZ0nLodsKAbq+kMRWxLp84sTo+HBJm2fWmm0
	 7Am5APBFbbwcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB064380CFD7;
	Tue, 11 Nov 2025 02:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] Fix IET verification implementation for CPSW
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282701275.2852248.9515452073916446665.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:10:12 +0000
References: <20251106092305.1437347-1-a-garg7@ti.com>
In-Reply-To: <20251106092305.1437347-1-a-garg7@ti.com>
To: Aksh Garg <a-garg7@ti.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, edumazet@google.com,
 linux-kernel@vger.kernel.org, c-vankar@ti.com, s-vadapalli@ti.com,
 danishanwar@ti.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 6 Nov 2025 14:53:03 +0530 you wrote:
> The CPSW module supports Intersperse Express Traffic (IET) and allows
> the MAC layer to verify whether the peer supports IET through its MAC
> merge sublayer, by sending a verification packet and waiting for its
> response until the timeout. As defined in IEEE 802.3 Clause 99, the
> verification process involves up to 3 verification attempts to
> establish support.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: ethernet: ti: am65-cpsw-qos: fix IET verify/response timeout
    https://git.kernel.org/netdev/net/c/49b391646517
  - [net,2/2] net: ethernet: ti: am65-cpsw-qos: fix IET verify retry mechanism
    https://git.kernel.org/netdev/net/c/d4b00d132d7c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



