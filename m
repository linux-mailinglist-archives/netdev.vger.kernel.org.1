Return-Path: <netdev+bounces-292489-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0P18IziPF2oUJQgAu9opvQ
	(envelope-from <netdev+bounces-292489-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:41:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E31965EB4B8
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 02:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 684E63010C36
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 00:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2731917CD;
	Thu, 28 May 2026 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZ8HaB4T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF918DB26;
	Thu, 28 May 2026 00:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779928573; cv=none; b=NMmWbt4xGj7L9jTGSjfzOauouWd4NwxnS1pKdzAsdI4C+/eoTHyCAAIJDuIJ6B70IcFypAfhSMa7wZdxUWlFsnvVtKKvylhK3kt+ZSmU6IGmf9RW/Jj2oe+UDQce/bwDSBG9jtWRKLw5L0nYPG4POPcHQj6V1lZ+dSVjN4v9ptI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779928573; c=relaxed/simple;
	bh=mYVca3FZPB0gt2uk1hx49vfFInh5ZueWSY16U5I9L4w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHApa605Zg79I6/v3zRfANi+sL4/qLicwqQOvyhpaPb6hDV1t+irXB2CWZIXUONVf1So4tgY+TYCgE9beNTKj3Fy8n4DFsLKNmr8dfILkXkUR0UUTzirAm2s2+1y9Gvtam+7O8pH314mtOcxEi8Tbu3E9j6cpoIrZx9PlUvy5fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZ8HaB4T; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754171F000E9;
	Thu, 28 May 2026 00:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779928572;
	bh=mYVca3FZPB0gt2uk1hx49vfFInh5ZueWSY16U5I9L4w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AZ8HaB4TZUtRQ0kSQ8iqNdj5ztNB8q9/8pkitIP/IkUEpOHrPuDLFARtER0HGb556
	 lEXy3fuXq4mcRoq5P34Fw630YyIuDuPcfdIG1Xt6J4+fAIrVuGLJxJfqtaGJBDPI6o
	 GU7SO3FQR3r112v2kyk6hPvkrHqvfOuNPGOkm8vdR20TyLr7AimbDyKYeqPpcpP1S3
	 fuhGnCg/1hoqsi/36QwGKdaTlHXEOX3OZhby/0xgvSkHVn6uMvZFT4DZXiT+rvItC4
	 n5iijb7me1yZg/LvkN82AjTZyVxeKOzwSfMPZNekNdnBHFp9/MhTXZ2MAs6/Hnbsst
	 2ki3C49Z/9MyQ==
Date: Wed, 27 May 2026 17:36:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yury Norov <ynorov@nvidia.com>, Abdulkader
 Alrezej <abdulkader.alrezej@gmail.com>, Mieczyslaw Nalewaj
 <namiltd@yahoo.com>
Subject: Re: [net-next PATCH v8 5/8] net: dsa: realtek: rtl8365mb: add VLAN
 support
Message-ID: <20260527173610.5cd14e85@kernel.org>
In-Reply-To: <20260525-realtek_forward-v8-5-5eb80a4675be@gmail.com>
References: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
	<20260525-realtek_forward-v8-5-5eb80a4675be@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292489-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org,nvidia.com,yahoo.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E31965EB4B8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 16:48:01 -0300 Luiz Angelo Daros de Luca wrote:
> + * rtl8365mb_vlan_port_get_pvid - Retrieve the port PVID
> + * @priv: realtek switch private structure
> + * @port: port index
> + * @pvid: pointer to store the retrieved VLAN ID
> + *
> + * Returns the port PVID if defined or 0 if not.
> + *
> + * Context: Can sleep. Takes and releases &priv->map_lock.
> + * Returns 0 on success or a negative error code on failure.
> + */
> +int rtl8365mb_vlan_port_get_pvid(struct realtek_priv *priv, int port, u1=
6 *pvid)

Warning: drivers/net/dsa/realtek/rtl8365mb_vlan.c:686 No description found =
for return value of 'rtl8365mb_vlan_port_get_pvid'

Personal preference but IMHO use of kdoc on international driver
functions is plenty pain for little gain. Maybe y'all use more advanced
code editors or such that makes this useful? For me it's just lots of
unnecessary metadata and kdoc warning risk, where a normal comment would
do just fine to convey the information =F0=9F=A4=B7=EF=B8=8F=20

Rant over, your driver your call.

> +/**
> + * rtl8365mb_vlan_mc_find() - find VLANMC index by VID or the first free=
 index
> + *
> + * @priv: realtek_priv pointer
> + * @vid: VLAN ID
> + * @index: found index
> + * @first_free: found free index
> + *
> + * If a VLAN MC entry using @vid was found, @index will return the match=
ed index
> + * and @first_free is undefined. If not found, @index will return 0 and
> + * @first_free will return the first found free index in VLAN MC or 0 if=
 the
> + * table is full.
> + *
> + * Although 0 is a valid VLAN MC index, it is reserved for ports without=
 PVID,
> + * including standalone, non-member ports. It uses VID =3D=3D 0.
> + *
> + * Both @index and @first_free will be in the * 1..@RTL8365MB_VLAN_MCMAX=
 range.
> + *
> + * Return: Returns 0 on success, a negative error on failure.
> + *
> + */

nit: extra line at the end here
--=20
pw-bot: cr

