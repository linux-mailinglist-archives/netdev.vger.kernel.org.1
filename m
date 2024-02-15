Return-Path: <netdev+bounces-71913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 833688558E7
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:10:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B62D31C20D84
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 02:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4F81870;
	Thu, 15 Feb 2024 02:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQl6EniS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85E9184E
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 02:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707963026; cv=none; b=PdzUlx8taUZKhdjFRkB2Sw9AaC8ADKERdovPSFd9nVL2HL12aDwVtzbUCwT/mv38fRzut47J6N+JDxTE1XaTbYkDrBK01h2OMwfo6LoxuDMJatrqmWDrCUS/A/lneeNAgSpqe4AsGRYoZRQ9sFF5WvvFxthik2Ijrh1fF0XCpys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707963026; c=relaxed/simple;
	bh=/9zJKtXFiVXKx6n41lA+c7sE7Kbf4fjNJ0TZPPgIEtU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FJlK0pnC6VNTuV3xFLXxotBSLalcqFl8zMLjN9m5uicrYQsCJieDCsQswFp03rpvbhACpo69Xtx8ewY1a8/7eMw+2N2T891Hv79YWk1TfuikOJE8YKrCvbmZOSvLIwjBrXe5QWvjg+Rh2bWDfO+tmIch4Gr1OLz5XQrO5XWYW0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQl6EniS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4B04FC433C7;
	Thu, 15 Feb 2024 02:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707963026;
	bh=/9zJKtXFiVXKx6n41lA+c7sE7Kbf4fjNJ0TZPPgIEtU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TQl6EniS9bV1WqmaMUUd2D//jwDVpFypyjYNSJE3daC+BjMPz+Jsq4pBWsNgXLkrx
	 iumqImDzoeoqPIv5G/9HQBQDwZYxZehRSyiJc5MPzK3Mc+ExT1JGpSeFfAuBQ46w1q
	 SpvltNHCAhMdzWG6QN2A3zPPJQc7sKG+qzZeHT4bH3d6prT4fF7aXm14E6X5yNjJYE
	 zhi0yFnvIxcq4K+KJQ/chwFioMwt2FGwe8adz12uN6XDmfe0guexypSwV3ilviK2jo
	 BNEXsrjfy4dCTI7o5ChfIY7wkSW+mEw6gbosUnexFO+/20bSGCvlj8VOe9lHChv8mC
	 YfY0BZWjlOslA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B962D8C96A;
	Thu, 15 Feb 2024 02:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ice: Add check for lport extraction to LAG init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170796302617.4642.9242434883572737628.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 02:10:26 +0000
References: <20240213183957.1483857-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20240213183957.1483857-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, david.m.ertman@intel.com,
 przemyslaw.kitszel@intel.com, marcin.szycik@linux.intel.com,
 horms@kernel.org, sujai.buvaneswaran@intel.com,
 himasekharx.reddy.pucha@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Feb 2024 10:39:55 -0800 you wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> To fully support initializing the LAG support code, a DDP package that
> extracts the logical port from the metadata is required.  If such a
> package is not present, there could be difficulties in supporting some
> bond types.
> 
> [...]

Here is the summary with links:
  - [net] ice: Add check for lport extraction to LAG init
    https://git.kernel.org/netdev/net/c/dadd1701ae11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



