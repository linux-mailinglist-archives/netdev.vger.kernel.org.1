Return-Path: <netdev+bounces-249647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BFFD1BC8B
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE699301E5A4
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 00:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5270D2BCFB;
	Wed, 14 Jan 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TgV3+5Ff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8A9944F;
	Wed, 14 Jan 2026 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768349613; cv=none; b=G7EaOi0Ya+AmPfZIDLxS620/U2it2WQJSDZClDYQQLA6mZNW57QmMfvcrynbbscJboO2BzPG8hpDc1MqWU9TMXs1VTuLgju7x+g9CL6lR++8dUBOYD5GUf1pfOaOyhF7NcGGhcU+w5ufjYdkuNRNR/eD5rJd1yDvq6upv/2q+AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768349613; c=relaxed/simple;
	bh=aqnHze+Td25OVXDIGdgpRDIRDAM53FeOGdj9+wWFseY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DW+HDFpj2NoItVT01wtVhXIhHtrI7IOMWauUbu9DK4YKqLG9C8qX/c3wWwjCjhHS/jwOy4Z542MhQS671LozkKy9YkSVjjWzZviDaDwYiJTb8OQYrbUkOTTgqsYj18isZj675/XCWqacsa3m1KC3TfVdKUdYmT50MUkGTzTR/ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TgV3+5Ff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEE8C116C6;
	Wed, 14 Jan 2026 00:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768349612;
	bh=aqnHze+Td25OVXDIGdgpRDIRDAM53FeOGdj9+wWFseY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TgV3+5Ff8t0/g8AniA+UuBLz/Te7zln4zP21xGOw2JnnTMj3jDJZ1Dwk5FMA0H9Dj
	 +OqDCfjpRGBvu0BYh6LnMFQePJ+g2bRtpcVOztF22fRiNA4a/mD+R1Hs7FISM5rNHF
	 jhvfjvXWOxbz+dcGEaUhuQ3+PUjGO78rX5xPY4bimyAvbd1upIk2XmMTl7jHaZxBzw
	 fAZRM+6nkobv7zU0ij/QyB9vBixc6RPODIg38Qr2hX1pWFehiPkTHf2d+fru2zP45w
	 reobcE+PZXhrQ72FSvth9pxLj+AknWR3iaYJ+SjLQ606c9dQf8jc4aPtDAOOlrmboM
	 tjQ4mazH7TALQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B9D93808200;
	Wed, 14 Jan 2026 00:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] tools: ynl: render event op docs correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176834940605.2527918.15409968883446606893.git-patchwork-notify@kernel.org>
Date: Wed, 14 Jan 2026 00:10:06 +0000
References: <20260112153436.75495-1-donald.hunter@gmail.com>
In-Reply-To: <20260112153436.75495-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: donhunte@redhat.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, corbet@lwn.net, linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Jan 2026 15:34:36 +0000 you wrote:
> The docs for YNL event ops currently render raw python structs. For
> example in:
> 
> https://docs.kernel.org/netlink/specs/ethtool.html#cable-test-ntf
> 
>   event: {‘attributes’: [‘header’, ‘status’, ‘nest’], ‘__lineno__’: 2385}
> 
> [...]

Here is the summary with links:
  - [net,v1] tools: ynl: render event op docs correctly
    https://git.kernel.org/netdev/net/c/fa5726692e4c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



