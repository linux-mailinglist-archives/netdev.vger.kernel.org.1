Return-Path: <netdev+bounces-292324-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id FUrdOoUAF2o70wcAu9opvQ
	(envelope-from <netdev+bounces-292324-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:32:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E97CB5E5EB9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1E5D6300AD7E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 095313644C3;
	Wed, 27 May 2026 14:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UebdHEc1"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791473644BD
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892352; cv=none; b=IWOAwLMj4YuSeLgf1q9sN49lTPQCHOfrlsYgh/hv5pPzBbtwhWzotdAtd87NnTafJCuC/G4D0/ziSjKt/6ZZkWHG3SVw6t1bP4l98aDHlUa44cH+Ecen36lmq73xcAyYSa2g3uGfptGm3eyLdPn3p0lYAb/nAee81Erbz95usnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892352; c=relaxed/simple;
	bh=IXrdLC0COOQgjL1CHKEs9Wz6AquS3/8HjxeC9No0Oh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qwFYo/QcV+vPOxsI4Q5/H0JyPAK7g3HODaEiCSAMoBcQJZulG6HEgb/wTcXjUaq5rI6PGYNQdTjnz/9GTqnKZxL566JR3QUqYo0zQFOIAPoSqBtBqI/iYBbXVSJXtL7GAj6cG80i/wb3uGaM9m7oyIed1S0XuqDo9yAqdP63tXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UebdHEc1; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 8E29A1A36ED;
	Wed, 27 May 2026 14:32:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6052A601A1;
	Wed, 27 May 2026 14:32:27 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 69916108884EF;
	Wed, 27 May 2026 16:32:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779892346; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IXrdLC0COOQgjL1CHKEs9Wz6AquS3/8HjxeC9No0Oh0=;
	b=UebdHEc1gUxYPSOS0pJLxXkXyDY3U2HzveymAPiHKExIjy/uK9rr1LTNVfIX2XD5Q6PAPN
	GsH+ASGwZ0fhXw34showmI95DDZxsi6q8uyRzdTOhdxgvOBRv4lEfB9jDqO/pQ/uvEgJhL
	O//lg3Xl3ioY3/csWRcwVrnU30Je+qDYt1dBdnlSa+Hsjan4gYN1x1wEo0kbX5vhm1RML3
	GEgQ91uEJtlvxdFc3eO/XgHJtwZ3pf+LGx/nYcZ1n3E1faYnONcXbsKiS/G0M/QxbwvlkH
	ccu9VNRlVFKWYVMz5Gpk38wMzd7Nq2WTqe24NsixY+9r1N3ePq+oOnQcrmRZHw==
Date: Wed, 27 May 2026 16:32:12 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, maxime.chevallier@bootlin.com,
 haiyangz@microsoft.com, andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net 02/10] ethtool: tsconfig: fix reply error handling
Message-ID: <20260527163212.6d3a3bc0@kmaincent-XPS-13-7390>
In-Reply-To: <20260526153533.2779187-3-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
	<20260526153533.2779187-3-kuba@kernel.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292324-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:email,bootlin.com:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E97CB5E5EB9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 08:35:25 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> A couple of trivial bugs in error handling in tsconfig_send_reply().
> If we failed to allocate rskb we need to set the error.
> If we did allocate it but failed to send it - we need to remember
> to free it.
>=20
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to
> get/set hwtstamp config") Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

