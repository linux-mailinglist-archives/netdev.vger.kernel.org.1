Return-Path: <netdev+bounces-298389-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wwmWM8k7K2rv4gMAu9opvQ
	(envelope-from <netdev+bounces-298389-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE3DD675B34
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 00:50:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="Q8R/Abv4";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298389-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-298389-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B62303001071
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 22:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3382397E88;
	Thu, 11 Jun 2026 22:50:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D1239184A;
	Thu, 11 Jun 2026 22:50:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781218233; cv=none; b=K8y2L3hcZWBFrZugjZBhVjX31X9xWPMO+o85gR7YV1cXiBxl8EyyKWrSmlTRtHCceTlGCRH7cHilv3GMjhbb2RDj0vy61jJuxBmV0V2quoU1M5lefcDZJ7K1zaG5Ip9Qmyehrzh3Q3xZ/xGwRqR3BitnZ3NOCZPxj91x1K0kvKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781218233; c=relaxed/simple;
	bh=f+ErjB1BCoNFOeWIQhMmrJki1qyBNN+DyiQaw9xnq5c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hAuwe1MiiyDzqEeQV9tnXKG1iDkf0l8KKqbhwA9mtoh9oY+01lWYwfRCbqHjRK0yrWeGIO4vX0O8gLrGhdyy6YjQPlBKJS/55SL8KeMKcibz8wmnhRpzOJUqpnvwzGg4oVb95vkwM5IHzPdko4/BwYPvc3rTcc2gt1YrWg1+olA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8R/Abv4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E58931F000E9;
	Thu, 11 Jun 2026 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781218231;
	bh=6alKEiUqCFAQiqP9Ey+Is89Wv4YKAIaVTHGpCe8xIrs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Q8R/Abv4rBXULfMkXAdCZzABJQnACMzdPm+hNmQCDRmebocKMniO6kuFtEuI3t6yA
	 wL2zP+5S/Xuro8JzMeiPwX+NumMjkSVXKxLoyIFX++xcRWcbMh0cdeFcEGGXgwIlfo
	 /qvonVhVlAcClJBZZNkTnnqa3T/jTSHnfq4p+tOKLjaKM29eL+mkrbmMbMSCeerhvZ
	 zcO0ab/DpiC+fGCMM+I9JmMiOSCxzemZnDbZoSfp/isdsmukENlaH6zaJKtYgwJR8L
	 YLupuADgVFxPozzMZaTAgiUL4U3Rcfcg3DnAPwxoY4+PWTUhh7b9GWE80ew4h0N8H+
	 D9BkI+ucxoKkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569873930FB3;
	Thu, 11 Jun 2026 22:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/15] mptcp: pm: drop TCP TS with ADD_ADDRv6
 +
 port
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121822814.394849.2368301778556817000.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:50:28 +0000
References: 
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
In-Reply-To: 
 <20260605-net-next-mptcp-add-addr6-port-ts-v2-0-758e7ca73f4d@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 corbet@lwn.net, skhan@linuxfoundation.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, ncardwell@google.com, kuniyu@google.com,
 shuah@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-298389-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:matttbe@kernel.org,m:martineau@kernel.org,m:geliang@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:mptcp@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:corbet@lwn.net,m:skhan@linuxfoundation.org,m:linux-doc@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:ncardwell@google.com,m:kuniyu@google.com,m:shuah@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE3DD675B34

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 05 Jun 2026 19:21:44 +1000 you wrote:
> Up to this series, it was possible to add a "signal" MPTCP endpoint with
> an IPv6 address and a port, or to directly request to send an ADD_ADDR
> with a v6 address and a port, but the expected ADD_ADDR wasn't sent when
> TCP timestamps was used for the connection.
> 
> In fact, such signalling option cannot be sent when TCP timestamps is
> used due to a lack of option space: the limit is at 40 bytes, and, with
> padding, TCP timestamps is taking 12 bytes, while an ADD_ADDR IPv6 +
> port is taking 30 bytes. The selected solution here is to simply drop
> the TCP timestamps option when such ADD_ADDR of 30 bytes needs to be
> sent.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/15] mptcp: options: suboptions sizes can be negative
    https://git.kernel.org/netdev/net-next/c/f4a58ffbd4cf
  - [net-next,v2,02/15] mptcp: pm: avoid computing rm_addr size twice
    https://git.kernel.org/netdev/net-next/c/a8bffec089d5
  - [net-next,v2,03/15] mptcp: pm: avoid computing add_addr size twice
    https://git.kernel.org/netdev/net-next/c/06c62385be85
  - [net-next,v2,04/15] mptcp: introduce add_addr_v6_port_drop_ts sysctl knob
    https://git.kernel.org/netdev/net-next/c/30ff28fdc4da
  - [net-next,v2,05/15] tcp: allow mptcp to drop TS for some packets
    https://git.kernel.org/netdev/net-next/c/1c3e7e043977
  - [net-next,v2,06/15] mptcp: pm: drop TCP TS with ADD_ADDRv6 + port
    https://git.kernel.org/netdev/net-next/c/23eeaad0d89d
  - [net-next,v2,07/15] selftests: mptcp: validate ADD_ADDRv6 + TS + port
    https://git.kernel.org/netdev/net-next/c/dd7fb53c21c3
  - [net-next,v2,08/15] selftests: mptcp: always check sent/dropped ADD_ADDRs
    https://git.kernel.org/netdev/net-next/c/5558517b0001
  - [net-next,v2,09/15] mptcp: pm: use for_each_subflow helper
    https://git.kernel.org/netdev/net-next/c/f81689172429
  - [net-next,v2,10/15] mptcp: pm: rename add_entry structure to add_addr
    https://git.kernel.org/netdev/net-next/c/350d76dd6e79
  - [net-next,v2,11/15] mptcp: pm: uniform announced addresses helpers
    https://git.kernel.org/netdev/net-next/c/7d4dacc8ccca
  - [net-next,v2,12/15] mptcp: pm: remove add_ prefix from timer
    https://git.kernel.org/netdev/net-next/c/938490767e37
  - [net-next,v2,13/15] mptcp: pm: make mptcp_pm_add_addr_send_ack static
    https://git.kernel.org/netdev/net-next/c/d0f866e64897
  - [net-next,v2,14/15] mptcp: pm: avoid using del_timer directly
    https://git.kernel.org/netdev/net-next/c/6ea199a938da
  - [net-next,v2,15/15] mptcp: options: rst: drop unused skb parameter
    https://git.kernel.org/netdev/net-next/c/6545a8c34703

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



