Return-Path: <netdev+bounces-295323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ojUxDfWjIWrkKQEAu9opvQ
	(envelope-from <netdev+bounces-295323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:12:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 913B7641B91
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:12:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=M+gtkEoE;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295323-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295323-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 684973111245
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7AC47DFBA;
	Thu,  4 Jun 2026 16:00:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB1147DD43
	for <netdev@vger.kernel.org>; Thu,  4 Jun 2026 16:00:32 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588834; cv=none; b=Pi3lV32Jnc20eYYWs/fLbWRB8PY22X6HUpAaQ0idiDrGusCVIHR0LxrsAg4qpAG+dajKjKO7oEGzFKjcvxfUQhR1R6IGknN1gi2eibcwjcVOQeGk0KWZPiFTLxScHxBPzJbwXveg02tLA5ZPTEaFziWwMLIDqFfpmGZcDKjND6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588834; c=relaxed/simple;
	bh=wCkiQAQJ6rrQr/Z6yXOVjzEEYXXHQ6GjH0bop9Pr3t8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HMli/uDRd4FL4uwMFWc5UYANgQjlGJhde7scCe76PmmCEcOi0LXevtL5DytWh0OnZRhJ83ggeC7LwcWkDDrYqqvihsuA3Dfx/MvG3s2M256E66+fdFt/Kw5+1DrAxTSB0pDASksjFH4f1wtIR09Vx2sYysiBwy6a+l0CcuqjWhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+gtkEoE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B150D1F00893;
	Thu,  4 Jun 2026 16:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588832;
	bh=oW9BIIfI7h9EY4mMvo5p18p7xLlPJL0to/w17zllvlE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=M+gtkEoEmYDysqa6mef7NcPwmWByxu0QRpH+ErS8KvVXLUt15I+sz4jmkGNxnE59a
	 wRIVRs5gKTUdSnaT68B3kuziJnNQ4kH+7mLPEr9/U3r0dEx1D7aRmR2WBPK0EEK9op
	 sdxqDQl08DR7hDJB41Zeqr3VGobziPfNzbrNQfH7aCQsgjrNsED4cyuREedXIdrzMm
	 KFindd5p5CT/QfPL75Ee25F6hblKQyuGvKLSmdWxc2qCwHQvzbRgo0s6JCGiTCFsZb
	 yZLnrzD84fPEvo5yKhK21ztq3LcO4yYE6jlGU3U7Zsita43vneVAtexVH8aUF7on5g
	 76+4CTkxu0Bwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D097A39309B7;
	Thu,  4 Jun 2026 16:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: mcast: Fix use-after-free when processing MLD
 queries
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058883339.2493857.18186544322454995670.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:33 +0000
References: <20260603101811.612594-1-idosch@nvidia.com>
In-Reply-To: <20260603101811.612594-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, horms@kernel.org, dsahern@kernel.org,
 leo@depthfirst.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-295323-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:idosch@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:edumazet@google.com,m:horms@kernel.org,m:dsahern@kernel.org,m:leo@depthfirst.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 913B7641B91

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 13:18:11 +0300 you wrote:
> When processing an MLD query, a pointer to the multicast group address
> is retrieved when initially parsing the packet. This pointer is later
> dereferenced without being reloaded despite the fact that the skb header
> might have been reallocated following the pskb_may_pull() calls, leading
> to a use-after-free [1].
> 
> Fix by copying the multicast group address when the packet is initially
> parsed.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: mcast: Fix use-after-free when processing MLD queries
    https://git.kernel.org/netdev/net/c/791c91dc7a9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



