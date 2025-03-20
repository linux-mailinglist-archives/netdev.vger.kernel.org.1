Return-Path: <netdev+bounces-176425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82269A6A3AF
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92A00480FC6
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AD224AE4;
	Thu, 20 Mar 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsHtC2gF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E002248B4;
	Thu, 20 Mar 2025 10:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466602; cv=none; b=udKwHMzRZP/ro6sLGogBlk65Wdw91IYJA8nMUvH6Vw2CpnoUJIiWKmcAmDTXa6nHewmSwaU+CscJOkjn89H47h7QiJ/7Y140zyRGLzHF2sQ6PfPvHKNh9sjxiLt11PqKcVeJuagWqWUS0gTJWF/z+am8GwlSnfwOqtBEgmzP7hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466602; c=relaxed/simple;
	bh=HvW+yK+cfSz6X1+LbzCfZ79HknqBLpkWp03giIKD3lo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iwYJKg2LxJgnxToPvSt3KCXPoEcojUR8YwdR68AeMy6B4DzRPbevJ7Ac3uPJVSczdVOq9JyqUF5wOR7IxtixuzPs+FEtxS1DrnFwHjd1f7WHly5yoaPKiRWvzOhzwbSQyROfK22QkThdmF7FvfmFuv8SnsGuQvCJHbDkVg87oAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YsHtC2gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E81BC4CEEA;
	Thu, 20 Mar 2025 10:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742466602;
	bh=HvW+yK+cfSz6X1+LbzCfZ79HknqBLpkWp03giIKD3lo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YsHtC2gFw73GoQ7d8h636mMRm5qXhy50XrWpjyZFb32cbwS/f4sMiaTasUEp3IQ3p
	 feG+2DJUaNtHsP55K4RGVHHEzFFpeuqoNOvunDskEWkP9HArA3JxhQKWMd2nJrkxJ0
	 Ey1JEkFUCVhm9dlnpjQTImugB7jaKoZcPpGX0HDztesGA7ikFjz11BLlLKZu6qiXPw
	 PVuav+LUnV866RmApjyO54Isx5Q21VeDSDA/VBOEL5MrlyLDVLZKTCX7uDvHHCoI+G
	 jdozQPt+wwYKUkrO3F1danStATATMEqB8gvDW3JUB7b+Yl7TP1Y95o5/FzhOgBZMkv
	 /nlh2/KeB4wtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DB43806654;
	Thu, 20 Mar 2025 10:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ti: icssg-prueth: Add lock to stats
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174246663785.1712233.14659376394563532017.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 10:30:37 +0000
References: <20250314102721.1394366-1-danishanwar@ti.com>
In-Reply-To: <20250314102721.1394366-1-danishanwar@ti.com>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: saikrishnag@marvell.com, m-malladi@ti.com, diogo.ivo@siemens.com,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, srk@ti.com, vigneshr@ti.com,
 rogerq@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 15:57:21 +0530 you wrote:
> Currently the API emac_update_hardware_stats() reads different ICSSG
> stats without any lock protection.
> 
> This API gets called by .ndo_get_stats64() which is only under RCU
> protection and nothing else. Add lock to this API so that the reading of
> statistics happens during lock.
> 
> [...]

Here is the summary with links:
  - [net] net: ti: icssg-prueth: Add lock to stats
    https://git.kernel.org/netdev/net/c/47a9b5e52abd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



