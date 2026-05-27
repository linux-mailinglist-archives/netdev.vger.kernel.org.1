Return-Path: <netdev+bounces-292325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4DNHNk4BF2p80wcAu9opvQ
	(envelope-from <netdev+bounces-292325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5A85E5F61
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 16:35:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 648933016834
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C70038C43F;
	Wed, 27 May 2026 14:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="qxuU3iOT"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D8533557D
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 14:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779892487; cv=none; b=QUIuM90D8Ufmr+PtOX7v+woY74x1kHImwmd1DjvY2/zzIItPQGzHgTuXbb3g1vg7+BtjZXrBNLPfqGAnTE3DajtRzDJkWiZeiilUdMZmGfD2ybfnQadcOUp193YvsVyPwa7RbfTK4f/iCi4+D/NNptZ0IFHagOqalMY2UpoU+WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779892487; c=relaxed/simple;
	bh=LNjpq5LQPl59zzcpbWaGnUd1c++eWT0GL0wfvz0D2A0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lpq4dvD78ax5ycbZUXjfwkAoUTzocuvaW4s8cAAvU4eO8sdt78D+zppF22ryMTaGcS5cDjVz/TX7DKAIIIxLB/9bfBhJj7pE0jPX3CyrGnGXKt/F8HjG8TTx31S0QGom6wA1xjUzvidSYDE1TYA4CtTdVgxfl5MVb5ArCPfqYs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=qxuU3iOT; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 10CD8C2AC00;
	Wed, 27 May 2026 14:34:38 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 11E16601A1;
	Wed, 27 May 2026 14:34:38 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E0973108884EF;
	Wed, 27 May 2026 16:34:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779892477; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=LNjpq5LQPl59zzcpbWaGnUd1c++eWT0GL0wfvz0D2A0=;
	b=qxuU3iOTEfprd/+Tf2tBGuAFoACdYzIhDsnym1SAq7i85ThLNsJzb7uziw+4H3aDb4ThIf
	1gTa8SiVmlkCEqleyu8uG73V8qEQDAs8Ygw5d3sf3G5SA1ZsyPU0xW2wSNQt/5ihdISQge
	S+Obnm0ATU16Od6NDYOAAXNlXkUuiVYHzz60kelTtXN2FKeBIasF2HugJf2Aj687Fg3wic
	AtZBoCBX9k7yzLBRe2iIvbrtmWBny1lPtbVqfyYXUkJIiavnH+gB9WKdSvTtwx4yDbEcyN
	waDtmRrM0BzeZkPs/smf/TAJ0sGMBXztmOlf7ahglY3z5oCRherVqbb1mPKbXg==
Date: Wed, 27 May 2026 16:34:32 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 o.rempel@pengutronix.de, maxime.chevallier@bootlin.com,
 haiyangz@microsoft.com, andrew@lunn.ch, vadim.fedorenko@linux.dev
Subject: Re: [PATCH net 05/10] ethtool: tsconfig: fix missing
 ethnl_ops_complete()
Message-ID: <20260527163432.72ba1420@kmaincent-XPS-13-7390>
In-Reply-To: <20260526153533.2779187-6-kuba@kernel.org>
References: <20260526153533.2779187-1-kuba@kernel.org>
	<20260526153533.2779187-6-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-292325-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,bootlin.com:email,bootlin.com:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7A5A85E5F61
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 26 May 2026 08:35:28 -0700
Jakub Kicinski <kuba@kernel.org> wrote:

> tsconfig_prepare_data() calls ethnl_ops_begin(), we need to call
> ethnl_ops_complete() before returning the error.
>=20
> Fixes: 6e9e2eed4f39 ("net: ethtool: Add support for tsconfig command to
> get/set hwtstamp config") Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

