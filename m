Return-Path: <netdev+bounces-23446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7B376C007
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 00:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2604D281BEB
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 22:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABFE6275B8;
	Tue,  1 Aug 2023 22:00:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625920F9A
	for <netdev@vger.kernel.org>; Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AAC92C433C8;
	Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690927225;
	bh=NB0gLchg2zvzbOcx/FfIzTbmhv8ymUyZDO+1widA2N0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYlrXnEWF91BZTLtTiuPyFrvhqNSRSxYUrqjMC+rBjYZZ1qTD7q9N80B1o07O5Xxy
	 hhL4NeUv3T8frIT9YSVe0BXVfg5YBR0WEKDLga8VZFZoHFtkXStF8ez8BBLeqf/F7t
	 zr8Y3SUcs9/5F8HUamOTH/U9Sdlv2PcgyBotNfDqd+MYEfj8HCmOKT9Ft+r1uPVX/r
	 kZHvkR/xFcFH9r+zWBddHNSWTR1BqFSUMwkHZ5n7SCFvUZdW9dGciTsEprEdvy1zrM
	 Lwg/hIL8Uvy82ivkWIFTzMWV1slXxhwzhZertyTuyF/ZGDLC5y1VxKji3gqXQY38Mu
	 bS7QWcM/HJOrg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8C1D7C691E4;
	Tue,  1 Aug 2023 22:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] USB: zaurus: Add ID for A-300/B-500/C-700
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169092722556.12287.10546466900913906538.git-patchwork-notify@kernel.org>
Date: Tue, 01 Aug 2023 22:00:25 +0000
References: <69b5423b-2013-9fc9-9569-58e707d9bafb@bigpond.com>
In-Reply-To: <69b5423b-2013-9fc9-9569-58e707d9bafb@bigpond.com>
To: Ross Maynard <bids.7405@bigpond.com>
Cc: gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 oneukum@suse.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Jul 2023 15:42:04 +1000 you wrote:
> The SL-A300, B500/5600, and C700 devices no longer auto-load because of
> "usbnet: Remove over-broad module alias from zaurus."
> This patch adds IDs for those 3 devices.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217632
> Fixes: 16adf5d07987 ("usbnet: Remove over-broad module alias from zaurus.")
> Signed-off-by: Ross Maynard <bids.7405@bigpond.com>
> Cc: stable@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - [v2] USB: zaurus: Add ID for A-300/B-500/C-700
    https://git.kernel.org/netdev/net/c/b99225b4fe29

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



