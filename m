Return-Path: <netdev+bounces-286045-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGXoCFhv/mnNqgAAu9opvQ
	(envelope-from <netdev+bounces-286045-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:18:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C38E44FCB32
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 01:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9FCC4301CC75
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 23:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4663328FA;
	Fri,  8 May 2026 23:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JkwqRXKs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7D8256C6C
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 23:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778282309; cv=none; b=WZNuON/PSwrc8HADfFQNvel+vP/k08Hx/bqagBW3wE/CJ2aUrZdFoSei9oMw1hnWVtteU5QJvW9jSN9Ns5uLXboFFvzlbSZQbkNKBKcfhhnr1cYN1RRbFoA5/6bEywDM8+UtiH51TbUtz+7l55ShPmMrLsUSjzoaLsFURVBkIXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778282309; c=relaxed/simple;
	bh=xpnX+qAbaGUlVLFiael2rU4Vzg73cKqaeZn4VAKNnRU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N85HOSF7RjZayc9QID5Y+3SrhHKiHstytSyRpx/MUhm0c/CFVvVo+OqShLGNQtlqxaVIJlryUB6SUjFHMzAx7ghSUUIUk1etNPCpSTwqmypApj2jXKVar6Ncp6MdpDFazJtj4eO/9cyrErwInO2Y09si8eiRRSijYuFkI38VyTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JkwqRXKs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31C95C2BCB0;
	Fri,  8 May 2026 23:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778282308;
	bh=xpnX+qAbaGUlVLFiael2rU4Vzg73cKqaeZn4VAKNnRU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JkwqRXKsMOZOtwTtOknWzpeiHI+zHlMy2XA6SXGWy7y/lE+asDfMgl5fVNeqr7KzS
	 JVQAPC7DLwgT75fAzzhFK7z1i0YBjrnqpfUYfwI/V6WHQhtjGCO4OsqRyccAuHeHhw
	 SbvwBAhTeQRJTOHLk1OBR1bpdw6siOe1AMOBxsEFymtv9byuBOaBNiLMonGS46VkYc
	 RKe+uw2dfx2XH9QiQLLp4B+be6K7Gt1J/vFGcQSHKVkcijKJYo9FDtgE4E+Skr0bwh
	 q56TOR8rj/Nxrrw2dGM3nUeYTTD5/wo6T9y1yy73o9SPYi8o+OF5BOO6rfBPTicojM
	 AuGLr9dyRnaEA==
Date: Fri, 8 May 2026 16:18:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, David Ahern
 <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH net] rtnetlink: add RTEXT_FILTER_TERSE_DUMP support
Message-ID: <20260508161827.15b114eb@kernel.org>
In-Reply-To: <20260507174547.4125412-1-edumazet@google.com>
References: <20260507174547.4125412-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C38E44FCB32
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,redhat.com,kernel.org,google.com,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-286045-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu,  7 May 2026 17:45:47 +0000 Eric Dumazet wrote:
> We can later avoid using RTNL when RTEXT_FILTER_TERSE_DUMP
> is requested, as none of these attributes need RTNL.

Since this is uAPI I think we need a better name?
TERSE_DUMP doesn't explain much, my first thought was that you'll just
trim some ancient attributes to make things smaller. Sounds like you
want it to be lockless. Also GET will effectively support this bit
too so _DUMP is a lie.

Maybe RTEXT_FILTER_LOCKLESS or RTEXT_FILTER_NAME_ONLY ?

