Return-Path: <netdev+bounces-237409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C74C3C4B16A
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD37A3A82FC
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 01:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAAE73446DF;
	Tue, 11 Nov 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQWLLTlL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BF03446D2;
	Tue, 11 Nov 2025 01:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762825260; cv=none; b=X4qOb9rIKh0ZsQR6vgLsPCLCwD+Br7SSr3c3icNvodQgsAAGG18/p5gxbTuwGmtdpN5178fU7pnrj+vsY9nl0WnYtYVro3PoEV6s4ej4BDXa4l6gVLRLyGEyfsFyaoClrl944GVl4+paVTDfWrC7DSV/0DO/FJEhHOxX591DJkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762825260; c=relaxed/simple;
	bh=DkX0CODJQnzN4JaB8zv3BoIFl4HfjumbRFHQ527ffm8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MnDTgZ1k4rizODHAqEr0FGxHVpqcYApCf1Ox7vaGoQkelE/VkPNpjXwPE3Tmnzl+EpYiSqHgn3jsC2YT02LMrspcmx8zt754S3wlTNi4ZlRMI4EC9oiidhRlURorA3sE7hNVWtOkIJaoq2mfg8EQk911+Q5KcLY+Tk1881MVFbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQWLLTlL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FB1C4CEF5;
	Tue, 11 Nov 2025 01:41:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762825260;
	bh=DkX0CODJQnzN4JaB8zv3BoIFl4HfjumbRFHQ527ffm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BQWLLTlL95MnztfuN6hC7ncdyTSHY+ewV2K5h9IMUdM1XRRh3u8Dvhvjyxt/HJhLN
	 8xua7uuHEL4tIlM3+LABx40HcvKWAtYf73z2URAsvYArQGAegzExfzyiY1QTbZZWau
	 SwTWNzRYwxOj24DKj1WZrjDFAKtqhcSlz1iXtf9yADYtathJv5JCty3JXRGM2YTe+5
	 wC9Un3QQreefz6tYAhF304jNezgHzYbhray0ZJktkaSoi3RN7Dc84CGOTkwNLvFEKA
	 GsX1hZiN+hSpNkKte9oodXd0f1+6g/qowp3vApSNxwhWpz9mgIlmsHf/hMbCbYSkn5
	 isWgtl3DlmjwA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E86380CFD7;
	Tue, 11 Nov 2025 01:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] usbnet: Add support for Byte Queue Limits
 (BQL)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282523075.2843765.15554475065878163.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 01:40:30 +0000
References: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20251106175615.26948-1-simon.schippers@tu-dortmund.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 18:56:15 +0100 you wrote:
> In the current implementation, usbnet uses a fixed tx_qlen of:
> 
> USB2: 60 * 1518 bytes = 91.08 KB
> USB3: 60 * 5 * 1518 bytes = 454.80 KB
> 
> Such large transmit queues can be problematic, especially for cellular
> modems. For example, with a typical celluar link speed of 10 Mbit/s, a
> fully occupied USB3 transmit queue results in:
> 
> [...]

Here is the summary with links:
  - [net-next,v2] usbnet: Add support for Byte Queue Limits (BQL)
    https://git.kernel.org/netdev/net-next/c/7ff14c52049e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



