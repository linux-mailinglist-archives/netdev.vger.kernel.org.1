Return-Path: <netdev+bounces-292484-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id HrFiK66KF2rtIggAu9opvQ
	(envelope-from <netdev+bounces-292484-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:22:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 003BD5EB361
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36639301AD1D
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FC458635D;
	Thu, 28 May 2026 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSaD0WMo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873BF39FCE
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 00:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779927721; cv=none; b=fPv2VA5XAslZMlAHu4aV16h7ADp6gZ9dZaRD3MvpSIbKuULXz6fty27k/0iR15P5CDvIbC0b2kWD5hIFpZl3/PSBfoncBYUYV70c0ZvRvwUDEeQqbGp0YWzGUbZqHIK+fuJMlCKmePyyYYUTQiA1g/lDT2wH2cOg99Xp3VA4x4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779927721; c=relaxed/simple;
	bh=iQwH2KNj5yM0xRv9YI1TPczppswPYdw0kqEd5hU4vNw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhgQYteENyuwQBFFdczW3uxdQfjVMaG6WTEbCrslxDQ8iDpepPDyPz7P9LzLxcrCxtYElTVAr3T9Mkdm6iF9E0J4H8nQshKTfChsc3olwaym8gp724ZpRBUyjyASeK++PX8X/g3cLfFTzFdDXaLhndkWWepRs9IgiPQikXzPRTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSaD0WMo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9F701F000E9;
	Thu, 28 May 2026 00:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779927720;
	bh=KEO80zV9s+4z3Or/QLoI2yIzi0UsikLeDkZdq8fPySw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MSaD0WMomYF4hFkrY3aewJoGXrLqhMEpdYaBT/WcEIyaaKdTfSYdDtD4bxZ0YDwtl
	 8RyNgu3ytioWzhkx32s4gT2+DOXok7GUpU9ZCmThxSTKTL2wg8qYc4mW37w7WgkeIZ
	 v40S+tlZVjXr9+zgp2BCxeTRKU5XxmkZUucxI04iXVjZccgZqXAlBAiKJ708aHX8TQ
	 p2p8qAKG9ihTZfwgrYsjI1aoh3pFQHdu1+wmsnh2hNjJMtdX5B8NiItMHKu0XNbgzz
	 cYbZeU9aCJhPU+UbssVLsxwbXrypYVEeJsXkwHzSpEn0hfsKxieVQI5/JLVbUKLZIS
	 EO4u4/bbfdjZA==
Date: Wed, 27 May 2026 17:21:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>,
 Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 5/5] geneve: Introduce IFLA_GENEVE_LOCAL and
 IFLA_GENEVE_LOCAL6.
Message-ID: <20260527172159.1dfcd042@kernel.org>
In-Reply-To: <20260526015152.2409183-6-kuniyu@google.com>
References: <20260526015152.2409183-1-kuniyu@google.com>
	<20260526015152.2409183-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,networkplumber.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292484-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 003BD5EB361
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 01:51:17 +0000 Kuniyuki Iwashima wrote:
> -	if (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) {
> +	if ((data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_REMOTE6]) ||
> +	    (data[IFLA_GENEVE_LOCAL] && data[IFLA_GENEVE_LOCAL6]) ||
> +	    (data[IFLA_GENEVE_REMOTE] && data[IFLA_GENEVE_LOCAL6]) ||
> +	    (data[IFLA_GENEVE_REMOTE6] && data[IFLA_GENEVE_LOCAL])) {

nit: Looks like a cartesian product, perhaps:

	if ((data[IFLA_GENEVE_LOCAL] || data[IFLA_GENEVE_REMOTE]) &&
	    (data[IFLA_GENEVE_LOCAL6] || data[IFLA_GENEVE_REMOTE6]))

? at the very least would be good if the last line also had v4 one the
left.

But, more importantly - I think the AI reviewers are right,
please update Documentation/netlink/specs/rt-link.yaml to add these 
new attrs

If you can think of something meaningful / useful in surfacing
potential bugs maybe also a selftest?
-- 
pw-bot: cr

