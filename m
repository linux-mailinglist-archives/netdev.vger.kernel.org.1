Return-Path: <netdev+bounces-217113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B70B3763E
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 02:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03CDC17E92D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 00:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280E91E7C10;
	Wed, 27 Aug 2025 00:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SV2F8WEH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0059C1E379B;
	Wed, 27 Aug 2025 00:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756255803; cv=none; b=bXNrDD+9gB/O/XYupcWjneC5LZO5NeKb4FtcgY30sa9RtW+N2lHl2DOAg5aoT2E3Arrgk6rrkLrSSBlFruLUmgbVhvigslO6QJfUV9wLpjKDjczbNUi3+aLraOY51em8IbzQ8bb5w5+5gNJGJdNJ3f9j4mjE0AC2rZ6WF2PPRFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756255803; c=relaxed/simple;
	bh=CQaDDNSjYYm1p+D1z7840AsenzbKhqC6l5s2Z9N3SJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B1AaoX1dKIPPzIDTOtXkdZsmjeZa+AG7tWmT8W5ePomUxsL1r3Tr96VtSL2sbhX+LjPs7k8sm6FI24F5KJY3bzysRXwiymR6q1t32eJQ6XqCXRJE+FRMvsXUrpICUgkNcX81Exukm1e9mzgDCxXGouppxebGoJbV+LyDXSPKG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SV2F8WEH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E680C4CEF4;
	Wed, 27 Aug 2025 00:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756255802;
	bh=CQaDDNSjYYm1p+D1z7840AsenzbKhqC6l5s2Z9N3SJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SV2F8WEH6LM/D7k/3jUH50bd1fHP4Svm1M4+FPZWkuvuDIm+ap/O8CBucoaNKV+tP
	 SVGwRySkP+GlFw55f3795TOQJLydi7jNfwmgx4725aHV/qi6pU5srNGK1YgcCluxcp
	 qJGi78C+yCQsE58QWgwZJzJhnHbe0zJ1RlWRZ/Ncz+yJqrSkeK9Vcbrru/1MAvO37i
	 vV1V+BJcwjS/6iPRez4ObDLBkZ6KEAJrbNKFr43MOuChZUqoUygtoBHCqXhmIBwG0b
	 FGpF6JuYW5XMjgghCmFnzy6Do7ID/7FYrzaJ2+VDSsSdjqBBXmayjb49OTW56z4c4n
	 V65dElSdbQIiw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EB7383BF70;
	Wed, 27 Aug 2025 00:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update maintainer information for Altera
 Triple
 Speed Ethernet Driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175625581039.152740.16923465181327272688.git-patchwork-notify@kernel.org>
Date: Wed, 27 Aug 2025 00:50:10 +0000
References: <20250825071321.30131-1-boon.khai.ng@altera.com>
In-Reply-To: <20250825071321.30131-1-boon.khai.ng@altera.com>
To: Boon Khai Ng <boon.khai.ng@altera.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, matthew.gerlach@altera.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 Aug 2025 15:13:21 +0800 you wrote:
> The previous maintainer, Joyce Ooi, is no longer with the company,
> and her email is no longer reachable. As a result, the maintainer
> information for the Altera Triple Speed Ethernet Driver has been updated.
> 
> Changes:
> - Replaced Joyce Ooi's email with Boon Khai Ng's email address.
> - Kept the component's status as "Maintained".
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Update maintainer information for Altera Triple Speed Ethernet Driver
    https://git.kernel.org/netdev/net/c/d9b0ca1334d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



