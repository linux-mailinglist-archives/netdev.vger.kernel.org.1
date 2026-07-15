Return-Path: <netdev+bounces-307630-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /ELgHWvYVmqPBwEAu9opvQ
	(envelope-from <netdev+bounces-307630-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:46:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A36759BEF
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 02:46:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=codeconstruct.com.au header.s=2022a header.b=ey2tITGX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307630-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307630-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=codeconstruct.com.au;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7AFE7300C001
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 590FE245031;
	Wed, 15 Jul 2026 00:46:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDB41DFDA6;
	Wed, 15 Jul 2026 00:46:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784076393; cv=none; b=qIbfSfUx5CMNBk2hj0Wh9GFkbQSHS3tqntLxzoE5wNFfiOoOwFcYzR+Ub0i2GnmPZbdPiL6us3WohkUXT+n5WpQky0p9IWAYuODN90AQ5907V0rvNCGekK7xxWAfUhAJttUtVoa8h+ZPIuSn0XVPB1p3p4adHS7+HXbeR3ic7kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784076393; c=relaxed/simple;
	bh=vrU8XWqCCLlTgcu8j2goqUAVFTIQgOYH5R+PXb9k1h8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KMHw+vaoSNxVV6i2UYVLH2YFMt8BQ+OHDjMCkECzUIHqTp0JnI9QtnKsea5q4qlnBhqgnRwY1z1oYbbL8mLWHR2tnAY6PDJd3MnRzwHafJDCDORpQMaS1NALWuriMJsPwu1QGa9kzKCnw0QT7ASKhrO5SfJl9iUNqMEbtvHya2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=ey2tITGX; arc=none smtp.client-ip=203.29.241.158
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1784076384;
	bh=vrU8XWqCCLlTgcu8j2goqUAVFTIQgOYH5R+PXb9k1h8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ey2tITGX4ubuFKK63MioBZjAjwz8gaY1Fcc05+LSklFdX8eXGHcUaiYaFOiDp/QTa
	 jdPpm82ERFDQwpM8G5DG7Ts1XqZgAgFXPvKALMn1eS7Id0l0ATABJ7loBEjIyIiYVN
	 6911Ussmdv5EcLlNl+jPmOyuEpFhMZ1fNVHJdAUXSlKi5mNCeh8fNKKDFZkMcoM53X
	 dpF1L0EQX/HR1ESIQOn3PRAeiJ5Y0v9xVYZU/KVz2xvqzqwv8fU5Ry45tUuv5G0aDf
	 +WGZiJXfTC2kEvxmFbk1MsPZvt+cAmhrXm9WdeirMB6ubbyBP7wt/IbB++wQ9cQNdz
	 TtHK+EonYw5gQ==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 382F4655A4;
	Wed, 15 Jul 2026 08:46:24 +0800 (AWST)
Message-ID: <1708246e17ce72f3b30d77ccb54d79b8d0909a8f.camel@codeconstruct.com.au>
Subject: Re: [PATCH net] net: mctp i3c: clean up notifier and buses if
 driver register fails
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Myeonghun Pak <mhun512@gmail.com>, Matt Johnston
 <matt@codeconstruct.com.au>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 	linux-kernel@vger.kernel.org, Ijae Kim <ae878000@gmail.com>
Date: Wed, 15 Jul 2026 08:46:24 +0800
In-Reply-To: <20260714081025.89163-1-mhun512@gmail.com>
References: <20260714081025.89163-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[codeconstruct.com.au,none];
	R_DKIM_ALLOW(-0.20)[codeconstruct.com.au:s=2022a];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307630-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mhun512@gmail.com,m:matt@codeconstruct.com.au,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ae878000@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,codeconstruct.com.au];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09A36759BEF

Hi,

> mctp_i3c_mod_init() registers the I3C bus notifier and then walks the
> existing buses with i3c_for_each_bus_locked(mctp_i3c_bus_add_new, NULL)
> before registering the I3C device driver.=C2=A0 If i3c_driver_register()
> fails, the function returns the error directly, leaving the notifier
> registered and every mctp_i3c_bus object created for the existing buses
> allocated.=C2=A0 The notifier is left pointing into the module that faile=
d to
> load and the bus list is leaked.
>=20
> Mirror the module exit path on this failure: unregister the notifier and
> tear down the buses that were added before returning the error.

Looks good, but we probably want to remove the unneeded
i3c_driver_unregister in the notify registration failure path too.

Also, you're missing Horms from the CC; more out of curiosity, but
how did you generate the CC list here?

Cheers,


Jeremy

