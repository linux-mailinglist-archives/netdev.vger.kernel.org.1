Return-Path: <netdev+bounces-261156-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJt8Dfi5n2n5dQQAu9opvQ
	(envelope-from <netdev+bounces-261156-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:11:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF411A05CC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5EE8530636BC
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:11:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82230389DE0;
	Thu, 26 Feb 2026 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D3P7j/3h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600CF385533;
	Thu, 26 Feb 2026 03:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772075422; cv=none; b=kE5OjOVXxk5mxsNePuDHQrV+wm9WQcBduUEN6sMJF0E7cHIXpIqQvgoRtxZbebwpxVBNJehqpf84fjgR4s7TAfaW9SMsoTVGzs2xbWLo6AIe4s6cMiwGvLfs/DSgFsXOZmwnESOGboSbkfQlsmZ24V5VEwpjhGR0tLmnWKsBYDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772075422; c=relaxed/simple;
	bh=WEuS4UpaH1mhIWOXTq0r0IT77NR5gxE3+MA6q4btOhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pjiuwoFBb8bvOBbxbEAUhltjLup62Wnjch4RLqm7YbjaMMB37tYm487oMtkf/pCEF/fF3sMz4IJNc1m6e/gjvM/U5CcrSrcSPqqIGjYjjWeQEr9c50EIHzaJ2K2RrPgRxxk8GppPExOkhbkoHqX2K8A6zP5zxZ8P1qEyAaLguE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D3P7j/3h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A946C116D0;
	Thu, 26 Feb 2026 03:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772075422;
	bh=WEuS4UpaH1mhIWOXTq0r0IT77NR5gxE3+MA6q4btOhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D3P7j/3h2OKv9yJKV4WmVeFHd+O7/FsGSb7Z0XFndDxNikaWTzyqt0bzBJmL2uard
	 RukAUeCwrWIdpDPcwUiUG/KFdHscIneyNWirPw8zxdf9iDvW7/11ti+Ulu6jXl+w/a
	 Dl7BJwZa50XOei3pUhQYk1TIF6SoJJ4sM9YfRi0XKSbMrAnYtuvKT5/WaGphkRMp+t
	 +4TBSEdIxM5gokvRH3tNd1Jiawkm+YeTDYeGKfS0fWKDKbh30ETlYybmkgiuJtmS6b
	 0F8roWj6nkVZtvQyXe/+pI5NXgeFJ4UwqOHlVfSVRWnrXpmEmMCxW6KYwUqTBbeym/
	 L/6cd6mHujBNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C13380A94B;
	Thu, 26 Feb 2026 03:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: fs_enet: allow nvmem to override MAC
 address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207542654.1014739.9375392210981588857.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:10:26 +0000
References: <20260224014607.353378-1-rosenp@gmail.com>
In-Reply-To: <20260224014607.353378-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, pantelis.antoniou@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,lists.ozlabs.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261156-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CAF411A05CC
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 17:46:06 -0800 you wrote:
> NVMEM typically loads after the ethernet driver and
> of_get_ethdev_address returns -EPROBE_DEFER. return in such a case to
> allow NVMEM to work.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fs_enet/fs_enet-main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> [...]

Here is the summary with links:
  - [net-next] net: fs_enet: allow nvmem to override MAC address
    https://git.kernel.org/netdev/net-next/c/dc2a1facbde8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



