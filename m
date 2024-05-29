Return-Path: <netdev+bounces-98854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD228D2B38
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 04:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCAF8B22FF5
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 02:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5FA15B122;
	Wed, 29 May 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dyghgn/W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375EE15B10E
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 02:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716951422; cv=none; b=uczNRcTzXGdfxhgYsphcR3jid/EqO8ksVZbdCaX7pDraFtsDWR0z4w+Yuv71ImBE2T/5V+qIrKKwuVJHtMXddkT17DCVRrML/8w9EtOU5p0IM0FHQSa+W31WVGnLgxBggOSv0DYrIsaFu+6mysS8NE6/bir6efSql1oePCKhSkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716951422; c=relaxed/simple;
	bh=qLNYjUMLHSXBceMTED0vsCGYV5YS58ifys4UOWglBWA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hE0hfFIlsvRyz00kAaJpfkVudwiwrIfNr9+6W1H8BH4GZ/CY8vy3QSlPX+BMzYu0wYpYg0K0pFl0WiRcOXd2mpMFK+BDAG8Wvhu1Y/JRzEq3vx/1dgwZqKAVtUKKIEIApRaDYrEAlIWQmfNNFU8wfK1k375ipXoMLLaejmSMbo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dyghgn/W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E1FB5C32789;
	Wed, 29 May 2024 02:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716951421;
	bh=qLNYjUMLHSXBceMTED0vsCGYV5YS58ifys4UOWglBWA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dyghgn/WJb7ogwRDEtF2Qhou/VzQCXlXkQblKK0/stoB9l3uBDeFzSu25FNuUGkga
	 N823sN6upl1niWVDmxOoV96cTbGFdLAk+bgVpDeQ2nvZnVcqSgzGQSQrMz7YsAKi06
	 VYEobqW61DvF8wWmjUro53vLU9xI7oUNb+3m9iLBYWWBbL8nXcalNjDpUXeMra0i0s
	 xUECVwuUEiPyNapYfxrlYK/98tfwV2VI8WtUZV0KI3Cglzv/B0eoZCoTcUAnKfSKzk
	 Z/VXZDC1lNCqrIHajMfWsk5PGeQI87PgcKPttYpB85nUmFbzytl/+7pVrhozvgFcM0
	 JSJIbyVZFtFnQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D3AB3CF21F4;
	Wed, 29 May 2024 02:57:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove detection of chip version 11 (early
 RTL8168b)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171695142186.13406.16181247827334412176.git-patchwork-notify@kernel.org>
Date: Wed, 29 May 2024 02:57:01 +0000
References: <875cdcf4-843c-420a-ad5d-417447b68572@gmail.com>
In-Reply-To: <875cdcf4-843c-420a-ad5d-417447b68572@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, nic_swsd@realtek.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 May 2024 21:20:16 +0200 you wrote:
> This early RTL8168b version was the first PCIe chip version, and it's
> quite quirky. Last sign of life is from more than 15 yrs ago.
> Let's remove detection of this chip version, we'll see whether anybody
> complains. If not, support for this chip version can be removed a few
> kernel versions later.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: remove detection of chip version 11 (early RTL8168b)
    https://git.kernel.org/netdev/net-next/c/982300c115d2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



