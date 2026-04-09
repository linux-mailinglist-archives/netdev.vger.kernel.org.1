Return-Path: <netdev+bounces-276788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4C0xJdcR12khKwgAu9opvQ
	(envelope-from <netdev+bounces-276788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:41:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 03FF53C5993
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 04:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B7A7301E6EC
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 02:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5405C36A022;
	Thu,  9 Apr 2026 02:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QRxGSesu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310BA366563;
	Thu,  9 Apr 2026 02:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775702441; cv=none; b=nyPiENJl7Bt5rE0eW1XgyqcboRve1evdBUs5galSF5OPt+ZXPpZc3UOYa59JvT1xmC0XMNXLG1A28tskDEoBD655Xk8p2dxZajpbkKpH2ySUN+VNS4+No1aC9fri8No2065v6GMeCzpBgDQqbyQcH9V9Xyi1R351KwycJQyp/Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775702441; c=relaxed/simple;
	bh=9AS6lnn0pG0xFnIq6j4LI7C76y5no8P+4QUSujsOFdg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MClD2M8TBZ26UKT9hVYiZa8p6p320svH/Diu3yhA/IrXavP0qef7WmBg2YpaQNjjF99XObs6j2RDrnd9sJkvRXvA0IZgc0jCcHBowKJlee/1HQUGImmwlC/wNu6HWr9bVc2NSWYUclfEvyAvdWomIjqwAX3jpbcCXtCOlDDX0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QRxGSesu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1F7FC19421;
	Thu,  9 Apr 2026 02:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775702440;
	bh=9AS6lnn0pG0xFnIq6j4LI7C76y5no8P+4QUSujsOFdg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QRxGSesugSMNVkrRxnSzxKRoqN8Tr5gjssePKysFNVhPOtl69qap39jcHt6IzQX3o
	 PHI8eJYFo/QuJQH1+DGpQSt9CHLK6NgE6lkCg8Ut/eW6EPyOL6qOoevTbjXpiXgjjg
	 fjew/DO4e+mVlRS+d73WohsChDJI+8EIE9VmmgoBMIjZpPxZWyd8ikPGbt8EhxNb9T
	 9SczPPXmZYEj8BvbS+72sh8rCaONlQAa6MGxir2E40naaHScENej+ijAJv3owFi3Fc
	 1/E0aWD4iD4MkaVMPaPG/MAlnrH91nwbUBnS0Dnp9VG8WqARyXYssWyeM3W0H89jgZ
	 aoq94FwXxQRbg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC543930793;
	Thu,  9 Apr 2026 02:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] selftests: forwarding: lib: rewrite
 processing of
 command line arguments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570241684.964658.11915982289473565445.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:40:16 +0000
References: <20260407102058.867279-1-ioana.ciornei@nxp.com>
In-Reply-To: <20260407102058.867279-1-ioana.ciornei@nxp.com>
To: Ioana Ciornei <ioana.ciornei@nxp.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, petrm@nvidia.com, willemb@google.com,
 linux-kselftest@vger.kernel.org, shuah@kernel.org, liuhangbin@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276788-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nvidia.com:email]
X-Rspamd-Queue-Id: 03FF53C5993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Apr 2026 13:20:58 +0300 you wrote:
> The piece of code which processes the command line arguments and
> populates NETIFS based on them is really unobvious. Rewrite it so that
> the intention is clear and the code is easy to follow.
> 
> Suggested-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v2] selftests: forwarding: lib: rewrite processing of command line arguments
    https://git.kernel.org/netdev/net-next/c/fff75dba7992

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



