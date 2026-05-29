Return-Path: <netdev+bounces-293013-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CE/BFDY7GWp6tggAu9opvQ
	(envelope-from <netdev+bounces-293013-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:07:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92C25FE51F
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E47963042531
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB63A254B;
	Fri, 29 May 2026 07:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="Cqm1KyfG"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E97D623C4F3
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038426; cv=none; b=N13JFBgftD3M3xQLRIsGM2Cnh3WAyCkDSY90pC/LNPksRC0faFeRwKAYyFoMndAw6rT/2fjTf7+OGSVabYMFkyMfHMC7r7k0HLrSRQ1YUN/zFSKUWLCB40zeCA/OK0XzxMh8vWwY1+uYzBoImqDBnXsPaJl1kLn8NUUmQPwB7oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038426; c=relaxed/simple;
	bh=lsrnTbMVOVhv+7OrmB+FUa1+ty6MWBFfoAbOeT7V77Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BFaEj6tOTM+vBeFRZWvU9tz2DWNHt/g6ulpyFYg8ebZ2/237qKwBzDiyJ9HXV+2sriJ0iJzPYfdHUQv3FUyBCh+cbFPNpGW3vt+yYiNDWnMp1E4EUhCJqVtwe/JA7rtUHoJsl769IzDJT4bwSdC52cFMe73CORNkhp8hnkbQkxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=Cqm1KyfG; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Received: by dvalin.narfation.org (Postfix) id 53DF920039;
	Fri, 29 May 2026 07:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1780038422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iuyGubf2/NYJK3ycC+f5/Zj97zRD1Z6XF2ZBowjdOAI=;
	b=Cqm1KyfGBuB4o/OZX1THF9NPlPy+ckEnjk2RPGJId14f0n/b5yUqPg+jHNiNNOnlWkf/o1
	jvpvLfDofkARW7HYKfEpV9H2FdhcLV3535+JLpx3EKlELJ6LqGSWEyxIu+NW+wCOk6JaQ8
	tOKVf+096fvPpCuPSE9XUEZMhMi0yms=
From: Sven Eckelmann <sven@narfation.org>
To: Simon Wunderlich <sw@simonwunderlich.de>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, b.a.t.m.a.n@lists.open-mesh.org
Subject:
 Re: [PATCH net-next 01/15] batman-adv: drop batman-adv specific version
Date: Fri, 29 May 2026 09:06:56 +0200
Message-ID: <5075322.GXAFRqVoOG@ripper>
In-Reply-To: <20260528171412.7a60e8f7@kernel.org>
References:
 <20260528142924.329658-1-sw@simonwunderlich.de>
 <20260528142924.329658-2-sw@simonwunderlich.de>
 <20260528171412.7a60e8f7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1957926.tdWV9SEqCh";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Spamd-Result: default: False [-3.76 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[narfation.org,none];
	R_DKIM_ALLOW(-0.20)[narfation.org:s=20121];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293013-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[narfation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sven@narfation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,open-mesh.org:url]
X-Rspamd-Queue-Id: E92C25FE51F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--nextPart1957926.tdWV9SEqCh
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 29 May 2026 09:06:56 +0200
Message-ID: <5075322.GXAFRqVoOG@ripper>
In-Reply-To: <20260528171412.7a60e8f7@kernel.org>
MIME-Version: 1.0

On Friday, 29 May 2026 02:14:12 CEST Jakub Kicinski wrote:
> On Thu, 28 May 2026 16:29:10 +0200 Simon Wunderlich wrote:
> > +#define BATADV_SOURCE_VERSION "linux-" UTS_RELEASE
> 
> What purpose that does "linux-" prefix serve?
> The unwritten rule is that the OOT drivers have to append something 
> to their version to distinguish themselves. In-tree version is just
> the pure kernel version.

We don't have a real preference here. If you prefer UTS_RELEASE only then I 
get rid of BATADV_SOURCE_VERSION and just use it in both places in
version.c

https://git.open-mesh.org/batadv.git/commit/?id=8cc63db2462ad7d3ee213059025bf5fffe2e7982

> To be clear, definitely a move in the right direction. I hope we can
> move _all the way_ in the right direction, tho, without still defining
> OOT-feeling version.h file with a dedicated BATADV_SOURCE_VERSION

version.c and version.h are there to not recompile more parts of batman-adv 
than necessary when the linux kernel version changes. Has nothing to do
with OOT. If you consider this a no-go, I can also just place 
generated/utsrelease.h + UTS_RELEASE in the three different files.

Regards,
	Sven
--nextPart1957926.tdWV9SEqCh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCahk7EAAKCRBND3cr0xT1
y8BpAP9YDul7jL0bTPXj2bxk32/4QTLdSxErhd7Ivj5bCnIr2AEA7+zwi4YULFDh
yVRmS4hsFwvO4ggFawfGEkH9xbH7Fgg=
=BVcL
-----END PGP SIGNATURE-----

--nextPart1957926.tdWV9SEqCh--




