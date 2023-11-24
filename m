Return-Path: <netdev+bounces-50895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 981BF7F77D3
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3F271C20F25
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 962382EAF8;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EfZaDnKn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78AE32EAE5
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 443EBC43391;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839826;
	bh=KdyVCtRGaCXEd49k/n/jGGjDqjaIwfPfUxoPb1AVQB4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=EfZaDnKnUYPGNF66AWaNyVgK7Kttg33WvpUUZbEFAm+Wc8fp2+/Gsi17OpDcz0eaV
	 2hppZdz6D2pL5we+j1dnK3WJZjB8s2AqP4FucjGUhUTgz6+8pHSY+6bMhltWQA8aAy
	 W0lgYpbERN5QP2NBX28LMLv6DPwa8nvg/YsnSB71oII6V+cMmRBztP61sgKgAXGt8x
	 etpmb75Z/ErsoJH79fiJD4lrS/WRaHRAsjnkwkWohvuWmFpjOMl6Rn2VKlF8V6En5j
	 lJrxnWjsfIN0QtNHu2PGs6cGq6CJ9147/CkGQvs27XdihMBuS9BDc3Zm61UuBo3pZ0
	 jbAcBDd+LXcoQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2BCE4C395FD;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: remove not needed check in
 rtl_fw_write_firmware
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083982617.9628.995933697280401321.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:30:26 +0000
References: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>
In-Reply-To: <52f09685-47ba-4cfe-8933-bf641c3d1b1d@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 edumazet@google.com, davem@davemloft.net, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Nov 2023 10:53:26 +0100 you wrote:
> This check can never be true for a firmware file with a correct format.
> Existing checks in rtl_fw_data_ok() are sufficient, no problems with
> invalid firmware files are known.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_firmware.c | 3 ---
>  1 file changed, 3 deletions(-)

Here is the summary with links:
  - [net-next] r8169: remove not needed check in rtl_fw_write_firmware
    https://git.kernel.org/netdev/net-next/c/3a767b482cac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



