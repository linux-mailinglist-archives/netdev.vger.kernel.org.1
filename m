Return-Path: <netdev+bounces-275238-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OS8KB450GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275238-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:03:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07987398A0F
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AEB7D3093E1D
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7351F364041;
	Fri,  3 Apr 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uU+rq/eX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5055E36402C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253633; cv=none; b=sFb2Rm+FXWMq/s5SDAUlIjVYsEpguAVR60zWGpOLj6mlBpgXM3z9DF0y34lqYxjTRXGe9PWpsxUq04hXSQ1Avepa01Br+JYd0Kw8EQuIwSUWV6stFjai7upZPtQECsQvzN3kmUjimVgdoDmElNwwiiJiEYLsbtfehRum42K8xWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253633; c=relaxed/simple;
	bh=wqBcj2NMo48zn6on1bQ6OXkjU7pnXL1t6MDijusiVNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pr0wN3ZHaCisuuvvDd5awAQkNhB+nQVSRhBulkoJ3pcl69AzusuvEcCIj5sav2tVdglotHClbSlnJfInDITB8G2IsypIVHjdNlpY9yCHI/OXFCwCP/L7n9uxbxZjMx8xrw6AEReUYnlrJ0sxR1hcdQKObItmWNTNx4gz4HOIlpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uU+rq/eX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC73EC19423;
	Fri,  3 Apr 2026 22:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253633;
	bh=wqBcj2NMo48zn6on1bQ6OXkjU7pnXL1t6MDijusiVNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uU+rq/eXmgglHQcKCI1ywp0mU9Ob5B82DEnV7AxVsucTyM+qWQSYJFLTi6PfBXA8T
	 BOwEoCSqSvkg2w/D8EvzvqYvOPciwFY1Rouf4nFQy5UrWS6eTjLxm8PnBUwjPA0egY
	 3raCmCDRPekUQuylQZkuywCwwrCjV0QCI1IziHuxXHYxhE9sK/nSHCX6/aXbmm8q9W
	 fet8woaqtAUchELyI7t8Kg5ccBCMHhrm98unuIu5FaxcoZBLdjT3RE4Chr6hDcTWsn
	 fxh9QJS0ADpOS6edURs5Ktf15BHSHbzFsqV2jem4FEYNC3WQT12GmFurLLG7XBpVVY
	 /Z2yAEiHv8nJg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F533809A14;
	Fri,  3 Apr 2026 22:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: sched: act_csum: validate nested VLAN
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361453.1466030.17187869530232713242.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:14 +0000
References: 
 <22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com>
In-Reply-To: 
 <22df2fcb49f410203eafa5d97963dd36089f4ecf.1774892775.git.caoruide123@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, elibr@mellanox.com, yifanwucs@gmail.com,
 tomapufckgml@gmail.com, yuantan098@gmail.com, bird@lzu.edu.cn,
 enjou1224z@gmail.com, caoruide123@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com,mellanox.com,gmail.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-275238-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07987398A0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 22:46:20 +0800 you wrote:
> From: Ruide Cao <caoruide123@gmail.com>
> 
> tcf_csum_act() walks nested VLAN headers directly from skb->data when an
> skb still carries in-payload VLAN tags. The current code reads
> vlan->h_vlan_encapsulated_proto and then pulls VLAN_HLEN bytes without
> first ensuring that the full VLAN header is present in the linear area.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: sched: act_csum: validate nested VLAN headers
    https://git.kernel.org/netdev/net/c/c842743d073b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



