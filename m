Return-Path: <netdev+bounces-122501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF18961872
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 22:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29370283BE2
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 20:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9600C1D3183;
	Tue, 27 Aug 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttFSWVhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70ABF2CA6
	for <netdev@vger.kernel.org>; Tue, 27 Aug 2024 20:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724790030; cv=none; b=R6Tdznhnwl1TFqkVrkIH4uQLtdC1Xv9B4+JZCp7fFJh7LhqXK/nJRusPIc+0pz+DFjC+svPCempzC0YgcaPrEf3MDFzq8FOc7y/102wEfmT50vr7o9a+yIyZPqRODP8t1xKm/O8eVNKB17crLRFjneCUkdw66X262i/P+g4iTP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724790030; c=relaxed/simple;
	bh=Lzn4+By5M55nO/5BienaPwW9TDU93s+r+Hb3j6y/wmI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rmsqtfKZcH+AQq46V88ZzztaEhtUOdHdL8pERW/OePQyEY38WtJYgqW5BQPbrPmjHf78QzoCmr4z4wigCey75fwdNl59ShpS/sXQuLHS9M/uZezZoSDiQjKeCKVVDqCiW3xkS+cXJNiAvseiPKe8rv8NKIuJNeDRlpzTR6DnUMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttFSWVhy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0BA2C32782;
	Tue, 27 Aug 2024 20:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724790030;
	bh=Lzn4+By5M55nO/5BienaPwW9TDU93s+r+Hb3j6y/wmI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ttFSWVhyB+/7M3ZmALGw8qwcGJ7XKATNlsl2ijtJi52KiFkNSoFbrUTb9erFvwU9e
	 RTAQLndR9Zy/m13QYp1Q29SxxIJ8OvbiKuSrgR21zblxZXFBlocv7g+b4xHIA2kyiW
	 R3yQgyLIQUEvInpAAkTPUPeJObU60D5xg/++vKUo+szY8xxJ9dwpl25ca9a75P2w65
	 hwBmB+Pe3f576dPXTLQyTpru3Nn3SrXxGkLRvIZ9p2gmWfyl7CaZkc4fAF6G10ZQXJ
	 y8L1ATy2vCnYDrVdGGR2f2FtpKm3KLYt5DgeHHykcM9ssq+WSpUtvBXrkinY9gwpMt
	 oUSw1iMLnEk5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 349823822D6D;
	Tue, 27 Aug 2024 20:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V6 0/3] Fixes for IPsec over bonding
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172479003002.753271.9461945323497406231.git-patchwork-notify@kernel.org>
Date: Tue, 27 Aug 2024 20:20:30 +0000
References: <20240823031056.110999-1-jianbol@nvidia.com>
In-Reply-To: <20240823031056.110999-1-jianbol@nvidia.com>
To: Jianbo Liu <jianbol@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, jv@jvosburgh.net, andy@greyhouse.net,
 saeedm@nvidia.com, gal@nvidia.com, leonro@nvidia.com, liuhangbin@gmail.com,
 tariqt@nvidia.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Aug 2024 06:10:53 +0300 you wrote:
> Hi,
> 
> This patchset provides bug fixes for IPsec over bonding driver.
> 
> It adds the missing xdo_dev_state_free API, and fixes "scheduling while
> atomic" by using mutex lock instead.
> 
> [...]

Here is the summary with links:
  - [net,V6,1/3] bonding: implement xdo_dev_state_free and call it after deletion
    https://git.kernel.org/netdev/net/c/ec13009472f4
  - [net,V6,2/3] bonding: extract the use of real_device into local variable
    https://git.kernel.org/netdev/net/c/907ed83a7583
  - [net,V6,3/3] bonding: change ipsec_lock from spin lock to mutex
    https://git.kernel.org/netdev/net/c/2aeeef906d5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



