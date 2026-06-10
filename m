Return-Path: <netdev+bounces-297399-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MS13BjfEKGodJQMAu9opvQ
	(envelope-from <netdev+bounces-297399-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:56:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 69826665594
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 03:56:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=X+Vdz8sL;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297399-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297399-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 37BF93183C28
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 01:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64E0633D4F8;
	Wed, 10 Jun 2026 01:50:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018323C4F3
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 01:50:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781056217; cv=none; b=t+nAVHuRB3StrkqUHL9O6d8japx0WEihRDAidDEXFoAtPTQKFPw5Bu59QwY4xYGLsqj0aZhAXIcdpbAER2hPQ0gGYpPu0dG1wkoqhUQmtLm65efIKZ+rbSJ41EooGdOPV6YEyyLnNcsLqoQt2PNR4kjWHDjzV4QUdsZGTO2chEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781056217; c=relaxed/simple;
	bh=RInikper9oYiIGFt3SXSjwjcJ0LuefSqBFzFzUujGgs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gMyo3UvrM2mrtfGbIunSa8+1f/NHZOW+OqMT2hWy5JtladAR+hTCsmBFZU4wMnTtadD0RN9izQCGKVOmSE9JSsQcFGYz9tuBFSAx26NOulF9CUbQ+Vq3gIUeE/nw/6FyAydHr68pVP9RAhMzTMPJ+gHfYvv4dY7s2z2r1iRaHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+Vdz8sL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B14AD1F00899;
	Wed, 10 Jun 2026 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781056213;
	bh=9SKIoIFT1unMHfvoewDivHp0l2pHQzqsr1y9+CMgsds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=X+Vdz8sLRLAb6EnVANATQSPan+J+yx6wS71hZGVF2U8x/yxxXuMezdj/n/6YSpnn3
	 KePrcWKll1pnSdG21qwtqN2wkecgx5tRoosx5WD2WSRbQRqLhbUbNmOGv83fz3I6j/
	 CQyvOEEu1YVHQfm6oW5GwW/aorsci2nOwvtb3OPWlaDCtyJgc97xXYqxaNrsYEHLCs
	 lI/Qp3z8mV7+wZMtGbsZ8KaTFDKx5kinVw8hljPT23MJ6B0D8b3OvZyG9UnRmoAnHv
	 lmTw84RDyG7YwvSH71Xzz7SQvf3fYkbxF5I+89Au66K7Y2h2uBbCgEA8606LnFYn7k
	 v8lk56JceaAYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199433930A1F;
	Wed, 10 Jun 2026 01:50:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: zero the whole vnet header in tun_put_user()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178105621163.2788910.10891803539978570037.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 01:50:11 +0000
References: <20260607054428.3050243-1-xmei5@asu.edu>
In-Reply-To: <20260607054428.3050243-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, bestswngs@gmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,lunn.ch,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-297399-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:netdev@vger.kernel.org,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:kuba@kernel.org,m:bestswngs@gmail.com,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 69826665594

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  6 Jun 2026 22:44:28 -0700 you wrote:
> tun_put_user() declares an on-stack struct virtio_net_hdr_v1_hash_tunnel
> without zeroing it. For a non-tunnel skb, virtio_net_hdr_tnl_from_skb()
> only initializes the first 10 bytes (sizeof(struct virtio_net_hdr)),
> leaving bytes 10..23 (num_buffers and the hash/tunnel fields) as stack
> garbage.
> 
> An unprivileged user can set the vnet header size to 24 with
> TUNSETVNETHDRSZ, so __tun_vnet_hdr_put() copies all 24 bytes of the
> partially-initialized struct to userspace, leaking 14 bytes of kernel
> stack on every read of a non-tunnel packet.
> 
> [...]

Here is the summary with links:
  - [net] tun: zero the whole vnet header in tun_put_user()
    https://git.kernel.org/netdev/net/c/7f2fcff15e99

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



