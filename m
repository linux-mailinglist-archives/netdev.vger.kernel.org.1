Return-Path: <netdev+bounces-138263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A0A09ACBA7
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 15:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 387741C2237F
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:52:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8344F1C3042;
	Wed, 23 Oct 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jbyLCrQ6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2D01C3030
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 13:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729691420; cv=none; b=UjnBdIX7FTATzerBJJrzGKZRwkaqwJKdyQY4UR41g/3LqctT8tt9LmMcCJqnOrnc4G/IPSkFy0JxhADFL+rmnKH+HJLprsK9lk4unURPhg3zujvIDfFQYEKot11cMghOxXbFkj5slwSQgfZMtAaIGTXmT9npU26ew5rduPnMSh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729691420; c=relaxed/simple;
	bh=bZxQ2R7b3aRIojaoqJk3orxm14+59bsNw4zOBf9WlIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=S5K4qgFfrF3KE9nC+pKYbjjue5X+v400v9k0iFAEYFY0qur/dhGzSlrjCQPuDmqxjGYOZ9iaHLgD3FA7Tpw+heY9l34fNeTT+XQNxE0wYNREzY9d5jX/h6Ry4apHkbV2yBXjaCVSTWGNo2Sstk87IegBfQY9qliW5+5FW9ccqWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jbyLCrQ6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D62C4CEC6;
	Wed, 23 Oct 2024 13:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729691419;
	bh=bZxQ2R7b3aRIojaoqJk3orxm14+59bsNw4zOBf9WlIU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jbyLCrQ64L6aWtgbTc6PhUQe1GULPrpmRPNqGo3MqK9g6/APltVj/sNKDBvMUQalN
	 IwzAJAaVF2FfMlOgYYWLvbbrscidj2+4uV1mtMpDdHgM2npWJtHcyuPA2EUQHJJmHW
	 krwbWkaZcC5GqXSOkxa878Es0oijB9Yq+VluFY8v/SG2MqBGlMR8zUxtUURKB800n+
	 HfpnMlYE4PXmW5+vLYFfUnth2by8OrrWOEKj3XA5QWnSJtdBBoZz3XJNWPcJDPyuFH
	 qi9NzmxtU8wcBWQRUDMxebHHT37+DT3mbLNjBcTcds/gdfbCmjp9liK3Lq3QScfWVk
	 BLXb9hUpXYMQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DAD3809A8A;
	Wed, 23 Oct 2024 13:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] r8169: avoid unsolicited interrupts
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172969142626.1602801.8477515665974007178.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 13:50:26 +0000
References: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>
In-Reply-To: <78e2f535-438f-4212-ad94-a77637ac6c9c@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org, romieu@fr.zoreil.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 11:08:16 +0200 you wrote:
> It was reported that after resume from suspend a PCI error is logged
> and connectivity is broken. Error message is:
> PCI error (cmd = 0x0407, status_errs = 0x0000)
> The message seems to be a red herring as none of the error bits is set,
> and the PCI command register value also is normal. Exception handling
> for a PCI error includes a chip reset what apparently brakes connectivity
> here. The interrupt status bit triggering the PCI error handling isn't
> actually used on PCIe chip versions, so it's not clear why this bit is
> set by the chip. Fix this by ignoring this bit on PCIe chip versions.
> 
> [...]

Here is the summary with links:
  - [net,v2] r8169: avoid unsolicited interrupts
    https://git.kernel.org/netdev/net/c/10ce0db78700

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



