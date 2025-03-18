Return-Path: <netdev+bounces-175639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3023A66FCB
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 10:30:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24FAB169794
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 09:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D1420764C;
	Tue, 18 Mar 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XPtcBTZR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2A3207665
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 09:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742290198; cv=none; b=O+dwYqP7cmEIJh1xJVQXiUy/e/EL/ZEBKbM2WM98lyRtJRq/2vsVn89qKmp1wD+xHB/MsRsrtrbMmrHCHMWoFGByrUne75ckKkt72s69zAZvmkcVE4opBzPoS8dkZg7aN1XiNm3HA9BVtfbXENqfXpE95c2sXuISZFx34TcrYeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742290198; c=relaxed/simple;
	bh=QO7+yGQla6Izw0IXrHzRnvBrA1ki/jNnj/KTaulV/+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gHwMvTUo4bgzD55kep6LfbYkpijsOi1VS4TC8cptrDoxZNrBETbfndkJQ46L1wO9OWPuGqJkCJh9iTsQP+KZ5eFK7sj624Ezi9f84Pjc20sNJd+2QniwEHnOm/3HhGYdqBnq0LORHZz9MSJS+joajybtCDGQx9Nq9+pAWMog89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPtcBTZR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A236C4CEDD;
	Tue, 18 Mar 2025 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742290198;
	bh=QO7+yGQla6Izw0IXrHzRnvBrA1ki/jNnj/KTaulV/+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XPtcBTZRZ5OYHjRZ/hik6ZeGS91mh7SkYDoCRiecaQvabs8DNMf6EoYNY5d8fPF5D
	 UU1oooLNxAjJx7cjFOQe9nsC6W7EMFyoaydsl7caOrUJxoMeIKCWIEGI5wtT6w0g+G
	 xMsgVRWTlmbehexF4pZldWqLHLbtVbkBWalSB3b0gvkfAVFVuM4+Ehn+oB5ueXG8+r
	 khVYidUW5KriS1yDteFumu1sJmyPUzVOY96m9Dwrgklh2rSQZNKFx905Rmjz91WGb7
	 yoTofxiIPk1TKOP8iyvpYWApO8KEXx/B0vENHon5Ag/0EAYsZYk7wF2snnZ33EccNl
	 AaKPN4ETsJUcQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE17F380DBE8;
	Tue, 18 Mar 2025 09:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/7] bnxt_en: Driver update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174229023350.4098201.6052285322311949172.git-patchwork-notify@kernel.org>
Date: Tue, 18 Mar 2025 09:30:33 +0000
References: <20250310183129.3154117-1-michael.chan@broadcom.com>
In-Reply-To: <20250310183129.3154117-1-michael.chan@broadcom.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 10 Mar 2025 11:31:22 -0700 you wrote:
> This patchset contains these updates to the driver:
> 
> 1. New ethtool coredump type for FW to include cached context for live dump.
> 2. Support ENABLE_ROCE devlink generic parameter.
> 3. Support capability change flag from FW.
> 4. FW interface update.
> 5. Support .set_module_eeprom_by_page().
> 
> [...]

Here is the summary with links:
  - [net-next,1/7] bnxt_en: Add support for a new ethtool dump flag 3
    https://git.kernel.org/netdev/net-next/c/b54b24908464
  - [net-next,2/7] bnxt_en: Refactor bnxt_hwrm_nvm_req()
    https://git.kernel.org/netdev/net-next/c/ed827402d4f0
  - [net-next,3/7] bnxt_en: Add devlink support for ENABLE_ROCE nvm parameter
    https://git.kernel.org/netdev/net-next/c/2c4d376c3a48
  - [net-next,4/7] bnxt_en: Query FW parameters when the CAPS_CHANGE bit is set
    https://git.kernel.org/netdev/net-next/c/a6c81e32aeac
  - [net-next,5/7] bnxt_en: Update firmware interface to 1.10.3.97
    https://git.kernel.org/netdev/net-next/c/17596d239f34
  - [net-next,6/7] bnxt_en: Refactor bnxt_get_module_eeprom_by_page()
    https://git.kernel.org/netdev/net-next/c/1b64544d634c
  - [net-next,7/7] bnxt_en: add .set_module_eeprom_by_page() support
    https://git.kernel.org/netdev/net-next/c/c3be245dfc8a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



