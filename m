Return-Path: <netdev+bounces-202072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 143F9AEC2AB
	for <lists+netdev@lfdr.de>; Sat, 28 Jun 2025 00:39:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 005BD7203EE
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216882900A4;
	Fri, 27 Jun 2025 22:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS86iZj1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C8728FFE3;
	Fri, 27 Jun 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751063983; cv=none; b=LAp68yvPip6Sk3Xk4fglCG0dZ9C7SOOpeyZioC/0E3UBcrel7ob7AC2TMZwNWYo4udHcCiCJBlBHZ5piYrRocQSx/a0qvPhZl5Lkc+fmcW/HwWCPNZq5b1HbTLVlhht/oViivTpVqbRkQVMy/LpUAHieTSaxz5xFQZ48pfXGlcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751063983; c=relaxed/simple;
	bh=xYSZORXM/k4CQAbTcBlF6Tppyy8kBuWao+ndUeGS4EI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XAuQAtKFqorsLgeOzkARRCeg4fPO5cNQ9zfMCARJQ1GirJ2oQL6G7UQPcouge/8DQqcepWB5AsIC5B9djWABrZyPNL8lju1wKuMIk9UgyO90+tJDmNyaq1WCmyciIAJZ+fVwuAb3eLGRId7f5QSPAcsvGO320jyF5vHrIRInZmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rS86iZj1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AEDBC4CEE3;
	Fri, 27 Jun 2025 22:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751063982;
	bh=xYSZORXM/k4CQAbTcBlF6Tppyy8kBuWao+ndUeGS4EI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rS86iZj1JH/JIGsl/AvbM6YKXnz6ID4AbQd83vNlg/K0BVtKCr9Iko3yVLiAkjl8H
	 QbzcUM7X+hJD2ihMS2mkbXeXLmbaaFV3TESLKTzCNQkWPpVgUSC9aIY7NPuaJ7d9FW
	 1EX6wUazdOFyzcb70X+TF/y5Kz0OGuZNeeF/Tl2IQHOB2bVLtKAIPBWgrygfyMLxcC
	 AjxLm4vL/dsY9JTUaDFtqT8xzq+JLarj/QtplgsTquIWA2UlRrOWjQ44OgyYANTxSd
	 30VCcwDKWi26zKsSA6WSyrDcxuEfGMDk9zL/uvc/zykFIcgItlUU4y339xhOB4cLGv
	 5izE/b7GA8WwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3E938111CE;
	Fri, 27 Jun 2025 22:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] docs: netdev: correct the heading level for
 co-posting
 selftests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106400849.2079310.3044466691330595540.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:40:08 +0000
References: <20250626182055.4161905-1-kuba@kernel.org>
In-Reply-To: <20250626182055.4161905-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 linux-doc@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 11:20:55 -0700 you wrote:
> "Co-posting selftests" belongs in the "netdev patch review" section,
> same as "co-posting changes to user space components". It was
> erroneously added as its own section.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [net] docs: netdev: correct the heading level for co-posting selftests
    https://git.kernel.org/netdev/net/c/6e457732c8a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



