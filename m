Return-Path: <netdev+bounces-254985-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBwlMjsbfGlgKgIAu9opvQ
	(envelope-from <netdev+bounces-254985-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:45:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 039C3B688F
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 03:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5EDE7300CE61
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 02:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A721B9C0;
	Fri, 30 Jan 2026 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+6amwCG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75611EE00A;
	Fri, 30 Jan 2026 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769741112; cv=none; b=tH0aPiLP1uIK0H4k467rpGiFc/pz1v93dEC5sgKUPyajdmyTe/v6ZQURQO3jThipsCEmik3TWIi7imDbbIn7qk0jDnL5yOuFvUPQQCUblfAdZFFkCBN6/xnHDLrqbXeWrrTEXomotwEiWA2ihyY4Q+OXe5Y7HF4b9tODClwxdQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769741112; c=relaxed/simple;
	bh=lvkR3AupMYkS1MRau1KxFU5qWBxB8Ry8+swDaQ63BOU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sEQIdSRYnRAP5or3dZdwum3zY2mEcn4dwU7QfuP6owDV4iyrxd5A/+gXKVCBC0CZvgFi/94yP3Ttr1iKjGU+sZr+blcbV2WxeCzEFCn8l1C4R2n27Jo0LJdLB4dXL0eEiu8TS7h4yJjtMfa8r8moIlB/+hKV5I7s45dbq8038eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+6amwCG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C8CC4CEF7;
	Fri, 30 Jan 2026 02:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769741112;
	bh=lvkR3AupMYkS1MRau1KxFU5qWBxB8Ry8+swDaQ63BOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=q+6amwCGq71Y1MzRhzQ5d3bFQrqqGYalYPxSLtPnmOvndLFEMKqsE/hs6zaM4WSq/
	 5K+/KwvNAqSI97ZMCuVUSBqoiDKKndUD+TweSo0lYlHW1MQ7tjhtIqhkdtIxfqgi3N
	 oeKb3P9JNeScW4X9+e42QLiwjABxH6VI0PBB+ZWAu9X/hCS+SFyXhRejTiD6Sc55YG
	 2E8LCZKn2SNRvLJTdxINYoZcYzUw0MwwqTMXyuMQ3dv6wl0akndPtynKClwy7EHGd+
	 06Rask6NRGEpLVLEosIrD4aFmWxyJ0GYrb7uR4N/AtRfHoXZe0Mn3WVJh3V6I9kC4P
	 As5rh7ZguGs/Q==
Date: Thu, 29 Jan 2026 18:45:10 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Antony Antony <antony.antony@secunet.com>
Cc: Steffen Klassert <steffen.klassert@secunet.com>,
 <netdev@vger.kernel.org>, "David S . Miller" <davem@davemloft.net>, David
 Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Herbert Xu <herbert@gondor.apana.org.au>, Shuah Khan
 <shuah@kernel.org>, <devel@linux-ipsec.org>, Tobias Brunner
 <tobias@strongswan.org>, Simon Horman <horms@kernel.org>,
 <stable+noautosel@kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v4 1/2] icmp: fix ICMP error source address
 when xfrm policy matches
Message-ID: <20260129184510.01319683@kernel.org>
In-Reply-To: <f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
References: <cover.1769595011.git.antony.antony@secunet.com>
	<f820e0e9f80b1467f97d1408f00f61b1fdb1b986.1769595011.git.antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-254985-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,noautosel];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 039C3B688F
X-Rspamd-Action: no action

On Wed, 28 Jan 2026 11:25:14 +0100 Antony Antony wrote:
> Subject: [PATCH net-next v4 1/2] icmp: fix ICMP error source address when xfrm policy matches

> Fixes: 415b3334a21a ("icmp: Fix regression in nexthop resolution during replies.")
> Cc: stable+noautosel@kernel.org # Avoid false positives in tests

I don't understand what you're trying to express with all these tags.
We are sending incorrect ICMP packets, seems like a normal net-worthy
fix to me?

