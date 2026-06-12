Return-Path: <netdev+bounces-298821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mqEbEuOaLGrETgQAu9opvQ
	(envelope-from <netdev+bounces-298821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:48:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E7167D15E
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 01:48:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=FfIAcWvA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298821-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298821-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1DABA311EAEB
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 23:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13672F83A0;
	Fri, 12 Jun 2026 23:48:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DADB3233920;
	Fri, 12 Jun 2026 23:48:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781308126; cv=none; b=sifiiiN6b4B1tbz4y0Vt0J+FGupLco0J1zdoadociUB1KVPax+sE2OiVT221revCdzs6GWfZRWkA/Cbn/dGkZLx7H/3Gs9hfU/AHaDY8fmYhiN1aaK/aZIIYecp52+XuYZ1FmrVLIXxShvfZIEYIepeCujyucal4on3huPRU7To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781308126; c=relaxed/simple;
	bh=jfg4PkbWjeFfksq0loUd/x+t0Yzdj6Ba/Yuoor+uKm0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kba+8mg0iadPHuyBhpGyHDYrluVIBZAGZOM3RF8xwNFhTPN2a6N9BrtcWIUkmYqU/FuGQzlR6BMJen0LL1tiyOXvW827qAd7jlfN+HT+7qbLkbR2qhKy1H7a/3xJGyAmQMY6uIed7N2E/mBMNfxWN2teDPwmG0OFjUzbiYWy18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FfIAcWvA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA83D1F000E9;
	Fri, 12 Jun 2026 23:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781308125;
	bh=8yoUjmsgvioaKiWi9pA9SXBu3LhphwrTuMsejO5mvYo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FfIAcWvA0WiOiXGgbpPhe1qHwiV+dPXOI6/urAsDW2rwoGq7E7k1XoQ5kVr/2ySig
	 mXR84OZGQYEUnbyVuDgSB/qFKqNymOxHC61M8HnBlNIz4mkKB3gymJQ60d+UF4ziHb
	 gtiSnrCn3/69sZaDDNyfbqDSM6rk+Ed8bguoNRwpm0MPTHw0WvuYHL6vpKRgOtoQCh
	 eid6hb+Is2U51b9wkCDfc8MLoxYy+J2FpZBZ/REIIvejlty50YQ+UobjekXzo63kIf
	 Rk0x1C2+fN8pPdUb7IRuis3K3K4WmlFPLlas4FomgW7agrtpGOUHFD+NGmHCngIVQF
	 MTHewTBP/Yx2Q==
Date: Fri, 12 Jun 2026 16:48:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org, Li Daming
 <d4n.for.sec@gmail.com>, Ren Wei <n05ec@lzu.edu.cn>, Jeffrey Altman
 <jaltman@auristor.com>, stable@kernel.org
Subject: Re: [PATCH net 4/5] afs: Fix netns teardown to cancel the
 preallocation charger
Message-ID: <20260612164843.20452d5a@kernel.org>
In-Reply-To: <20260609140911.838677-5-dhowells@redhat.com>
References: <20260609140911.838677-1-dhowells@redhat.com>
	<20260609140911.838677-5-dhowells@redhat.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298821-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:dhowells@redhat.com,m:netdev@vger.kernel.org,m:marc.dionne@auristor.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-afs@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:d4n.for.sec@gmail.com,m:n05ec@lzu.edu.cn,m:jaltman@auristor.com,m:stable@kernel.org,m:d4nforsec@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,auristor.com,davemloft.net,google.com,redhat.com,kernel.org,lists.infradead.org,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A0E7167D15E

On Tue,  9 Jun 2026 15:09:08 +0100 David Howells wrote:
> Fix the teardown of an afs network namespace to make sure it cancels the
> work item that keeps the preallocated rxrpc call/conn/peer queue charged
> before incoming calls are disabled (i.e. listen 0).
> 
> Also, if net->live is false because the afs netns is being deleted, make
> afs_charge_preallocation() skip charging and make afs_rx_new_call() avoid
> requeuing the charger.
> 
> (This was found by AI review).

Both Sashikos think this patch is still racy FWIW but not a blocker IMO

