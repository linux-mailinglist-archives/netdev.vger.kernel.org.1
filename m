Return-Path: <netdev+bounces-163334-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13CA6A29EF6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67DB018897AD
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 209DF14B080;
	Thu,  6 Feb 2025 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXnnaiHM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D5714A62A
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738810212; cv=none; b=pKXOvCsJgQQxEkMULuTYqo8WH4yrf7ODxGUrS83ifbb/Mz5R+x85YZ9IL37mhiPSJkR/wtXTpjXlpRdSfL7zYi/UZu1D4oX8faxBXueoE9jYyM5FAdbjPy+IHRwSTWBHKVcNDSEK5OrmKVngkNrC4mO74AD7q6B7MQZqVXKNRr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738810212; c=relaxed/simple;
	bh=Dcz0hKYe+UKZ8wGQqyfjPNwLDVFVZtkQa/lbjWAkch4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gXj/nyiBCGgHDl9IRmD8ijaCrNbmI4h8aqL1igtY+qZiPUVc4seIZEvnYVSOR+eKBA+qrwxGaT/Ri1ocE+zHti36haZMJ5UJKcdxjrEKNiYJ8/U1GdO4ataKHnYmBK1OFTItKiLNaa7grMpwinYkGR4eQdYci08L56+E47+i51w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXnnaiHM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63777C4CEE5;
	Thu,  6 Feb 2025 02:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738810211;
	bh=Dcz0hKYe+UKZ8wGQqyfjPNwLDVFVZtkQa/lbjWAkch4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXnnaiHMnc+0lpYqzD22DAGBnotfJg0eHauIjAIZCRM2NTHXsimEUJ2bXqECrDG9M
	 CTcGN3acQRct4UPJnwPkWtvrL/0/o+Y5/67moVi20zS1fhGnHTUSag12K0yJTg3nqA
	 NUYKqzdjbOVrYv1jy5z/T5cgX43ULlFSKHDM6g1Insmn4qoouDTpzcCOYBjUQE2erh
	 cj2OSUeeYvb204/60xW2914RkVU+jCvMvNVsd/OR2rmYr5zIqNgPtU25CGWKyaYsEX
	 AGswethtq6bA90dtcs8lLOXzs3Vm2xdLto1CimE5K+lJCV5oc0oZfPB7c5ltoXgU47
	 D9C/Cio6BL69w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 345B5380AAD0;
	Thu,  6 Feb 2025 02:50:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] r8169: don't scan PHY addresses > 0
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173881023875.981335.18127366675344963328.git-patchwork-notify@kernel.org>
Date: Thu, 06 Feb 2025 02:50:38 +0000
References: <830637dd-4016-4a68-92b3-618fcac6589d@gmail.com>
In-Reply-To: <830637dd-4016-4a68-92b3-618fcac6589d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 4 Feb 2025 07:58:17 +0100 you wrote:
> The PHY address is a dummy, because r8169 PHY access registers
> don't support a PHY address. Therefore scan address 0 only.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
> v2:
> - Because of the IOCTL interface, don't remove the phyaddr > 0 checks.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] r8169: don't scan PHY addresses > 0
    https://git.kernel.org/netdev/net-next/c/faac69a4ae5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



