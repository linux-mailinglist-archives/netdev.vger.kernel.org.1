Return-Path: <netdev+bounces-81933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B972788BCAC
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 09:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B07D2E4241
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 08:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE8F10A19;
	Tue, 26 Mar 2024 08:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="oxn7/buG"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17ABB40879
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 08:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711442569; cv=none; b=SRVPuIjeQdUQSS6n22Js8kZnkqIQ+5GKJ/kx0Qux9OC9h1Djr0Fmca0GVulz6H5BqzaNmuWEjYUCU4A96f37N0dPokWGWzkENQPPTRNKzKfgJJXC+i/jstpp03HVvQ9MHWuxdKW0XN3l+5mvlaU+vNz+i+MhOBq76t5qY9xK3w0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711442569; c=relaxed/simple;
	bh=AkZ4rcv1lS3qw+Dn4WDI2ERAPNdRm9CMxtrftobJi+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C8zbr6DCR4zJzhfCCVFHbbpPL/rZMdMMlvDjezUWDk6SoIq/3nqfhfDr64xW6T1VA+VrRJ3UPKxgCpypt/isKUHzXG4nwzQAbbM+/jZjj5lQvF0zdTO95eTdLbgrnlnzOuvoPt3TlG7KdkX/S8FmJTKq8oyU+gES4kNIwRdELAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=oxn7/buG; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0P2AEpjVE6JKNokmM2Z5QIIJY9wSRoJmMDGkm42KoBU=;
	t=1711442567; x=1712652167; b=oxn7/buGK/pHrRO3MuHCUwRUF4QgUEaLj9niXv8VXELN6Ov
	ukYUTZEuyvriPHu+wgm9h7aYV7w2RkTYnBxHlBxV3ssPcyRHoka/6Nr89DCwQo2JB6Y1fOOHEgPvq
	vJlAkBDkXlq7bofZxtAJRehneApTYcWo5EgN8PJ6G2T8F8fwZ39Qs0uAI76z977Se6iE/HvgFiUCN
	hMzUSf2rJcha/D0dw7dSnvUvfqfC78duSBtxyoLdfFsK17SpQJHHE8jtjx+/ly7CYZzvcCZHJVGwi
	TZNjrd5h0pTDZ4DBtlHNoKCK8RAGkb/Y/xC7zSyFM6Dho1zEL5WxJC+zTsQe+QyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rp2OK-0000000FZwr-1i9q;
	Tue, 26 Mar 2024 09:42:44 +0100
Message-ID: <8eeae19a0535bfe72f87ee8c74a15dd2e753c765.camel@sipsolutions.net>
Subject: Re: [PATCH 0/3] using guard/__free in networking
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Date: Tue, 26 Mar 2024 09:42:43 +0100
In-Reply-To: <20240325190957.02d74258@kernel.org>
References: <20240325223905.100979-5-johannes@sipsolutions.net>
	 <20240325190957.02d74258@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-03-25 at 19:09 -0700, Jakub Kicinski wrote:
> On Mon, 25 Mar 2024 23:31:25 +0100 Johannes Berg wrote:
> > Hi,
> >=20
> > So I started playing with this for wifi, and overall that
> > does look pretty nice, but it's a bit weird if we can do
> >=20
> >   guard(wiphy)(&rdev->wiphy);
> >=20
> > or so, but still have to manually handle the RTNL in the
> > same code.
>=20
> Dunno, it locks code instead of data accesses.

Well, I'm not sure that's a fair complaint. After all, without any more
compiler help, even rtnl_lock()/rtnl_unlock() _necessarily_ locks code.
Clearly

	rtnl_lock();
	// something
	rtnl_unlock();

also locks the "// something" code, after all., and yeah that might be
doing data accesses, but it might also be a function call or a whole
bunch of other things?

Or if you look at something like bpf_xdp_link_attach(), I don't think
you can really say that it locks only data. That doesn't even do the
allocation outside the lock (though I did convert that one to
scoped_guard because of that.)

Or even something simple like unregister_netdev(), it just requires the
RTNL for some data accesses and consistency deep inside
unregister_netdevice(), not for any specific data accessed there.

So yeah, this is always going to be a trade-off, but all the locking is.
We even make similar trade-offs manually, e.g. look at
bpf_xdp_link_update(), it will do the bpf_prog_put() under the RTNL
still, for no good reason other than simplifying the cleanup path there.


Anyway, I can live with it either way (unless you tell me you won't pull
wireless code using guard), just thought doing the wireless locking with
guard and the RTNL around it without it (only in a few places do we
still use RTNL though) looked odd.


> Forgive the comparison but it feels too much like Java to me :)

Heh. Haven't used Java in 20 years or so...

> scoped_guard is fine, the guard() not so much.

I think you can't get scoped_guard() without guard(), so does that mean
you'd accept the first patch in the series?

> Do you have a piece of code in wireless where the conversion
> made you go "wow, this is so much cleaner"?

Mostly long and complex error paths. Found a double-unlock bug (in
iwlwifi) too, when converting some locking there.

Doing a more broader conversion on cfg80211/mac80211 removes around 200
lines of unlocking, mostly error handling, code.

Doing __free() too will probably clean up even more.

johannes


