Return-Path: <netdev+bounces-272117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GKRyElpVxWkk9gQAu9opvQ
	(envelope-from <netdev+bounces-272117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:48:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A039337DA5
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 16:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6913161454
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 15:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F824070E7;
	Thu, 26 Mar 2026 15:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZN6iSroL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EE1140629D
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 15:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774539041; cv=none; b=Cv2f1+gymXURhxCsm9mN6LqHmiTq3ebCICpjSFbUgG7imAGIOHeh6L+SbhjfpWZZeKRNwY+bP7K/R9wbdJHTZmL1TKpaoD5OQzkZTabQGxEN2NDvslIYf8c3FAFW0H6eogJxpMDflMhuTu3BFs9kJ3VDYPsUf6EjwAsH6FOB/0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774539041; c=relaxed/simple;
	bh=HreVZYnRckYDyEMjUce/Qy7GLlm6mNkzDlrxXNC8Tfw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DmQQmJKWL4nLWxCFTXLtkGfIT+TUGe/ftx7JCuRdN3l6uZvwLw9AtA/kIKjidUwzDE8T8ArrI2Bm/CT8AAs/9QpiAn6CQyfCAApbQDjZjuSrBtA324tZa9h5Fmp2qiRISVH9GjzH69m/MVe+6TpLY6RWu0Y+w1+ukH20ha6qWCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZN6iSroL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACE22C19424;
	Thu, 26 Mar 2026 15:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774539040;
	bh=HreVZYnRckYDyEMjUce/Qy7GLlm6mNkzDlrxXNC8Tfw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZN6iSroLIxv/K51ijFXzY8sbeqGDNhml70ZzQG1bfUD4+qZ1bIo2RWMxVYqsouYPI
	 cLIsdbo6eYGdXoT0YfQNswQKz4yncfKgz7ggPJanRaz0645eOYJ/9uKEXVvLG8PpL6
	 k81aUVtEgv1Si2PbFBd2L4CqqW7pJj0Rt/Gzx9bMZdh4HCgAB5jd3xmwL94Sd1utwY
	 nfDJphX8Uq4leftRMo7Z24zHmQMG/wGpy+6I6fi+nXWjuzC3TDUd2hpipyoFknLWXx
	 Ji1Zdv6v4yZ9dInQsiuGso0vHxazJlh1B2HVYNmncTW/QPM6tk/q80xgrztzGoaNt5
	 0OhqtB1Ls1jWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CFEC39EFA69;
	Thu, 26 Mar 2026 15:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netfilter: ctnetlink: use netlink policy range checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177453902728.2636466.202984065147410322.git-patchwork-notify@kernel.org>
Date: Thu, 26 Mar 2026 15:30:27 +0000
References: <20260324171259.318041-1-devnexen@gmail.com>
In-Reply-To: <20260324171259.318041-1-devnexen@gmail.com>
To: David Carlier <devnexen@gmail.com>
Cc: pablo@netfilter.org, fw@strlen.de, phil@nwl.cc, edumazet@google.com,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272117-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,netfilter.org:email]
X-Rspamd-Queue-Id: 4A039337DA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Pablo Neira Ayuso <pablo@netfilter.org>:

On Tue, 24 Mar 2026 17:12:59 +0000 you wrote:
> Replace manual range and mask validations with netlink policy
> annotations in ctnetlink code paths, so that the netlink core rejects
> invalid values early and can generate extack errors.
> 
> - CTA_PROTOINFO_TCP_STATE: reject values > TCP_CONNTRACK_SYN_SENT2 at
>   policy level, removing the manual >= TCP_CONNTRACK_MAX check.
> - CTA_PROTOINFO_TCP_WSCALE_ORIGINAL/REPLY: reject values > TCP_MAX_WSCALE
>   (14). The normal TCP option parsing path already clamps to this value,
>   but the ctnetlink path accepted 0-255, causing undefined behavior when
>   used as a u32 shift count.
> - CTA_FILTER_ORIG_FLAGS/REPLY_FLAGS: use NLA_POLICY_MASK with
>   CTA_FILTER_F_ALL, removing the manual mask checks.
> - CTA_EXPECT_FLAGS: use NLA_POLICY_MASK with NF_CT_EXPECT_MASK, adding
>   a new mask define grouping all valid expect flags.
> 
> [...]

Here is the summary with links:
  - netfilter: ctnetlink: use netlink policy range checks
    https://git.kernel.org/netdev/net/c/8f15b5071b45

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



