Return-Path: <netdev+bounces-268335-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gwWxGoCQuGkUgAEAu9opvQ
	(envelope-from <netdev+bounces-268335-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:21:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCDF2A1E65
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 00:21:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 102933040454
	for <lists+netdev@lfdr.de>; Mon, 16 Mar 2026 23:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D49372B2C;
	Mon, 16 Mar 2026 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUysy7PT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEBA33D512;
	Mon, 16 Mar 2026 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773703215; cv=none; b=A1DDoN7n3MZX8kWMHgWU4C2EeKz1ZN65i8X5H7S3k48Wap8okT3ch215I9ZTB3FToRRXtAHIzeu2chtttoztiR9eC1wvY/fzcO+YJgOsUN0+zDH3lTC4oyoKvxiUcMwOOQmXKWIDE3VJr5OPRaeA+ThKRCaCsqndysfKQz8/XRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773703215; c=relaxed/simple;
	bh=ngLPlTpHcItC/FgmPRd4XsiSQ26Qg1Kt1lDDC99DPLk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BBjZytpqkXhUDeMPe4NlrTiDQPnhUlQFmZY0Jyq4rZB4XBS5cFY4yQjY9aH5tw6TL3MeQpdDVwKbWi2TlVDayQs9IfNIqEJlxDaJlm2Lo7q1XQs5vSClNqFQufiqkogRy4OwABvJjUuhadVaAhwOG4JVqqh8fHY0fIEoFOdh9hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUysy7PT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8D6C19421;
	Mon, 16 Mar 2026 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773703214;
	bh=ngLPlTpHcItC/FgmPRd4XsiSQ26Qg1Kt1lDDC99DPLk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bUysy7PT/3AwxiBgsmJQsM8P+szwf4MJUbGgBwnD+L2inQ9rS5Egl36F8/xfz09TV
	 Zf0CnaewxsL/aOMknM4ABAU9n14owOkYVRpLXa+NW7x4KymSZDSE0VUOMCvgDKDPOF
	 ntQmyKQp3z5DlzPS22fNJ+D5UFIITnaDjrzj0Qccs4/dc1j/e8B8taXfEY9JCr9QmT
	 NajowZyMStNoU4pqFijnMdeJpRPryOLpXmNWvQzjV6P7em9q6JKg3ZBKWnsA3oiCaJ
	 sPTzEUvmyWVI1ljtNcoM6vtLszBoqP1f9qFqBJV9/5rGy8HLTp3XPMySO3JKTimVap
	 wXpUf0Yt+VVTw==
Date: Mon, 16 Mar 2026 16:20:13 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Paolo Abeni" <pabeni@redhat.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Vladimir Kondratiev"
 <vladimir.kondratiev@mobileye.com>, "Gregory CLEMENT"
 <gregory.clement@bootlin.com>, =?UTF-8?B?QmVub8OudA==?= Monin
 <benoit.monin@bootlin.com>, "Tawfik Bayouk" <tawfik.bayouk@mobileye.com>,
 "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>, "Paolo Valerio"
 <pvalerio@redhat.com>
Subject: Re: [PATCH net-next v2 1/2] net: macb: implement
 ethtool_ops.get|set_channels()
Message-ID: <20260316162013.5f8aa0c1@kernel.org>
In-Reply-To: <DH4CGZWQLUX0.17P120CM20SV8@bootlin.com>
References: <20260311-macb-set-channels-v2-0-982693a1f5fc@bootlin.com>
	<20260311-macb-set-channels-v2-1-982693a1f5fc@bootlin.com>
	<20260312182624.35ab61c8@kernel.org>
	<DH1R3P9TTPS7.1YE0XC8RTNTIJ@bootlin.com>
	<20260314075427.034097b2@kernel.org>
	<DH4CGZWQLUX0.17P120CM20SV8@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268335-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[15];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: BCCDF2A1E65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 16 Mar 2026 17:24:28 +0100 Th=C3=A9o Lebrun wrote:
> > Sorry for the delay. This code can only be reached from the IOCTL path.
> > The Netlink path will check that params haven't changed in
> > ethnl_set_channels() (look at the @mod variable) and return 0 directly.
> > So you're basically adding a discrepancy between ioctl and Netlink.
> > Not a huge deal but I don't envy any user having to debug this.. =20
>=20
> Actually, the IOCTL path also does the check (see below). So the
> `count =3D=3D old_count` check shall be dropped from the driver
> .set_channels() callback because it is redundant. Agreed?

Oh, even better! Some of the ioctl paths don't validate the equivalence
of the config but clearly I don't remember which.

