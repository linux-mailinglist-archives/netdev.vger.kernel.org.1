Return-Path: <netdev+bounces-153574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 456259F8A9D
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 60BD41888AFE
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 03:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E6B94501A;
	Fri, 20 Dec 2024 03:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hADNCNpe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEC41A0B04;
	Fri, 20 Dec 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734665424; cv=none; b=daNzNiXhHyngtxuPsAbUgshKkfNZ2jW39p9nw0Qlnl6Bb6POPJeb1sYKN0bwg9Grk16AfV+coiKnsXwB/OV5uiEXDUd3gD+TMAjWjxUQykz+gXeGWwLmHrfFWeAY1AN+93QF31k3N7GbFeo5XeV/gV0i+MKFohrBmOrchcymWRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734665424; c=relaxed/simple;
	bh=gws3hjmJGflzi0qzwZkugs8TXl5J9BXijUhwFaR93mg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tENB5+JjV0aiyvmSUSRB/1u2hLT6dE77Sz9Ivxa5nDqYhfBmZKK06hdWNtwd9TBP80/Xvfqt44pGZfxqM4mRmOgdHwjMC5p58OtXyNhKjakHhguqUVmNLr14GQmcXO+2yiteZSqzZEPrchjt8I88dibMoM7fhkxDFsmV8L6lV+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hADNCNpe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B061CC4CECE;
	Fri, 20 Dec 2024 03:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734665423;
	bh=gws3hjmJGflzi0qzwZkugs8TXl5J9BXijUhwFaR93mg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hADNCNpeTRrmHNO7LoaIlvvCTfj3NCuv4ISxer9o7Crb0hnhgWRjO8SGGsEAQMke6
	 dhA8obAsnntPOued2IrwO63eoFQMA62zaVC/+04XqSBdGR73Sw68PRh0GoW5yOhqmK
	 +TLdTVdKW/H2db0TuQ2ggh6a+haiSNlD0rmuXk1U9grdpEYwhQytQeTsQ1146Jspnr
	 ECgoB2RfCga50DfrW8V82uHWPpsPy0j8KpEdwHKAfgH0sXoEonhb2GdQhJ6lGnv1j2
	 k1VEiOEmMAGkvLVbCLxJ6kXcJUdcnaw40llhtWKzW1xkhVy3abegBsO5cN6+z/+z2u
	 zgvL4eDk+A7gQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB6A3806656;
	Fri, 20 Dec 2024 03:30:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: Document netmem driver support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466544121.2462446.7135397928871556841.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:30:41 +0000
References: <20241217201206.2360389-1-almasrymina@google.com>
In-Reply-To: <20241217201206.2360389-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Dec 2024 20:12:06 +0000 you wrote:
> Document expectations from drivers looking to add support for device
> memory tcp or other netmem based features.
> 
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> 
> ---
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: Document netmem driver support
    https://git.kernel.org/netdev/net-next/c/f6038d913b13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



