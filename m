Return-Path: <netdev+bounces-141763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C41D9BC314
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 03:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D36F91F22A4A
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 02:20:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AF836AF5;
	Tue,  5 Nov 2024 02:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGxJHShX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F118F2C859;
	Tue,  5 Nov 2024 02:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730773224; cv=none; b=qpFDifgvMhR7b9pLuIDEnq6c1cKgLopnG5B9kzfkXR7qiwx+2EhN137cpHo759ze79TVPnvUWHcdNd4E33Ma7zmEg64Vo3D2AVyLI6F3UTnzqzFepNifDpqTN6XBiCglS3FD4w6CC6PqPx4PlCyeQV4MDIf8TtjvlIBUmzKh0Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730773224; c=relaxed/simple;
	bh=OV+TjXUpuywBWxnRBlAvK87n8KcdOHvrWxU6kph37Nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WKu20/wP1muGw+qUzySKLn3iVQg6UMDs9RPgjBPVsUlYnCva5PduUZ9Kj1nziv2od8bI+qONUykmB0zTEPG3M1H3cbtZU+eGVTbHrxexV9Xq8v9eeyoUoJAehR8Yj1x+yKFTWw3/rmTmiuDW7SNMerpuXdq5ChEalG73OnarH8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGxJHShX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E3A3C4CECE;
	Tue,  5 Nov 2024 02:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730773223;
	bh=OV+TjXUpuywBWxnRBlAvK87n8KcdOHvrWxU6kph37Nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TGxJHShXNi+Gg3QJ1lbnpyJXXgRerTFA6FJHq66ZwRIfkgX/qFxsRw/8As/KIvRki
	 pSx5l3Fy6cpAXp2CQGPjgdG687Vraabk2gThQK0QwjwGVnmsK26NlaePceyRmpcblP
	 GBUMN9/zWTphi7vHL6q0x94zkmDKbkTEBMNz+d6ICMd1cRGDqJpoecEy5ypQjfXvvg
	 fGbKdgKY19bKFDXCYVAUgMBRQBsgMBgGkAgfyKnq1lGEPGRcABNKRxgetKBroBxYkO
	 Yf6x1yEMj6ZafIzTPJ0rzhSjJK7lvx7nop7Au+ycMwU5o0QD1x9WUn9lj6XV4UkAlp
	 kglqow5GSoHeA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CEC3809A80;
	Tue,  5 Nov 2024 02:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ena: Remove autopolling mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173077323226.89867.8254343342757374598.git-patchwork-notify@kernel.org>
Date: Tue, 05 Nov 2024 02:20:32 +0000
References: <20241103194149.293456-1-linux@treblig.org>
In-Reply-To: <20241103194149.293456-1-linux@treblig.org>
To: Dr. David Alan Gilbert <linux@treblig.org>
Cc: shayagr@amazon.com, akiyano@amazon.com, darinzon@amazon.com,
 ndagan@amazon.com, saeedb@amazon.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  3 Nov 2024 19:41:49 +0000 you wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> This manually reverts
> commit a4e262cde3cd ("net: ena: allow automatic fallback to polling mode")
> 
> which is unused.
> 
> [...]

Here is the summary with links:
  - [net-next] net: ena: Remove autopolling mode
    https://git.kernel.org/netdev/net-next/c/b356b9170815

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



