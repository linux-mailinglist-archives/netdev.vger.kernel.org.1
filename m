Return-Path: <netdev+bounces-138201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0CCE9AC96A
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:50:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6598C1F219C5
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B38D1A76C4;
	Wed, 23 Oct 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWCVD7nl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65DA949652
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729684224; cv=none; b=U0++fwopapMZXNYqsrOaEhvrO/uUtztFd4Oflxtsqk8Eva0PFjgTqABXuGWyDIjroH1PUEU63/LmedLcuAmI4FbO6Z72qllMVLTMmdgubB3e92OrpVB+A3l3nE7dp5wEkHDvrkoFx1VHQjojlj6lGr2ALVNQ5+5WhK4Ubaqwdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729684224; c=relaxed/simple;
	bh=UpZQI/HgFWVyDdcqAjTSxa+w1EifMtdRaI8R7ihx+ME=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Urb3eeEFjEBBjzPDCH/vOIvBQ4pZr0ifD7bZC1HZmMYJ0bP3pzaJPSLJ3TkQM2p0fDXKinEJv4WqFt/4PrScM0AtTJLHsEQVNDoLZwWLAFFDXwVK4DxpWDpZrGmNuTJE2lqcLsYnrFFHWyBHZ9Bl33+5kvgub5ZddAi5CX9nMAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWCVD7nl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E63C4CEC6;
	Wed, 23 Oct 2024 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729684223;
	bh=UpZQI/HgFWVyDdcqAjTSxa+w1EifMtdRaI8R7ihx+ME=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HWCVD7nlNhmygOYJQuvGWw3Tn5bCTbMA9ENwQKVjA6GhRB5pg+/8dqNhRN1HLf338
	 sNp3la9ODRybUyxyRWLMxkP5x/K2moLFbux4jcyPL8j+s1n+mPlKm8S4g47zxZAN4X
	 KyMZ44OZZJd1H2PW79ir2sUvBBveWVacsC739nltqEGCXtccnwUhc3lRX00kUcxwm7
	 cPF/nLricl+pgotPyBpRlKcqL3v/4Moe7Ww2PBGJfBk018DnQhutqsnEiqrw4QJF+z
	 U1psfxW1d/0En6prjBxZZwdat5SMvuwX+jUb/S3ePETKQGuB1Rf+BJf3Z4I1foh09a
	 xOlrspc7X2Gpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C693809A8A;
	Wed, 23 Oct 2024 11:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v1] netlink: specs: Add missing bitset attrs to
 ethtool spec
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172968423026.1575504.17452250935151852740.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 11:50:30 +0000
References: <20241018090630.22212-1-donald.hunter@gmail.com>
In-Reply-To: <20241018090630.22212-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, kory.maincent@bootlin.com,
 donald.hunter@redhat.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 10:06:30 +0100 you wrote:
> There are a couple of attributes missing from the 'bitset' attribute-set
> in the ethtool netlink spec. Add them to the spec.
> 
> Reported-by: Kory Maincent <kory.maincent@bootlin.com>
> Closes: https://lore.kernel.org/netdev/20241017180551.1259bf5c@kmaincent-XPS-13-7390/
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v1] netlink: specs: Add missing bitset attrs to ethtool spec
    https://git.kernel.org/netdev/net-next/c/b0b3683419b4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



