Return-Path: <netdev+bounces-301360-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id BBA/NY56Omq29wcAu9opvQ
	(envelope-from <netdev+bounces-301360-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:22:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 665516B70A7
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 14:22:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ag5Hm+RN;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301360-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301360-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D3320302FAB9
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 12:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F09E250BEC;
	Tue, 23 Jun 2026 12:22:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAEC93D567E
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 12:22:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217356; cv=none; b=ahQBddDE4L5n7dGNRy5BbNhABhY3XZSkFU79elyUSpVhWh3KixJaD3WP9DZWg0dWBLcTGqyiW5qFZveH8cFWuX8WTR1BDUxlB8K/VA9MmQHio45hwpHwBb5bb1iDHxNluMXbDxw7xB5SaHH3MQidgsl1WpT0uiDX6X9Dsovy6xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217356; c=relaxed/simple;
	bh=LH/VnGgCnFwSj9VN7+GY3WRshzT8ch55U7m4NbeUxzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sndC2e54uPMeO+XKSa8NaxyJDZ523lPc3udFncF1Vr27VNf6pl8Og7K1c8nKM18uLJmnbkIo/zpvpHc12bdCUc7XRGMBvhv8dtW5JCHQF4U7A23+JIKkKH6Wlh6ds74fUaOGPO3BjSBKiuonYuFfNV+4iTVulWlpYEcWET3+RAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ag5Hm+RN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18A061F000E9;
	Tue, 23 Jun 2026 12:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782217354;
	bh=MVDyPTjerdOBmT+C67OudtG1LBzc9F1BxwLCyBzR8hY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ag5Hm+RNMo+r6yIvjQMLwIJvPs0VMtJdS8EGJegKp4b5iax6ryfCSfvWAa29xCJSx
	 ob1ItoXIQYRHROsAHA2N+FwAYMOluOfQxAYR32IP5wH9XZN2dYMMysBcFYRty2bkVG
	 5rbmjUsIAAzpZdfm57nk9TKcrjVgpA533uZ1SKsnoeFfUNFumVJT7wp1cQTW+DPBO0
	 7Q+XJB0HKniWbooYsDAqdMB1e2hTRKjx1ulwBaHT1E/TkuY2Xc+1tZAJtfK/yLZayA
	 Sy33aAsKhsRMyM4e1U/UxrCRU40uSPM2QnVqNrxl7ZIVZqzjtTgV2AOYfu/99rA6mr
	 9E2hQWB/hZLOg==
Date: Tue, 23 Jun 2026 13:22:30 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: Re: [PATCH net] net: do not acquire dev->tx_global_lock in
 netdev_watchdog_up()
Message-ID: <20260623122230.GK827683@horms.kernel.org>
References: <20260622110108.69541-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260622110108.69541-1-edumazet@google.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-301360-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:eric.dumazet@gmail.com,m:m.szyprowski@samsung.com,m:ericdumazet@gmail.com,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,samsung.com:email,horms.kernel.org:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 665516B70A7

On Mon, Jun 22, 2026 at 11:01:08AM +0000, Eric Dumazet wrote:
> Marek Szyprowski reported a deadlock during system resume when virtio_net
> driver is used.
> 
> The deadlock occurs because netif_device_attach() is called while holding
> dev->tx_global_lock (via netif_tx_lock_bh() in virtnet_restore_up()).
> netif_device_attach() calls __netdev_watchdog_up(), which now also tries
> to acquire dev->tx_global_lock to synchronize with dev_watchdog().
> 
> This recursive lock acquisition results in a deadlock.
> 
> Fix this by removing the tx_global_lock acquisition from netdev_watchdog_up().
> 
> The critical state (watchdog_timer and watchdog_ref_held) is already
> protected by dev->watchdog_lock, which was introduced in the blamed commit.
> 
> Fixes: 8eed5519e496 ("net: watchdog: fix refcount tracking races")
> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Closes: https://lore.kernel.org/netdev/a443376e-5187-4268-93b3-58047ef113a8@samsung.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>

Reviewed-by: Simon Horman <horms@kernel.org>


