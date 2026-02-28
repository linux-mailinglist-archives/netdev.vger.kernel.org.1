Return-Path: <netdev+bounces-262051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEUDH5lVomng1wQAu9opvQ
	(envelope-from <netdev+bounces-262051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F221C0009
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9600030BEE58
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888C0334C19;
	Sat, 28 Feb 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b3qovycS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66702334C04
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 02:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772246408; cv=none; b=P71TegEKQsOif4kWer89Rd8ijlTjWCpPUjrglOKfSoPyFHgJ85jY/yzDOmhAJBaWLkxAe2g+83dNo36r2wZXkX9fmL/zNZyxTy9+q2HMmdBGjhmQHike1xG68vAyG4Z7yi5kjCtYAo4B9zblv2sAQf/SkOh5Jj+91XfpvuF+4+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772246408; c=relaxed/simple;
	bh=Fol3u6dX2sgAk8ss/CyAkFLiaQ5kpbNrWMbmINgMais=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GeGUnJ0pxvrVp87jHCliRkxtpPC4Qex6MGpgA0/fQKiO12q3X/T0dDn/tJh4p4Sy1RU9bF5A9ZGPaY4K1QNaHlQhSa7in+yds1dBXYAOLs4/LX7phaEK2yM4foh2AlOTgDF7f1FJcOY8MkRLfZ2D09Ew4d7JRajejqClfP7It+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b3qovycS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09C6BC116C6;
	Sat, 28 Feb 2026 02:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772246408;
	bh=Fol3u6dX2sgAk8ss/CyAkFLiaQ5kpbNrWMbmINgMais=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b3qovycSl6L2W9xTtOz8JX0sY0vm0AHGOuUkl72Cp+S3UQPTerzodIQplAi7gCqS3
	 NXaMXYwHZDzSMjrTVKPWaS3c9Kg/kn3t8RFbwgftU18HbIjhRMBz65V42iAvdyvUcZ
	 p9pFnXBrikIbjROCu8BbqIYvwbWxieGgvBL+0KdOZ8fjW1XNQQgwUTKuX7vFreVapm
	 aBBIiNHYwWdQmwz0WyGVyL6p4hQT9OWhxB3vqOCFiOHFoqcHniGuHxD67uJeanAamy
	 JWa+8+oADE2Vp3kJzhVoJc5GDyagW3uNkfB1t4l5ZKL5HXiKdsUs0uHKOce01jQj8i
	 JprcRx2Xj20Bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E7239EF96C;
	Sat, 28 Feb 2026 02:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] selftests: netfilter: nft_queue.sh: avoid flakes
 on
 debug kernels
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224641129.2844958.9691755306378670690.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 02:40:11 +0000
References: <20260226161920.1205-1-fw@strlen.de>
In-Reply-To: <20260226161920.1205-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262051-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_TRACE(0.00)[kernel.org:+];
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
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D6F221C0009
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 17:19:17 +0100 you wrote:
> Jakub reports test flakes on debug kernels:
>  FAIL: test_udp_gro_ct: Expected software segmentation to occur, had 23 and 17
> 
> This test assumes that the kernels nfnetlink_queue module sees N GSO
> packets, segments them into M skbs and queues them to userspace for reinjection.
> 
> Hence, if M >= N, no segmentation occured.
> 
> [...]

Here is the summary with links:
  - [v2,net] selftests: netfilter: nft_queue.sh: avoid flakes on debug kernels
    https://git.kernel.org/netdev/net/c/ba14798653bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



