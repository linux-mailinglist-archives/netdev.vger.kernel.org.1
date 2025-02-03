Return-Path: <netdev+bounces-162040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A96D6A256CD
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17D6918894A4
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6CA202F87;
	Mon,  3 Feb 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNgSVED/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 931B7202F76;
	Mon,  3 Feb 2025 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738578005; cv=none; b=hKgvMXgpTo827uysX8R+Nz8Ob4uqf3NZWLOfVfc9TVH27EDmNAvAvZ+8Es62A/+NHafMe1e06OqBomqHJ0GQqtxfEG2NF+QD3eA0bnKD914TStg2+ylx7QyyVFNBh5cKM7XoqydHgSi82ScBv5qEcBuq7BZtcD2qv22VPNdwvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738578005; c=relaxed/simple;
	bh=Xv9eHcbnU/1+NEYnwYBURbDcBgKdPynV+1Vz9Yzsz0s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YHlZ4gjLSO1VoZC/I2W/uCqth3KnbokPrb3hCEvIm4dQKLal0S+MLiI7HfpE8obCKQRUfZZH/zXYL9z64pd/i4AVXVBkE/UN9Uh6vSpG8LmmhkRrZzYGpWuIfhmUiYapEP4Tp5GTzLDsjWXojRhC3maGTMrMRcrC4BLIZQvfDxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNgSVED/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724A2C4AF09;
	Mon,  3 Feb 2025 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738578005;
	bh=Xv9eHcbnU/1+NEYnwYBURbDcBgKdPynV+1Vz9Yzsz0s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QNgSVED/JmQbTFVli2cUTnpuh2bOZqDfMAm7W6/pbrxOeqUBxF6cx4WVdtK4z31CR
	 gmH+4tjzaUVvN1ciUrE2oP5XfX3CV3rSn4okG/EZiobXIRhodFAmwzzivroL75k7nG
	 bxLnRg7EM/VRuVHT1vt7hBUkUv3G7NlU6GgJhmrz0LspBHdfPpVaeDaocoMuYdPdfc
	 /yUmJOBrd/KRUcfhFvms9MkbM65mpepCP2jFaiRy9gQsLL3JBWFLpSJm/5tQpIpKoU
	 GJdhIvkZkKEcIE+GoFySGl7yLPv6akJnG2vMcJl4bqoi2pNePl/A0mZ+m5PTVHRNX4
	 /zCOT4URQKShA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE763380AA76;
	Mon,  3 Feb 2025 10:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tg3: Disable tg3 PCIe AER on system reboot
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173857803225.3097404.12260057603363109670.git-patchwork-notify@kernel.org>
Date: Mon, 03 Feb 2025 10:20:32 +0000
References: <20250130215754.123346-1-lszubowi@redhat.com>
In-Reply-To: <20250130215754.123346-1-lszubowi@redhat.com>
To: Lenny Szubowicz <lszubowi@redhat.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 george.shuklin@gmail.com, andrea.fois@eventsense.it, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 30 Jan 2025 16:57:54 -0500 you wrote:
> Disable PCIe AER on the tg3 device on system reboot on a limited
> list of Dell PowerEdge systems. This prevents a fatal PCIe AER event
> on the tg3 device during the ACPI _PTS (prepare to sleep) method for
> S5 on those systems. The _PTS is invoked by acpi_enter_sleep_state_prep()
> as part of the kernel's reboot sequence as a result of commit
> 38f34dba806a ("PM: ACPI: reboot: Reinstate S5 for reboot").
> 
> [...]

Here is the summary with links:
  - [net,v3] tg3: Disable tg3 PCIe AER on system reboot
    https://git.kernel.org/netdev/net/c/e0efe83ed325

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



