Return-Path: <netdev+bounces-246144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E5ECDFF66
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 17:44:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0E69300BD9E
	for <lists+netdev@lfdr.de>; Sat, 27 Dec 2025 16:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 717203254A0;
	Sat, 27 Dec 2025 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CleZfVpy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A21D201113;
	Sat, 27 Dec 2025 16:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766853851; cv=none; b=PoE+5XvLGf/yWNGemEBG0b4Zw/ABgWLTIykcsJSA2Za9kbM/1Ba+HtGqSvW3K4LK9QgRcnHjVF0PKQ0TL8KjUv8AHf2CR+2kJ4zyWHRX9zLuhSAk21Ww2Xj48+LBPRSx7DiudzzoQCsEBbV2W/n+Vg6YWeZ4e9OEQmqQB8BAQkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766853851; c=relaxed/simple;
	bh=iXuV9I0Z+4HC+WQMpVhoUF2iUwJ0BBEaePSN2873FrI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WiZk79vDPGVOKfQEsih+VXKO5AlZKs7Y+Emh/iw2+j9GpYKqzaYFVwlJ8nZeNZbHUJsVIxEeEF+gXIrWu59JFi/OYoJviQAzEdlYmLDIF7YoEWTbUkj78rwR9m9qOpN36BEaR9izo6KLu8mRQkBOK0Zvb2xckHZC+3komcT+fOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CleZfVpy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADAD6C4CEF1;
	Sat, 27 Dec 2025 16:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766853846;
	bh=iXuV9I0Z+4HC+WQMpVhoUF2iUwJ0BBEaePSN2873FrI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CleZfVpyrYPGuIeM44fk6WW/jI+o+zsdnLKsT1XB46g7U+JqzjKrJ+mSr37w2FuvT
	 l2uXTdK9bGzqWFjtYq6TSIELQiQgxNABz7aw+Q8DRAzZz5caSDUClegquQBSRHu8Gc
	 zOFz7zY8jSzRngEBh7qo/WE3Vwvm+3MsJFrxhhkMhPmZJkVLovsIzamF/dNj4a10Zh
	 eZkudc+WCFYK585G6ysN8WRNOFpnwZu1bXuxNui2y+DEAYZHsQAFXLhrIe0QfoRvpf
	 MNcFKxrYoZj/VDgdD1qKdHmIDbR0OElOVz/4FUn4gU91PQFQ3Qc/jJAmzfZFkkI2JL
	 MwHwo00h3kjag==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B58423AAA77D;
	Sat, 27 Dec 2025 16:40:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: b53: skip multicast entries for fdb_dump()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176685365055.2176197.15824201437320340359.git-patchwork-notify@kernel.org>
Date: Sat, 27 Dec 2025 16:40:50 +0000
References: <20251217205756.172123-1-jonas.gorski@gmail.com>
In-Reply-To: <20251217205756.172123-1-jonas.gorski@gmail.com>
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Dec 2025 21:57:56 +0100 you wrote:
> port_fdb_dump() is supposed to only add fdb entries, but we iterate over
> the full ARL table, which also inludes multicast entries.
> 
> So check if the entry is a multicast entry before passing it on to the
> callback().
> 
> Additionally, the port of those entries is a bitmask, not a port number,
> so any included entries would have even be for the wrong port.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: b53: skip multicast entries for fdb_dump()
    https://git.kernel.org/netdev/net/c/d42bce414d1c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



