Return-Path: <netdev+bounces-235346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EF6C2EE0D
	for <lists+netdev@lfdr.de>; Tue, 04 Nov 2025 02:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 53B424E3321
	for <lists+netdev@lfdr.de>; Tue,  4 Nov 2025 01:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B0622FE0E;
	Tue,  4 Nov 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hhJzu+p/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 599A472614;
	Tue,  4 Nov 2025 01:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762221031; cv=none; b=KR7qRbt7c8WZKZ0L7nyrAhFlXGsiCtcqzrMLQyyv2PL9pYaRHlFw5LNK/QtzwXfa3oWTcLM57j5thyjgTrWWOu24tci+KhoN5lUxp1gFeCE1Uh8wkQCiVcst5oVg9hIlnykJCnepNtf/QUNKAyxBgSQeGPvWQ/oED7FlRO1byig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762221031; c=relaxed/simple;
	bh=xyeWkEmQlljnPJHBF9+EF6BPKwFsQyNjI1lK2r9HxhA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tIPD/M4Lqut/Tjhzg/vj4xoZeq9r0OQHa/8fakL9ePEeNt5Rd/2Z0abk3idBSYRAntQ5s6sQua41KV+Q2wa8Z6F/oydQKAPAedi7e8zZ7iBpsFOATu7PmPa2MtQ6voj1jkMWxaQHWIUpae8EM1qayaSvoPUCZ2m+f+lno69GvUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hhJzu+p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E434AC4CEE7;
	Tue,  4 Nov 2025 01:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762221030;
	bh=xyeWkEmQlljnPJHBF9+EF6BPKwFsQyNjI1lK2r9HxhA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hhJzu+p/tRpudvXCM5qq4mUt329iyPbzFNwbtysQsOBoDStgsUXA4Zjy5NPvkh4NC
	 FNOfOSFyjJCYdsUS+V37PbJZFpZ/zEITfUK1wZuX6BiVeflEYiOqVlp7MiBKdEMah1
	 nJ2gnQbo5G2vHrxFuz1NCUKsce2/Cy8Lyf5JlmVSEWg/KfkxoxMTs5JX4qleVFrDAP
	 Z9MpHaZDSGqM30BOsbU47uZJGA19ImzvEwrfN4PHdFw3iDJzHRLq85VABDjv6C39sI
	 Wzu+M5VBHfNnpk3gIWtfffARBWsmSvwZRh1SvdzJW6YXpnua1FGAwHdGSUK4AcNRFb
	 5IozqDiVcaTeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D923809A8A;
	Tue,  4 Nov 2025 01:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: usb: qmi_wwan: initialize MAC header offset in
 qmimux_rx_fixup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176222100525.2288210.7982486320595194051.git-patchwork-notify@kernel.org>
Date: Tue, 04 Nov 2025 01:50:05 +0000
References: <20251029075744.105113-1-qendrim.maxhuni@garderos.com>
In-Reply-To: <20251029075744.105113-1-qendrim.maxhuni@garderos.com>
To: None <qendrim.maxhuni@garderos.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 08:57:44 +0100 you wrote:
> From: Qendrim Maxhuni <qendrim.maxhuni@garderos.com>
> 
> Raw IP packets have no MAC header, leaving skb->mac_header uninitialized.
> This can trigger kernel panics on ARM64 when xfrm or other subsystems
> access the offset due to strict alignment checks.
> 
> Initialize the MAC header to prevent such crashes.
> 
> [...]

Here is the summary with links:
  - net: usb: qmi_wwan: initialize MAC header offset in qmimux_rx_fixup
    https://git.kernel.org/netdev/net/c/e120f46768d9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



