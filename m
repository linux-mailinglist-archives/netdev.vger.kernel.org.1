Return-Path: <netdev+bounces-141976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A27119BCCEA
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 13:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A1481F22D86
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 12:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7177B1D5AC3;
	Tue,  5 Nov 2024 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YAqMdFAk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B411D54FE;
	Tue,  5 Nov 2024 12:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730810424; cv=none; b=ZL6cOMG1V9RQGapK0kDwNOCUZDTrLf8+Q2DwW0jEe8Hpe6a8cZRJAdyRGP2HZfLS6Zbcv2+h9S2DBND1irlZpRBjYhczUsKJtQH9eVLj4roS0GfT/rZ9gypJcHgl5kJ1O8Oz0lRrvSIAFXhIAuAAm8EkgkPyX19rf1yGErD0jh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730810424; c=relaxed/simple;
	bh=B470//hXIXrWvSblv+Zhgqc1KNBhJ2sWDSCy8NGeT8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Svzf/1XLEyV9W6Nw0NRHwU7k2+gun+q9xpdRY/H2ZvQqNEY61wCcCIE+kczyYK8YJ4dv9oP7lZ8et8P4qqHpTYftgH0pav13q3t7fHOP8kYEPNxXKHnXQEpZFqyeWZ3zLTbDSwuwj5kG7kL5H0I8HdNKqKPKHah6ng6ixDSYfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YAqMdFAk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF2BC4CECF;
	Tue,  5 Nov 2024 12:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730810423;
	bh=B470//hXIXrWvSblv+Zhgqc1KNBhJ2sWDSCy8NGeT8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YAqMdFAkC499s6s3pWmQ9QaZWEWS9YgZHVua8RrnUvI1+nT+nVzP5SQ54LJz0xKhY
	 cFW4fuAwlXKs4w4ffYVxcO/yJJ2TU5x7no8NUT36QAUOSkdWwqlFa5oFBxkDo5Rg8D
	 oazbzKTXJM3aMq8VP2kyiiP+ujCVvT16GtgvmCH1LgiHwIKmjgNzw9OMXrhYvGkWOE
	 hqCf/MFBK5TpVxgZHp2ocuQyV1W438PP+D3OWs9ER0h4ZcVuDy+89/aLg0W64/I4/n
	 o1b4xJA5LkfBKie7CWnyfcY4c5sn8YhkjxNin+Y/Ode8ynt7U9KilOlvVZ1xfs1cnD
	 tKetBWYgTyGsQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70FE23809A80;
	Tue,  5 Nov 2024 12:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/6] net: lan969x: add VCAP functionality
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173081043226.542753.11161846541422250316.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 12:40:32 +0000
References: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
In-Reply-To: <20241101-sparx5-lan969x-switch-driver-3-v1-0-3c76f22f4bfa@microchip.com>
To: Daniel Machon <daniel.machon@microchip.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, lars.povlsen@microchip.com,
 Steen.Hegelund@microchip.com, jensemil.schulzostergaard@microchip.com,
 UNGLinuxDriver@microchip.com, jacob.e.keller@intel.com,
 christophe.jaillet@wanadoo.fr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 1 Nov 2024 08:09:06 +0100 you wrote:
> == Description:
> 
> This series is the third of a multi-part series, that prepares and adds
> support for the new lan969x switch driver.
> 
> The upstreaming efforts is split into multiple series (might change a
> bit as we go along):
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: sparx5: expose some sparx5 VCAP symbols
    https://git.kernel.org/netdev/net-next/c/9bdb67b53f3f
  - [net-next,2/6] net: sparx5: replace SPX5_PORTS with n_ports
    https://git.kernel.org/netdev/net-next/c/8f5a812efff8
  - [net-next,3/6] net: sparx5: add new VCAP constants to match data
    https://git.kernel.org/netdev/net-next/c/8caa21e4e4ed
  - [net-next,4/6] net: sparx5: execute sparx5_vcap_init() on lan969x
    https://git.kernel.org/netdev/net-next/c/d4c97e39bf40
  - [net-next,5/6] net: lan969x: add autogenerated VCAP information
    https://git.kernel.org/netdev/net-next/c/7ef750e490dc
  - [net-next,6/6] net: lan969x: add VCAP configuration data
    https://git.kernel.org/netdev/net-next/c/1091487dc743

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



