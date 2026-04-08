Return-Path: <netdev+bounces-276262-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VIuaKODL1Wl9+AcAu9opvQ
	(envelope-from <netdev+bounces-276262-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:30:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C943B695C
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D186B3020FD7
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 03:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B6342CB0;
	Wed,  8 Apr 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eVpThKVR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C664E34252C;
	Wed,  8 Apr 2026 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775619032; cv=none; b=l8dxUbHTSp/uPgMT75et4ARDwfTrvvZaB0KA1/vr9NUu4wIsgC6S8o9GJ3X03p2frs2FociXssWgRNqGc1vtutCeydP57aGjUV2dcJ0qHHjPktir5ZoWFQeMRVqO/5/Q3J+4O2eGIE5B+LPLsh7VN8/auV1udynn6LNNJCYxbhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775619032; c=relaxed/simple;
	bh=bPyXy4rJirF5xfF9/xYSxpI0Q/3vLeBBffEb348O8fg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G38oAsbwSdRGg95WCKDDuuBJEiaoM9IX9o5tHi6mfwN8iKqSXSxKqTumQjv4XsgEIKu7PO5uI0FgpMLLCKGnG7ltZdYOzvwOd3SeJAlNg5Fe0WQEYmEKPOvtds37XS3qDrBDf2Yhv2oTr2csSvKpBAsxsdKvzhgEhIMh8TSpxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eVpThKVR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56933C116C6;
	Wed,  8 Apr 2026 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775619032;
	bh=bPyXy4rJirF5xfF9/xYSxpI0Q/3vLeBBffEb348O8fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eVpThKVRcybpsD7ptGGeaonsaCTnfc3P2x17oIeGUxJD1TObdHzcY2pHOGEHUpeFS
	 DPRkvBfOKbG7jnNwrx5SAepZPifYxK5Kp34EXSDGsEY9EDMoFrQfzzKz19hw17UjQ1
	 uTjj0d9n89v1obAqSV3e/JptbbZlQw2VPJHw8dOh318fZCRnq2v4tgxW+LFpYZOnFr
	 GXVPXLxt2/NA9bG35Txh/9ZNyCd3WCINiRTf61cXG60IUM8C99qEcD7wuqDtRSLrCd
	 FNAhUMZXG66PyCOodSNHA//0WZP+1S/nfPDprXJH8HudcLyNgoZz89lhlIGDwP/+Om
	 J+2M9aloQ5k3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EFD3809A29;
	Wed,  8 Apr 2026 03:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] seg6: fix dst_cache sharing in seg6 lwtunnel
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177561900954.56280.12053503868401686.git-patchwork-notify@kernel.org>
Date: Wed, 08 Apr 2026 03:30:09 +0000
References: <20260404004405.4057-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260404004405.4057-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 david.lebrun@uclouvain.be, stefano.salsano@uniroma2.it,
 paolo.lungaroni@uniroma2.it, nicolas.dichtel@6wind.com,
 justin.iurman@gmail.com, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,uclouvain.be,uniroma2.it,6wind.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276262-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 31C943B695C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  4 Apr 2026 02:44:03 +0200 you wrote:
> The seg6 lwtunnel encap uses a single per-route dst_cache shared
> between seg6_input_core() and seg6_output_core(). These two paths
> can perform the post-encap SID lookup in different routing contexts
> (e.g., ip rules matching on the ingress interface, or VRF table
> separation). Whichever path runs first populates the cache, and the
> other reuses it blindly, bypassing its own lookup.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] seg6: separate dst_cache for input and output paths in seg6 lwtunnel
    https://git.kernel.org/netdev/net/c/c3812651b522
  - [net,v3,2/2] selftests: seg6: add test for dst_cache isolation in seg6 lwtunnel
    https://git.kernel.org/netdev/net/c/32dfd742f06a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



