Return-Path: <netdev+bounces-159730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 41FECA16A88
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 11:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 533EC7A6154
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9683A1B87EB;
	Mon, 20 Jan 2025 10:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NftyrO2C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A86D1B87D7;
	Mon, 20 Jan 2025 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737367808; cv=none; b=aUF8fqDjt44/BBOY4diVL51QF7EPwSG//H/6KX7RVEipgIZCbO9P+/dZeiQ+wLZ5/TlVdRQOpOcJURx6uYj/FGrIOuEO7tKxaTWoMnOiL10SE4tpZLOe5WIYesCVCoU4/1dryUdDgnv/mYkMadTUQXdT6WAyy2OI+yjUz/eHjmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737367808; c=relaxed/simple;
	bh=TPFCKAMe3gVNj10ZQthjkDGlKTZCDMkVH1ZwfKjjTvI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=swoLtOs+C/4hJhwTmzF+EmlEZ6hEUI+mY2Vqb5Yb5eLt7Xf7OhXt6U03qUM01e70He15HHFapeD6tHOPIyln7gnuM9cr5d66rbyZgmelqxJ/KHxioVvsf8MKO2F7BvvR6/6Gm/TAb2kSLaNbQjjDAV/OSfUhoZfL+ZzVHk8DsTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NftyrO2C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2A38C4CEDD;
	Mon, 20 Jan 2025 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737367807;
	bh=TPFCKAMe3gVNj10ZQthjkDGlKTZCDMkVH1ZwfKjjTvI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NftyrO2CkU9WCQTMMx7//gTkD4IWTrx+a0EdLeU8lleJ9Yws489KvX+4HpSCbpcK0
	 hwXrtKT7XyO3GFjBqP5tnA7/zcUVRu3p4B3o8P/P2P0NRA2m6HtBTvDFIf5ULBv9ft
	 N6lSShObGaIzwWKJtzXlu9cxYtBdu1gSu+tI2ZDpawvkhAR4i0huMKmJh4XT0ZiE1n
	 Eb1LTpQBAAAcTDjbfYhNiIUyAN4FFJJndfRGsXzItSdw95sBk5jCi7BobmiYUPnwg0
	 AmjxbWuaz+Y9riHWRe6cCWf0IZ6dbkDNcm/B1WCpQ6xJs6EWe0c8SXspUHhLFHcDC2
	 TEKx5g9/FpkYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACFA380AA62;
	Mon, 20 Jan 2025 10:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: appletalk: Drop aarp_send_probe_phase1()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173736783173.3476879.5069911593463162072.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 10:10:31 +0000
References: <tencent_27DFF9F35BFBF50F6EE024ED508FA8F5FA06@qq.com>
In-Reply-To: <tencent_27DFF9F35BFBF50F6EE024ED508FA8F5FA06@qq.com>
To: XIE Zhibang <Yeking@red54.com>
Cc: kuba@kernel.org, Yeking@Red54.com, arnd@arndb.de, davem@davemloft.net,
 edumazet@google.com, gregkh@linuxfoundation.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 prarit@redhat.com, vkuznets@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Jan 2025 01:41:40 +0000 you wrote:
> From: 谢致邦 (XIE Zhibang) <Yeking@Red54.com>
> 
> aarp_send_probe_phase1() used to work by calling ndo_do_ioctl of
> appletalk drivers ltpc or cops, but these two drivers have been removed
> since the following commits:
> commit 03dcb90dbf62 ("net: appletalk: remove Apple/Farallon LocalTalk PC
> support")
> commit 00f3696f7555 ("net: appletalk: remove cops support")
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: appletalk: Drop aarp_send_probe_phase1()
    https://git.kernel.org/netdev/net-next/c/45bd1c5ba758

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



