Return-Path: <netdev+bounces-299623-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Vw6wONVsMGqwSwUAu9opvQ
	(envelope-from <netdev+bounces-299623-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:21:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 897FB68A282
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:21:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=oynQtO5x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299623-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299623-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7F3233042984
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C643B5E15;
	Mon, 15 Jun 2026 21:20:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B573AE706;
	Mon, 15 Jun 2026 21:20:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781558445; cv=none; b=ax/yt2FscerHuP+J82hNjVuvEA+TkWHnWKTJ8zu4T/tC/ze03zev90nSSIFwJvK+/edUAKaMeKl/gxAg9u0xlVJ9fLcWtiv6IgP0o68U7eBJ1+YpPg0ssb1FmK3DnaBv7pLKmo/VDinE7P5d9BJbGau3gWaSWfV2QRHue+y1sqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781558445; c=relaxed/simple;
	bh=lwMiZA0PVhBjGIxlXjCZxvblaO57+GTOMoT0+3bOXYk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ba8pMkBTuyjixGossZ9/C0F7lacMHUr0FuokgyFeSFHj87TEb5EfXd9v/m63TV+fgMYJwCaXbl02mPin2sez/yZGCdsxLdn/FK8POKwRiKMzQqt/6AttC71f2hCwTkvrZH2oY2epLBRPw9S/FnUVJ7GIyjbn+2FqzxYEWDjuwvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oynQtO5x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10DA91F000E9;
	Mon, 15 Jun 2026 21:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781558444;
	bh=s4Qbe+W/lEvK6Mb1Mos7N4Qvk6t3oGI2t9y8rUkD/XA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=oynQtO5xh6fJq+YqFbWHP0xv0JbM2DWEBGyZ9ApAfObzRgmDsH2xBIeKQ2/+l/JEZ
	 QDzaGu2OthSeJoxg6bqaXS+Ps5t0kclI5sp9yk2GjAC/BFH5hJNzVjpMXA/l/gQe6/
	 E2oT9leJIVJeXOdmQE4JAE9eY4cvAcK/ro5VAwMUWQO0tt87M8jN9iUPCulKWy2K0M
	 jbbKtqfZ/hp1U7lfGchpL2iv0LbiVPwLxVhkm4NduG2l8vGbXWmaj+VONRgJxd1QJd
	 2ZARBdCloyA6HkHESJxDYHnN/og96hthXHSrlDYAd1y6xFVtGfBEfP2sNRWygSweZ4
	 KnqTo8+44MPRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568B33839A06;
	Mon, 15 Jun 2026 21:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] selftests/net/openvswitch: add SET action test
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178155843888.301119.8263394079175828047.git-patchwork-notify@kernel.org>
Date: Mon, 15 Jun 2026 21:20:38 +0000
References: <20260612130503.311240-1-houminxi@gmail.com>
In-Reply-To: <20260612130503.311240-1-houminxi@gmail.com>
To: Minxi Hou <houminxi@gmail.com>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 i.maximets@ovn.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 dev@openvswitch.org, linux-kselftest@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299623-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 897FB68A282

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 12 Jun 2026 21:05:03 +0800 you wrote:
> Add test_action_set exercising OVS_ACTION_ATTR_SET with an ipv4 dst
> rewrite. The test verifies the SET action in three steps: first
> confirm normal forwarding, then apply set(ipv4(dst=10.0.0.99)) to
> rewrite the destination to an address nobody owns and verify ping
> fails, then restore normal forwarding and verify connectivity
> recovers.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests/net/openvswitch: add SET action test
    https://git.kernel.org/netdev/net-next/c/3b165c2a29cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



