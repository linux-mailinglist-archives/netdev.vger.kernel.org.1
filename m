Return-Path: <netdev+bounces-263100-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mEsRFXiupmn9SgAAu9opvQ
	(envelope-from <netdev+bounces-263100-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:48:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4C1EC15D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 10:48:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 207623044BBE
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 09:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1017838C407;
	Tue,  3 Mar 2026 09:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SdWD26Aa"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2ED38C2D7
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 09:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530993; cv=none; b=MIyLfjcJU60JvpIsbuIR5WgxkEajTQEW4t9b7oDhsza7Es8W56a3PCkSlJr08sgJF0R7JggmppNefDvTYFDz7ASfhDHqXfMkLuaf08xkowwArLJMfGe99mNaKZih7jAJqs7t3TG0UA+kwvvSgVlMYS4a2FXS/XZylX9gBwE2HIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530993; c=relaxed/simple;
	bh=+Ls+70EODi+1G0THgyYCXhR2Z7n4Ltp2CPCQLxSWUTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jiRNiRBJM5XkYcMFGDe+OCFnf6iN43Q6WJ9e+oE7w2AsQ/MkxWvkIdwWKfPklrsAJwjtHsG34Xs7TD/JVnGVW0r40YTP6IqHS+2ZWS21wOoxWyaXJaXcmnz/fQAFPuiFe7arQ8Iuy2rFHV6SDCC00Geyqz8Rm5RNZYRWRO16BcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SdWD26Aa; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ab39b111b9so26134265ad.1
        for <netdev@vger.kernel.org>; Tue, 03 Mar 2026 01:43:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772530991; x=1773135791; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fAG/yCp5zU1Q+E1ywZBao8oWa/l/DBt64PVYUKwkwbw=;
        b=SdWD26Aajp7HNW76ZK5EJyo8tMF2PzNHFuSSRX64k/gAWuwxWZlbIXfPGkqmsxCcp2
         gVpJ38327yY8ngVwDYlhxQQFe4yv8BlnsleAxkY7psKRsNYb1z52ybBr/GCM/cYgCldR
         6LwabdaQngf912hjg+q2InXAuqKGlrM4ZqvrZm3RL4cejxXhFy9mO6tZhMAyGapzWtjM
         HP+P9JlryR8Dg2aMvYvZRzdy+iuOgml4sGRt4TRwA/GBWCLJtHIEseyg86q8jdTcWIs4
         fwANlHpEje9AaaTQXFaFFHVUJvYaEecH+zZy2Nt87I6NQ4se0ElPHlffh9Lkjq+4Bp2o
         LHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772530991; x=1773135791;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fAG/yCp5zU1Q+E1ywZBao8oWa/l/DBt64PVYUKwkwbw=;
        b=PQJfnKEW3fDewoekL+k4HKfYUWtWdlqVymNkvdB25eIDD4vLvNXPCJmL4aGSme8rTU
         JZjmkZ5gYjm17BLdDSoZHv3E3LkNiyyHuyWlBrL5ttWcoGrglTWCeXOn8iGYvZq6MWeQ
         bDgphlq+F+q/mqQR422Fe3eBKSjJOomrgL4SlrvyHIZcNVSp9bl8YvcEYPZND6dmZRb/
         A79/W6VJE25PTSlWRzd3l0KUnxL3bYpCmP2NWd9AG2jn3PZI/9iWZf7vheEUEwk4AamH
         bMYd6zgtVXieoNPv0XhSGZylSoRjlw6EKJWzVLm0E5jdGPniE6BOrAcSzkDgjwM7P2p+
         F5lw==
X-Forwarded-Encrypted: i=1; AJvYcCUtX6mBauGGb/v94kDDnBCz7DIFhQnWMemURqwDbAXy0oQ43FENY0+bMlk3onJS7XiM5/v2L+U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZAFiyFn7RLHOeSyLJyWjf36vzxJ4p0aySYsL3BWnn1AHisCm5
	9zqnowEYuB3yEsNWTcTar2AY6BA8FhGzqKbGYhNRqErCLhLjtJCCq631
X-Gm-Gg: ATEYQzwI0G4FQCu08d1ucaGdwi7OK8GRsPIVUNMk3Rge6tqsaZMa69qfpQoMxdg++z1
	IXvvZUVljvjSoJTs1m/EgI5gc1pC5/BQ1T6v7+V4J/qMG0gNcwKwIwxRP1DFG/C+bMDgg5Yvy7E
	iSxv16P/vBepNZcJoAQPBtgq0JKM4qdTPVx4xfglN3Wv95oVmI7bsf8CDf0RKq3r03iYC3VAHtO
	0XCKl5Q5kXb/aD+5jpqnXdFrafuuWCBsoKH+yF/0ZGX5v4BlvzcYPG9McZZ2F/kTWNqnTwY6yoE
	BKFnQG7f2Qtvq4HusCgGcpiV8S07FiaJ09YxuOsw3YcYLKEaHHEL4iA5Mu8jiJjC1d0KI2fJgcW
	pZZFtDpX6ay3Z5ZtfY8AcO37evnKiFgYFFKd/jvedKLtddViUnW4hb6TPPHEnp1XqCA8CYealwe
	zpFSKXufpWWpsGe1tvaPoWMMOyvy5BEUrrqJVPYVS4p+WZg85mBUTDJvErLrI=
X-Received: by 2002:a17:902:ef4e:b0:2ae:3ab7:1545 with SMTP id d9443c01a7336-2ae3ab716c3mr100913675ad.43.1772530991099;
        Tue, 03 Mar 2026 01:43:11 -0800 (PST)
Received: from SLSGDTSWING002 ([129.126.109.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69f283sm163382885ad.49.2026.03.03.01.43.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 01:43:10 -0800 (PST)
Date: Tue, 3 Mar 2026 17:43:06 +0800
From: Weiming Shi <bestswngs@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: security@kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, xmei5@asu.edu
Subject: Re: [PATCH net] net/core: add xmit recursion limit to qdisc transmit
 path
Message-ID: <aaatKuzRBaR_cSL2@SLSGDTSWING002>
References: <20260303022947.3061602-2-bestswngs@gmail.com>
 <CANn89i+mK-CqGPeW65RBeOe2R-YjqjxU9W9AGbvV1Ef+HS4DtA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+mK-CqGPeW65RBeOe2R-YjqjxU9W9AGbvV1Ef+HS4DtA@mail.gmail.com>
X-Rspamd-Queue-Id: ACF4C1EC15D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263100-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On 26-03-03 05:30, Eric Dumazet wrote:
> On Tue, Mar 3, 2026 at 3:37 AM <bestswngs@gmail.com> wrote:
> >
> > From: Weiming Shi <bestswngs@gmail.com>
> >
> > __dev_queue_xmit() has two transmit code paths depending on whether the
> > device has a qdisc attached:
> >
> >   1. Qdisc path (q->enqueue): calls __dev_xmit_skb()
> >   2. No-qdisc path: calls dev_hard_start_xmit() directly
> >
> > Commit 745e20f1b626 ("net: add a recursion limit in xmit path") added
> > recursion protection to the no-qdisc path via dev_xmit_recursion()
> > check and dev_xmit_recursion_inc()/dec() tracking. However, the qdisc
> > path performs no recursion depth checking at all.
> >
> > This allows unbounded recursion through qdisc-attached devices. For
> > example, a bond interface in broadcast mode with gretap slaves whose
> > remote endpoints route back through the bond creates an infinite
> > transmit loop that exhausts the kernel stack:
> 
> Non lltx drivers would deadlock in HARD_TX_LOCK().
> 
> I would prefer we try to fix this issue at configuration time instead
> of adding yet another expensive operations in the fast path.
> 
> Can you provide a test ?
> 
> Thanks.

Thanks for the review. I have two follow-up questions:

1. For the configuration-time approach: the loop in this case is
 formed through the routing layer (gretap remote endpoint routes
 back through the bond), not through direct upper/lower device
 links. Since routes can change dynamically after enslave, would
 this require adding checks in all of bond_enslave(), route change,
 and address change paths to be complete? I want to make sure I
 understand the scope before going down that path.

2. As an alternative, would it be acceptable to move the recursion
 check into the bonding driver itself (e.g., bond_start_xmit() or
 bond_xmit_broadcast())? This would avoid touching the generic fast
 path entirely, and since bond is LLTX, there is no HARD_TX_LOCK()
 deadlock concern. It would narrowly target the driver that causes
 the fan-out recursion.

Happy to respin in either direction, or explore other approaches
 you have in mind.

