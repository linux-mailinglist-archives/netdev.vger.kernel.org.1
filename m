Return-Path: <netdev+bounces-157961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0C7A0FF30
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 04:30:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7F93168D5F
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 03:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF429406;
	Tue, 14 Jan 2025 03:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx1ChFbH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A31A231A54
	for <netdev@vger.kernel.org>; Tue, 14 Jan 2025 03:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736825414; cv=none; b=eLMfQHjJbTtmgNfbJjaSV+JrevubeE5r7fA6JnUYAYuzT/jSdL4Fg6TR+cdAzdZ9jAzDzM3JvHFa0QMnhIZCgAewIkW/qXj0/SU0EGxB+8c/0THFF0f+QkQv+uV/OZVorp5ixvhgfjv4UKzkNbEmJiBrqm3iPGbpRw7YNJsUUFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736825414; c=relaxed/simple;
	bh=C+wP2ZORcXQzXbgPyq7FVItp0pPTbPN3+of1gXWm3v0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VifmJhA2jtN1k2P/ULE3ecT03JIrUIwk8m9EMX/hbnGNCsRA02yFf/MRoE/8KMtvGdd+ha/zUebCjpEFF0l+JF8o+AGV/uxZIrCIqpt480enS1SuLsMHBW3mYJugf367WWEx9vdRsGuZ9bvUOlDxArX9T7VgFEAJPqrLm6AjMK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx1ChFbH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF38AC4CEDF;
	Tue, 14 Jan 2025 03:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736825412;
	bh=C+wP2ZORcXQzXbgPyq7FVItp0pPTbPN3+of1gXWm3v0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lx1ChFbHugcdBBF02LTx+ky3yt0zsuumDiYPdvLlvVCeAz4ltH7tjZ2I+ru82dtLX
	 Uxl2SK/RWpYRK1B/3ZO76J69ILmVL+OBSOs5CvDAHQKU/pjrGiUdiet2r76ibcDYrB
	 wv304gD6EWueVoY5e4lPoxQ8rG39bTvtmD1/jbyLDQBp1l7TTDiqRKaIg5kbp4TJSx
	 DGAosa8f/lOibzvvVXu0LAIOZt/dNHFjwpENF8YyFXt+SlT2XCwjk8JgW8gkDj4WJs
	 JzEiQ8vwnT/tYk04U45vdh9zzKkspTNAXF6tjNKmpfuQIch/fo8vCf9twBdVqClfEn
	 8M8Hq1Ujm59dw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE03F380AA5F;
	Tue, 14 Jan 2025 03:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] r8169: remove redundant hwmon support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173682543550.3721274.13811220006094990948.git-patchwork-notify@kernel.org>
Date: Tue, 14 Jan 2025 03:30:35 +0000
References: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
In-Reply-To: <afba85f5-987b-4449-83cc-350438af7fe7@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 9 Jan 2025 23:43:12 +0100 you wrote:
> The temperature sensor is actually part of the integrated PHY and available
> also on the standalone versions of the PHY. Therefore hwmon support will
> be added to the Realtek PHY driver and can be removed here.
> 
> Fixes: 1ffcc8d41306 ("r8169: add support for the temperature sensor being available from RTL8125B")
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2,net] r8169: remove redundant hwmon support
    https://git.kernel.org/netdev/net/c/1f691a1fc4be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



