Return-Path: <netdev+bounces-67413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA184340F
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 03:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F1F283782
	for <lists+netdev@lfdr.de>; Wed, 31 Jan 2024 02:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC7D281;
	Wed, 31 Jan 2024 02:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PzJzfwHb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5B3E576
	for <netdev@vger.kernel.org>; Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706668827; cv=none; b=KcbX+pzujw8Hai3YVUIdbFouDTxRVzCWReoVAYc/JRXAUHdN2gi8/uACBDz87rznI5GQnHbT5+0Ru8iOf1gmV4+9p41RlY3LNoBisf7R1BrYipcwGAZtDTkTvk3TSmh1bYHRTuA05Evc/bou1iU9eneZf9uLNvibYKJuxkspSbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706668827; c=relaxed/simple;
	bh=ou8h9RWtFTwYbrIkq5VinVskN7WC04WhMSdBPie+ZpY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qwnZMTxkd/MFIrJhHAUVJWM+9HWKlAbSF5eziX5cD6Ct12jbe1T+VaveBAOqYKm/p8g0g0w21v3xO6zfAkMEsFJ/BZDngEB6C8fifeYhpqiYVnF4hPZS4YxO2t4udgEcL4xxkChk/1j7ixd08caxIn9mwL9XMw9AICzH8M0ujXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PzJzfwHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8D020C43394;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706668826;
	bh=ou8h9RWtFTwYbrIkq5VinVskN7WC04WhMSdBPie+ZpY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PzJzfwHb0N1ieciTHBmMNvyCgLjowOP3c8CFK2F1rwSNRIBR+/joj5j6jyQYbhksl
	 P2POXdV7tt8joLOXdBzxva+Sn3huzwbIo6U0Xo9miTB7VTwc3A0ODqHVSBTf+30WXT
	 M5wQAePr2JVRWofUhSUc7q919CG3jrFrzIicvZ5FcF6x5Ffk/ZaKxGqk0D3QSZafII
	 7zsayneITd9x3xP9dUP3dXsMmFC/LNOXuXXKCuqIPEQyiIKlPNtP/e5lGlCMgS22EL
	 PipnN9tExHOIGw/YELHtFdZH1rj5T+HFyMSOxIW9EzCRYwuFEF2LHg6+hobZ5U1w7D
	 u3nTlAh2FWSUA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 72F6FDC99E7;
	Wed, 31 Jan 2024 02:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates
 2024-01-29 (e1000e, ixgbe)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170666882646.24091.17698785883375480869.git-patchwork-notify@kernel.org>
Date: Wed, 31 Jan 2024 02:40:26 +0000
References: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240129185240.787397-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Mon, 29 Jan 2024 10:52:36 -0800 you wrote:
> This series contains updates to e1000e and ixgbe drivers.
> 
> Jake corrects values used for maximum frequency adjustment for e1000e.
> 
> Christophe Jaillet adjusts error handling path so that semaphore is
> released on ixgbe.
> 
> [...]

Here is the summary with links:
  - [net,1/2] e1000e: correct maximum frequency adjustment values
    https://git.kernel.org/netdev/net/c/f1f6a6b1830a
  - [net,2/2] ixgbe: Fix an error handling path in ixgbe_read_iosf_sb_reg_x550()
    https://git.kernel.org/netdev/net/c/bbc404d20d1b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



