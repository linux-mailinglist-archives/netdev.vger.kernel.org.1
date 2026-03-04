Return-Path: <netdev+bounces-263533-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAfUI6iMp2nliAAAu9opvQ
	(envelope-from <netdev+bounces-263533-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:36:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 59C411F9874
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 02:36:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B590F3077142
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 01:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2233065C;
	Wed,  4 Mar 2026 01:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YALUO8XS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08162330317;
	Wed,  4 Mar 2026 01:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772587841; cv=none; b=o+yTGR16XkSIwUY+p2fu9vxrU79LIHQQOsd61qmQ4B6XHIGCYS7bZoSTQtx9VmJVY1noez/todCJOAyfzUmdTocFzIA+0o7+uKbq7SHrGKr5aYDyXWGU0JJMmJxdJsgostgzfFF22/Jfp0raGFqNqPQ3yVs5rlqpytNU71Fyxi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772587841; c=relaxed/simple;
	bh=nNM89GMzz09FFMOfCSNaVw2W0NXvOj3qbMWRcIk6TEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kmY8JVV82XA6Btn1+IGz/5cj6CdsdnizRHwvlDtRstHA4ZfHdjnRrjpAwUrrjGEkv8qDZmR6ZVyexoPN+WWgtruZ+gReTnGZ214wye0CM8ocsZatqHQKBnvByPVBZVbmEMCeUdlvYsgnVeNoue3m2KHB4vjAy6gwSJ94wfUNaJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YALUO8XS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DE0C19422;
	Wed,  4 Mar 2026 01:30:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772587840;
	bh=nNM89GMzz09FFMOfCSNaVw2W0NXvOj3qbMWRcIk6TEQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YALUO8XSCqxOOyWMP4oQlO/tiVUYJxrzF28XmjpKBBLD8i7siP52vuG1dFs1ewAwg
	 4vTjdY0xlrLGZ44cvdQch+f+8dR4p6yQDGNeWs+djVt6ECSze1E/+a5qhTMGmJgHAR
	 PDupUq3Rg3WuaQL/XaYljXqWTA02jmQDzA08uRVlaHs0V41orNUtFrh47qPFxwzt3l
	 TmyX4ygSgmTepFQwqhD2vWln+yNpz8C84/WzejM0WMp4QVpEO9SP1D6XD2ZmP09Giz
	 uDGr4WZrUggfDfNE7sXuwzDnPfSFzrgM+jUtn1UhSfnLec7QM7q3y42oZUu/X4rIVm
	 3B4BZ4PurteOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E623808200;
	Wed,  4 Mar 2026 01:30:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 bpf-next] net: core: allow
 netdev_upper_get_next_dev_rcu
 from bh context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177258784156.1546050.14252305363021482077.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 01:30:41 +0000
References: <20260220110922.94781-1-kohei@enjuk.jp>
In-Reply-To: <20260220110922.94781-1-kohei@enjuk.jp>
To: Kohei Enju <kohei@enjuk.jp>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, toke@redhat.com,
 kohei.enju@gmail.com
X-Rspamd-Queue-Id: 59C411F9874
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com,fomichev.me];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-263533-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 20 Feb 2026 11:09:17 +0000 you wrote:
> Since XDP programs are called from a NAPI poll context, the RCU
> reference liveness is ensured by local_bh_disable().
> 
> Commit aeea1b86f936 ("bpf, devmap: Exclude XDP broadcast to master
> device") started to call netdev_upper_get_next_dev_rcu() from this
> context, but missed adding rcu_read_lock_bh_held() as a condition to the
> RCU checks.
> While both bh_disabled and rcu_read_lock() provide RCU protection,
> lockdep complains since the check condition is insufficient [1].
> 
> [...]

Here is the summary with links:
  - [v1,bpf-next] net: core: allow netdev_upper_get_next_dev_rcu from bh context
    https://git.kernel.org/netdev/net-next/c/39feb171f361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



