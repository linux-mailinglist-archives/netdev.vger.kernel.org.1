Return-Path: <netdev+bounces-233541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA30C15495
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94CA73AE3CC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE1D253B5C;
	Tue, 28 Oct 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eM3+yCt1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D712512C8;
	Tue, 28 Oct 2025 14:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761663033; cv=none; b=C7EjEApMwZn910Mj35+l1l6Gz2b09SWgADosXHm24IFUQeaJxKnplZjw2rCeKlxqBgMnkKGCAubmHg4exfOLaUJbYjXY/9snq1VDT3bx2rLHFzeYls82ZbxNYSYEPQ7qDpzNb71gj4uDMektkWFg6kV3MBrtt3zTYj6Bx+ke5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761663033; c=relaxed/simple;
	bh=6K/S8d0IVvVTkkQFbLMvHUlIli4SloaGEMV2HIrhuwM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tywDSaCk9eAQC8SjEnAwdNwotcCtehyIlZir3gSpF7Byk0jHcPFXau4rC1/F+ReUiK59lE3R+/ONKWCgAvs3YTD1l8e/Ybh3LUwyFFz9fz86+DwFFtumoRKkkmrFvlg6W6s52nxIRy+1xOcj4oZwPtvt11ECtNhFowJyO5p6NR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eM3+yCt1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2944C4CEE7;
	Tue, 28 Oct 2025 14:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761663033;
	bh=6K/S8d0IVvVTkkQFbLMvHUlIli4SloaGEMV2HIrhuwM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eM3+yCt18RfkfiycnlMD+IvDLDucmNxUByaJkwdlM7uZYjsJ8fBZwFjTAzV0RB5lL
	 sFPDBmjn86sWiCRf+aR1aShxtEs70ohGhHYM0uMFfNlX2oR8FE/OwHVPS3YBnJiuUa
	 UJuD2VaKLrJjcttYbLX9gAqgYAx9KvOAsHAeZmxGY9PXzYGrrFQJf6kZMLF03R764c
	 xPthxPygltd4liezV6i2XVnOkOwImZNv7ws4EOyWJnJbOpUFe7/RmHElLefFyY4a5e
	 evRh8bFWhCOLbQFsclRhijStG53G74u9aTqhOgA4dpVlbd4a3ehw7FztfGk/TrwtAW
	 YnZmkl9H7GdRQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB21C39EFA55;
	Tue, 28 Oct 2025 14:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/2] net: stmmac: Add support for coarse
 timestamping
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176166301074.2258992.15898542633680780702.git-patchwork-notify@kernel.org>
Date: Tue, 28 Oct 2025 14:50:10 +0000
References: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
In-Reply-To: <20251024070720.71174-1-maxime.chevallier@bootlin.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com, linux@armlinux.org.uk,
 kory.maincent@bootlin.com, vadim.fedorenko@linux.dev,
 alexis.lothore@bootlin.com, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 24 Oct 2025 09:07:16 +0200 you wrote:
> Hello everyone,
> 
> This is V2 for coarse timetamping support in stmmac. This version uses a
> dedicated devlink param "ts_coarse" to control this mode.
> 
> This doesn't conflict with Russell's cleanup of hwif.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/2] net: stmmac: Move subsecond increment configuration in dedicated helper
    https://git.kernel.org/netdev/net-next/c/792000fbcd0c
  - [net-next,v2,2/2] net: stmmac: Add a devlink attribute to control timestamping mode
    https://git.kernel.org/netdev/net-next/c/6920fa0c764d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



