Return-Path: <netdev+bounces-253633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id nEAJHagHeGntnQEAu9opvQ
	(envelope-from <netdev+bounces-253633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:32:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A6BA8E7E2
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 01:32:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 201DA3006479
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 00:32:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CEA156236;
	Tue, 27 Jan 2026 00:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lVf2ImBy"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EAB38FA3;
	Tue, 27 Jan 2026 00:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769473956; cv=none; b=UnimRtKwNebrWIVrmCL5k5xlcLLyBeJ7BMNnDqa39kCIwZwqHsixWrart2pMd9wPAMH9eJKS6mjtt7OhEYD2NPzZ5dpspe4pKjhi/wbLT9H0HzHIz7gD06XRx9t616zm+1FqIfFwyHHWJaSuhlV7WbkG+D/4rw7Nyq6NJQjEVXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769473956; c=relaxed/simple;
	bh=0H3mcYtLkoimfh59Ktyvf7h4R2eDIiT8HXaTVTxM8+M=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ibVavHpzw9zMrXH6/37aBd4r4PKqDSkISMZoN8AFWXnL2unCsjyUtjwUHD+ryPdlibXjkCc2MxAZ48oWUG6+BUBC1b4SlHoTF3OQXDe7HhYzo4vJ/nEDHWwpfgNH/d1Z8Qj4EqAd/nm8tytsaMdbNxF7zMFFTnjdRl6JSxkOOlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lVf2ImBy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1769473946;
	bh=0H3mcYtLkoimfh59Ktyvf7h4R2eDIiT8HXaTVTxM8+M=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lVf2ImBywBa+k42XkU+DqPsa1yMlILXzb8z87z9p2bLEvciuHd+VapIJxFqDJ9a04
	 UbJH1lG/dtJbR+kbgCnN3ILfAPGoBjKdDE6G6q7NnmKLeb6Kf2ji+fyln/TKOrvByn
	 Jgeu6KNxsnR+KT3Wn/VcwZGWdc7UQHfWJMfPbi1a9lt2rKKEfqpBy3ku8Jj44J/ZtF
	 Q/aOvC5Ail2Jqp56tlwNI6XFEPySDO52ZIYKyfq8IncNVOSyhFtgwKoyrrM8iHBsBb
	 lqlmM/9mEAiX4Rms5Lx14QG9nbUg18FIZOWTU3FKub/pNfElXiZp1n57TiDFIAfXR0
	 k1LRM9n14Fcyw==
Received: from pecola.lan (unknown [159.196.93.152])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 2B9B864704;
	Tue, 27 Jan 2026 08:32:24 +0800 (AWST)
Message-ID: <6ca4bc87620bb0c2e5bfb264ec88189f32b53757.camel@codeconstruct.com.au>
Subject: Re: [PATCH v2 0/4] i2c: SMBus ARP support
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>, Matt Johnston
 <matt@codeconstruct.com.au>, linux-i2c@vger.kernel.org,
 netdev@vger.kernel.org,  linux-kernel@vger.kernel.org
Date: Tue, 27 Jan 2026 08:32:24 +0800
In-Reply-To: <aXdyll4KVOF6SWni@kuha>
References: <20260121092328.2308705-1-heikki.krogerus@linux.intel.com>
	 <30ad166e2b3d7f10080356ec232e604f3ac9ea2e.camel@codeconstruct.com.au>
	 <aXdyll4KVOF6SWni@kuha>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2+deb12u1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-253633-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jk@codeconstruct.com.au,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[codeconstruct.com.au:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,renesas];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A6BA8E7E2
X-Rspamd-Action: no action

Hi Heikki,

> Since we use kernel mode device drivers, we need the kernel device
> instances (struct device) that bind to them. If you want to deal with
> user mode drivers then you can always do that with the i2c-dev
> interface, but then you will not be using the kernel drivers such as
> the mctp-i2c.c in this case.

Sure you could - the userspace ARP implementation would be responsible
for binding an existing kernel driver to the newly-allocated dynamic i2c
address - say, through the new_device interface. The choice of driver
would typically depend on the enumerated UDID.

> But just to be clear, this is not only
> about MCTP. The ARP-capable i2c-clients can be anything.

Yes, I'm not just talking about MCTP here either.

> So even if you still want to scan the ARP-devices in user space
> separately, the kernel must enumerate those devices independently in
> any case.
>=20
> I should also point out that to my surprise the i2c-dev interface
> (I2C_CHARDEV) isn't always enabled, even when I2C seems to be
> otherwise fully supported in the kernel. We simply can't assume that
> it's always available.

I don't think requiring a specific functionality to be enabled would be
a showstopper for any particular implementation. We need CONFIG_I2C
already, why is CONFIG_I2C_CHARDEV any different?

Cheers,


Jeremy

