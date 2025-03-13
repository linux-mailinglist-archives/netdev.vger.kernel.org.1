Return-Path: <netdev+bounces-174765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AA8A603CC
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:00:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0373AE988
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899951F4634;
	Thu, 13 Mar 2025 22:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHHXZDvc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618CC7FBAC;
	Thu, 13 Mar 2025 22:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741903222; cv=none; b=uJTHB75aUelr/aWVnFYth0lahX/NLuD623cHMHdgsXTP5uidlZ84qM4YIkfgngKlgp3r4C3PoP7lowCRRigucaNwUA9ZPrup4YBVXeKq07/18pKoknkVfqjp+kxb0eUGeC6en1AT6z0s/If+LNwFo8nf/c3D2YFRb+8ygunag6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741903222; c=relaxed/simple;
	bh=UQYKNY0RG7DHAmX7JHu16iMKRFHg2Xbo77zTHiWsMfo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CQS12c+fzJXaWNlVn/UJcNdrWxQ/lSjx4TkzhHUQcMmbOHQbMQq9VDwKfOpR999rWBCdGAU6c8pqjz458ZfMfKjzMPaBlE9v7BuaPjhskwepU1xeOauxcKG3qbRSfgoZO6YWeBFczMAbtsiPyG1ZPtFKX3tfCr6S2chaJj1DxmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHHXZDvc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF8C6C4CEDD;
	Thu, 13 Mar 2025 22:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741903221;
	bh=UQYKNY0RG7DHAmX7JHu16iMKRFHg2Xbo77zTHiWsMfo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iHHXZDvcRX8N4WH7548F6sMk9IBybblce0Bdv9PHAojHppBQ/DiSVam6is6fI0jRn
	 rZQ/CNjzvjTR0bwaryYqsMxSxUn+Pi6mxSHUN055jsbGJhsyWMJ123h5Z2GV4V2zlS
	 5Z4LjEqY92bvG8TjoV6vzM3+r54rxPoz47mYaJwlXAo4m63UDiXP/m01ZIfQ+OuzdG
	 FXsfNUSrvU6S6KPblSFpANylwpu0iEGC4AXR7Byrtb5/xY5tbzz6O/Yp9+X13DxrU6
	 4o0nwuIQPw9ZH+Nc8U8QxCjZ7eR+16zlWdZ9VW4rcOzA70xvBgpa5BeckUeDSm49p3
	 1us9nxJetozWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD5D3806651;
	Thu, 13 Mar 2025 22:00:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] Networking for v6.14-rc7
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174190325650.1674705.7511836623566236671.git-patchwork-notify@kernel.org>
Date: Thu, 13 Mar 2025 22:00:56 +0000
References: <20250313154206.43726-1-pabeni@redhat.com>
In-Reply-To: <20250313154206.43726-1-pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: torvalds@linux-foundation.org, kuba@kernel.org, davem@davemloft.net,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Thu, 13 Mar 2025 16:42:06 +0100 you wrote:
> Hi Linus!
> 
> If you have CONFIG_CHROME_PLATFORMS enabled, your config will get
> a new knob, too: BT_HCIBTUSB_AUTO_ISOC_ALT. I hope that would not
> be a problem.
> 
> The following changes since commit f315296c92fd4b7716bdea17f727ab431891dc3b:
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] Networking for v6.14-rc7
    https://git.kernel.org/netdev/net/c/4003c9e78778

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



