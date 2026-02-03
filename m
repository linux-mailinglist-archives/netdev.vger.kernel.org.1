Return-Path: <netdev+bounces-256274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8LPpHHLqgWkFMAMAu9opvQ
	(envelope-from <netdev+bounces-256274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:30:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDCE4D9085
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4211F3012C56
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 12:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64A0F340283;
	Tue,  3 Feb 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mi4ndnHQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415DB34026B;
	Tue,  3 Feb 2026 12:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770121519; cv=none; b=FUWQ8sZwomf6rBQu3kx1dJNH3VU8rh8mkQWDize+aqZXLetqpVoOUOu6SJgxli60qjebhILwc75yqHv+QiLnx+QF+o1OiTLKu2s6phpZeRCWWnZeP/mHSGR05xKR0GiNkEtyiDaZZOXyjw8d98aDhQr4NMOYP/WraD9pSCmF+jw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770121519; c=relaxed/simple;
	bh=zmW9iZ8OTMDOnUFlsSj9dHUE8b3JXtp0PZ2MDJrb9Rw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/YkfZ26Sda0a7/iKX0YtMDkn0ddvl389aesAWT15vIBItMnjQeFClIKCBiCYWf/DHOW2jwmuS9aiW4PS/gV4qAbWSXOPl1XnL5Pstmf4qYmOaNhk1oYBMPby8AZkOTSdEJKwmxp5WEZmxtMzC2AV/wZqmRk/fmtlUWI2I+Fuas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mi4ndnHQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2242FC116D0;
	Tue,  3 Feb 2026 12:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770121519;
	bh=zmW9iZ8OTMDOnUFlsSj9dHUE8b3JXtp0PZ2MDJrb9Rw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mi4ndnHQpEXB8yLdqJdVP31htPDKnXXQG4QWtfNa0SM2+lbmf5xFl5ix4bAUaW+ZG
	 a7jw6DqnyPAnhCxZ9Jd5j1bZHhyq4r1jhp1991IikVHHburF/5iS4KlpMxoII4ARwN
	 LRQxmzKDdqjApDYsMVuYFa3HMfEtuXxq1JONgRkaBMHYBhP50mBv1469e0SiW3I7lD
	 zNrtTwdrt6HxiEyymnuEvvicoXwf5BPG6+iv9QUnoUqPO9HlxDsD93TUmW3bmJww/X
	 YExGY3L6Ey382/DlP9AYGn8VGoufvSL9xgewVIbob6ahC1D2r/mhHAvgtjSREeUN9a
	 5cm/BW6mWtrXA==
Date: Tue, 3 Feb 2026 12:25:14 +0000
From: Mark Brown <broonie@kernel.org>
To: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	linux-phy@lists.infradead.org, Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	linux-kernel@vger.kernel.org,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Subject: Re: [PATCH phy] phy: enter drivers/phy/Makefile even without
 CONFIG_GENERIC_PHY
Message-ID: <57002ace-400d-4cc0-8225-3dc326e5c528@sirena.org.uk>
References: <20260123110600.3118561-1-vladimir.oltean@nxp.com>
 <007a2100-0913-4a8f-82d3-8118664fc1a7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="h62oFimrhVL7k4f2"
Content-Disposition: inline
In-Reply-To: <007a2100-0913-4a8f-82d3-8118664fc1a7@linux.ibm.com>
X-Cookie: Do you know Montana?
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256274-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[broonie@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sirena.org.uk:mid]
X-Rspamd-Queue-Id: CDCE4D9085
X-Rspamd-Action: no action


--h62oFimrhVL7k4f2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 03, 2026 at 03:26:47PM +0530, Venkat Rao Bagalkote wrote:

> I still see linux-next build failures with next-20260202. Can we please have
> this patch merged.

> Mark, can you please pull this one.

Patches aren't applied directly to linux-next, they are applied to the
various trees and then merged into -next.

--h62oFimrhVL7k4f2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmmB6SkACgkQJNaLcl1U
h9C52Af+IUUoMAI2QCfbuabrqV+840eg/Nk+Gopoh1c98ZPyewZMPNznIYkvtWLM
rVWnRdeZYDX8zrCkbzJcTeF6eSVAAClLrEvzFMVTsNlIcujYo/92kEszJ5QlQM+3
P2KxmXJB+oDd2dWsay6+X3m3tiYlezSKEldLtShYpt5TmxhHE07pxAaZUeeVFw4E
A1P5PTxiZ7SfaKf98hgJqlEqF2JMZ6axLYIEw6ROdDx2q8FGrNq8f3Mf1uJXQJYI
fmtfSZ/+/o1loG2Cp70hUAlYjrYZf2CdivyqChk6Ka8ZrU1aNBweFdP7CMOarpMo
T8wG9KNr+clGOB9cK/lg5julQmMP4w==
=Od2n
-----END PGP SIGNATURE-----

--h62oFimrhVL7k4f2--

