Return-Path: <netdev+bounces-17745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B52752F4D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 04:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A267E281F7D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 02:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D243A4D;
	Fri, 14 Jul 2023 02:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E900809
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 02:21:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72FCFC433C7;
	Fri, 14 Jul 2023 02:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689301265;
	bh=Z+YyNKft/yNO6HkbCw8ttg+W0kytJcV940yRY0t2Ph8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hEvBNn55OuTTo6ozQ5WHPulQtyagnEBq9ws80QGSgGL/LXtKp8MTmnJ9Es7ys2eJq
	 KZIL3Co4VxUOBy6h2SpNdU/K0Lp6jNviyUOaTbi3SwsB+wZiA1spCxC2c5pxKBBDSJ
	 11tsxxTJq+QTDbTxLLQ+XlBoZHEF/c3nM+K5RYAd1VPtfOMCICDR3rDYk4S73UI5ls
	 NM+Du30y9hRLmP6+IHQ3MwJVMWUVhaT79b9KrMdL54qulZ54P4toJiphmoN/CbrEU4
	 /cX4LVPi5YNo7uCBykskNl53MdhkDS4MqeuHcjFzCdL+qQcCXWUdEyxmIVIPkwYoA7
	 Zz38BdVxEgckQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 58EAEE29F46;
	Fri, 14 Jul 2023 02:21:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next 0/5] ionic: add FLR support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168930126535.23383.301042946156500503.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 02:21:05 +0000
References: <20230713192936.45152-1-shannon.nelson@amd.com>
In-Reply-To: <20230713192936.45152-1-shannon.nelson@amd.com>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 idosch@idosch.org, brett.creeley@amd.com, drivers@pensando.io

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 13 Jul 2023 12:29:31 -0700 you wrote:
> Add support for handing and recovering from a PCI FLR event.
> This patchset first moves some code around to make it usable
> from multiple paths, then adds the PCI error handler callbacks
> for reset_prepare and reset_done.
> 
> Example test:
>     echo 1 > /sys/bus/pci/devices/0000:2a:00.0/reset
> 
> [...]

Here is the summary with links:
  - [v2,net-next,1/5] ionic: remove dead device fail path
    https://git.kernel.org/netdev/net-next/c/3a7af34fb6ec
  - [v2,net-next,2/5] ionic: extract common bits from ionic_remove
    (no matching commit)
  - [v2,net-next,3/5] ionic: extract common bits from ionic_probe
    (no matching commit)
  - [v2,net-next,4/5] ionic: pull out common bits from fw_up
    (no matching commit)
  - [v2,net-next,5/5] ionic: add FLR recovery support
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



