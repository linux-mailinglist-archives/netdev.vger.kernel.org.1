Return-Path: <netdev+bounces-179330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 379A1A7C044
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 17:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 059EB176011
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 15:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31C21F3FE5;
	Fri,  4 Apr 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yy1sNhqK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4FD1F3D58
	for <netdev@vger.kernel.org>; Fri,  4 Apr 2025 15:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743779398; cv=none; b=u6mOOzZeQzf4rNxVtWMv51KiFqq/4L7e1v4mKAZ3YMQpDCSknW3FqQfFt4TIpBF+m0kd1IRaF3eyJ1HUnsHBrrzTY/wN8q68/pPM27MOM2CZgtz6BE1CKSh/+7LuOY6yGaVau7wo2nMYN5Qqo4jtu67c4SsZ9yLvJCxYCOh9HXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743779398; c=relaxed/simple;
	bh=VctWM4mw6f1CpNj3DK7jyqi78oGyDMTpzVgxONEemhw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JseSAUik3eEMrUAn71RY+9kiSRexBK0pLQC0EYbfBJrGhQKiEL7GTRNmgu99lEUHD88yeLMFjkKoAPes+SeeZsX/fUUrCNuwjyD3dxclpUKIQUX+4nWzOosIJ/VQ6ugx1KFGKNuWFmv6Q8M6kaLTkxIi/B24Iyh64gFMCPxESUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yy1sNhqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C52C4CEDD;
	Fri,  4 Apr 2025 15:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743779398;
	bh=VctWM4mw6f1CpNj3DK7jyqi78oGyDMTpzVgxONEemhw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Yy1sNhqK5M0aMrU45JvdbD0swtkbxHFzGo4FVztNTu1T9e2ZwJcsGybHV2bi4vpT2
	 GBp3le1p+y43yGbm6IACcNiYuQ7Sqe4Dlr8eYl6qQb1uruho9YSgiF6CiTTQIs/htC
	 ALeMHV3dyLcULakbH687oEHBR23NY3vBflTjb8hqq8Vyiqt9yZ3LyzeG0IUeHL2cYH
	 YBJcmlks4BUPjW2XpX8ac58ClaqXjpzicHP6B7k6BS0iOj4vfiLQaeta6wbx96KYYt
	 41jyqCmZCQW+YobxCud1aqXO4+3/HXYkO3mKfmiy8JVe2MXfXkRVABrGJYUYSxY81K
	 yYEKBYwZAiXqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33FCD3822D28;
	Fri,  4 Apr 2025 15:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/2] net: make memory provider install / close paths
 more common
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174377943501.3293273.13049725354845035230.git-patchwork-notify@kernel.org>
Date: Fri, 04 Apr 2025 15:10:35 +0000
References: <20250403013405.2827250-1-kuba@kernel.org>
In-Reply-To: <20250403013405.2827250-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ap420073@gmail.com, almasrymina@google.com, asml.silence@gmail.com,
 dw@davidwei.uk, sdf@fomichev.me

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 18:34:03 -0700 you wrote:
> We seem to be fixing bugs in config path for devmem which also exist
> in the io_uring ZC path. Let's try to make the two paths more common,
> otherwise this is bound to keep happening.
> 
> Found by code inspection and compile tested only.
> 
> v2:
>  - [patch 1] add to commit msg
>  - [patch 1] fix arg naming in the header
>  - [patch 2] don't split the registration check, it may cause a race
>    if we just bail on the registration state and not on the MP being
>    present, as we drop and re-take the instance lock after setting
>    reg_state
> v1: https://lore.kernel.org/20250331194201.2026422-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: move mp dev config validation to __net_mp_open_rxq()
    https://git.kernel.org/netdev/net/c/ec304b70d46b
  - [net,v2,2/2] net: avoid false positive warnings in __net_mp_close_rxq()
    https://git.kernel.org/netdev/net/c/34f71de3f548

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



