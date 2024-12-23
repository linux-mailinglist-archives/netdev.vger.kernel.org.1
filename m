Return-Path: <netdev+bounces-154109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 477179FB494
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 20:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 017C67A2200
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4E51B6D18;
	Mon, 23 Dec 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgn0xysA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849C7EAC5
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 19:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734981021; cv=none; b=J2a71d+fDjPR+sl2o59QHs5KzJMmiDyXci3GAgR7PqHTleC9dXdVLssQCeMCzJmezWW7OOMisOGMZYl7og3rXoUsu9SDSsmm47zsO861d014DnUuUZHJYt3AIVBejjNdXDDbUDopNBUJTrJoXmuUFg6VyXaGBvruimBHpvtDgPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734981021; c=relaxed/simple;
	bh=U5XmyB9GEVfmRZIBoFV/Z/pweyokuk4H1KApLPoKh7w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=drgFCBbvsuMkHaa3ofX4hwK4o09fTgdftr2cL0UmVswhKCngxNeSb6fhA62dOW0EfOj/cBK+ZJrlhMhL3dWWkSPuQLdapn8pGNDUgDk4bUXrPxvR+g5HJhSg0BYoBBXktSvVf/Xuv5CMsQudRa1tAzHk7pBZyZM2/Da68Q3UWiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgn0xysA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04205C4CED3;
	Mon, 23 Dec 2024 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734981021;
	bh=U5XmyB9GEVfmRZIBoFV/Z/pweyokuk4H1KApLPoKh7w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mgn0xysAzU6RUz/20+2guuDihpwbeRuepRxmnab+VQqujyGp9cu1CaszhCEx3G+S5
	 lORIzJdl6Iga2NGcuU7mJ4+e8cr6IOexZtk1ehCKXKWkhwXHoKIVL53fcG3MORA0oE
	 +z7LgPlRDzyGvtJVzG2v/WZVWU6ofr48CtkS/SkeuYY79UhYF7+Za7+N5hFr4Yq5fS
	 sF2YWL30foqsGC02Zri+yyTQojw5YXHVlPYVTsVgjnNYRhuTq5bLYXO43UD3hB982U
	 0+yoQ4cmg+vcyKzHGdvywd2VxUV9/sUyy8cLrTzrtjDC/SONJHrbW9OYBKDWVygDyR
	 YXamB8tXT88Cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFAA3805DB2;
	Mon, 23 Dec 2024 19:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 00/10][pull request] ixgbe,
 ixgbevf: Add support for Intel(R) E610 device
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173498103949.3934211.3463776191601465643.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 19:10:39 +0000
References: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20241220201521.3363985-1-anthony.l.nguyen@intel.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 piotr.kwapulinski@intel.com, przemyslaw.kitszel@intel.com, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Tony Nguyen <anthony.l.nguyen@intel.com>:

On Fri, 20 Dec 2024 12:15:05 -0800 you wrote:
> Piotr Kwapulinski says:
> 
> Add initial support for Intel(R) E610 Series of network devices. The E610
> is based on X550 but adds firmware managed link, enhanced security
> capabilities and support for updated server manageability.
> ---
> IWL:
> ixgbe: https://lore.kernel.org/intel-wired-lan/20241205084450.4651-1-piotr.kwapulinski@intel.com/
> ixgbevf: https://lore.kernel.org/intel-wired-lan/20241218131238.5968-1-piotr.kwapulinski@intel.com/
> 
> [...]

Here is the summary with links:
  - [net-next,01/10] ixgbe: Add support for E610 FW Admin Command Interface
    https://git.kernel.org/netdev/net-next/c/46761fd52a88
  - [net-next,02/10] ixgbe: Add support for E610 device capabilities detection
    https://git.kernel.org/netdev/net-next/c/7c3aa0fccb19
  - [net-next,03/10] ixgbe: Add link management support for E610 device
    https://git.kernel.org/netdev/net-next/c/23c0e5a16bcc
  - [net-next,04/10] ixgbe: Add support for NVM handling in E610 device
    https://git.kernel.org/netdev/net-next/c/d2483ebc9deb
  - [net-next,05/10] ixgbe: Add support for EEPROM dump in E610 device
    https://git.kernel.org/netdev/net-next/c/e5b132b4f4d9
  - [net-next,06/10] ixgbe: Add ixgbe_x540 multiple header inclusion protection
    https://git.kernel.org/netdev/net-next/c/a0834bd521ea
  - [net-next,07/10] ixgbe: Clean up the E610 link management related code
    https://git.kernel.org/netdev/net-next/c/34b415770771
  - [net-next,08/10] ixgbe: Enable link management in E610 device
    https://git.kernel.org/netdev/net-next/c/4600cdf9f5ac
  - [net-next,09/10] PCI: Add PCI_VDEVICE_SUB helper macro
    https://git.kernel.org/netdev/net-next/c/208fff3f567e
  - [net-next,10/10] ixgbevf: Add support for Intel(R) E610 device
    https://git.kernel.org/netdev/net-next/c/4c44b450c69b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



