Return-Path: <netdev+bounces-115181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF3D49455F5
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 03:30:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64F071F23460
	for <lists+netdev@lfdr.de>; Fri,  2 Aug 2024 01:30:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE58AEEC3;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2HLBJiP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AA0B64E;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722562231; cv=none; b=dOA80JLS/EnPBe1JQgj7er75sJj4USv47XDOUyvcpdYU/wcttTu7pOf77J97ZoyEpoLbR8ILBtJ1C9K98jhkwL2khM/hZl7iSlDQNXkmOh0plUTFb0Zsz1JvQgd2R4VZ01CnNDs1+Y5La4khoCoB104R1VBAliA22P3bL0TTSzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722562231; c=relaxed/simple;
	bh=skuxqEzWEpIl/EPeoJNqbGjB0UPvMgD9bxEAwvvKZjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=If6V+kuKaVF1nFqHhKXeJAPYAiP1Jw1sYTHaWHPvrzHIiyd3qSEN9QUosyzKcapDoE0m0/W9mylQCD1btRKEWbMDcANMnAjyVlym+/M7jVga+o2vSt+dlWdJyRMsNCqgy1NYz01S6cimDj+J5JJFlCjw873tn+SeyZR44TWtk3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2HLBJiP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4DFD0C4AF0A;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722562231;
	bh=skuxqEzWEpIl/EPeoJNqbGjB0UPvMgD9bxEAwvvKZjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n2HLBJiPv7mTETxdSUucsC868IG0OI143hu+0hTmkb7PpNIpykvQKsUswIazE9hQx
	 UwkkpcqKaVFz1Ty0XjeBPdAONmNO9CQN+WULnl/L4/kRT/zL89HwlXYgG03Hrf+M5C
	 ZPkCdWn6J3G92wyXKX8X5DIvZRuNfX4ZxApi3aLRtnmg06yjU/zUA6nOC+4kHjIj05
	 QaCmiQceAligPfUPRmWC4zukHcJNWkHn/sdst8+tydZ0DTC5QUT9+tnjJVhbq3Vs0+
	 nPx7GIukPUZIdNici5Up0qZIz4orQqNPRctr+ELYEb8oC0VI+N4srQ430ci9wH0HVN
	 Sa0dciQpPNMwg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3A236D0C60A;
	Fri,  2 Aug 2024 01:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: mdio: Use of_property_count_u32_elems() to get
 property length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172256223123.32676.12201339677165213035.git-patchwork-notify@kernel.org>
Date: Fri, 02 Aug 2024 01:30:31 +0000
References: <20240731201514.1839974-2-robh@kernel.org>
In-Reply-To: <20240731201514.1839974-2-robh@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 31 Jul 2024 14:15:15 -0600 you wrote:
> Replace of_get_property() with the type specific
> of_property_count_u32_elems() to get the property length.
> 
> This is part of a larger effort to remove callers of of_get_property()
> and similar functions. of_get_property() leaks the DT property data
> pointer which is a problem for dynamically allocated nodes which may
> be freed.
> 
> [...]

Here is the summary with links:
  - [net-next] net: mdio: Use of_property_count_u32_elems() to get property length
    https://git.kernel.org/netdev/net-next/c/0b0e9cdb3d1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



