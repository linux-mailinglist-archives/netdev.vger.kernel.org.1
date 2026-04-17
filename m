Return-Path: <netdev+bounces-279420-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJyPOVei4mmv8QAAu9opvQ
	(envelope-from <netdev+bounces-279420-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:12:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE1B41EA02
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 23:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 282203025A72
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 21:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9809E33AD9D;
	Fri, 17 Apr 2026 21:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b="p9+xHT23"
X-Original-To: netdev@vger.kernel.org
Received: from sender4-of-o52.zoho.com (sender4-of-o52.zoho.com [136.143.188.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFFD32143F;
	Fri, 17 Apr 2026 21:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776460367; cv=pass; b=ZCIEUflOP0MiepGl0ZM9/HvB80SB3eLEYKEsF7UXYXSpSw/WcwOBiTRWCgaRLmoZv5bRmXGxdxZmQmFyXjPoKntEynRw8VzliZFeUQYqj4uyAz9xxon1klsSZtov0fSTwbPRpJdI5Zxv/FzS19gCK6ekxPZ10ktoYCzWS25Pfx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776460367; c=relaxed/simple;
	bh=9LCzNWgbQjoLV75dv3g3As9+0rxowGEUuHkmxZX+8UI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J1nHz0mzzXTEIgymwAIoPHemTwHGCuav7rGSbszJidhbrgxTc6JuMua71bVGX/aP7UxYoo1Ec8afZ8BFOMpVg/QVQuk9xOhPY6XoVz5MCqXWEpM25bs+0CYSOhAoJTtbpWh4S5pyqODuAOyBqMJrfNHFaxZEC6KBUzaaNJIZhaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com; spf=pass smtp.mailfrom=mpiricsoftware.com; dkim=pass (1024-bit key) header.d=mpiricsoftware.com header.i=shardul.b@mpiricsoftware.com header.b=p9+xHT23; arc=pass smtp.client-ip=136.143.188.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mpiricsoftware.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mpiricsoftware.com
ARC-Seal: i=1; a=rsa-sha256; t=1776460334; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=lBkknkYSDWUpMh4yCullM4m8jxJtEffFFW0cI1hmyzpkQ0XgUrvB79GaJYwHUowwsAGerlQxVQAxCnAfA5JqZ85KxLOe0SCB32Ec11EqwUszVvKiw4MjgnNLqCTaBvzyqUX8VzrAnLArNBKNJh5XzebOp1zS8LNue9O9hUr6vPI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1776460334; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=xg/IxZ6rKsza+ZIWkxEOo6kiEkolK46uyRinQ6V2VhE=; 
	b=H/1CccVpzrhcIQC2fjba1auKj4yv/fe4xbtb3lFqe4BCLBc5uGY0b23DXb55MaxlOrVls1DJ1OiX7YZxzTne4C57B3c7uDqKOVe7MkzbXUAIrGxU5kWU1JBjfu7dl7UdAQkVjcz2eZilWcTuz9YjZmppdeV4oow+p47cGVKokUo=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=mpiricsoftware.com;
	spf=pass  smtp.mailfrom=shardul.b@mpiricsoftware.com;
	dmarc=pass header.from=<shardul.b@mpiricsoftware.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1776460334;
	s=mpiric; d=mpiricsoftware.com; i=shardul.b@mpiricsoftware.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=xg/IxZ6rKsza+ZIWkxEOo6kiEkolK46uyRinQ6V2VhE=;
	b=p9+xHT23+y0/WKC4/n779Jj8+ANxYulpVnPIjC6/JUHZk8lVXqdQXwZC9qIWa+4f
	7OrxHZyWLny62Fu32XBbQDbNl6m6SmfjUwEbKPyGqK6Ma33309/4tEYY+aDowBxDMWV
	juDiAV5br4KMYGcOO3uaq0T3QukFfenzAgupxvdE=
Received: by mx.zohomail.com with SMTPS id 1776460331316854.0983054491305;
	Fri, 17 Apr 2026 14:12:11 -0700 (PDT)
Message-ID: <08c2189f7bb66d81c1fc8feff1a56dd7250958d3.camel@mpiricsoftware.com>
Subject: Re: [PATCH] net: hsr: avoid synchronize_net() in hsr_del_port()
 under rtnl_mutex
From: Shardul Bankar <shardul.b@mpiricsoftware.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org,  netdev@vger.kernel.org, liuhangbin@gmail.com,
 lukma@nabladev.com,  acsjakub@amazon.de, kees@kernel.org,
 xiaoliang.yang_1@nxp.com, fmancera@suse.de,  linux-kernel@vger.kernel.org,
 janak@mpiric.us, kalpan.jani@mpiricsoftware.com, 
 syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com
Date: Sat, 18 Apr 2026 02:42:03 +0530
In-Reply-To: <CANn89i+Yug-M2HFnoz5LrffTaB4AHtC74sPKjLWA7cJ2fKF4-w@mail.gmail.com>
References: <20260417175322.2701465-1-shardul.b@mpiricsoftware.com>
	 <CANn89i+Yug-M2HFnoz5LrffTaB4AHtC74sPKjLWA7cJ2fKF4-w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4-0ubuntu2.1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-279420-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com,nabladev.com,amazon.de,nxp.com,suse.de,mpiric.us,mpiricsoftware.com,syzkaller.appspotmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[mpiricsoftware.com:?];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_SPAM(0.00)[0.333];
	DMARC_DNSFAIL(0.00)[mpiricsoftware.com : SPF/DKIM temp error,quarantine];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[shardul.b@mpiricsoftware.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_TEMPFAIL(0.00)[mpiricsoftware.com:s=mpiric];
	TAGGED_RCPT(0.00)[netdev,f2fbf7478a35a94c8b7c];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8CE1B41EA02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 11:18 -0700, Eric Dumazet wrote:
> On Fri, Apr 17, 2026 at 10:53=E2=80=AFAM Shardul Bankar
> <shardulsb08@gmail.com> wrote:
> >=20
>=20
> =C2=A0synchronize_rcu_expedited() should be quite fast...

Confirmed.  I ran a targeted HSR-only teardown stress on current
mainline (many HSR-bearing netns torn down concurrently, no WireGuard,
no syzkaller harness).  At N=3D1000, patched-vs-baseline cleanup_net
wall time is within run-to-run noise- the patch has no measurable
benefit on the workload it was meant to address.


> Signature looks like bug fixed recently in wireguard.
>=20
> commit 60a25ef8dacb3566b1a8c4de00572a498e2a3bf9

Agreed.  60a25ef8dacb covers what I was actually observing, and
standalone evidence for the HSR path on current mainline is not
strong enough to justify this change.

Please drop this patch.

Thanks,
Shardul

