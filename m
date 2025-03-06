Return-Path: <netdev+bounces-172681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C28BA55AF9
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D50F61740D5
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B227EC6C;
	Thu,  6 Mar 2025 23:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rhc1fDh6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010FA27E1D3;
	Thu,  6 Mar 2025 23:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304405; cv=none; b=k7R2k1+UhMblE/KtADmAIOB+ox2eJqZFFZXY2C1LWPYp4RRCcmg0TsFjIA9LQFn5gPNCBl9qFLcVHtNriD7JPrxGDs01LjwXkR6wF/G9e70+tgy3uAXUS3kY8NkbMD4MmRieuYiDdef4f4rbtTrraR6vFHGcD2LV5rngYK1LBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304405; c=relaxed/simple;
	bh=2QSee9WokSYspQJ+xRHNNYB0mN5bS+JLoP/ZWB/o79g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ep/mXmDDhNB5NlHbfDwix5xA/KykU78qhIxklXfHs/kQ1p+lILqv9bKMJDuu8MNV5Oq0mDpay916QPkGDbm1nHPDk+CXDHjz2LqWHepRepzRcvMce5mSMX6CoyxdxS1jUhXYZuU5XZwfCrsQUdIr/kjr6L6ai+TYj1DyYffUwU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rhc1fDh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF55C4CEE0;
	Thu,  6 Mar 2025 23:40:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304404;
	bh=2QSee9WokSYspQJ+xRHNNYB0mN5bS+JLoP/ZWB/o79g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rhc1fDh67EBOuiKV1bApq40dxAjAq5x/hauy5rCh6DpnHSwhNcSTIFmjmPMQpai5C
	 shJSi+TKWch6PItoD7htSicRlB2sHSCDkYo0guwyt7ogxakmmmycXo37+hRMcO2b0n
	 c5v1gFuSk2PyInqkK3UsRmzbhdaPO+Ru6N5lCGl4KTPc4IydcEnDrTsWqsYXqDv1wz
	 B4Arp2PgfIzhYVegzstUmNjA814/2FXMYtdwpXPktI0C+Roxlb+0KkLmJitsH08GPD
	 Ak0a47mxubiTcIVi43Ktk11jaij8nSVZbHLzyXeqzq9YTeR1VPXg3wIay6yL6pJUXb
	 TXn9plJ9h1pyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFC6380CFF6;
	Thu,  6 Mar 2025 23:40:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v8 0/2] net: stmmac: dwc-qos: Add FSD EQoS support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130443748.1819102.11441827117696182422.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 23:40:37 +0000
References: <20250305091246.106626-1-swathi.ks@samsung.com>
In-Reply-To: <20250305091246.106626-1-swathi.ks@samsung.com>
To: Swathi K S <swathi.ks@samsung.com>
Cc: krzk+dt@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 pankaj.dubey@samsung.com, ravi.patel@samsung.com, gost.dev@samsung.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  5 Mar 2025 14:42:44 +0530 you wrote:
> FSD platform has two instances of EQoS IP, one is in FSYS0 block and
> another one is in PERIC block. This patch series add required DT binding
> and platform driver specific changes for the same.
> 
> Changes since v1:
> 1. Updated dwc_eqos_setup_rxclock() function as per the review comments
> given by Andrew.
> 
> [...]

Here is the summary with links:
  - [v8,1/2] dt-bindings: net: Add FSD EQoS device tree bindings
    https://git.kernel.org/netdev/net-next/c/1f6c3899833a
  - [v8,2/2] net: stmmac: dwc-qos: Add FSD EQoS support
    https://git.kernel.org/netdev/net-next/c/ae7f6b34f5cd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



