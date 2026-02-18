Return-Path: <netdev+bounces-259184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLQRH/oTlWlYKwIAu9opvQ
	(envelope-from <netdev+bounces-259184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:20:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EDEF01527E8
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 02:20:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5A6173052AFD
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 01:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91182D738E;
	Wed, 18 Feb 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYmYlyGo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B15284665
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771377625; cv=none; b=pW5n1fGIfSkRgefPsyXGu5SU7I7xbAmg+qQ9ORlbBWRv87enu8kee0EmT+HPXbhICDuoBZ1v/gDd7rWPqDeC5eCa4g2NMIQyHrcuSl2icJ1AVs+b2o8AeUyTS0Fw+Qby4my8ZafmQhPlxE/C2FNO3lUMK8I0kwUqc/ZQfU4D+nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771377625; c=relaxed/simple;
	bh=nHVpOmQMRMhWr2IgXDXLhTq352iqEVSQ6/n3E/vK+lg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hg+M61XrEmqxgADoSRlj6+K0O11mwHzCSl857krN6OZyCzHeFxTCSXqwnojli7ssjim2ZEMEHqIRY7O+NOMe4vhCtH2cw+RbValywTzT5PnlQM+iML4w2WcMheMUA071FezpzzYLC6YDmFK5ry7vNO82/lO/49tM7xEJ8k9pRMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYmYlyGo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92AA7C4CEF7;
	Wed, 18 Feb 2026 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771377625;
	bh=nHVpOmQMRMhWr2IgXDXLhTq352iqEVSQ6/n3E/vK+lg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jYmYlyGonjDm5ANhgved1V6JxNKfgWXm45/xSEwL6jcjrYyZiRoG2cPoBenNd0fsV
	 EwXts7G89Afg+MvXua3hudeZKKlycGyzfpw7gghZ1/A+wYwQdyKGNutZG8py4DTZat
	 w3kc42QE70PRK2E45vmzk+sPunSUVRGKcET7XxDJig3bi1R94XGaZVHIZQptJBhLar
	 KQSBPwCOGjAgDO2XfGq2gfBxmDk6q5wDnqDDyuaKe4c3q7H77VR3yWqt92aj6c9oQg
	 y8wjK3qgjLXUXPc6IH/fh80w8NPSJFogbQn8BnuR5uvzngnks+Qg0US4zBfVZm4PgL
	 WSU+3KxQN4JDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 84FD63806667;
	Wed, 18 Feb 2026 01:20:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ping: annotate data-races in ping_lookup()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177137761707.765825.17845226541522243431.git-patchwork-notify@kernel.org>
Date: Wed, 18 Feb 2026 01:20:17 +0000
References: <20260216100149.3319315-1-edumazet@google.com>
In-Reply-To: <20260216100149.3319315-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-259184-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EDEF01527E8
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Feb 2026 10:01:49 +0000 you wrote:
> isk->inet_num, isk->inet_rcv_saddr and sk->sk_bound_dev_if
> are read locklessly in ping_lookup().
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> The race on isk->inet_rcv_saddr is probably coming from IPv6 support,
> but does not deserve a specific backport.
> 
> [...]

Here is the summary with links:
  - [net] ping: annotate data-races in ping_lookup()
    https://git.kernel.org/netdev/net/c/ad5dfde2a573

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



