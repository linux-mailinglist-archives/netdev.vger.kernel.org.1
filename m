Return-Path: <netdev+bounces-280601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P1NLeSi6WnafwIAu9opvQ
	(envelope-from <netdev+bounces-280601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:41:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1989E44CFFC
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD71730A1B21
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C20437E314;
	Thu, 23 Apr 2026 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmMhSvw0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79762332EBB
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918654; cv=none; b=heHI79rTO8Uvd7gIxD6Qu951bsG03sv4TDoW5kshB5ds4Seaj6P1GQU/m1DyOdQLUC0au15aF7usWjTiQYIoImSKv9A7wq9CVIrVznxis9ZhVL68pw9nhY6jWM97vQ/dWir9ebqg8co3zPMKELfY0MivrkUGyRfhnp4OZ618H8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918654; c=relaxed/simple;
	bh=Vfn7WyAgD9ErmvAguafylYjEE3asclfLKri7kWTWwAI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gn4xBj7TX0y6OuhWkNZHALx37l2z2rIkvZ33XqxaaS6EWv7z41Jwa6Bn54cnf0ZNWSWab1vCpynK+szvp61MiKX5s8D7rMroAZM3Vn6RS5lNcZ+Wx2PxrFHQlzgvyL/3O1hDJRnzJaSYYuY8y/unLzm2FlJpX/6Uoy3s2hQC3CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmMhSvw0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 544AAC2BCB4;
	Thu, 23 Apr 2026 04:30:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918654;
	bh=Vfn7WyAgD9ErmvAguafylYjEE3asclfLKri7kWTWwAI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KmMhSvw0fMFIBUAxazj9/A/LqAZUsBcjG5bzV+ttZAbDYPedjA17vVBURiGOVjx1t
	 EdjujvlTiHlAWn4bigOD93yLGwcyg3Zu8oVJqiVyy6NoOx8+2JndiQZE//IGZFXr5n
	 Ob5OFqw7MO5z5tkzNuJszQXDuQGpoY250kKGKluFEGiVoKPCDZOhog+Kl5g+6o57X3
	 B4Z9lOYM5lcptMocvHuB9rrUa3Dc8UK7usvogFgPNYZJJuQQXt9ZRgPr+hWDFWZfI+
	 OFkbl2vSNft/th7OEEsidLdgQAZzivLd8cYEsZqIzEdoWj53Xm8Rbii2enkYJqaRbr
	 pPlm78Ul2szKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CCC13809A86;
	Thu, 23 Apr 2026 04:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_sfb: annotate data-races in
 sfb_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691861629.4157517.11724096991046656703.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:30:16 +0000
References: <20260421141655.3953721-1-edumazet@google.com>
In-Reply-To: <20260421141655.3953721-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280601-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1989E44CFFC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 14:16:55 +0000 you wrote:
> sfb_dump_stats() only runs with RTNL held,
> reading fields that can be changed in qdisc fast path.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Alternative would be to acquire the qdisc spinlock, but our long-term
> goal is to make qdisc dump operations lockless as much as we can.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
    https://git.kernel.org/netdev/net/c/1ada03fdef82

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



