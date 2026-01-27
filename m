Return-Path: <netdev+bounces-253945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UM5gCNvveGkCuAEAu9opvQ
	(envelope-from <netdev+bounces-253945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:03:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6729820F
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A93B83036B64
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 16:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF893559E4;
	Tue, 27 Jan 2026 16:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YWk6gscj"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17C1221FB6
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769532675; cv=none; b=YgjAgXix/tPCBgTJjri9VJm8jdQVWXQ4Wb3Ld/2xsflYnHWPfeed9DqbRz82HMuj8TAwRkSHlCQz5P/6BJbF2yPss9amL7vUCAy1WsqIQTsDijfkIasN9H7aKwQhgqBJWasAeTfF7AdOoKhXBgZ6DTspNzzzcvdhsXMd9wJYB9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769532675; c=relaxed/simple;
	bh=MiXiUIs2ptSQbYwUZ2qbvhUhqOFqhMYho0KH0pV7c44=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DEqRMlLhU3ly4Acka88veYgBBhB7YE4L634HHfjUq6W7soclyh4lqF7KOetwOz5+le2wBkoQp7p8Yu/r0t8ZuCumbr/MUh0x0K5R9JSsmfXUMrbiryEPFop+kU9vFI5OCx5AJhwLnhwvSSjgUPi9WIlt80gHIyCmqXNgrqxlvjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YWk6gscj; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id BDCD8C211C6;
	Tue, 27 Jan 2026 16:51:12 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92292606F5;
	Tue, 27 Jan 2026 16:51:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ADF27119A8695;
	Tue, 27 Jan 2026 17:51:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769532669; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=MiXiUIs2ptSQbYwUZ2qbvhUhqOFqhMYho0KH0pV7c44=;
	b=YWk6gscjerrfJ1VRAL1zMsEgeqjk/egmEJXkM2NUUxCw7gkEKbMEazVLkUeITYTKGP18M3
	YSqhz2pwQ94+UQme/1n1yimxtaJnhub1jbvbDpfWTzLnlS9+jpKOFjlAlyCaopWFhP4etH
	eLkL4urNbcTY7oD8iCCsL35dgvweV4lYJK8JlMITgfnNXZ4XOhj9seoi9hu8YN3X0i76UE
	iFedursQdHqnuOUINa0KEQGyw4LuKAPb67qzZg2P+OF0/52eWUNdnlwwdKZTKdHYYP0zvI
	ukTr+G197sTAVbUU2Nr/n9To6oUL211VBw93stGjQCbrqxwX6LXhhdDjNNcXDQ==
Date: Tue, 27 Jan 2026 17:51:03 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Zilin Guan <zilin@seu.edu.cn>
Cc: horms@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, jianhao.xu@seu.edu.cn, kuba@kernel.org,
 linux-kernel@vger.kernel.org, marco.crivellari@suse.com,
 netdev@vger.kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net v3 1/3] net: liquidio: Fix off-by-one error in PF
 setup_nic_devices() cleanup
Message-ID: <20260127175103.19831bd5@kmaincent-XPS-13-7390>
In-Reply-To: <20260127151241.1144039-2-zilin@seu.edu.cn>
References: <20260127151241.1144039-1-zilin@seu.edu.cn>
	<20260127151241.1144039-2-zilin@seu.edu.cn>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-253945-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[seu.edu.cn:email,bootlin.com:email,bootlin.com:url,bootlin.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE6729820F
X-Rspamd-Action: no action

On Tue, 27 Jan 2026 15:12:39 +0000
Zilin Guan <zilin@seu.edu.cn> wrote:

> In setup_nic_devices(), the initialization loop jumps to the label
> setup_nic_dev_free on failure. The current cleanup loop while(i--)
> skip the failing index i, causing a memory leak.
>=20
> Fix this by changing the loop to iterate from the current index i
> down to 0.
>=20
> Also, decrement i in the devlink_alloc failure path to point to the
> last successfully allocated index.
>=20
> Compile tested only. Issue found using code review.

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

