Return-Path: <netdev+bounces-147124-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF21F9D7984
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 01:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C8D516263D
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A829632;
	Mon, 25 Nov 2024 00:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQLOg1OB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35097376
	for <netdev@vger.kernel.org>; Mon, 25 Nov 2024 00:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732495818; cv=none; b=YVpDGc9o3wQRfop1vlGPhZf1ome6P0BqMBIvM54d9kvDGuyqgr455GRxztSTsZqiKZmi5ycqiDFJF8a8pugQNgNFo5uHiCJFBQqqzZ+2dbkDYA3ySgR9aPXaSuFJYqLA5uRGT43asPLJiffuSiUs9yvs/mji+xRrqKq61d23qoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732495818; c=relaxed/simple;
	bh=QQOpZTrWPHV7PIm1xo+qlYS0+gIow3KGGlupBsIuXHg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eSCbmoUMDQl04sB6LTM6qP0bOfZb6Y6QSX5enKNb7Q9dbO9YtsDcOLy5U8iObgTDsR8hhPsKyUeSZGscqZEIBGLlbglIYmUUFXHquWNIEM+OltSapRRWo8SNcj/fhkxHlXa+9Nl3ZvHoGMwdlQe9Gcnjg2AIfGlxYx1MSOKNDYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQLOg1OB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E4FC4CECC;
	Mon, 25 Nov 2024 00:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732495817;
	bh=QQOpZTrWPHV7PIm1xo+qlYS0+gIow3KGGlupBsIuXHg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZQLOg1OBra8SjpZSqaR0R+E1KOJixax1a5EmqofT3QiGdCWqHgPxXBZFLJ7z8obKj
	 nW+5NdE0by94h0sMrVpYLDc+wRcqluKVfeCa7hrgfldbGhI2pQy2tM4slCspj24fBU
	 XUD9eJwwnJObGwZBypo4wLo0l7wuBnRf2ZeahqKKhcHqxKd4Vs7t4b4FCkJ2tUtocB
	 iCqZlCak+f1vtgCkDpj2+4U/WONaD/KU0DOiAwUKXXz6V2LjhH2LkiLL0C39Y039xB
	 e5WyMBikbs+0NYHisgh+Fz0Pwa0yD/HDLRcXfVX3I0Kcp6f5x4Lq+yX6M3Cg+xUKxb
	 9y4MVH9i4J87w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7183D3809A00;
	Mon, 25 Nov 2024 00:50:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tg3: Set coherent DMA mask bits to 31 for BCM57766
 chipsets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173249583016.3408383.9396476401419535053.git-patchwork-notify@kernel.org>
Date: Mon, 25 Nov 2024 00:50:30 +0000
References: <20241119055741.147144-1-pavan.chebbi@broadcom.com>
In-Reply-To: <20241119055741.147144-1-pavan.chebbi@broadcom.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
Cc: davem@davemloft.net, michael.chan@broadcom.com, edumazet@google.com,
 gospo@broadcom.com, kuba@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, noureddine@arista.com,
 kalesh-anakkur.purayil@broadcom.com, somnath.kotur@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Nov 2024 21:57:41 -0800 you wrote:
> The hardware on Broadcom 1G chipsets have a known limitation
> where they cannot handle DMA addresses that cross over 4GB.
> When such an address is encountered, the hardware sets the
> address overflow error bit in the DMA status register and
> triggers a reset.
> 
> However, BCM57766 hardware is setting the overflow bit and
> triggering a reset in some cases when there is no actual
> underlying address overflow. The hardware team analyzed the
> issue and concluded that it is happening when the status
> block update has an address with higher (b16 to b31) bits
> as 0xffff following a previous update that had lowest bits
> as 0xffff.
> 
> [...]

Here is the summary with links:
  - [net] tg3: Set coherent DMA mask bits to 31 for BCM57766 chipsets
    https://git.kernel.org/netdev/net/c/614f4d166eee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



