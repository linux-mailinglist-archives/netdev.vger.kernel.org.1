Return-Path: <netdev+bounces-53174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C25E7801905
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 01:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 775811F210A2
	for <lists+netdev@lfdr.de>; Sat,  2 Dec 2023 00:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF87F7E2;
	Sat,  2 Dec 2023 00:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OoJlNKbi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B29FB1857
	for <netdev@vger.kernel.org>; Sat,  2 Dec 2023 00:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5A159C43395;
	Sat,  2 Dec 2023 00:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701477624;
	bh=y6UX/8wO227yLeoj7K8iltIdsezgY6vVM57Wu0yA3oY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OoJlNKbif4mLWYG8i9Zd4GMEDlxJ24GO/Yvcvwo+6zceygx++QbSbpzSwT/7lPJLG
	 mvTfhmDUuKJnxjYHpHjgrkK6rjkCAyQkvqU0yFb6HsQIsNBxPQYcvaXpkASSBirFOv
	 6T80g8h8s97ckxySu9LYKSZ1Bx/E5wotQUJN1KcM0jIhs/jb+YU02XuJv7dcFDGT6e
	 NpnJTKuwAyAWHl0Obdjq79O81n2AlUAr9DcLa43sSDcwYuuk9a87ecLgc4q+jGGTBS
	 YhUqr7pOe4JgZmmZqBI2IivgOCxn8+w6GxJA8SYvacGV4DB/yatrw2+CDVomF9vbgl
	 97TVQVRN/4w2w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 230DAC395DC;
	Sat,  2 Dec 2023 00:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net/tg3: fix race condition in tg3_reset_task()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170147762413.28593.6189426352632406246.git-patchwork-notify@kernel.org>
Date: Sat, 02 Dec 2023 00:40:24 +0000
References: <20231201001911.656-1-thinhtr@linux.vnet.ibm.com>
In-Reply-To: <20231201001911.656-1-thinhtr@linux.vnet.ibm.com>
To: Thinh Tran <thinhtr@linux.vnet.ibm.com>
Cc: michael.chan@broadcom.com, davem@davemloft.net, drc@linux.vnet.ibm.com,
 edumazet@google.com, kuba@kernel.org, mchan@broadcom.com,
 netdev@vger.kernel.org, pabeni@redhat.com, pavan.chebbi@broadcom.com,
 prashant@broadcom.com, siva.kallam@broadcom.com, venkata.sai.duggi@ibm.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Nov 2023 18:19:11 -0600 you wrote:
> When an EEH error is encountered by a PCI adapter, the EEH driver
> modifies the PCI channel's state as shown below:
> 
>    enum {
>       /* I/O channel is in normal state */
>       pci_channel_io_normal = (__force pci_channel_state_t) 1,
> 
> [...]

Here is the summary with links:
  - [v4] net/tg3: fix race condition in tg3_reset_task()
    https://git.kernel.org/netdev/net/c/16b55b1f2269

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



