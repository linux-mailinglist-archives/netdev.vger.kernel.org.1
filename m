Return-Path: <netdev+bounces-215566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 326F5B2F441
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 11:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5D4AA5791
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 09:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AB72E0936;
	Thu, 21 Aug 2025 09:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ho9fAYlX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEB2C21FA
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 09:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755769198; cv=none; b=In7AiG+SwrI73J8ZeHlhJqimU0cJG4GasM2RdWOpG1rdVDFJDlI89OP16rrsN9OEZ34mI/veGQKqz1EY/18eu6avjciy0KrmYUnk6QYGP1hQW9qMZ/8jBvRhB2HRidSoaBmi8IHx3lxoYGwY9hnA7uE9VlnzWUE/kD5MvUjJJyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755769198; c=relaxed/simple;
	bh=9xUmbVQEMPreNhlqJGOMpcviTh+j9TmH8hQ5UrB4JO8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7hKsrewNWmtq9wSLArlCio5ICq+7rJIOc/r4wvKIAQI0RajZmiKAOL/O9LNjMnQlBCwo6dtP8VRgLVoiHYHzxduyrdYZfBqxnkv2UOw2K+kegWHHgWXESYqEpgkaDN7aE9j/NikclqEfQCjSP7Vcyyon+uUzmP/pWD7JsVLtEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ho9fAYlX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A77C9C116C6;
	Thu, 21 Aug 2025 09:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755769197;
	bh=9xUmbVQEMPreNhlqJGOMpcviTh+j9TmH8hQ5UrB4JO8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ho9fAYlX/7B/r2TSrrOUz80WAC5u1O8aEA8bL/7l4JpH8LlRGe9p7BN/yr+aJ5di1
	 Xf8LUJHB+RRLP/5wGN35XXWpIXagc58kp8bLkp+mMAgcwcjqOYtGRpvQOu/AOfMcHR
	 DyCBHx94ysFAxNmzRCpu7MJU3DqFuQDKkbynvInS1Sx+sSRZQTwGl7JaT5lEcmkUkQ
	 a/JFm/CqPKfFkN6mhqcRcdNWHo8sDrOwpqljBE5JBG8H9/om7D/CzSx3otGfxovqMX
	 GZJNoOdpJ45MHWN8lN5nv5KAXhmTWPSZowh08N7Ja0JYpx2K30cJWgVOVWTNbErii5
	 AT1A7l0RJYTUA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB142383BF5B;
	Thu, 21 Aug 2025 09:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: ppe: Do not invalid PPE entries in case
 of SW hash collision
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175576920651.962267.9015249362878728671.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 09:40:06 +0000
References: 
 <20250818-airoha-en7581-hash-collision-fix-v1-1-d190c4b53d1c@kernel.org>
In-Reply-To: 
 <20250818-airoha-en7581-hash-collision-fix-v1-1-d190c4b53d1c@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, michal.kubiak@intel.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 18 Aug 2025 11:58:25 +0200 you wrote:
> SW hash computed by airoha_ppe_foe_get_entry_hash routine (used for
> foe_flow hlist) can theoretically produce collisions between two
> different HW PPE entries.
> In airoha_ppe_foe_insert_entry() if the collision occurs we will mark
> the second PPE entry in the list as stale (setting the hw hash to 0xffff).
> Stale entries are no more updated in airoha_ppe_foe_flow_entry_update
> routine and so they are removed by Netfilter.
> Fix the problem not marking the second entry as stale in
> airoha_ppe_foe_insert_entry routine if we have already inserted the
> brand new entry in the PPE table and let Netfilter remove real stale
> entries according to their timestamp.
> Please note this is just a theoretical issue spotted reviewing the code
> and not faced running the system.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: ppe: Do not invalid PPE entries in case of SW hash collision
    https://git.kernel.org/netdev/net/c/9f6b606b6b37

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



