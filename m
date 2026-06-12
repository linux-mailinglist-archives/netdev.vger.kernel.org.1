Return-Path: <netdev+bounces-298508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id l1K2B7u8K2o3EAQAu9opvQ
	(envelope-from <netdev+bounces-298508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:00:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B16677964
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:00:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=wUw6lQzX;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298508-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298508-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 285E9316A016
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A3F366DB5;
	Fri, 12 Jun 2026 07:57:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71381175A8B;
	Fri, 12 Jun 2026 07:57:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781251031; cv=none; b=A8fvcVJyqZdBi7Q8IgwfW8G9rTDdhTU5zu2FAk/DMLcyNo5RHitY/JhPHJ6nIfXJbE9/0opwbnXCCfcFXXoJIEYxLjrrlSRS0vEdz9MIMha35b6bg2AQz2lB9WtM+5pcagw8v9wV44DPOg/k1WsasGChmcjSyZPdIGnMR+bz5Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781251031; c=relaxed/simple;
	bh=IExqj3AlBha4DwK4ZpHmpFko6xZPrhdbxVJsbfLB1Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DGDXGjqX3wNrzBKGwqdngH/CZz8x5JzqqtrRWxv6p+EhmiH53U5aTrmqj53iYLmbgnPXeX8UcKsAaTNvgrzZBipI37wHVhPbxXpx2rVhRUQ9HDWSjgtadr+Z9f72OiNyPMNlBV4fn77AwtxX5XkK/OgPbWOlK9yLyW7zG4KyEwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wUw6lQzX; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 15C9DC51469;
	Fri, 12 Jun 2026 07:57:05 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4FAC860012;
	Fri, 12 Jun 2026 07:57:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D0FDE106C85A3;
	Fri, 12 Jun 2026 09:56:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1781251021; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IExqj3AlBha4DwK4ZpHmpFko6xZPrhdbxVJsbfLB1Hs=;
	b=wUw6lQzXu+j9NabaFNmnj8BQqDMjM38WTyiDCZHgHEz0yZ0EugXsvTOI3eivzfdrJ8CAkB
	xjotDlNHi8AfmtHivdf0ARIbt3iOOr/X03QM9iwWEPQgpOcmQyqwYlEdjchYFJHLo7X7kK
	cAeDC8tU/3iIgM2qSofp9Um/JdIWz4t/Jb2QFRMU9y/4HA7Lmfc2i1h0UpM+0rQaG1Rekv
	ukZMycnyefrRmr14PbpZAQBQdoOCXxrsRuuWk88Ndjc8DT+/Egy6Hc+pNcBtqUJawKxPLo
	et7CQLwBhIxl+Xievy97MycyzsyAlQeyl0/zO/6xWqXie82I8OcFHgyILE7MdA==
Date: Fri, 12 Jun 2026 09:56:57 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Robert Marko <robert.marko@sartura.hr>
Cc: o.rempel@pengutronix.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: pse-pd: set user byte command SUB2 field
Message-ID: <20260612095657.76e76af4@kmaincent-XPS-13-7390>
In-Reply-To: <20260611102517.445549-1-robert.marko@sartura.hr>
References: <20260611102517.445549-1-robert.marko@sartura.hr>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:robert.marko@sartura.hr,m:o.rempel@pengutronix.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:luka.perkov@sartura.hr,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	HAS_ORG_HEADER(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kory.maincent@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 67B16677964

On Thu, 11 Jun 2026 12:24:49 +0200
Robert Marko <robert.marko@sartura.hr> wrote:

> The Set User Byte to Save command has three subject bytes.
> The PD692x0 protocol guides defines SUB2 with value 0x4e, while SUB1
> carries the NVM user byte.
>=20
> Template only initialized SUB and SUB1.
> Fill SUB2 explicitly so the command matches the documented layout.

Acked-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

