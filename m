Return-Path: <netdev+bounces-280853-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMrFDCdw6mmizQIAu9opvQ
	(envelope-from <netdev+bounces-280853-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:16:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F09F4569DF
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 21:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 044B230EFD8A
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 19:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895DF392825;
	Thu, 23 Apr 2026 19:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CR+iN9Be"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DF43921D6
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 19:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776971465; cv=none; b=XkPW8ekP6+6VQxmhT2gNu4O2I9mc12pEOQkQjJyo21aTOxRiAC8aZpWBDMuwRPg3PIj3LUIymqF9HsreJgf0NvqWD0LYh+2eWIfqwoPzBji8QXBHn++zcyZVR+iv09qV/KwAVdLh+IuH5yMuQuaYzTKwOyWkAmiRdfI+SI1RoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776971465; c=relaxed/simple;
	bh=2oYTam+TvKU8usSnPif7Ai6TcChKLdyfmehTlynXauk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F/EKuxtcqiP4EDN4ujum/+qOa/MlC1q5uFV/KDZRXXWS9Tv4ddxKSmeXODgXD44lCtm+9ys+xmwBpoQLQcv5dKTvlPblktHdl95WdsgZIP0zEhI3EIBVCa0Tc/1w7TlIUMDlQYBOu0V+hcdwEbw3F830elfZA85uXvwSlLbb2FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CR+iN9Be; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE11FC2BCAF;
	Thu, 23 Apr 2026 19:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776971463;
	bh=2oYTam+TvKU8usSnPif7Ai6TcChKLdyfmehTlynXauk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CR+iN9BetYl3Df982q3Ebb9SNvy2AWAxKKDJnku5v1FAGF4llPMglMd15H6EPEXUS
	 esttCBBZcnU5KrNpFqYxX6oxk9F6DLj4B/5XyOxd7iOd3cJ04qEoE2TTgUka34aZe3
	 jn7kiTcP/qp3ZpTZBqGS26rom5d+f0PwHhKoT6Wnz77KQcSkMlDjhhUidMmhYrWYOb
	 0DfHWkTtMDrjaeCXd6xcn0AgZ/Y3hfUo+Ds1VH8shigyB2IASvATdsvihDtVF0JE/s
	 6Aoi2h2aszi5pbZeeriKU/42juxucFzz/F6OC7sJt6wTjuUtAgvoSCrA8X+l1qM/Mc
	 7CUm73pLQBP+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD403809A90;
	Thu, 23 Apr 2026 19:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv6: Cap TLV scan in ip6_tnl_parse_tlv_enc_lim
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177697142429.724716.15260457369863148640.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 19:10:24 +0000
References: <20260421202406.717885-1-daniel@iogearbox.net>
In-Reply-To: <20260421202406.717885-1-daniel@iogearbox.net>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: kuba@kernel.org, edumazet@google.com, dsahern@kernel.org,
 tom@herbertland.com, willemdebruijn.kernel@gmail.com, idosch@nvidia.com,
 justin.iurman@gmail.com, pabeni@redhat.com, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,herbertland.com,gmail.com,nvidia.com,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280853-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8F09F4569DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 22:24:06 +0200 you wrote:
> Commit 47d3d7ac656a ("ipv6: Implement limits on Hop-by-Hop and
> Destination options") added net.ipv6.max_{hbh,dst}_opts_{cnt,len}
> and applied them in ip6_parse_tlv(), the generic TLV walker
> invoked from ipv6_destopt_rcv() and ipv6_parse_hopopts().
> 
> ip6_tnl_parse_tlv_enc_lim() does not go through ip6_parse_tlv();
> it has its own hand-rolled TLV scanner inside its NEXTHDR_DEST
> branch which looks for IPV6_TLV_TNL_ENCAP_LIMIT. That inner
> loop is bounded only by optlen, which can be up to 2048 bytes.
> Stuffing the Destination Options header with 2046 Pad1 (type=0)
> entries advances the scanner a single byte at a time, yielding
> ~2000 TLV iterations per extension header.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: Cap TLV scan in ip6_tnl_parse_tlv_enc_lim
    https://git.kernel.org/netdev/net/c/076b8cad77aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



