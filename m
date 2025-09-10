Return-Path: <netdev+bounces-221517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A892B50B2C
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 04:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8398172A62
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 02:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF222417F0;
	Wed, 10 Sep 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jNNYJenb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21223B63F;
	Wed, 10 Sep 2025 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472012; cv=none; b=IxdUDgIIWXwxScH3ZFtZKymxKBDb6EgKziqQbDYJzWyR3u+g0OQ8v0GBHVqK45fajFg6LM3TAKeeYiFNZGuoz8dJhAVPLsI2BF0mwESh8v0YaKpUxNq5GTWc8I2GbDKWpqbi6GDJrGsncpxtTaFK/MVufrl4imdvZ4Uiw5iLm6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472012; c=relaxed/simple;
	bh=nZR1dALMHbgyKK0AcfI3cwQlZU/usFmgnkGpJdsY+VY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=W8N7kFuGtRkzypmgEQcXWAZMMh3d+88mBbmbH7DKXdXIYKlQEua5FlJx7F/939xbZNvmhXxH/7RjWnOfMOGd0/j/CkEdw7rTjUqPowq05M5BJs1UkePqitIQr11ktO6l3ZAdwAoGLmqnj/wnT5zMB8b07xEWZQCSdJe6wgp8TFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jNNYJenb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F0CBC4CEF4;
	Wed, 10 Sep 2025 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757472012;
	bh=nZR1dALMHbgyKK0AcfI3cwQlZU/usFmgnkGpJdsY+VY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jNNYJenb6kLy4W+zjOyyxLdIhcU9HLhymCSwGuibjRkXSPspqS2H/lq//IBjA2oV3
	 e3fjw2bf1FtolwO/SC9+X5JG0s8sR78WdTmeeduKCn271/oLfDGyz/ALWOruAIs4DB
	 Lp1s4I7TA0pkGg/Kwco8Ft55oz4Y9Tx4+OCEqZCo80t2ZxWQrQK9vAq/Y11PcGbHqQ
	 Z3eI6di0eZCReRSKOOm58LB4umiQWPO82O/elfVYMEUrCMmE0I28h3ivd1nQpg4XQ4
	 QoPHIl6ooVNFSB4SW340+x19ofkmzBxTqNvrPPhyI6SICKMvmRYIdbyV28wOyUo1xd
	 JCr05fb+oO9Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCB6383BF69;
	Wed, 10 Sep 2025 02:40:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/3] ptp: add pulse signal loopback support
 for
 debugging
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175747201550.884239.5015453227972787708.git-patchwork-notify@kernel.org>
Date: Wed, 10 Sep 2025 02:40:15 +0000
References: <20250905030711.1509648-1-wei.fang@nxp.com>
In-Reply-To: <20250905030711.1509648-1-wei.fang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 vladimir.oltean@nxp.com, xiaoning.wang@nxp.com, Frank.Li@nxp.com,
 yangbo.lu@nxp.com, christophe.leroy@csgroup.eu, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  5 Sep 2025 11:07:08 +0800 you wrote:
> Some PTP devices support looping back the periodic pulse signal for
> debugging. For example, the PTP device of QorIQ platform and the NETC v4
> Timer has the ability to loop back the pulse signal and record the extts
> events for the loopback signal. So we can make sure that the pulse
> intervals and their phase alignment are correct from the perspective of
> the emitting PHC's time base. In addition, we can use this loopback
> feature as a built-in extts event generator when we have no external
> equipment which does that. Therefore, add the generic debugfs interfaces
> to the ptp_clock driver. The first two patch are separated from the
> previous patch set [1]. The third patch is new added.
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/3] ptp: add debugfs interfaces to loop back the periodic output signal
    https://git.kernel.org/netdev/net-next/c/e096a7cc0be1
  - [v2,net-next,2/3] ptp: netc: add the periodic output signal loopback support
    https://git.kernel.org/netdev/net-next/c/67ac836373f4
  - [v2,net-next,3/3] ptp: qoriq: convert to use generic interfaces to set loopback mode
    https://git.kernel.org/netdev/net-next/c/f3164840a136

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



