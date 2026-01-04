Return-Path: <netdev+bounces-246789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED41CF12DB
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 366A93010ABE
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43702D7398;
	Sun,  4 Jan 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="firLmRX9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6052D738E;
	Sun,  4 Jan 2026 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767549900; cv=none; b=l2se4wyzQEJhi5lO0Hs8x1ffdss1HuYMSAusySk4QZiXN6+QO3aabpDCjbXRcW+Up2Y7UuEDB9/YywEY1pSx3su7mSVRQ7k4z+vnnFFvjzIOMd0+K810YPT6Qc71GoNQI1jf4E/6/BzmSRB/JHp0ffnMTYVsJ/W/hIsH17ntbnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767549900; c=relaxed/simple;
	bh=N9reVgHxUFIXhGhMYyqKvMFqtt2tUVHQzz1N7y9V08Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=czJ4MVOOpbyq64TzdxngkDSTiF/GK3CGUCSAcphxGbbmIQd0maHCCpSt8Jp0hiIqZ32k9R4QCEF/9Y+Xkq6GTFnEp/D7Ij55s1I1AHT4nUft2njIavib9Dry1p9sHkIfJqd1h9bk4ODi0BlBl/Ghz98okghRPfejXuiqGruMbuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=firLmRX9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6533FC4CEF7;
	Sun,  4 Jan 2026 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767549900;
	bh=N9reVgHxUFIXhGhMYyqKvMFqtt2tUVHQzz1N7y9V08Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=firLmRX9HL7TlQg9KaTgAY9nvdDgN483LYBEcDrLd1UnlRMJe+SCxk3iSfD9+wzE1
	 /1z9fBv1Sj33lbjpoo3qtUteFd6z5fYuIjIC85hhWtYe/m2CrWdXYytG7fQEs9qDT4
	 s42JdOS3kEaWZop6HVpVc+/Y9awWHvChW5qqQmT0p/Ool/crZ/yX4+rWdmNVBwyz+Q
	 bIe5t7lwkPTYM27tx5DE/XXVzGZQ+8mRqCceAyIqKY29Y/SXuebxR6l/oV/RHA43PC
	 CIKbIlq0AhIM3n3Vin8Sj5U25RdvIYn/l6KMm3tOv4QWDyod4oQb4bqOK3r2EQrJze
	 uDzNHm1EilusA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 79191380AA4F;
	Sun,  4 Jan 2026 18:01:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bnge: add AUXILIARY_BUS to Kconfig dependencies
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176754969928.141026.3418587325823396897.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:01:39 +0000
References: <20251228-bnge_aux_bus-v1-1-82e273ebfdac@blochl.de>
In-Reply-To: <20251228-bnge_aux_bus-v1-1-82e273ebfdac@blochl.de>
To: =?utf-8?b?TWFya3VzIEJsw7ZjaGwgPG1hcmt1c0BibG9jaGwuZGU+?=@codeaurora.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vikas.gupta@broadcom.com,
 leon@kernel.org, siva.kallam@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 28 Dec 2025 16:52:59 +0100 you wrote:
> The build can currently fail with
> 
>     ld: drivers/net/ethernet/broadcom/bnge/bnge_auxr.o: in function `bnge_rdma_aux_device_add':
>     bnge_auxr.c:(.text+0x366): undefined reference to `__auxiliary_device_add'
>     ld: drivers/net/ethernet/broadcom/bnge/bnge_auxr.o: in function `bnge_rdma_aux_device_init':
>     bnge_auxr.c:(.text+0x43c): undefined reference to `auxiliary_device_init'
> 
> [...]

Here is the summary with links:
  - [net] net: bnge: add AUXILIARY_BUS to Kconfig dependencies
    https://git.kernel.org/netdev/net/c/d7065436e8a0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



