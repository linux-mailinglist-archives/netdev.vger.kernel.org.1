Return-Path: <netdev+bounces-14317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AB174019C
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B20541C20ACD
	for <lists+netdev@lfdr.de>; Tue, 27 Jun 2023 16:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A19FA13076;
	Tue, 27 Jun 2023 16:50:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCBB1373
	for <netdev@vger.kernel.org>; Tue, 27 Jun 2023 16:50:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D41BEC433C8;
	Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687884620;
	bh=6TvhQXborCtEFeKBN48VRZ6+Hf6Ywkxx1C1qCnmtMyk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PDoU8Pk+vZF5nHbbYgCyVdfJj+7bA8SNla+mouM9FuU553sP3haUAEXFU+Fqn/zzh
	 zVrEZjb36g7jFMiR/WLOUPw0+9dMXqsIQxR7QF1TxYvEeWErpQIsRJZre5duagfMJn
	 pK6TUdoFpa2N7lNH3bQxTfE42Sg5WzfuL8mzK0A+bmAlTIsKgdJJ0TQleVoWpvrAMG
	 SxPs5ycgGmRLBmzl8ZwEH1SfYTHdNIbkDs3lN3lLJZKJi/PyLYIKPzyvDbj+gYlzYn
	 HE1tPxQQqAVkBOX4P4pvxlZ8VUYrg5EHyOB9uH0gcCQCdjJ+jSlenMfuP9om/qwODd
	 ajvDzA83cyaLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id AC7D7C64457;
	Tue, 27 Jun 2023 16:50:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] netlink: Add __sock_i_ino() for __netlink_diag_dump().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168788462070.27533.16207439638694222251.git-patchwork-notify@kernel.org>
Date: Tue, 27 Jun 2023 16:50:20 +0000
References: <20230626164313.52528-1-kuniyu@amazon.com>
In-Reply-To: <20230626164313.52528-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+5da61cf6a9bc1902d422@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 26 Jun 2023 09:43:13 -0700 you wrote:
> syzbot reported a warning in __local_bh_enable_ip(). [0]
> 
> Commit 8d61f926d420 ("netlink: fix potential deadlock in
> netlink_set_err()") converted read_lock(&nl_table_lock) to
> read_lock_irqsave() in __netlink_diag_dump() to prevent a deadlock.
> 
> However, __netlink_diag_dump() calls sock_i_ino() that uses
> read_lock_bh() and read_unlock_bh().  If CONFIG_TRACE_IRQFLAGS=y,
> read_unlock_bh() finally enables IRQ even though it should stay
> disabled until the following read_unlock_irqrestore().
> 
> [...]

Here is the summary with links:
  - [v2,net] netlink: Add __sock_i_ino() for __netlink_diag_dump().
    https://git.kernel.org/netdev/net/c/25a9c8a4431c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



