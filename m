Return-Path: <netdev+bounces-290541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WF9fEcoyD2qSHgYAu9opvQ
	(envelope-from <netdev+bounces-290541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:28:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 663315A9492
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 18:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82E343065738
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 15:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90815357D0B;
	Thu, 21 May 2026 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUv0BR9t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57554360EE1
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779377403; cv=none; b=D6acQg6POnwfeq9nUh03ipEL6cWTpXjcmGA/MB2HwNealcFmocoe0JD5em3iwriHOZ607FcqI7ULRIz2HYxVG28d+wi6Y/VJ6Ki2Wc0vWerHwRae0nPm94/BNAzunPZWMKd5Kbw1gmsonK3RKyMCcUJlQLTiuqQJU8C3gP0ZdgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779377403; c=relaxed/simple;
	bh=Yyr9IbzLYk/ixCtNxkr7zQ0VmhDiRtgH1bmYe8tOc5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iRvH2ONGis2XIjvXLTEy7PMIrnvuaZtDHyhct2yKS7dqu41zgWhqrd0zv/7O99SwvpqX7WNXFSnPohKT2JBZBQ7jb041vYQZRgG3WesTP//ejrqzuEMVHz0PL0mW22aJrQy7guSSViaHCRmKUTVrrVK8CeQ1ge1fDVo+kYyBnU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUv0BR9t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFD91F00A3B;
	Thu, 21 May 2026 15:30:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779377402;
	bh=UG4NapV2txzWaDpLsyk2dRJLCWoWVPtADyWjm+9V7q0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AUv0BR9tIWSjq8IBQFT2wOHxF65S5W4Ibu8Dpsi6iPegUFN/N+VIpFcL6AID/h58K
	 SmSTlK/6BTOo8rPFiF8hlyhpkV8c8K+xTjOcFPHYdahBygeCobX+sWX+FumN8Z0z5G
	 Tf0fHISIiRh1v9iQWPk4B/QFi/9A8bMS6au4HZF80CQpVKgLea9wfO8A6/Q5wdKAWa
	 8ce0D2sW8EoNvQDAbYfK4dvvA5VDPg64qFJjvYBtc/DiT3q6pXTYwaLcUymR8iFV+j
	 ZOpNjgpXsxftza2Rs7sh/KTDLE/y/AFeKEH2dLG9TDDT7LGoBOVbTxuTIOhlRrv7vV
	 226bpjpl/MLLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1991E3930E02;
	Thu, 21 May 2026 15:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: gro: don't merge zcopy skbs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177937741163.384060.17108249006950873409.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 15:30:11 +0000
References: 
 <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
In-Reply-To: 
 <c3b7f906bbfcbdfd7b4fa9d6c18a438870df85be.1779307748.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, huzaifas@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 asml.silence@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,redhat.com,davemloft.net,google.com,kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290541-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 663315A9492
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 22:44:42 +0200 you wrote:
> skb_gro_receive() can currently copy frags between the source and GRO
> skb, without checking the zerocopy status, and in particular the
> SKBFL_MANAGED_FRAG_REFS flag.
> 
> When SKBFL_MANAGED_FRAG_REFS is set, the skb doesn't hold a reference
> on the pages in shinfo->frags. Appending those frags to another skb's
> frags without fixing up the page refcount can lead to UAF.
> 
> [...]

Here is the summary with links:
  - [net,v3] net: gro: don't merge zcopy skbs
    https://git.kernel.org/netdev/net/c/4db79a322db8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



