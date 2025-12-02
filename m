Return-Path: <netdev+bounces-243126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FF0C99BBB
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 02:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D9353A50A3
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 01:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163E51FDE31;
	Tue,  2 Dec 2025 01:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+UlTygG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6631F91D6;
	Tue,  2 Dec 2025 01:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764638613; cv=none; b=OeVmNMvjw2XcwZqcBsvErgNcDpR0QfanH1RmpPJBVxtEYeeqmZJ9NpH2S1WTrQiIHV81ccaqnat0BA+rdXn6/oHWS1aJmyItt8QJygWK3qLHIvUjqoyGrY5JBEHwVPpPEgD63/mZa6CdX8E4wRylwC4WnCG7TvKYgiuP5tWNdek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764638613; c=relaxed/simple;
	bh=9WvK0lgBbXrHaHRa5+mv3REjoJOXzRVc1j5Fk3hbzZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QpP3jyHZW7eMuoogtHxGZEv2NetSTRfGfwq7eH1qk3PgQ/blVQN6p7UjWids6d4tJejpaMRaaWfLk1xtOGHjwAH/W/gAvk93s0ZiLVQsDzNBRTnwpPZsz09DvRmB3DWiCQk5Z6zMkGgAXqLOsuf7l5/IlxdMHDE5KIbr+BjcW/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+UlTygG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C473C4CEF1;
	Tue,  2 Dec 2025 01:23:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764638612;
	bh=9WvK0lgBbXrHaHRa5+mv3REjoJOXzRVc1j5Fk3hbzZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m+UlTygGu1ffAPgP6SvMm1pArV5WQ9EK1z4SVhSgOtvUOlP80QGraN9/C64h42lQ+
	 4Q7wFLRh7fw0iaZHL4KjSpgpmxrvL79Y1XAC5lGVKYecTt15LMwSdzVDu7iD2aoNlv
	 hsoPLmJ38m0z/jXiQdG4QviJVZLNhp4HDOCecuWi9L1w/2Xikk0TnviDeA6N1PR4ZZ
	 X1c3IhM65duil7vsUQfKMBrJRRj1MB3J6idUxArZ49QJzxML+0f2OC1Do7975UEooF
	 T0b9LV1rCy69W16aftWeLdxcJNIHqc2QFAE5evNK7t/AZk5l0JqS5Fqk4X9Xiy4ILx
	 LYX0Q1QXcZMrw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78A40381196B;
	Tue,  2 Dec 2025 01:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] bluetooth-next 2025-12-01
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176463843203.2624727.14035616858412312765.git-patchwork-notify@kernel.org>
Date: Tue, 02 Dec 2025 01:20:32 +0000
References: <20251201213818.97249-1-luiz.dentz@gmail.com>
In-Reply-To: <20251201213818.97249-1-luiz.dentz@gmail.com>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Dec 2025 16:38:18 -0500 you wrote:
> The following changes since commit cbca440dc329b39f18a1121e385aed830bbdfb12:
> 
>   Merge branch 'net-freescale-migrate-to-get_rx_ring_count-ethtool-callback' (2025-12-01 11:54:50 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/bluetooth/bluetooth-next.git tags/for-net-next-2025-12-01
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] bluetooth-next 2025-12-01
    https://git.kernel.org/netdev/net-next/c/4a18b6cd7c57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



