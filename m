Return-Path: <netdev+bounces-299124-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zPAGGCAHLmqTogQAu9opvQ
	(envelope-from <netdev+bounces-299124-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:42:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B981E680329
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 03:42:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=YwzQuPww;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299124-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299124-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D231D300B994
	for <lists+netdev@lfdr.de>; Sun, 14 Jun 2026 01:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE3928488F;
	Sun, 14 Jun 2026 01:42:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1811027A10F;
	Sun, 14 Jun 2026 01:42:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781401373; cv=none; b=pTgtHbhe8i5qwW3lVCpEZeBllgXr04xfl9Ok+lzduj7BgIcAlCNa4uEi0gCV/d5ecpibvmqUpT0cGfmgnQGMP3MLoxsps3bNCY25Fx/cwKdj140Acdd9VF0R9m2Mex4zoqgbAzKRlyn7nxHaYYrvJVYNcd57P0kmSiP95bKcz0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781401373; c=relaxed/simple;
	bh=+zbonxntW7gOxdvCvz5t5GNwgu5cXBkbgMpjj9QYbR8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQqEfBqw2nBpXbdRcyuilsFfR+p3e0lkBHMiC8eg3i8t62s3VLdUdUiEPkpjTXPEZ3SaHJKNl3ME1bq/30VQoUKXH91MvTduLF9rgSDayFbHfJOgwuTWzmJUq6hhh1zL8bcgxHWCtg03XDjMEY/deB7uqvdSy8mAxXSYzKBCIq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YwzQuPww; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3233E1F000E9;
	Sun, 14 Jun 2026 01:42:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781401372;
	bh=YwnpKG75ZQSzgDSaXDWamF0T3FAa+ZfyciFDx/SlIYQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YwzQuPwwRvvKxNfXyUNBqv2Pw220WImSIVNsq5XqQQGLhSSbX7DBwpK6xaRfURV5Y
	 ivR0pHmAYCQ2amux7Bez+LMwOwPsDChXTXoqegn6G2+4bL0gqDbiIW1/gkPSDqvp1K
	 Syb7lMSbkbgWCDxEusBqDBONxwnBEdDxxNO3/2x8ZkAdyXvpHQT2SnOeiCdZJ06cua
	 bizckoBeHqaAz3eVGFSMQJ03HZxq9tKklhIXtJXlFyImGePuN8ADZjUCnQznLDFlu8
	 ELM2js4Ic59KL8Q6g/WThq+BQ5ZK6opXUhCUANQ800FjtVfJnI8J4JuQ+c/r3wUYwV
	 L+EE64WXbjOqw==
Date: Sat, 13 Jun 2026 18:42:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laika Price via B4 Relay <devnull+laikabcprice.gmail.com@kernel.org>
Cc: laikabcprice@gmail.com, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v3] ip_tunnel: drop stale dst from generated PMTU
 ICMP replies
Message-ID: <20260613184251.7c5a18ef@kernel.org>
In-Reply-To: <20260614-master-v3-1-9f5060ba1ed1@gmail.com>
References: <20260614-master-v3-1-9f5060ba1ed1@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-299124-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:devnull+laikabcprice.gmail.com@kernel.org,m:laikabcprice@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:devnull@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,laikabcprice.gmail.com];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B981E680329

On Sun, 14 Jun 2026 00:13:57 +0100 Laika Price via B4 Relay wrote:
> Changes in v3:
> - Squashed the selftest update into the ip_tunnel fix so the patch remains
>   bisectable.
> - Link to v2: https://patch.msgid.link/20260613-master-v2-0-061b70fd45dd@gmail.com
> 
> Changes in v2:
> - Fixed incorrect PMTU exception generation in the selftest.
> - Link to v1: https://patch.msgid.link/20260613-master-v1-1-df796e8e2d74@gmail.com

It's still failing the tests.
Please do not repost it again until someone guides you towards 
a correct fix.

