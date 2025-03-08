Return-Path: <netdev+bounces-173187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56BB8A57C4B
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 18:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9236E16C842
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 17:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F089C1E51F0;
	Sat,  8 Mar 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uHq80inG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAAF818C933
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 17:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454407; cv=none; b=iva0dXA6FH0q0T7PujdajqDuPIb/lQ8XN50a11sc01zHRyNz+pgXhd6y2fElJVHQIlBW2G+nLR9CA40ZL7uvRciQXnuP+TAdx80oJ76hMeigeqIaq0UxM9wIzxe02lAymNTNVawopVgB1l2GVuaXCwBs+YWtj0B6fly2abnN5Tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454407; c=relaxed/simple;
	bh=KXjKj31EeV8YlyEXU0baN5GtrOv6eixv0MBujI1Ywco=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uGIiPmoYTNrAgUdOdExHYxHkKydThN1Q0xqGNQYvFadRdh8XiecI9edZB4Dq5gTKAPOEa47oZvJisUt6R9neI5/xOz/Hys78RgQA/cyjyjTq6PRFzW7mw0jrSwVzZFNuYlzeSPoh+UShTM1uu/cBZ/Ffi+hTGsd2Q3ClcGx1rE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uHq80inG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B983C4CEE0;
	Sat,  8 Mar 2025 17:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741454407;
	bh=KXjKj31EeV8YlyEXU0baN5GtrOv6eixv0MBujI1Ywco=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uHq80inGYdoBRVPDw0rRN3rCWqDALbPCQzE1K2ZHD9W57WJbx3Ye12IBsBz576Vle
	 HrBwmTv/j4hlqWESfJE5ja14P4QuBocI6MpN5HJgqtcTnWgH3mftiVm3IVp430NHsy
	 55U2YW1uGHfzR9rDxgxn2Iu1p7hwHBQXXQ3fc8YzefIxUeTLyn/T0Z7tIer7NNbZvC
	 YQfF4yFy834p4czhTKEHHYhlg/M/bn5yIXIZiGeVJcyomvGvlW8AjosAzjFHDV+Gfo
	 bS3/wvJtxzCV+RXBfb5SFq1zTt6kw/HKIrwWiVVpiqksYMvObyEoVzcqKh/Rk8f451
	 UjKVa9N4j4Xuw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C88380CFDC;
	Sat,  8 Mar 2025 17:20:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174145444079.2698227.18404393535860515639.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 17:20:40 +0000
References: <20250307102002.2095238-1-edumazet@google.com>
In-Reply-To: <20250307102002.2095238-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Mar 2025 10:20:02 +0000 you wrote:
> SKB_DROP_REASON_UDP_CSUM can be used in four locations
> when dropping a packet because of a wrong UDP checksum.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: add two more call sites. (Willem feedback)
> v1: https://lore.kernel.org/netdev/20250306183101.817063-1-edumazet@google.com/#r
> 
> [...]

Here is the summary with links:
  - [v2,net-next] udp: expand SKB_DROP_REASON_UDP_CSUM use
    https://git.kernel.org/netdev/net-next/c/b3aaf3c13baa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



