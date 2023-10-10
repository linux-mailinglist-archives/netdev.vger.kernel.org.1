Return-Path: <netdev+bounces-39638-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C227C0391
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 20:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08E0281BC0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 18:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D7C18639;
	Tue, 10 Oct 2023 18:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DcGMjb98"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531B4EB8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 18:40:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C191FC433CA;
	Tue, 10 Oct 2023 18:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696963230;
	bh=VvYCBuzvTxNqvXI0/Dte7XGp/9z7rAbpUZxhqoH0w1g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DcGMjb98/Qa93ZeX32y6kT0w0V/oo3n1UBPLX163GVEIVSKlSq2dZBcXXlDZ9FIUj
	 RbMcDVXRD4HszXwziM4dkr0fGYJEkdhtWXrGdR3Bp3Cftfn5jGHajzGHF1wHj2JRbF
	 WJkOO5O5voSB5AJXvaA/5mmsuiV/s2vPEewKGI8blHZ/50k1mVrQQUmh3QTR95IY9i
	 EKcttPJthdufQgygRx9w9lhYQl+hJ52qGmsptn+XJPL/OxSHmeN8tMrqcdvZQrjMSO
	 QaTWtF/mh0Uu+Hbze15UWMHXXaWU0Rghk7woOwSsjcHKlAm/TRVsRIdmSVWyI2kGC2
	 z20v6NewERRTQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A39CAE0009E;
	Tue, 10 Oct 2023 18:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: hci_sock: fix slab oob read in
 create_monitor_event
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <169696323066.22645.5131811474824547611.git-patchwork-notify@kernel.org>
Date: Tue, 10 Oct 2023 18:40:30 +0000
References: <20231010053656.2034368-2-twuufnxlz@gmail.com>
In-Reply-To: <20231010053656.2034368-2-twuufnxlz@gmail.com>
To: Edward AD <twuufnxlz@gmail.com>
Cc: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com,
 davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
 kuba@kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 10 Oct 2023 13:36:57 +0800 you wrote:
> When accessing hdev->name, the actual string length should prevail
> 
> Reported-by: syzbot+c90849c50ed209d77689@syzkaller.appspotmail.com
> Fixes: dcda165706b9 ("Bluetooth: hci_core: Fix build warnings")
> Signed-off-by: Edward AD <twuufnxlz@gmail.com>
> ---
>  net/bluetooth/hci_sock.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - Bluetooth: hci_sock: fix slab oob read in create_monitor_event
    https://git.kernel.org/bluetooth/bluetooth-next/c/78480de55a96

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



