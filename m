Return-Path: <netdev+bounces-234804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9ECDC27518
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 02:00:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBB5D4E9407
	for <lists+netdev@lfdr.de>; Sat,  1 Nov 2025 01:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8FC158535;
	Sat,  1 Nov 2025 01:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rbeyDYdR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECCF34D3A2;
	Sat,  1 Nov 2025 01:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761958838; cv=none; b=bmWfkcSzn+9+BX/yIKzSPOnHnBEnasuvr7XqVR/ynOtGTXM6FI8seOBr0tYNbB8uuasYpVMhwBYp4le9PpXTVE+wHRc+Dd1FWl4/vbc9/O1lApfXfW024bNyVAeQzzLrWpJKaFiW+NsBfwpLIM6oiFqZFuBn3XFoaTW+L91jwzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761958838; c=relaxed/simple;
	bh=wrqiKWQt0XwI2cu9SkmsiDISgrhz/Q9a+/0LgHNrBes=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tXynJs+4jXxAZAujs2HwCoteRQFGnCC0jI6AsPQWRTL69ju0yb+J75T5JNvd+120hBgH2ghXz6zJN19k++xj1XP9zOb4Y6e1WHxQbyr3Bio8tjJU8O1KCMULL6acHQ9wCSOVLnIX1n8UFH1/sZofnyRCOJGEgW42LjX50rr1+sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rbeyDYdR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE10C4CEE7;
	Sat,  1 Nov 2025 01:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761958837;
	bh=wrqiKWQt0XwI2cu9SkmsiDISgrhz/Q9a+/0LgHNrBes=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rbeyDYdRBMSwgZApId558bzFjtsfxROWQXkvsIV4oObb45wQN+m7UVkZ3nGfPaB/O
	 0DrGhI7eXB4AsN7OY55a7UdS4JPnsDuV+wmgwDilhwObCAv1IqR6bFNihbSDUou/YG
	 AWqModvlZTCUypUmiTwkzVGBo1jAMmedypSlmbayzP4qGXQ/h/du/WqcG//I6Dqty0
	 w0Jdxh7L4hw+uFHJ2YRQ+MahJSQyk8RwKvbB/HDfqxkrw9SnsYohljkC9EjNBgJKa/
	 dWu6qzHcCeJ443te9hwsdneA0I2IkNJupLtKuQA1PO0MIR7AsRQMI20XqVHJdAueNo
	 8HCfmyMWpRj+Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF713809A00;
	Sat,  1 Nov 2025 01:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 0/2] net: pse-pd: Add TPS23881B support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195881324.684055.3090787758071283242.git-patchwork-notify@kernel.org>
Date: Sat, 01 Nov 2025 01:00:13 +0000
References: <20251029212312.108749-1-thomas@wismer.xyz>
In-Reply-To: <20251029212312.108749-1-thomas@wismer.xyz>
To: Thomas Wismer <thomas@wismer.xyz>
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 thomas.wismer@scs.ch, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 22:23:08 +0100 you wrote:
> This patch series aims at adding support for the TI TPS23881B PoE
> PSE controller.
> 
> Changes in v3:
> - Incorporate review comments from Oleksij
> - Link to v2: https://lore.kernel.org/netdev/20251022220519.11252-2-thomas@wismer.xyz/
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: pse-pd: tps23881: Add support for TPS23881B
    https://git.kernel.org/netdev/net-next/c/4d07797faaa1
  - [net-next,v3,2/2] dt-bindings: pse-pd: ti,tps23881: Add TPS23881B
    https://git.kernel.org/netdev/net-next/c/32032eb166a6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



