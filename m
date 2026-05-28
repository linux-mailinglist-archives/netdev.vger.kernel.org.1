Return-Path: <netdev+bounces-292864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFl5NH+9GGoumwgAu9opvQ
	(envelope-from <netdev+bounces-292864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:11:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3ED5FACFF
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 00:11:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04887304EFE2
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427035E1CB;
	Thu, 28 May 2026 22:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VXX5xbKA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604036921B;
	Thu, 28 May 2026 22:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780006255; cv=none; b=R1NAaQRyhClTkVqdeyC7Uzx5qT6MdgvE3W5WNKQyjVVZyEjbEXngOb6gJrPFuy2uVIRwze+R97yF4cT1pYpCln+qQOzHLza6Nbt5PAk8tbSj6lVc9etP6CA23w0As9lSGbv3LYdl08HIYau2TVUMe+yD7KK3RtdFx1u8X/zwYBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780006255; c=relaxed/simple;
	bh=MJauyLPrVOjMmdZZN3XBhbIELzrdJUSo7zqyIvmbsJI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bl7/b/2VCL0gow08uT1pONkZgyYFv7fSehUwIPN7FGu2QCWvVcp+HySRilUrWhnexYuS3KZiHPFrZJbg5VLJoGeeic4FgxPT6ywH5E/Dwp1MDgMMmtYAK0qDY7kDaSMyRgJhpAspuh0hBzskOcgOwDQQcIjMweXaZRRXf0DFd68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VXX5xbKA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A69F1F000E9;
	Thu, 28 May 2026 22:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780006253;
	bh=MihBZLmSF5hf5EffR//CvVrqExmU2M8+W8fSnVreuok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VXX5xbKA4r1zdkmqIxdJtFVukUE90VmHw0fekU2gVd1+ejfe9g6Dh7hGr+LUmyehY
	 dSSkEnumE3QcVg0jn4lLGq615aVBcidIYrtxaDIymiFdm5iSIt20Y0vEqo7E/0q1pu
	 rwWgEve2ZL9SXpaeJeeRAZca4Fdwbknsfu6d4C0KvhBiuapT35rtFqDMCaxeSYQ+QY
	 peJCAO3XkGWH1sKpI589G+k3NqQFl1eUyPNJPnHbHE3XOftAZw5SLUGo73vAT6Lcv3
	 M9Zji6Pd+F8upcQB8FUwksPSY2SODoZP1HXqPRN7EVi5IDtdCYMhapF4oVgdeq6liM
	 9oK7e81lvxD0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AC73811977;
	Thu, 28 May 2026 22:10:58 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net] Revert "vsock/virtio: fix skb overhead
 overflow on
 32-bit builds"
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178000625714.1533055.10719008699075181524.git-patchwork-notify@kernel.org>
Date: Thu, 28 May 2026 22:10:57 +0000
References: <20260527171046.130211-1-sgarzare@redhat.com>
In-Reply-To: <20260527171046.130211-1-sgarzare@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, eperezma@redhat.com,
 virtualization@lists.linux.dev, kuba@kernel.org,
 linux-kernel@vger.kernel.org, xuanzhuo@linux.alibaba.com, mst@redhat.com,
 kvm@vger.kernel.org, pabeni@redhat.com, jasowang@redhat.com,
 horms@kernel.org, stefanha@redhat.com, edumazet@google.com,
 david.laight.linux@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292864-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,redhat.com,lists.linux.dev,kernel.org,linux.alibaba.com,google.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A3ED5FACFF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 19:10:46 +0200 you wrote:
> From: Stefano Garzarella <sgarzare@redhat.com>
> 
> This reverts commit 4157501b9a8f ("vsock/virtio: fix skb overhead
> overflow on 32-bit builds"). The fix was semantically correct (although
> it would have been better to use mul_u32_u32(), as David pointed out),
> but in practice we are estimating the memory used to allocate the SKBs,
> and this will never cause a 32-bit variable to overflow on a 32-bit
> system, since the memory would have run out long before that. On 64-bit,
> SKB_TRUESIZE() already evaluates to size_t, so the multiplication is
> already in 64-bit arithmetic without the cast.
> 
> [...]

Here is the summary with links:
  - [RESEND,net] Revert "vsock/virtio: fix skb overhead overflow on 32-bit builds"
    https://git.kernel.org/netdev/net-next/c/e03f0b53b4bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



