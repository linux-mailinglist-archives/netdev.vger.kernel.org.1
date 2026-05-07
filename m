Return-Path: <netdev+bounces-285298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WDXMAI+A/GkcQwAAu9opvQ
	(envelope-from <netdev+bounces-285298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:07:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEB24E7FCC
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 14:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 055AD3006150
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 12:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2753A7584;
	Thu,  7 May 2026 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eR58poj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdQIQl85";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eR58poj/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="LdQIQl85"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26B6C379EDF
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778155659; cv=none; b=peQWrkx5L5q4DMXHMDn5UVeTJkrbizzf6blZZhZLCXdAWRVtP+yfyvWwXJ09aw4E8KYxueaPjSWPCZyKGWai9IDJsOup17xcrG0EIuL6ZC3PTHbBF3ssMkSu49ZszecG+EdEx7zo22wKRNLuUxbMl0SgRHro6bd4x+iBSlI2SC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778155659; c=relaxed/simple;
	bh=+fUUhPZeNFV3P55GU6f2uAVhCRbsf/GQ5bx4jFrbUgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eOu9ddTWjAaBa+6Ne4bCR8zY7HA9lktYWC8hkkih1WQPEdmroLOHStq0SIEH8jTzP4/5Z85sS7s01VI436i/2w3ntKb9P0DGPwmkT/KPEbf2tyMyRFwHaCi5MMuyfp5V0uaMZfcL1ATbm7bd5rnm5Gpf4GDZ1O41AhGFzJv3Cpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eR58poj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdQIQl85; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eR58poj/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=LdQIQl85; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from lion.mk-sys.cz (unknown [10.149.218.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 6963F6C2E6;
	Thu,  7 May 2026 12:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778155656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=II893x9pv21BNu8DzYEbQrpAQwkDCQdRE03nONT/+l0=;
	b=eR58poj/CBeswVinjLEPpM0uv8HzcysUFo5dP0qT5a0J/sAT8iIHEx4/TuNml/pUSyrA2Q
	rD7u0bqwGnGhTUd4T/WMmPG63UxFD3jz6g/JQmBwvrc8334HPtRpEFbeM/iQ2AXVl4V8vf
	hXOzNyN9OSTkW8109NiM5q10uBGPNow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778155656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=II893x9pv21BNu8DzYEbQrpAQwkDCQdRE03nONT/+l0=;
	b=LdQIQl85Yw5zfgaJv09UPTgTvqRYQ1pt1EH/Zp0YPh8jLeOExEqLz58hGQdZdV5HD6Kvhw
	ssjxy8OBYlKwVFAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1778155656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=II893x9pv21BNu8DzYEbQrpAQwkDCQdRE03nONT/+l0=;
	b=eR58poj/CBeswVinjLEPpM0uv8HzcysUFo5dP0qT5a0J/sAT8iIHEx4/TuNml/pUSyrA2Q
	rD7u0bqwGnGhTUd4T/WMmPG63UxFD3jz6g/JQmBwvrc8334HPtRpEFbeM/iQ2AXVl4V8vf
	hXOzNyN9OSTkW8109NiM5q10uBGPNow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1778155656;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=II893x9pv21BNu8DzYEbQrpAQwkDCQdRE03nONT/+l0=;
	b=LdQIQl85Yw5zfgaJv09UPTgTvqRYQ1pt1EH/Zp0YPh8jLeOExEqLz58hGQdZdV5HD6Kvhw
	ssjxy8OBYlKwVFAg==
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
	id 3FADA2008C; Thu, 07 May 2026 14:07:36 +0200 (CEST)
Date: Thu, 7 May 2026 14:07:36 +0200
From: Michal Kubecek <mkubecek@suse.cz>
To: Danielle Ratson <danieller@nvidia.com>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [PATCH ethtool-next 0/5] ethtool: Add 'pages on|off' option for
 module EEROM hex dump
Message-ID: <4chkrvenxrbc2tylrbob6vdo3uyjzbwbhbup25yvnohrccvotv@fd7rqasq4btv>
References: <20260507114721.3409128-1-danieller@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tbokijsiy3mioc57"
Content-Disposition: inline
In-Reply-To: <20260507114721.3409128-1-danieller@nvidia.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -5.90
X-Rspamd-Queue-Id: 9BEB24E7FCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285298-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[suse.cz];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkubecek@suse.cz,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.cz:dkim]
X-Rspamd-Action: no action


--tbokijsiy3mioc57
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 02:47:16PM GMT, Danielle Ratson wrote:
> The existing 'ethtool -m' command can dump module EEPROM data either as
> a parsed pretty-print or as a raw/hex dump. The pretty-printer reads
> multiple pages per module type, but decodes only specific fields from the=
m.
>=20
> In practice, both outputs are often needed together for offline debugging:
> the pretty-print to identify the module type and decoded fields, and the
> hex dump for fields the pretty-printer does not decode. However, there is
> no single command that provides the raw hex dump of all relevant pages,
> organized by page boundary. This is especially problematic for CMIS
> transceivers where the existing hex dump does not provide Upper Pages
> beyond Page 02h, let alone banked pages.
>=20
> This series adds 'pages on|off' sub-option to 'hex on|off' for
> 'ethtool -m':
> $ ethtool -m hex on pages on
>=20
> That produces a hex dump organized by page, matching exactly the pages re=
ad
> by the pretty-printer for each module type.

Do we need the "pages on|off" switch? Is there a reason not to show the
full dump always (whenever possible) but only when requested explicitly?

Michal

> Each page is preceded by a header identifying the page number and, for
> banked modules, the bank number. For SFP, where the two memory regions
> are separate I2C addresses rather than pages, the header shows the I2C
> address instead.
>=20
> Output example (values zeroed to omit vendor-specific identifiers):
>=20
> $ ethtool -m swp61 hex on pages on
> Page: 0x0
>=20
> Offset          Values
> ------          ------
> 0x0000:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0010:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0020:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0030:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0040:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0050:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0060:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0070:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>=20
> Page: 0x0
>=20
> Offset          Values
> ------          ------
> 0x0080:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x0090:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x00a0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x00b0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x00c0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x00d0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x00e0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 0x00f0:         00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

--tbokijsiy3mioc57
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEWN3j3bieVmp26mKO538sG/LRdpUFAmn8gIIACgkQ538sG/LR
dpWGaAf6A/4bRm9fL2fQyJ0qBcB7oPWa131mNPLyeuxUIpnCVaF9OKOzkXfKbair
bDyqL6UBpMqUQVhHIK4AC83hBvkFdawwkaMbAYguVeXQQEkuIQRDRIX+to1FDLYK
BzMBjfEJ9Ng85PTs1hCWA/jcOSYFtVL8Cl+Q5Oalh5KCNndQ61gQZ9c1gkCugqIg
cyw7OtY0GhyUAkWUw0FYm/oP4Cq4Zxo/h+qWB00H0lSP1Oei7yqSOIUCgEAPlnFu
vHAP/3gxiR65UvCJmGYAX1ITnOU4Nf/EOVOAMhFpEmQSRaVfMmLtK48wd69CpEcS
Y9ULzvOqPURjMd5J/y6HZiUoN15Vbw==
=9aAw
-----END PGP SIGNATURE-----

--tbokijsiy3mioc57--

