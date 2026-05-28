Return-Path: <netdev+bounces-292845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WCwAA4mtGGpolwgAu9opvQ
	(envelope-from <netdev+bounces-292845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:03:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C2675FA250
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 23:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3FAED3015853
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE41D33F390;
	Thu, 28 May 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzBGY0We"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC3A32B130;
	Thu, 28 May 2026 20:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780001808; cv=none; b=t6iOczZq/FyP5zMLMcDCFAk4/biM23GX3Q6kOoosWqqCcd5M1AUsWIs0ZQDZK1TAMPFZ+sfucAYA+GACQkPzGUv7tcKWDW9wCOtuelZXf4/1mhHCE/del8BAY9mgFXmEoBd97mDgeHGAuOEvSWJxiJfN6Zj0O5i3JAp0FMeIUzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780001808; c=relaxed/simple;
	bh=ZGbzaMKq6c8BjQti8/Jyf1GklIhPWDvOyEjfhWC25ck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4rI1IP1nuQ/qHEv7Mpdzyn0rworotHKtxIMWw0tA/DzTgFciwOethlcHuJhzzIAgdu8nyOzWPuDuBwtd71PuyFnzD01xjf2F4f0O5buO92/7aHb3AZY9FU8DFVuk6JGP+TMIZBdI8Yf90iU1Ij1uueO+zXxRJO8SIhCIAfXN9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzBGY0We; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 512D01F000E9;
	Thu, 28 May 2026 20:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780001807;
	bh=ZGbzaMKq6c8BjQti8/Jyf1GklIhPWDvOyEjfhWC25ck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NzBGY0WezaY9xGwigzFYwidD4CYk6jqU+Ec+naYgoeI0UKmjq2oei0dUcvWNeedIt
	 rvguyOnYxlaLtgcnKvsg68LYU36YalypvDroXN9821mBDJY6Y+y1Xu3tJiryxA2Ydu
	 QbhoHgF/YcNgqJs6ISuYBpEfW0/GXr99/Zp+KoLpQhi+wk8j7Nmh5BffDh4KHDqfzr
	 ZEEnGgmZLkHmeeLPIPt9ANP2fRQ4JpFfrSq9lUnA7V4tChV4VcJxcV2KufOxqwNvWa
	 doPDfSBb0zcVbjqgUF85ZX4zeckIV4Uyk+kL2Zo8z3JmsDC/27O4g14D19na2nG6d6
	 a/kmdXkZjAc4w==
Date: Thu, 28 May 2026 21:56:43 +0100
From: Mark Brown <broonie@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
	Lucien Jheng <lucienzx159@gmail.com>,
	David Miller <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
	Networking <netdev@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <c584c7ba-f0dc-4c5b-9c44-5559dca552f0@sirena.org.uk>
References: <ahhlcK0ufJn0VEzM@sirena.org.uk>
 <20260528130436.450720f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UySIyz8JMMbo2jjs"
Content-Disposition: inline
In-Reply-To: <20260528130436.450720f9@kernel.org>
X-Cookie: Someone is speaking well of you.
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292845-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[collabora.com,gmail.com,davemloft.net,redhat.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7C2675FA250
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


--UySIyz8JMMbo2jjs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 28, 2026 at 01:04:36PM -0700, Jakub Kicinski wrote:

> The AIR_EXT_PAGE_ACCESS define is no longer visible in air_en8811h.c

I did see that and fix it up for the final tree.

--UySIyz8JMMbo2jjs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmoYrAoACgkQJNaLcl1U
h9BVmAf+M3D9jVypiIvcCUahQ8U4S9y3nNZ/3hssDpTzcn2B6TxNSTULdQOlTt3j
5fblQWPvyOFUR42xY0tjPOVs3/euAH03fHCDpWpeMweuiQ6rQdK2BTcLrj52KJd/
KhMzIFkBT3zHrJmnTcjP3hvEG5AhzXdX6awTP3FRK9eDb9BAZJ82hXQDsBEM6uAF
ykbZjIPk4whMBTBDdLsJzpluWhy1TnFTRbfyKYF8/8MMphLD9eUJF0NvcsqX9IGk
jdqz2ItZSnPmv9d16m99HaNw+Xpb+MoAluN2A9XMwDuZzdtEvepYYpyAR0ECs/Zb
UzZKEPGRhNwOKb4ySKGQNKsSE+PuRg==
=I60q
-----END PGP SIGNATURE-----

--UySIyz8JMMbo2jjs--

