Return-Path: <netdev+bounces-273651-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AZoLJHWy2mILwYAu9opvQ
	(envelope-from <netdev+bounces-273651-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:13:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1470E36AC15
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 16:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87F2C3096F0D
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 14:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D668A3F9F23;
	Tue, 31 Mar 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BC33zc/F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0B43F20EF
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 14:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774966222; cv=none; b=sy2PG92JbRxD3xKThTD5f8GJ+JVzncsK15Z/6N/9GL7jxFy6bDT6W/aWTAMKwYsJx2ve0diECVHzrcf4gisvV+loPCfM8ZuMwknXnYOhp4OmjUV9trbySAS3dGL7dAQ9AS+92s2zB1fR3czJhuDTRY6PEoYDwuEvlglMDLaixUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774966222; c=relaxed/simple;
	bh=m225p+zaeoz7WTYXgYiHFp1uFFmBPhX1yGYfwani1LA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F7Oip1qGOJ29Qz/jPk5On4gF2qlQ8s20VN0/Z6h8IDK5ZfQpUzGT25cqV6oSgbOrl3tA7Ztz8jwXBQxW3951kAoDKslKtJ2R5Nbq/DBta4pP79GElEh6slCXpyqpOn+UwUraBYCRa1gOH0Ts+cb3UtxBaS+TM3wQHK6UjbpgU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BC33zc/F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA080C19423;
	Tue, 31 Mar 2026 14:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774966222;
	bh=m225p+zaeoz7WTYXgYiHFp1uFFmBPhX1yGYfwani1LA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BC33zc/Ft8/hTnO20s4PcCC/Nohbb1zQL6wvj2hOpcvmxRSeE6bc+PACritsm4G13
	 fAUjswnrmHAEU7npav8iWQiDNgF3PSw3Zq/lcqQtwb3ve8zrDoQeSkRbrmgNlXkaa5
	 B9iNF8ef7wJkRfDgFbxCtwScqcZzjASIMEiVQ9vb5H9WX37Aj6v1dQZfA3lPo74UPg
	 MwRPlwEhYUQaBVGNegJ9JexZGQXhnm/1beLko3e8+AJCVKnB9+XUthbAZGCZnmTnfL
	 lOqHk4ErVHuZfqY7kmoxW3ehwHzjGBgwn8ljyHSgY4ng/9oikyVWkSkdsyj1Erx4Ed
	 wHYq/2YGYS6jQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0ED3809A05;
	Tue, 31 Mar 2026 14:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] fbnic: Set Relaxed Ordering PCIe TLP attributes
 for
 DMA engines
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177496620554.2311335.1486421284598776843.git-patchwork-notify@kernel.org>
Date: Tue, 31 Mar 2026 14:10:05 +0000
References: <20260327204445.3074446-1-dimitri.daskalakis1@gmail.com>
In-Reply-To: <20260327204445.3074446-1-dimitri.daskalakis1@gmail.com>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: davem@davemloft.net, alexanderduyck@fb.com, kuba@kernel.org,
 kernel-team@meta.com, andrew+netdev@lunn.ch, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, jacob.e.keller@intel.com,
 mohsin.bashr@gmail.com, lee@trager.us, mike.marciniszyn@gmail.com,
 netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273651-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[davemloft.net,fb.com,kernel.org,meta.com,lunn.ch,google.com,redhat.com,intel.com,gmail.com,trager.us,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.991];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fb.com:email]
X-Rspamd-Queue-Id: 1470E36AC15
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Mar 2026 13:44:45 -0700 you wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> Add ATTR CSR bit field definitions for the DMA engine TLP header
> configuration registers:
>   AW_CFG: RDE_ATTR[17:15], RQM_ATTR[14:12], TQM_ATTR[11:9]
>   AR_CFG: TDE_ATTR[17:15], RQM_ATTR[14:12], TQM_ATTR[11:9]
> 
> [...]

Here is the summary with links:
  - [net-next] fbnic: Set Relaxed Ordering PCIe TLP attributes for DMA engines
    https://git.kernel.org/netdev/net-next/c/9229cb5a941c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



