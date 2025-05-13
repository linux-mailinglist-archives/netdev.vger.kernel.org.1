Return-Path: <netdev+bounces-190263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CED4AB5F11
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 00:10:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DE0C4A621A
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 22:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE6420F091;
	Tue, 13 May 2025 22:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tuCUKZ25"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A28C20F06A
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 22:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747174200; cv=none; b=M93hLuhkgnVSpOLwL6FhfC8x7jmneRNDEUddVHYKUQvyGZp2k22b3pKdcry2tfq+mu4zZv25jPQkryPPoRASc9Bw81Zd9zCRnIv+5uAMPpz7H1R1YF1EMn7Do1I0BIbuJjgkxe+8Vn+c/kemhbygi/SMpDfQB1p8RcqQhHOna/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747174200; c=relaxed/simple;
	bh=+zXc/Lpo15L8S44TPkPzpssZH9VR+bMfjxrf8q5dtk4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sEoCyzLf2ujEZzE4RkA0+g3fh96/8n723BwZXFzxUy700tBUOoCLq8hINmZQTa9EFIBRyY58MoS9uE2l8DoiTZG+g0xK1cKTqEfEu6uwTUIFP5NX4NSwQnUygOVCeI/cTPRoVcZfAG/1uAaihNQ+qXyoccPJND2RTo3Bd3YQNic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tuCUKZ25; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2361C4CEEF;
	Tue, 13 May 2025 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747174199;
	bh=+zXc/Lpo15L8S44TPkPzpssZH9VR+bMfjxrf8q5dtk4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tuCUKZ25ug1La/gkLD8q5MtgttG6RsNiZGgqpNEBKqLBYdLW7V4FyKLGFD1v1aC24
	 uj32V/IAXPyMfHJsQ0aWdsgh9+0MTyyllVYS1owobd2gqaloC8bBoGGFivlqPDzAO+
	 OjcauY5lxpyR3ejl9TUEYErAFE+OWTovw0qznEqevpjl5lSmefgDDB0nZv4XxfS35u
	 aFzBIo5V40QdO3mFUDs6XGGBTwpQt6STRd3vPJB9DxYdfNmX6ZRcegTbmeumnQyQyd
	 fatLoVkc8hK6aohcyFcFVJEKlOLOETqL/9HzzLWrWhejtFdlLDO45NYHFmj/O3VVsE
	 KwxG1YSAdH/ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF80380DBE8;
	Tue, 13 May 2025 22:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl-gen: Allow multi-attr without
 nested-attributes again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174717423649.1805570.8916507708937786329.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 22:10:36 +0000
References: <d6b58684b7e5bfb628f7313e6893d0097904e1d1.1746940107.git.lukas@wunner.de>
In-Reply-To: <d6b58684b7e5bfb628f7313e6893d0097904e1d1.1746940107.git.lukas@wunner.de>
To: Lukas Wunner <lukas@wunner.de>
Cc: kuba@kernel.org, donald.hunter@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 11 May 2025 07:12:00 +0200 you wrote:
> Since commit ce6cb8113c84 ("tools: ynl-gen: individually free previous
> values on double set"), specifying the "multi-attr" property raises an
> error unless the "nested-attributes" property is specified as well:
> 
>   File "tools/net/ynl/./pyynl/ynl_gen_c.py", line 1147, in _load_nested_sets
>     child = self.pure_nested_structs.get(nested)
>                                          ^^^^^^
>   UnboundLocalError: cannot access local variable 'nested' where it is not associated with a value
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl-gen: Allow multi-attr without nested-attributes again
    https://git.kernel.org/netdev/net/c/396786af1cea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



