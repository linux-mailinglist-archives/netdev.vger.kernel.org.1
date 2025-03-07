Return-Path: <netdev+bounces-172739-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 548E3A55D69
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 03:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B96BE1894749
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 02:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694231624E0;
	Fri,  7 Mar 2025 01:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N5Pqh2+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F67685931;
	Fri,  7 Mar 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741312799; cv=none; b=uTYDn9FizYOIMO/wNdlMkorE60j8uCy4XH38eWBRa3+g8dofD1YLe6YqMRdhevVhvhgHA8lrjAF7UKMMF8dao49j9W9iPd74AXqLTk/sPnScurUVqlAu4i/q6mrPw2v//0WAFELsJj4wFd7CUtpnVXr2ng9djMwFDToaD6eXF2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741312799; c=relaxed/simple;
	bh=ulj+vhipmfz34qioaiFLWEsQ+Aq8r+/RSLJ+tVnvt0o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tBo8NKaw81NeEYu05/o05yvfMweRqw8ROVEYPNfLmiRzHmmAsf0LtR33UHmEvjXVx4u42FSWfF1scgaLpAXzJCB5H4WLQY36MR4fo656SGU4XO+6XMmtZ4ppB//v+LgLGKGVzGODsbi42se+junOYanH5UcWu4fhXDBbUNbFIH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N5Pqh2+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A711CC4CEE0;
	Fri,  7 Mar 2025 01:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741312798;
	bh=ulj+vhipmfz34qioaiFLWEsQ+Aq8r+/RSLJ+tVnvt0o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N5Pqh2+p2XL+6S6QKqbBBqoLPRvmmAuyO2i2szgqMImDiNdWeONioiCzTmsjTGmbC
	 p29GZY9lV/Sg8SCvBoMQ0jMdDb9OR9hHUCb33rY+7J/T8xw9g7CLNfBw/5GOty0e+S
	 FHCvX3YqkXdI2Otl2KWLtwn/RrNNwlhN3fHNOCPP8dIPZYAM+mHxn9caHI2vXVooyv
	 GkpZbZgtmEEJR0OPd76Td8BaX5/Lg6EBGih4lYPhqoRJdsYK6DToQNcaPEA9RUghYH
	 NZaSzn/mLkpjIsh2OuHdfbRAP4z8R19sFhPnUjmDxH+zMJKeCW3Tv6VUIWB12PvPZx
	 VBDA0x//a+Y6g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34917380CFF6;
	Fri,  7 Mar 2025 02:00:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Add perout configuration support in IEP
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174131283199.1853786.11033321360799820644.git-patchwork-notify@kernel.org>
Date: Fri, 07 Mar 2025 02:00:31 +0000
References: <20250304105753.1552159-1-m-malladi@ti.com>
In-Reply-To: <20250304105753.1552159-1-m-malladi@ti.com>
To: Meghana Malladi <m-malladi@ti.com>
Cc: javier.carrasco.cruz@gmail.com, diogo.ivo@siemens.com, horms@kernel.org,
 richardcochran@gmail.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, andrew+netdev@lunn.ch,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org, danishanwar@ti.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Mar 2025 16:27:51 +0530 you wrote:
> IEP driver supported both perout and pps signal generation
> but perout feature is faulty with half-cooked support
> due to some missing configuration. Hence perout feature is
> removed as a bug fix. This patch series adds back this feature
> which configures perout signal based on the arguments passed
> by the perout request.
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] net: ti: icss-iep: Add pwidth configuration for perout signal
    https://git.kernel.org/netdev/net-next/c/e5b456a14215
  - [net-next,v4,2/2] net: ti: icss-iep: Add phase offset configuration for perout signal
    https://git.kernel.org/netdev/net-next/c/220cb1be647a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



