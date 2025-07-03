Return-Path: <netdev+bounces-203749-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 52943AF6F88
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA6533AA59D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:59:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35F32E03F1;
	Thu,  3 Jul 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THpAOasR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F19A2DBF7C
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751536791; cv=none; b=H/OMHebyyJawz6zGcmGt/P4BhKOukmOHJbnxR10hsrI5S1YjU+ye+UE5WiVvVZBnnXf3VvE5jbKOS2518MRptxCIt5cAjllvupQjScKGSG2y7IYEMaG9wz/Je/uYVV8lGKGkFmwrhb3mvcRjkUO7mPJj8X19iROxAJvUyH4SLYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751536791; c=relaxed/simple;
	bh=vYaD9DYCNPBX7JW1GGz3dPNqi8+19ljdGZQlVlpzWj8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WKzmVafmTulgGTUWguywyabwwsDf439iXTWBlePIRF1pQn8/lCuh67Id1I4mdAC5go+CK4ORFf7TnICyR1CZ5P9L5C/EI/TXXtskF67QxGWAQfnbhsrVdwUFBwI8rr16oaw4VZhrT+XOG4BQT19+jWhJ8JbAJRca3ZtO3aaeVzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THpAOasR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A737C4CEE3;
	Thu,  3 Jul 2025 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751536791;
	bh=vYaD9DYCNPBX7JW1GGz3dPNqi8+19ljdGZQlVlpzWj8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=THpAOasRS2Zm0daSia5Z/YojZlNmXOKqs/3HQm9NdMg3hkg4YHzAaDLI3Tb2aniR0
	 Yb+u2aD1w2iYKol6E08MKdi3cUgAdtn1O5Q+snv5RH4AB13X7x77MAyhe1XEzSApWF
	 ZDSHNxb+BRL3tDqDgLiE5pGesg4ortwdO/A21l8S48xL+d8SGMu3WD03OROzZNXF22
	 UH/ML7bCCSc/n3DRmratk98/8JXG3zlbCkBX5GjBdArKylfLxnbFw6DY/qpn+cdKu+
	 CcN31mogL0dgO4FO65LH9ZcRHuGJ1OThCKkYWxnMGBx4byrN/uA2vu+U/ApNuKtCfn
	 UIf3R/YE7W8+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE5C383B273;
	Thu,  3 Jul 2025 10:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4 0/3] Fix IRQ vectors
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175153681551.1389884.4980983924046945780.git-patchwork-notify@kernel.org>
Date: Thu, 03 Jul 2025 10:00:15 +0000
References: <20250701063030.59340-1-jiawenwu@trustnetic.com>
In-Reply-To: <20250701063030.59340-1-jiawenwu@trustnetic.com>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 michal.swiatkowski@linux.intel.com, larysa.zaremba@intel.com,
 mengyuanlou@net-swift.com, duanqiangwen@net-swift.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  1 Jul 2025 14:30:27 +0800 you wrote:
> The interrupt vector order was adjusted by [1]commit 937d46ecc5f9 ("net:
> wangxun: add ethtool_ops for channel number") in Linux-6.8. Because at
> that time, the MISC interrupt acts as the parent interrupt in the GPIO
> IRQ chip. When the number of Rx/Tx ring changes, the last MISC
> interrupt must be reallocated. Then the GPIO interrupt controller would
> be corrupted. So the initial plan was to adjust the sequence of the
> interrupt vectors, let MISC interrupt to be the first one and do not
> free it.
> 
> [...]

Here is the summary with links:
  - [net,v4,1/3] net: txgbe: request MISC IRQ in ndo_open
    https://git.kernel.org/netdev/net/c/cc9f7f65cd2f
  - [net,v4,2/3] net: wangxun: revert the adjustment of the IRQ vector sequence
    https://git.kernel.org/netdev/net/c/e37546ad1f9b
  - [net,v4,3/3] net: ngbe: specify IRQ vector when the number of VFs is 7
    https://git.kernel.org/netdev/net/c/4174c0c331a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



