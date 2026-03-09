Return-Path: <netdev+bounces-265416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBTbOTaLrmmzFwIAu9opvQ
	(envelope-from <netdev+bounces-265416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:56:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5BC235B98
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 09:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A7E43300DCE9
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 08:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE9736EA9E;
	Mon,  9 Mar 2026 08:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XbDj2xhy"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF91636E484
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773046574; cv=none; b=mlZGVt3ixb645jd/EO1Q+np9iAxswPlFYINxFCdc63pp8XDvssEDjtAIpdaO+3QLVZGkIFEyZ5qF+VyTpzuXfvpEHi3u/EZ07z3Go3o5wBnafI7h3mkQ0UZQfb9PN3stQIMOdYoh2qrRoVF2q4sT1FqoAjJwz0vMOSzSAprhh8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773046574; c=relaxed/simple;
	bh=11tlPpTwnFTyOQw1wgwUs3kQCRJtAAlwuHiVJT4IYFY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OaiprOFkOWA/s7/p0kF1f+8iUkxJemgiy3m6W4uu3lQeP3u8TNmqUqqgm2hRtS/WCi7WxSdoPXNnPhnEftw0yVUO3259RzcKsS4eN1h67IL08qzz9kegTGAO5MkeimL5OZllpjIE7GYdxg6vBJ55Wi3JUTR8NJO7r5tlXQp/KJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XbDj2xhy; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DD1EF4E425DC;
	Mon,  9 Mar 2026 08:56:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B05405FFB8;
	Mon,  9 Mar 2026 08:56:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3EAB710369ABE;
	Mon,  9 Mar 2026 09:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773046562; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=11tlPpTwnFTyOQw1wgwUs3kQCRJtAAlwuHiVJT4IYFY=;
	b=XbDj2xhy9DohxFWLd7waC1Pmlf92tPz5ciU2e1nwLgwpnzjErvemmxcSPrHEka60r0Zl4Z
	T29OUXg5Mj5oUPNNOuTlVKC0NXdXBf7kTxUa5vnggUT77vnn2MoF1IYtprC3R0H4phjbXT
	xVPEiqHSDhFw7eJqYpXWYReS9wpwxGasU6r0ZwFy8hjdPpEzU5yKxbjPQxGpv+015Szo5A
	/0FE83ZUlKsm6pOS/hWSCA2Hxxm6/BTw97BSwuG31Z9iC1im0chItp6D/JWy6Mf80+lDCt
	1hdSPMZa7+Lnf2BB2Kpyd5rE+NTjrloHl1NMIU2keGrAx3g8bAMT+3EqQPUMJg==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Johan Hovold <johan@kernel.org>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>,  Alexander Aring
 <alex.aring@gmail.com>,  Andrew Lunn <andrew+netdev@lunn.ch>,  "David S .
 Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,
  linux-wpan@vger.kernel.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ieee802154: atusb: drop redundant device reference
In-Reply-To: <20260305104313.15898-1-johan@kernel.org> (Johan Hovold's message
	of "Thu, 5 Mar 2026 11:43:13 +0100")
References: <20260305104313.15898-1-johan@kernel.org>
User-Agent: mu4e 1.12.7; emacs 30.2
Date: Mon, 09 Mar 2026 09:55:57 +0100
Message-ID: <87h5qpgz4y.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 8A5BC235B98
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[datenfreihafen.org,gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265416-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miquel.raynal@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.998];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:dkim,bootlin.com:email,bootlin.com:mid]
X-Rspamd-Action: no action

On 05/03/2026 at 11:43:13 +01, Johan Hovold <johan@kernel.org> wrote:

> Driver core holds a reference to the USB interface and its parent USB
> device while the interface is bound to a driver and there is no need to
> take additional references unless the structures are needed after
> disconnect.
>
> Drop the redundant device reference to reduce cargo culting, make it
> easier to spot drivers where an extra reference is needed, and reduce
> the risk of memory leaks when drivers fail to release it.
>
> Signed-off-by: Johan Hovold <johan@kernel.org>

I'm not qualified enough to judge how useful that can be, but on the
other hand I don't believe it will hurt either, so:

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l

