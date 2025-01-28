Return-Path: <netdev+bounces-161305-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F1ABA20940
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 12:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8761E18893C9
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 11:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BD119F11F;
	Tue, 28 Jan 2025 11:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYLR5pLk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162C519B3EE;
	Tue, 28 Jan 2025 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738062605; cv=none; b=f4rPASBxy0Rb7jum09ZYUevBPP5ZQSbDbOdprd8RNB5GugnuE0Qr6BeS3lJWhBwrJGo9QjjmZ6Syn0ULlNlgzgiTm2ukr8/HFpCieL7SLUJ3J+CRp0uuR7pntwAP1ph5DP8kdH4xDuUeRSg7oqCuSFfpUaFqyx85xntJA/uQU9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738062605; c=relaxed/simple;
	bh=EBH7wpaN+rW1juwiRHGZVLDhgPBv2Sr97TKB2ghTtfs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lhnp8chmlbkL8r2cBdLBjuAp/HJTXDvdYpozm3LcETBTHR/hV81WTGEVU908Ljam3PP5YwGd19N5XajwYzU5VaS/hAFCNHu8KH/Eau7QjSH/okhzac/M4PZpuxSPow75ZZ+OVqt9NzLk3ubKc+HZduCIM5O9V77Fy6wXB0Lqm34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYLR5pLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AED6C4CED3;
	Tue, 28 Jan 2025 11:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738062604;
	bh=EBH7wpaN+rW1juwiRHGZVLDhgPBv2Sr97TKB2ghTtfs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AYLR5pLk58FoxssSxF/fEicy2oEyfg4NA3cNas9qZAU/nvYmfUew4ztdrMCJym6u4
	 cmi8m9VqWO57dIHW+GN/b7L2XwgnZKF3j/XdmHg976KVOA5jajO3EVGH/lb1W/Y37/
	 4kiB7dtMrmkVt1CwKmwEyJtOcYY5GI/WrVGjlHMa8H7gQwJxE77u/0CqLS51+VMPDO
	 iMnOS9m3TrfhtWlCj1wQ3IlJju6+w9Hu9wnNE6h6nlJtDcLAj3A45lk3MqXe3t5KgU
	 8n4G/omzVZKjrJe/IFsvrn7Z0zDkMC5wGWQtsswZva2s1YP1iM/VKMhfnooV332oKR
	 ooHrraznTqbsw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FAC380AA66;
	Tue, 28 Jan 2025 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: usb: rtl8150: enable basic endpoint checking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173806263026.3755886.9954145283968687793.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 11:10:30 +0000
References: <20250124093020.234642-1-n.zhandarovich@fintech.ru>
In-Reply-To: <20250124093020.234642-1-n.zhandarovich@fintech.ru>
To: Nikita Zhandarovich <n.zhandarovich@fintech.ru>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 syzbot+d7e968426f644b567e31@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Jan 2025 01:30:20 -0800 you wrote:
> Syzkaller reports [1] encountering a common issue of utilizing a wrong
> usb endpoint type during URB submitting stage. This, in turn, triggers
> a warning shown below.
> 
> For now, enable simple endpoint checking (specifically, bulk and
> interrupt eps, testing control one is not essential) to mitigate
> the issue with a view to do other related cosmetic changes later,
> if they are necessary.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: usb: rtl8150: enable basic endpoint checking
    https://git.kernel.org/netdev/net/c/90b7f2961798

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



