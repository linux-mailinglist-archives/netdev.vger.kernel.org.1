Return-Path: <netdev+bounces-34358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37E7A36A3
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 18:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3883A281CCD
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 16:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA63C5394;
	Sun, 17 Sep 2023 16:50:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31814A2A
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 16:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 41FBAC433C9;
	Sun, 17 Sep 2023 16:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694969423;
	bh=C9gxb6ygGZTrYUONXA9mBq77NHECc+jbe5xlDI++VEo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n7/m2+NMUxNVSPnhpbbe+9yfGzZRUdrN2jQee8HZJB/k1SLiQ56Gfrd9Dukvpzst4
	 RU+FKiXsilR4f90uE6IjFPPw2/WXB+LdcDqh6L5Kntft3t/NVaFGpIxckaxkUkn5dy
	 7rE/0isBmj0D/GGZgLpDTrJpSTAkA0k6jeB0A1QWXKvDiMnazd+/LeNNFENK2uO/vx
	 oK/XtkbhVXe0VIZprphvK3ymhEjDDqfX2pSOKnSPK7dHB0J28pa/zzoeW3BneI5sj2
	 cre8n8GBCbtwluui3ws5idgVJagTEzXQBXwbFOv7U8FPEN4OkMvau0aTPAKAsxKKsc
	 +QR7Q1CN16AlA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 266F1E26885;
	Sun, 17 Sep 2023 16:50:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] scsi: iscsi_tcp: restrict to TCP sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169496942315.18728.17720146599552391400.git-patchwork-notify@kernel.org>
Date: Sun, 17 Sep 2023 16:50:23 +0000
References: <20230915171111.4057930-1-edumazet@google.com>
In-Reply-To: <20230915171111.4057930-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: lduncan@suse.com, michael.christie@oracle.com, cleech@redhat.com,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 jejb@linux.ibm.com, martin.petersen@oracle.com, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 15 Sep 2023 17:11:11 +0000 you wrote:
> Nothing prevents iscsi_sw_tcp_conn_bind() to receive file descriptor
> pointing to non TCP socket (af_unix for example).
> 
> Return -EINVAL if this is attempted, instead of crashing the kernel.
> 
> Fixes: 7ba247138907 ("[SCSI] open-iscsi/linux-iscsi-5 Initiator: Initiator code")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Lee Duncan <lduncan@suse.com>
> Cc: Chris Leech <cleech@redhat.com>
> Cc: Mike Christie <michael.christie@oracle.com>
> Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
> Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
> Cc: open-iscsi@googlegroups.com
> Cc: linux-scsi@vger.kernel.org
> 
> [...]

Here is the summary with links:
  - scsi: iscsi_tcp: restrict to TCP sockets
    https://git.kernel.org/netdev/net/c/f4f82c52a0ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



