Return-Path: <netdev+bounces-203134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2EFAF0903
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88E383B5407
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92B3919E7F9;
	Wed,  2 Jul 2025 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIM+BWYT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5242F42
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425784; cv=none; b=OSkXlGhsp7unT9D7b4AM2l9XZwHL43nzLMBz0C1oeCMAnvQRj1Qs81SDG+oJyuVBfEVJ5xiq3N12757fF6WV4DuXCqaa+XRbVCPbEqXNH4NazPjrPo4K2Ouc0/2Yu5h6ci554U3FtwFNTlLbYyhGg4r63qiXFn4SwiIe6TtgxN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425784; c=relaxed/simple;
	bh=5gHBQlRdpMAMx9P8m3MwOb7vD+p6NNVH/NHVmgydy7s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=H7dKP+UWKeNP5UMjzULAOFuDp/ntKkKj3W33X1gnJ+PEMcaz+Otu0cy8jpyiE9QlMMVKi277WAGz2K40ABwGV5WolYpuFeQn/WotRKLDb2LibJF1KxLYzJ8x2FoIi8313ySaZKwT55Mp5gCuweVksziwlL69+Y/fX3tBfHnb3I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIM+BWYT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39B55C4CEEB;
	Wed,  2 Jul 2025 03:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425784;
	bh=5gHBQlRdpMAMx9P8m3MwOb7vD+p6NNVH/NHVmgydy7s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OIM+BWYT3wblthFbjPNSn38s2wSXTTjzlvKMIUFaw7s3/yhfMzmiBt3p39kdH3bER
	 WjSHimyYGpbpkGfi+IL98eVNG6NhaaiPtxoKe1WWVBycxqble8oY9aLfY3Kg03M8Z+
	 ah3BRzy8B0N9v2EQ0f5AnCFxIOFE3Dme5ovAyIGE1CU6/uL6IdUEDicS90hRvQvUO2
	 /qJ5jcgcmgAFEO1DfhYmvKG98i6k99E9qXzhzj4fP1Li34e5CnoEc1fuhR9TBZoC4a
	 bN3tXDoRjwH1o0WP+5lOlgYlE5cKGs6NXHDY+Z4yG8RmnDGDCwsvHrmoW8gOldvmNr
	 ar8IlUJkx7o9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D98383BA06;
	Wed,  2 Jul 2025 03:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: atlantic: Rename PCI driver struct to
 end in
 _driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175142580901.190284.10844841336207050615.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 03:10:09 +0000
References: <20250630164406.57589-2-u.kleine-koenig@baylibre.com>
In-Reply-To: <20250630164406.57589-2-u.kleine-koenig@baylibre.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig_=3Cu=2Ekleine-koenig=40baylibre=2Ecom=3E?=@codeaurora.org
Cc: irusskikh@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 Alexander.Loktionov@aquantia.com, vomlehn@texas.net,
 Dmitry.Bezrukov@aquantia.com, Pavel.Belous@aquantia.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Jun 2025 18:44:07 +0200 you wrote:
> This is not only a cosmetic change because the section mismatch checks
> (implemented in scripts/mod/modpost.c) also depend on the object's name
> and for drivers the checks are stricter than for ops.
> 
> However aq_pci_driver also passes the stricter checks just fine, so no
> further changes needed.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: atlantic: Rename PCI driver struct to end in _driver
    https://git.kernel.org/netdev/net-next/c/b9ac2ae0008d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



