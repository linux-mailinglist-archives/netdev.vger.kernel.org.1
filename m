Return-Path: <netdev+bounces-186832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 305C5AA1B2F
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 21:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76B8E1A885DE
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 19:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C1525A358;
	Tue, 29 Apr 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kPSGfkiF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B479625A355
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 19:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953799; cv=none; b=dKWJG601BjnOsFzsdkR6CcqpeWwq/OqU0vlOHJndAcm3sqtPuudl7XGmS1+iXjS0Pa4R7Fys5cUTAB4/Vn7BSXhJ/c8UtUiOx0FURQilYZYF5De3GDgD9GUMNJQuyYgPiGmS2xp9q8yq15okvmvYaex9CT6VOexp2ELXKKz7CTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953799; c=relaxed/simple;
	bh=ZGxv+6RtuqTdf7KhZc93dx18dtJlcCVjSRKVLw6HSRk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LAwovI8WTDMOGHaiChJ7wUoIFP7q626k2lz8ib7Ir1IzThusBRgdmOY3K99h9Fgcf0kDsVywlmtBF7AgXdWnqeG+L3nvbtTngi1hk8zAVGkmW1r469WBpoKIXp+t4Q3EYVz0kM12sdzQ/7Huju1rpGj3VXqxH1CkDDUAUlH9qRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kPSGfkiF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38CC1C4CEEA;
	Tue, 29 Apr 2025 19:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745953799;
	bh=ZGxv+6RtuqTdf7KhZc93dx18dtJlcCVjSRKVLw6HSRk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kPSGfkiFD0RNbjo0gt+uUXMKj+T2Lkg0YSN266nAEoI33BFZvTQP7bkU+NIzq0eO7
	 10nJxd7U4UHT5CPknvDiO1HjmugR+KA/zUZUno8R1UzRDqa1T12ehAjV+5xHAR6gFS
	 txt8Cl5k2z5ABzJ/8tC14ke+s5Y/UP16W4OYG9B5aW0dehB6wous45N9zJq3292ALK
	 dBsP0S1N76k51Re6o7Ge1wBt0zwaTy/sl1xTUlmcMwDzbza459BS2pH52a0WY38Icm
	 R9orSR0qfrroWGfDmGgJEagos2Wtfb8PmGvFR4g+dUfUEI+3ohVCkYNlLWgi4jLnUm
	 X4vjTMjEsQinA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C083822D4C;
	Tue, 29 Apr 2025 19:10:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] net: phylink: Drop unused defines for
 SUPPORTED/ADVERTISED_INTERFACES
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595383799.1770515.3156946371461910813.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 19:10:37 +0000
References: <174578398922.1580647.9720643128205980455.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: <174578398922.1580647.9720643128205980455.stgit@ahduyck-xeon-server.home.arpa>
To: Alexander Duyck <alexander.duyck@gmail.com>
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org, andrew@lunn.ch,
 kuba@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 27 Apr 2025 12:59:49 -0700 you wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The defines for SUPPORTED_INTERFACES and ADVERTISED_INTERFACES both appear
> to be unused. I couldn't find anything that actually references them in the
> original diff that added them and it seems like they have persisted despite
> using deprecated defines that aren't supposed to be used as per the
> ethtool.h header that defines the bits they are composed of.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: Drop unused defines for SUPPORTED/ADVERTISED_INTERFACES
    https://git.kernel.org/netdev/net-next/c/2b06aa2bcfb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



