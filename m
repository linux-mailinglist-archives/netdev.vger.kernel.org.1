Return-Path: <netdev+bounces-189406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9E8AB2049
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 01:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A8289E8369
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 23:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4488267B6D;
	Fri,  9 May 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VtzH/G8X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA11267B1F
	for <netdev@vger.kernel.org>; Fri,  9 May 2025 23:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746833398; cv=none; b=eITe0NWXg9lcVSs/1C4/moz06zhfl+1fpysJMyZ7hPt8UkqPNGejnpISp24O1DtVDh2cMIS39fzGBOLhV+U1oxzf+l1Iwt1UHvTmMqXBjwPZywQcUOMF8qwCZMhteX0UTHHYtL0ZR0M6rdt+/TJmZ2tCMxbgvwtjsPm5AZAXRio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746833398; c=relaxed/simple;
	bh=Ux+KUBJ3o/ynp6MZ2GaKiOBMWCb3aUskN8RqFIAtNZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n0b3QJEnIXgUI6TqJ1+ZkLOG+FBdFW8rL2H0TH3IXexZ0zP73COVMN7Y6xg2HTrz0h92b1U5srN8i1H7t77UmRQYRmS6Mau9VilbNXPwrcWg9/G0xprNA540PXzu6o3cX9xioq6BGXjz0fUK2Hdf8IlLjj9Uy5StTsIQ2rSFVE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VtzH/G8X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19FFEC4CEED;
	Fri,  9 May 2025 23:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746833398;
	bh=Ux+KUBJ3o/ynp6MZ2GaKiOBMWCb3aUskN8RqFIAtNZ0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VtzH/G8XjWj38I4YnQ39D8Sq92xMRHfGvcwhbfPcvYI3Pw2WIdkgXmip/TmfBkMnR
	 Z9caTLDpmsEFeaLuR/Ly0WfoBklkWCy7xSXSte5hIdgOj/JD9c6xZD0wFxD+dTHzgq
	 8K92aH98/LLRQ4OfHeWXpbxn8Q0FTI4cgot+MZSpXITlaYVsRcW27cH85p8YNzvVMg
	 YvhkwiANpkWZ8xQvAIqZPL7YdOjl3MtKA6Hu8tOcwGn7z6j4aIYVpY+e9UqhPuAHbF
	 TGc9ETOlkF9lX1iyfGSr5dLNQXzA1eclgfeHYA2UILQjppqYkdWhLj4wyNVtTjw+xC
	 XyoOMfb6i6Csw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADADF381091A;
	Fri,  9 May 2025 23:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: mctp: Don't access ifa_index when missing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174683343624.3841790.10861960505661534637.git-patchwork-notify@kernel.org>
Date: Fri, 09 May 2025 23:30:36 +0000
References: <20250508-mctp-addr-dump-v2-1-c8a53fd2dd66@codeconstruct.com.au>
In-Reply-To: <20250508-mctp-addr-dump-v2-1-c8a53fd2dd66@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>
Cc: jk@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 syzbot+e76d52dadc089b9d197f@syzkaller.appspotmail.com,
 syzbot+1065a199625a388fce60@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 08 May 2025 13:18:32 +0800 you wrote:
> In mctp_dump_addrinfo, ifa_index can be used to filter interfaces, but
> only when the struct ifaddrmsg is provided. Otherwise it will be
> comparing to uninitialised memory - reproducible in the syzkaller case from
> dhcpd, or busybox "ip addr show".
> 
> The kernel MCTP implementation has always filtered by ifa_index, so
> existing userspace programs expecting to dump MCTP addresses must
> already be passing a valid ifa_index value (either 0 or a real index).
> 
> [...]

Here is the summary with links:
  - [net,v2] net: mctp: Don't access ifa_index when missing
    https://git.kernel.org/netdev/net/c/f11cf946c0a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



