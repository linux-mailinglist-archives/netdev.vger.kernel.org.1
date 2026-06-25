Return-Path: <netdev+bounces-301993-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YhsJCc5EPWo80ggAu9opvQ
	(envelope-from <netdev+bounces-301993-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:10:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 656DD6C6F35
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 17:10:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="M/4PQJJq";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301993-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301993-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E7186301AD2C
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 15:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311D13E5A0B;
	Thu, 25 Jun 2026 15:08:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A6D21C695
	for <netdev@vger.kernel.org>; Thu, 25 Jun 2026 15:08:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782400137; cv=none; b=elofnGkhI3GpdNCZpGpNxXuU1+6llNWQznsSxuVATXEvZcyPap7R7/32I0Z0jugnwCSVq+7R4cN/JGQcfwfySZs8ZSS1+lwR2uzyr7tFSXV/GP2xuBDfFediU1WWMT5zPkkKofN1+8eTuvzOjzI6v7IG1yiYysoEiOPjizTDb5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782400137; c=relaxed/simple;
	bh=T+mazuz88HSQp9AISBHa1RwblZqs3JqcY50r/r411X0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VBYA2U/mg3XcFZhft4o1Ae+atGWS3AknlBf+qrKnukhcu/OijqhddnWHHicw5U6QrMrZf9xYFgRBCyMWPjIOtCoLwkuasd6j2s/BnuULF142slBOrlqXBtScRTcaA0qnpWEmwsgkI8vPBcIVhEFk4SciuoAKvSnsASNwQYmsvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M/4PQJJq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838511F00A3A;
	Thu, 25 Jun 2026 15:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782400135;
	bh=F0IxRSwExU9yzE3OgxmfYZtXeHuMfQM2x5PbEfFY5CA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=M/4PQJJqSQMRPOkw1P5Um8Jjel0+bpENf33TyjEdCzIiIkXyqJEKPZX4rIlp3iOqg
	 RlfOsoSP+mOxGJYEd7iun0JWMtOp0kTgm/7/kY2wBONv78epnNqhrg8kwRWBIfPLzT
	 GFAyyjRIB/duuDrb7DkHGAG4yCXH/AREMjff4KgAdyKmXI865a/b8y7pPmBfAP6sBq
	 FmpJ0RUJwy5MWNOy3UO17ITFRmYJMnwqFREFmAJ2NHBm5q7Oqefm0lGfhpQpBuCNYF
	 jvGZ005yxsckfGDFWoh7mKenOFKobDATfQlN2c7PUlnQnsBesObNZnsVAx8AeKxv1D
	 4O91CK69vIbhg==
Date: Thu, 25 Jun 2026 08:08:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Yue Sun <samsun1006219@gmail.com>,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net 2/3] net: udp_tunnel: convert state flags to
 atomic bitops
Message-ID: <20260625080854.06851faf@kernel.org>
In-Reply-To: <20260625065938.654652-3-edumazet@google.com>
References: <20260625065938.654652-1-edumazet@google.com>
	<20260625065938.654652-3-edumazet@google.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301993-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf@fomichev.me,m:edumazet@google.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:horms@kernel.org,m:samsun1006219@gmail.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 656DD6C6F35

On Thu, 25 Jun 2026 06:59:37 +0000 Eric Dumazet wrote:
> These flags can be modified concurrently from different contexts:
> - RTNL-locked paths (like add_port/del_port) write to need_sync and
>   work_pending.

These should hold utn->lock. Not sure why udp_tunnel_nic_lock() 
is locking in the callers rather than directly in
__udp_tunnel_nic_add_port() / __udp_tunnel_nic_del_port()..

> - The RTNL-less reset path (reset_ntf, used by netdevsim) writes to
>   need_sync and need_replay under utn->lock.

I'd rather add asserts to confirm utn lock is held everywhere.
This code is hard enough to follow as is, without having to
think through potential concurrent accesses.

