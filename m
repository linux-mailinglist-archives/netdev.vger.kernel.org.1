Return-Path: <netdev+bounces-258539-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ep6AoORjmlFDAEAu9opvQ
	(envelope-from <netdev+bounces-258539-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:50:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC15132785
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 03:50:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3F164308F810
	for <lists+netdev@lfdr.de>; Fri, 13 Feb 2026 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13DE223EA85;
	Fri, 13 Feb 2026 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rM7I8u5B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5470347C7;
	Fri, 13 Feb 2026 02:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951019; cv=none; b=LcWBAarfwrZ7fa7UW+PMkxwEWoTMbbiOwtWjmyRSNmg9rP3H2NZV5KPUiV0Bw1kx6S7CBj8XE1RRHN3YzVouNNhLmkfaNnvs/RoetTK9vCiZ/jM4OLSyZ/BnRmkwZIackQBFveWH3ewhU6Is4xTNmc9KDR8aArUg3e0B164ID+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951019; c=relaxed/simple;
	bh=a4dcIPI5bc3ns8GoD0kP3vv75/MQpGeLDkm0Wfvh1/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R+kWTqiej8gTJPOH7dqx8EReFMMYhDGLp6I1zto623z3KdSe/Lom3p3AE00OBMFsWyglrt4MdBHzabNuvxvq7wb6n1befjJd/2r67UoPyIRR8heFCoUbozMpEeURFyO6DAOEnLFnY6JaAVcV6NCQdgCEqdI163TTQdhZ/oJafKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rM7I8u5B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF54C4CEF7;
	Fri, 13 Feb 2026 02:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951018;
	bh=a4dcIPI5bc3ns8GoD0kP3vv75/MQpGeLDkm0Wfvh1/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rM7I8u5BHF03mTKOWzVqx3fpJRlHiH7SmrlJuYE14I9ye0RSMq2f+K2UGdrS0nBWZ
	 sUbomiBPXwy28aQivZiztgDF3ERxBLGqst34BGUcBSUib+iIegcN+yy6wJeieCWqy/
	 OSO0FYD4Cmych1LO4Oh2UXiN6K5Ei/Zpguukv37AqKDEukWe+0fsoyHFIvy6QORUxS
	 Qs4jb40UcNP3Hvjk7fw7W283jJC9p29Ei1c1d2SwqwiEXkDS9bF5jbyJ+ZtWouBGqH
	 B49heHFsg1FNwkpUdr+I8FPtv37AWCLzM05BecH8cDh1HDLs297CIh2pnVfsxcsCFN
	 DFLqRa5LBS+YQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id C23DA3931093;
	Fri, 13 Feb 2026 02:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next] bng_en: Remove duplicate include
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101232.1819996.3801611459080724370.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:12 +0000
References: <20260211032021.2719742-1-nichen@iscas.ac.cn>
In-Reply-To: <20260211032021.2719742-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: vikas.gupta@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-258539-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email]
X-Rspamd-Queue-Id: 5EC15132785
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Feb 2026 11:20:21 +0800 you wrote:
> Remove duplicate inclusion of <net/netdev_queues.h>.
> 
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/ethernet/broadcom/bnge/bnge_netdev.c | 1 -
>  1 file changed, 1 deletion(-)

Here is the summary with links:
  - [net-next] bng_en: Remove duplicate include
    https://git.kernel.org/netdev/net/c/fe6515f5952c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



