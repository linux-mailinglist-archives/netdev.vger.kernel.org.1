Return-Path: <netdev+bounces-112625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86FDB93A3B1
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 17:22:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C79FBB218DA
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876D2154BE0;
	Tue, 23 Jul 2024 15:22:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.chopps.org (smtp.chopps.org [54.88.81.56])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E51D43D55D
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 15:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.88.81.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721748131; cv=none; b=bHHXaZEJuaTuW/yuWpKvkOS589D/O+eJ+WLPWFGxIROTUC87kw88GZFwmx9jIJaDn3ht+lKiqqrNcupS7Oi8Lfg4f3Mr2U/ZDV7tspM3VdGpJEbTpssjg7oniCVH1Lwnkp4u8v8T6ZsnwE+S4i1kodTyMUvOwVtBPk9gq9/wlVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721748131; c=relaxed/simple;
	bh=a+oDkoHZb77L5/N+VcTCnMX6VOdmmRQzMrOo9Rt46sc=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=Hug9+fdEgQEwqbZMhyiCj99xxyQh5QuiiJq03eZGzu+ruaH5C6Clp/bkG4DK99bBYg8cfBfDZ/5YlPpWd9CIUuBy3EdwbVQE0hSqeVHOyVd08T7g8w+IpD3gR9Qhf/aEbFYM1hE5AI5LaiFtYkhy+nrg2L3R69ko5SkWQnBXzzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org; spf=fail smtp.mailfrom=chopps.org; arc=none smtp.client-ip=54.88.81.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chopps.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=chopps.org
Received: from dhcp-9273.meeting.ietf.org.chopps.org (dhcp-9273.meeting.ietf.org [31.133.146.115])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.chopps.org (Postfix) with ESMTPSA id 375E17D08A;
	Tue, 23 Jul 2024 15:22:03 +0000 (UTC)
References: <m2bk2rx2lb.fsf@dhcp-8377.meeting.ietf.org>
 <593029.1721615874@dyas>
User-agent: mu4e 1.8.14; emacs 28.2
From: Christian Hopps <chopps@chopps.org>
To: Michael Richardson <mcr@sandelman.ca>
Cc: Christian Hopps <chopps@chopps.org>, netdev@vger.kernel.org,
 chopps@labn.net, devel@linux-ipsec.org
Subject: Re: [devel-ipsec] xfrm/ipsec/iptfs and some new sysctls
Date: Mon, 22 Jul 2024 07:29:02 -0700
In-reply-to: <593029.1721615874@dyas>
Message-ID: <m234o0w2ue.fsf@dhcp-9273.meeting.ietf.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha512; protocol="application/pgp-signature"

--=-=-=
Content-Type: text/plain; format=flowed


After talking this over some more with Steffen, we've decided to just remove the new sysctl's for now.

Thanks,
Chris.

Michael Richardson <mcr@sandelman.ca> writes:

> [[PGP Signed Part:Signature made by expired key 954CE156FDFC4290 Michael Richardson (Low Security Key) <mcr+travel@sandelman.ca>]]
>
> I think that:
> xfrm_iptfs_reorder_window
> and
> xfrm_iptfs_drop_time
> are parameters about receiving.
>
> While
> xfrm_iptfs_init_delay
> and
> xfrm_iptfs_max_qsize
>
> are parameters about sender stuff.. I think the names should include that
> indication.   "xfrm_iptfs_sender_init_delay" maybe.
> 1M byte default for max_qsize feels big, it's 1000 x 1K packets.
> I realize that isn't a lot at 10Gb/s+.   I dunno.
>
> How do you plan to get feedback on whether the defaults are working?


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJGBAEBCgAwFiEEm56yH/NF+m1FHa6lLh2DDte4MCUFAmafypkSHGNob3Bwc0Bj
aG9wcHMub3JnAAoJEC4dgw7XuDAl6g4QAIY6owKfhATBKxLjlQmThSlNdJtss/++
x9F1MewIayiRaZe0l7q70IULZe53SmN1ZjLxpklk7QihkqY/DxJ01z1Mcg+wJ00A
O154d/vaAI4lZm+D1gTrC8QkkJMTm7fnr3mcmMGHFfMy6hQgsB70yFF+6eVyylTM
v/4pY9i44cIifM3wl0K6lW+6395G5SDJEjzKYZJ+1ic1o8Ar1yDWfyXYIo0+moEZ
JwW7WYnjpPbmZAanE79vAu4sAWT/Eitoo5XIwbbNLF09B9PPWJyNXAkzwQhmBE3+
DcTKGdvAtg1I05d5OCCdCNM/MvMLE+C8SIUa1IbPNI+NL8nOOZrNUqc4toxdEFso
IhiH6Yiuk8vB0zAhct0lZ+/5AXMb6uXxFJJgabPFcc8JepEZFu20tnmVMQ2RX2CP
n++TR8uL7hTuWTxFqzm/Rksidx8CVajZj9QXEWh+AOLbxnBC1EXmQLNcZi9/C41/
vvwyVKkqx0UypI0EVG+LtdsxwFBRyLoxgQzeUBgQFQjvTPeJC+LcpTatuSuG4R4W
avA1oxw7QgBfSDuiMYMJnldrtr1+JXMsXC61YIfTWi8Ao9Heb9D/2babZbBrvo/j
Tx7Y/r+0jVhHM7ZxUDn4t0awDGzPsGw4IVUeNEANR9kbBAKcLF7Shu09XZm5s5Th
ge4KJtJm3aaN
=yZfb
-----END PGP SIGNATURE-----
--=-=-=--

