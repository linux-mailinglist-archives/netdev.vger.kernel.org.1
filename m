Return-Path: <netdev+bounces-249384-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF311D17DD7
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AC05C3016239
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 10:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A2D38A289;
	Tue, 13 Jan 2026 10:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HD+Io5AA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48DC389E19;
	Tue, 13 Jan 2026 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298616; cv=none; b=G3fzQqBiD2wZfY85Zo5it3kKRryoI4FsYhQTwnkaYg99je9YlR+Qj18F80a0oVgljYic9teVBniSPIc2uUltG0wQ52AOQxRHl8QXuA7/q6fAbWL7k3ehs+e71qQhvShQ9P19HVz6QeuzXx1ArIzu+yJvQ9zFWeC6w9dMzCYjyQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298616; c=relaxed/simple;
	bh=N/JgtIC0F9eFQi2kpAeeEiQOn5k9jMHhvpkpoD30b1Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PAIA5sjA3EFu20mj8QN6eKDWqdD7qcI9akC+yGU9iXL1YB2PmEQ68DT0IlUJ7A4BYpEya4HLfV4mRrkb/cTv/yOqNCoBwIAfJbTFAG8fhDGqa9aWX7gk3v30r+/e0MpNZkn23OGCecRweUl/jlSBLbC+GErwYl6GJFYV7RoF+xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HD+Io5AA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B350C116C6;
	Tue, 13 Jan 2026 10:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768298616;
	bh=N/JgtIC0F9eFQi2kpAeeEiQOn5k9jMHhvpkpoD30b1Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HD+Io5AAjuz9I20SDQz0adeDQnhaUNh0Gxv/SYaa/n9Q6Trb3QdbZbsHh1OjQCYI4
	 F3O3W/DmuercoVJ6+Xm7VIwnx3ROgojXAR8kBa5xUz3RzPLlWm9pIqznFggYmJ1ue3
	 V7bktmKVNjvhAWkFO8HIBMj7K0LJeb6iOFaqLuFL6BozDJ0JRF2izECRTGCPxYQoVi
	 Q6txwM0THmuThENR+hKkx7jqh3S1RAVNpNRoyUWt51zGNt3enTq/6rPFb9lqvUyJwm
	 QbuhNKfphwfCa42PnAuFFQV0ey7uS00tdiG3FacQAVwbeAGeJQj+/NR/Cng9hhiLMF
	 8pH3JKii5YulA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 532853808200;
	Tue, 13 Jan 2026 10:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1 0/3] r8169: add dash/LTR/RTL9151AS support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176829841027.2162163.2380139406681496633.git-patchwork-notify@kernel.org>
Date: Tue, 13 Jan 2026 10:00:10 +0000
References: <20260112024541.1847-1-javen_xu@realsil.com.cn>
In-Reply-To: <20260112024541.1847-1-javen_xu@realsil.com.cn>
To: javen <javen_xu@realsil.com.cn>
Cc: hkallweit1@gmail.com, nic_swsd@realtek.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 12 Jan 2026 10:45:38 +0800 you wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This series patch adds dash support for RTL8127AP, LTR support for
> RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 and support for
> new chip RTL9151AS.
> 
> Javen Xu (3):
>   r8169: add DASH support for RTL8127AP
>   r8169: enable LTR support
>   r8169: add support for chip RTL9151AS
> 
> [...]

Here is the summary with links:
  - [net-next,v1,1/3] r8169: add DASH support for RTL8127AP
    https://git.kernel.org/netdev/net-next/c/3259d2cf9427
  - [net-next,v1,2/3] r8169: enable LTR support
    https://git.kernel.org/netdev/net-next/c/9ab94a32af70
  - [net-next,v1,3/3] r8169: add support for chip RTL9151AS
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



