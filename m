Return-Path: <netdev+bounces-46743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B118F7E6267
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 03:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28C0A281210
	for <lists+netdev@lfdr.de>; Thu,  9 Nov 2023 02:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2BBA5257;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SwrDndz+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43864C8D
	for <netdev@vger.kernel.org>; Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6192FC433CD;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699498231;
	bh=VVBmLj0eDjzMkKfK9rO4gAdMvCjI1ktytsggx+qqXXU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SwrDndz+w/81QRUrHI2CZnJGjsMaQskvQhQeqTDJUfCq5tUYdFWyqK+Qt278BV7Rw
	 7tLTym5sjwjlyyezhf06zzTlBFPsvW5rs55tyLJVisMNWb7OT5eJiFxfQMAUoAXhay
	 mUPtH//IqdRIkhCdwv4OhXuKJY0MXLXey4o9DtbvNKi6fAVif/mU/XRZ8jV/llwRok
	 jqpLdpQRZuHbL/heCwg5pGaJA/9FmJrDeyj02uIIW1wFxnuOrqgnGSImGroAYCIFHE
	 bQAHxOxoqwuL9xntvIp7aD4b5Qds4IQ9achEPbfDBmQS/dwvXktq3QnKnzM4/ibtO9
	 /j44LenpTW43w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CA53C3274D;
	Thu,  9 Nov 2023 02:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4][pull request] Intel Wired LAN Driver Updates
 2023-11-06 (ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169949823131.3016.7741891691059813608.git-patchwork-notify@kernel.org>
Date: Thu, 09 Nov 2023 02:50:31 +0000
References: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20231107004844.655549-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon,  6 Nov 2023 16:48:38 -0800 you wrote:
> This series contains updates to ice driver only.
> 
> Dave removes SR-IOV LAG attribute for only the interface being disabled
> to allow for proper unwinding of all interfaces.
> 
> Michal Schmidt changes some LAG allocations from GFP_KERNEL to GFP_ATOMIC
> due to non-allowed sleeping.
> 
> [...]

Here is the summary with links:
  - [net,1/4] ice: Fix SRIOV LAG disable on non-compliant aggregate
    https://git.kernel.org/netdev/net/c/3e39da4fa16c
  - [net,2/4] ice: lag: in RCU, use atomic allocation
    https://git.kernel.org/netdev/net/c/e1db8c2a01d7
  - [net,3/4] ice: Fix VF-VF filter rules in switchdev mode
    https://git.kernel.org/netdev/net/c/8b3c8c55ccbc
  - [net,4/4] ice: Fix VF-VF direction matching in drop rule in switchdev
    https://git.kernel.org/netdev/net/c/68c51db3a16d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



