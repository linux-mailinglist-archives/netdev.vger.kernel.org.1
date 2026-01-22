Return-Path: <netdev+bounces-252205-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJ2hNdancWmjKwAAu9opvQ
	(envelope-from <netdev+bounces-252205-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:30:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4185061B88
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 05:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4C8DA4EA7FE
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 04:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 701E9364046;
	Thu, 22 Jan 2026 04:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jQFE6sbQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119C3342CB3;
	Thu, 22 Jan 2026 04:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769056209; cv=none; b=H9TUx3scZREngs9PeIpmgevy856/KWt7c2ypr5zPkYuIWw3jLJBYlrN0LluBtUpkx3A9FwLmKdI4r3ZvliwvTbnBBR/L7dzos6N31nZwrkqjnSea4ncNG1VHHwqwqBqgRLOxRLu9gbjdGrAceNd60g1TcbGqA23gkBJ28Aw0Hrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769056209; c=relaxed/simple;
	bh=hnGeGwdxSxEqCyYD6ES4wKWPV/bIz+DhKa0Tr5rnzNM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iHcqIi3qOk00dG07moI6jkAFz4j5U51oPMdLslhiT0Gif0iB6Jmmi6dzi8T1nxzNcNNh6MdSeq+E01aX+eogHhxCZ6umfTIMnwNQLfAjhoSX92yMvKceyj8pv0Dz145yzUibxGhUmiFtOjbzVz2DZdC8i2AwGBVqUN/MR/wdVrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jQFE6sbQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94915C116C6;
	Thu, 22 Jan 2026 04:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769056208;
	bh=hnGeGwdxSxEqCyYD6ES4wKWPV/bIz+DhKa0Tr5rnzNM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jQFE6sbQNMGRuTnEkVCDmUYmMWtbZJp7r41iIa41FAbxJf2iNm3Nz9YYAICjtNJpZ
	 SUryruUt8Iz7WQojtFYUG1E8tmPdsHPkzcmEIxxsYaqX58ObfcHKbzfeI8IKY75mrr
	 bkCxZUtOENjz48WP09dq8tE+t566pdW0OgcamMdkp0Wgvf3wvF3LmHjcexS2Yy3JN7
	 CZ4h73Pobgh26dGz6hMSouGqXKmLAciAvQtYhF0cdC5Wultp+qnp7CbXFBC1SYqbmg
	 2bHMv/A2kmc5hZ/FEQjKvPm2zb3ch7CQU27EHiGhB1vPWsqor5IvuQdlyDQZg3NrT5
	 S2uIU7c5yGRWw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBCE3808200;
	Thu, 22 Jan 2026 04:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-af: Fix error handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176905620536.1556348.16974849678560370809.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 04:30:05 +0000
References: <20260121033934.1900761-1-rkannoth@marvell.com>
In-Reply-To: <20260121033934.1900761-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252205-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 4185061B88
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 21 Jan 2026 09:09:34 +0530 you wrote:
> This commit adds error handling and rollback logic to
> rvu_mbox_handler_attach_resources() to properly clean up partially
> attached resources when rvu_attach_block() fails.
> 
> Fixes: 746ea74241fa0 ("octeontx2-af: Add RVU block LF provisioning support")
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: Fix error handling
    https://git.kernel.org/netdev/net/c/19e4175e997a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



