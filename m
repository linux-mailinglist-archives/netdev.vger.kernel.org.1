Return-Path: <netdev+bounces-78831-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7429876B48
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 20:40:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1786281A75
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 19:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD7B5A7AB;
	Fri,  8 Mar 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c8cfwU2F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3789E57882
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 19:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926831; cv=none; b=FjWTGEAID0qwmQUnxXn8xHRVPkVUhAAdEzyOeSbeGtZGHLYC7lF+hWLFd/HP0hKT0TBVNRWnAeBlZm5z+ndgUO2g8iD2VMXe/+kW+igyEDoQRDJhZtk15vT0VIKfChanxRlqaioUlQkMwjccCbGaKugwvO5BGm1brdQx4yvv49M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926831; c=relaxed/simple;
	bh=RjYEQQ1gG3MReaAX/sxGmMj3GM2hUxZMYbc009YKtrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T37/59OMiytOZHfRe/lrge4efLDF+s3j3hLTszFl+oIRPNClVH0qH/WG3rZByEM5xGyj1kO/Nfl8VFRNzJZVNSNfsnP2M6pev5OIgkn/I4ibZ6IpQchlWiBaM26qM4e3szOWVgUnkwLir/nx0QmXYYYV+N4Eg6crH6MjKPjLXkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c8cfwU2F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E76E6C43390;
	Fri,  8 Mar 2024 19:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709926831;
	bh=RjYEQQ1gG3MReaAX/sxGmMj3GM2hUxZMYbc009YKtrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=c8cfwU2FhiUL/cz0nbiVeI2KjOiomrDJyu7FeyWPN/7ZMulEWxlzPM6t2dxtF7kxd
	 vHahd5qjgDD056EVJpYI2hDHAzrMSNn9d0/Yzt9zhqQciFhbMv2CUua+58HB8HgRk4
	 rdX+nUyF7zCfNLRGMW9JtZRiMqSy4fyXtEymDXqG0xrN1hSvCEgAMcr9A33Q7BC8hn
	 TO9j0GrWIfpb/GtVKIIp0b5PFAWDyHbxzC5arzsbOtug5J9mOgWh1lhFPy3ig8Ys/K
	 LqWz2jnJz5rDSdGYomnof3CF6kVCcAWm4xwL3+AZFBlS4Q8MvY6Ap0poJzcJg0TfP5
	 cfl7Zb/R77/+g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CA17EC59A4C;
	Fri,  8 Mar 2024 19:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/3][pull request] Intel Wired LAN Driver Updates
 2024-03-06 (igc, igb, ice)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170992683082.9448.10703615335638966640.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 19:40:30 +0000
References: <20240306182617.625932-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240306182617.625932-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Wed,  6 Mar 2024 10:26:11 -0800 you wrote:
> This series contains updates to igc, igb, and ice drivers.
> 
> Vinicius removes double clearing of interrupt register which could cause
> timestamp events to be missed on igc and igb.
> 
> Przemek corrects calculation of statistics which caused incorrect spikes
> in reporting for ice driver.
> 
> [...]

Here is the summary with links:
  - [net,1/3] igc: Fix missing time sync events
    https://git.kernel.org/netdev/net/c/244ae992e3e8
  - [net,2/3] igb: Fix missing time sync events
    https://git.kernel.org/netdev/net/c/ee14cc9ea19b
  - [net,3/3] ice: fix stats being updated by way too large values
    https://git.kernel.org/netdev/net/c/257310e99870

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



