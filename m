Return-Path: <netdev+bounces-105300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4641A910633
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:36:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 539411C212FC
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 13:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4859E1E536;
	Thu, 20 Jun 2024 13:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bw0kfx2a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B9812E4A
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 13:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718890228; cv=none; b=ifVY0pa4pzuHyRGIIx/gj3uzDrYPGcueCbh5C3mqKHIA4D0bIdpzIydzFkhfZSVv88ji4fsR0vEWx0b8IMhsFg7w8/Lu7xYGKju5itRcgp2uAFVVVqRO9AKVIur9iUEqeglU9g/XkY7heUaGP1NfnQo4xxIjvJV90It1XL4qDKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718890228; c=relaxed/simple;
	bh=h9MiGC4MpG75aIqXto8y6TqERV6jAdB04prvelNgaLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g7YLLyP0m67xpZ/ouMr6xg3FT9nmBrof1gVjkQy+1HuUfchKb+FHwAcAtniibtgv5xvoTGCk7ib5iJmEMbzRplbdMHojWkh2/Z4aEQiIZolWrip4PFaIyB9ZK3YVbekIxSagShmMVW8els7NQkrBcxjXAChkACgCg8IOkEBxoro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bw0kfx2a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9787BC32786;
	Thu, 20 Jun 2024 13:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718890227;
	bh=h9MiGC4MpG75aIqXto8y6TqERV6jAdB04prvelNgaLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bw0kfx2aZwIGSZBaV+PogUbMXy+KwBsKxtODFjliM6SJ6xxRjsk1M7nDRQYN07G6g
	 IgbTEFuYT0wZ3RTb51ajdisn+Swjg8H47Rv1MhippZ0EqJIW+q9/eAvSilrYrBJRsw
	 hhJ/g6z4Qt+g76bMKIGjhPeEqHplVSVITwsOuHo1KiI6oKSfu0+R6Of+bAG6wDu1Wd
	 Flp9tOKK5ifaMRI20OLrrTogYtdlDnw49Qtnk5MFW3mSZThWaxVQBnO2kOmHVvGPfE
	 /MhCDiZuxssMxpi68RLwurlgRxwf97/YUovIQ7qZ8vk6QPiJxAGEC7+bmPBzJxbghZ
	 ux52r+hZGSW8A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 80FF6C39563;
	Thu, 20 Jun 2024 13:30:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] igb: Add MII write support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171889022752.30107.6589414574110706329.git-patchwork-notify@kernel.org>
Date: Thu, 20 Jun 2024 13:30:27 +0000
References: <20240618213330.982046-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240618213330.982046-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, jackie.jone@alliedtelesis.co.nz,
 chris.packham@alliedtelesis.co.nz, andrew@lunn.ch, jacob.e.keller@intel.com,
 himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 18 Jun 2024 14:33:28 -0700 you wrote:
> From: Jackie Jone <jackie.jone@alliedtelesis.co.nz>
> 
> To facilitate running PHY parametric tests, add support for the SIOCSMIIREG
> ioctl. This allows a userspace application to write to the PHY registers
> to enable the test modes.
> 
> Signed-off-by: Jackie Jone <jackie.jone@alliedtelesis.co.nz>
> Acked-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [...]

Here is the summary with links:
  - [net-next] igb: Add MII write support
    https://git.kernel.org/netdev/net-next/c/a012f9a752a5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



