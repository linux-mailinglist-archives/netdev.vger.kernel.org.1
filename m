Return-Path: <netdev+bounces-139945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5806A9B4C4E
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 15:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFDD2821BB
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 14:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273DD206518;
	Tue, 29 Oct 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES3lH2vh"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01426206071
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730212829; cv=none; b=BCvcob6VgOJBA8F7Ur6TUKJbkGmKD/KKVHKqplMyImTxLMrhae1gQwbe4OEhhTlExRQefvoT99jPn4aMf/P+weQqUJ0HknjlsKCbsoupcuH6rvKZlDgCNXiW1lsjLSKukZj+gbPZNNXg9aEh1QgXL5u/9Fy3TVQLOjHxDmT5Wn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730212829; c=relaxed/simple;
	bh=cjm8czkDFDxcCPGLZy/KAhl0Z8Y2T03EJ0XpPaNyXfc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=haCDEvbs/l8iLHG8tM16dc2xleSEjCpXzSbWd3j54JaaV7vEXZ/52og+fSZJp7uxGkkTNXR8XE+nFocUW2ph9EEMOca5FDS2Qd7l3msjWTQh7etCnH7v/Y0DkrwaMgM0oluz1YIHfLE9vYZ1V88eadvWEO3H3rGC5k3KKrRs1bc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES3lH2vh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E477C4CECD;
	Tue, 29 Oct 2024 14:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730212827;
	bh=cjm8czkDFDxcCPGLZy/KAhl0Z8Y2T03EJ0XpPaNyXfc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ES3lH2vhF8Z/QRYFpLe97wlIrdFqw7NeBbN0xTAuxlhzDAAtw9hRXZ4nDz8eiXYe/
	 RlE9uWZuL1J05SDGhgNDVSH+u9lSewpu2xGlsuL8qzn8nXaRg0Y4Xk9suApgDUNLx7
	 qC4EnM48kDF5i9cCpymWZZA6jQHB2EJBtY0gUaPThnlC/QgZk4bjN9XuvyFagRgUTI
	 GXlipeF0T0QThSc1AaZ5tBHxczsJ2gN2inUz72pDjoqa2YUdhhjjTOyUWMljDBldAT
	 ISh77mJOhHVUeE2PlrUorRGjHcbyOuGCU6mHoW9RAhi0zYZvHlGDR4yOhMv0rKqTT2
	 BuE6MqRLZgpVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345EC380AC08;
	Tue, 29 Oct 2024 14:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3] Intel Wired LAN Driver Fixes 2024-10-21 (igb, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173021283501.714259.1143210534617901464.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 14:40:35 +0000
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, jgarzik@redhat.com,
 michal.swiatkowski@linux.intel.com, piotr.raczynski@intel.com,
 vadim.fedorenko@linux.dev, milena.olech@intel.com,
 arkadiusz.kubalewski@intel.com, michal.michalik@intel.com,
 netdev@vger.kernel.org, jiri@resnulli.us, wander@redhat.com, yuma@redhat.com,
 rafal.romanowski@intel.com, kalesh-anakkur.purayil@broadcom.com,
 karol.kolacinski@intel.com, himasekharx.reddy.pucha@intel.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Oct 2024 16:26:23 -0700 you wrote:
> This series includes fixes for the ice and igb drivers.
> 
> Wander fixes an issue in igb when operating on PREEMPT_RT kernels due to
> the PREEMPT_RT kernel switching IRQs to be threaded by default.
> 
> Michal fixes the ice driver to block subfunction port creation when the PF
> is operating in legacy (non-switchdev) mode.
> 
> [...]

Here is the summary with links:
  - [net,1/3] igb: Disable threaded IRQ for igb_msix_other
    https://git.kernel.org/netdev/net/c/338c4d3902fe
  - [net,2/3] ice: block SF port creation in legacy mode
    https://git.kernel.org/netdev/net/c/3e13a8c0a526
  - [net,3/3] ice: fix crash on probe for DPLL enabled E810 LOM
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



