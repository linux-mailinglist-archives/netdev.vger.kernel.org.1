Return-Path: <netdev+bounces-234244-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DFFC1E152
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 03:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B652934D4B0
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 02:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 531442E9EDA;
	Thu, 30 Oct 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DvgD0crX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFD6FC5;
	Thu, 30 Oct 2025 02:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761789634; cv=none; b=W0w8MjKLEJuS10C++h/f49RLYZFS/Gd4hUbnhmKwtdNQGUaa+Wvp4KuZ2VnDc6iwU83XvcEuwMuUN/7Sy7O/qkCwjHHo1t/6CQIxjwQDQDBW/c43oaqFojgo7jLDt/zQEEcn/2tT8pwRp+KasPV9iLhIQuetf1LyRG0EYxFDYxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761789634; c=relaxed/simple;
	bh=adIWWp6JkooxcKkGWYYawGCvhKj6QLF1nHLdmWN8kTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iKL4d8acscSuxcTcmoloPOVHnn9escCoDu4rLB0LlAlKQBd1XkAcmy3if+4Va+PYZbrJqQr44hEwqeRAvdqwz0cxerY6BdosfrMrr85TYWu/MeE6OWsthnjhoAhSpt/fjexWUIa60HLO7ISnH2SMwpH/KcwH7oMcUEm4yF72PuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DvgD0crX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AF0EC4CEFD;
	Thu, 30 Oct 2025 02:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761789634;
	bh=adIWWp6JkooxcKkGWYYawGCvhKj6QLF1nHLdmWN8kTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DvgD0crXsz2KIHnfdi2gFAs+PUXtkzVqXmU0p99CXOjMOalyelax+Vt3tajwrE6X+
	 pLi7P2vQso326M5CXCD369G0Y/kUzkwJeIq/3WmqLYV9OmVRlfqC4bcxH94Ors1RCe
	 g5sACvH+KPESlK0/hcbU2jOKBJB6SW5X7Z1GWiRzfyncxOddGTimHShWe1HhHhPc3J
	 TLvq89M2lJ4wXUSGW8/4Tmx44Yx0w6Fdkj+2F78x2POLBShSO3YUdkEsIf0GgpBgpq
	 +2q8fzLAL8eM7lcXln+LKoQTc4cIV7C6cgv+3fydUpIDsDAdB/nS0DuRnPu1AYHL04
	 EjEUP9E3qnzhg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C123A55ED9;
	Thu, 30 Oct 2025 02:00:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] net: stmmac: Fixes for stmmac Tx VLAN insert
 and EST
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178961100.3282477.1158388762703076399.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 02:00:11 +0000
References: <20251028-qbv-fixes-v4-0-26481c7634e3@altera.com>
In-Reply-To: <20251028-qbv-fixes-v4-0-26481c7634e3@altera.com>
To: G@codeaurora.org, Thomas@codeaurora.org,
	Rohan <rohan.g.thomas@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, Jose.Abreu@synopsys.com,
 rohan.g.thomas@intel.com, boon.khai.ng@altera.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 matthew.gerlach@altera.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 28 Oct 2025 11:18:42 +0800 you wrote:
> This patchset includes following fixes for stmmac Tx VLAN insert and
> EST implementations:
>    1. Disable STAG insertion offloading, as DWMAC IPs doesn't support
>       offload of STAG for double VLAN packets and CTAG for single VLAN
>       packets when using the same register configuration. The current
>       configuration in the driver is undocumented and is adding an
>       additional 802.1Q tag with VLAN ID 0 for double VLAN packets.
>    2. Consider Tx VLAN offload tag length for maxSDU estimation.
>    3. Fix GCL bounds check
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: stmmac: vlan: Disable 802.1AD tag insertion offload
    https://git.kernel.org/netdev/net/c/c657f86106c8
  - [net,v4,2/3] net: stmmac: Consider Tx VLAN offload tag length for maxSDU
    https://git.kernel.org/netdev/net/c/ded9813d17d3
  - [net,v4,3/3] net: stmmac: est: Fix GCL bounds checks
    https://git.kernel.org/netdev/net/c/48b2e323c018

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



