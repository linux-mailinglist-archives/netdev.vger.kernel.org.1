Return-Path: <netdev+bounces-97179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECA428C9BA5
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 12:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BA461F234F8
	for <lists+netdev@lfdr.de>; Mon, 20 May 2024 10:50:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA1151033;
	Mon, 20 May 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKRJ78c2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4C0C2032B;
	Mon, 20 May 2024 10:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716202227; cv=none; b=D6UwcuHsjBZDemgv33l1D6K1DUkghBcexCjg03dGgYAhyng1rNJbZ6LfIAtFLk04Fy991eByDgYMukkSA9+kRsvGFXSZglO2ns/eVXCzzTJwzxooSMPSAnxvogWdR5tIu+LKzEdHiTfIY4stHBrp9NMEJSfAz6GK5pvRzQOsHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716202227; c=relaxed/simple;
	bh=lTUo5Q00BKLH5/8wPC+5Dy6hJWp7AhGEpTMSeDWdJPw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EDUaRXQhjgp36nDabZUeBU4YMS6bR+RgyKhVX/YcVO4f3oHupFduaFPBoewNXX1BnpTxPh5VaeMWTsNduUWHxnjrpORIQxvavXXjddauCx8ZI81o8eZLbn1xyKtWAiV0d2rYpdQvgpigw5Yw4Cn55wVOU4BrUNDRktHcLjtCIwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKRJ78c2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 2138CC4AF08;
	Mon, 20 May 2024 10:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716202227;
	bh=lTUo5Q00BKLH5/8wPC+5Dy6hJWp7AhGEpTMSeDWdJPw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aKRJ78c2J07ujABdOluqxM1b3foQuX1zTXyc/ETCbO1SyKV/VVTDISnlz//fooQM7
	 saTD012Oqe0sSLbKgL6xMPNhllB3/HKO2wcfsCy7IZ9mLPtXZ8ET1wq9TTJ1gq8XxH
	 9hjxu8cf3fCvUhr4jfr4oREPbVIvlvjxObQpgDYNlZU2KvHVLhntGnSgl8w8OqmbrR
	 NwZRLrF6/GS3eQia1Kt+t7DynKTFQLyhpVubqYM8hr9FdGYh51Keesr0lx18E5Br6s
	 EyVp+ga/t9ibfGk41GyJyotpB2SkUhwNuHbigQiW2Jb+0SF7WqOLJmb8XZTWQaXKuV
	 zf2KyXM8llX0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0EB5BC54BD4;
	Mon, 20 May 2024 10:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5] nfc: nci: Fix uninit-value in nci_rx_work
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171620222705.18778.2126198087127121163.git-patchwork-notify@kernel.org>
Date: Mon, 20 May 2024 10:50:27 +0000
References: <20240519094304.518279-1-ryasuoka@redhat.com>
In-Reply-To: <20240519094304.518279-1-ryasuoka@redhat.com>
To: Ryosuke Yasuoka <ryasuoka@redhat.com>
Cc: krzk@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, syoshida@redhat.com,
 syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun, 19 May 2024 18:43:03 +0900 you wrote:
> syzbot reported the following uninit-value access issue [1]
> 
> nci_rx_work() parses received packet from ndev->rx_q. It should be
> validated header size, payload size and total packet size before
> processing the packet. If an invalid packet is detected, it should be
> silently discarded.
> 
> [...]

Here is the summary with links:
  - [net,v5] nfc: nci: Fix uninit-value in nci_rx_work
    https://git.kernel.org/netdev/net/c/e4a87abf5885

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



