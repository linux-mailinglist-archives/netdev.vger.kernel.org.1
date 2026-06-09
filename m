Return-Path: <netdev+bounces-296851-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id KtYkFHZ1J2poxQIAu9opvQ
	(envelope-from <netdev+bounces-296851-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:07:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B541165BCC8
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:07:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Qzob7YTg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296851-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296851-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEB15301F33D
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD54313E34;
	Tue,  9 Jun 2026 02:02:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39C51C862D;
	Tue,  9 Jun 2026 02:02:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780970571; cv=none; b=iMve75GnLGVh4q7tnHEY70lrsThC3GRWLUiFWdgQIDOMfYKqPGYFewXLBgbBs8ws2clrDJQdnoIE7Hpa5+MAMStgIHA9rAsAo+5tx/EzFPifzv/HQeLRkItT6dZLP+8G196194qg0xXlKTJimVVuOXaenEViczar0F7ntbxvSWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780970571; c=relaxed/simple;
	bh=4DLg5vFKr/MdOkVPkyqAhn7lKmQqQs6z0SssMQO3OBI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TtJJIFZiIh4M6R1B236CoCaNsh+akH6dCJ+C9L95ktZut2jE28CfSizjb94GQlINqzdKU5ZUO5P/w+rg854i4Wjk007WhgTr2UDulc5llEVCFThv6Yko29TbcXxYcpdwGnwfKKmxN+tE40KNKdC2ZopR7xJor6Fh4jxVyHfdyRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qzob7YTg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AC31F00893;
	Tue,  9 Jun 2026 02:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780970570;
	bh=ZFfblUl+2BQQI/iDMzj3upvP5Re2fQBphQvxi0LqbQE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Qzob7YTgxwW1JDklJPVBuLx+oULb2gpMzIrmnXRlsSQyEDsu9pwIO0/0gU/BX6RqP
	 2dbYELUdDToLqw9IrIXfwgbnPwLXKKxsfv62BCaelmjiBg+QSbAFwIpJ3G14SZXc88
	 aClmZfCbakeN9+f/6IHG46yJCeuhINtqx6niWnBf88hh970TndGFgeXYFAmkDAW/EP
	 jkpnwjQ8p+ex43DkxbbXHKBm2a2atEHVq7BtW4XjHji+1GZMpL936y09Hqae/Jghhq
	 n5wLuMDcRcvcEAuTita/JgWRkN4TQe2sUNKMFMAmVdeCEqL7q6CwPB6nGZNPYs8IM6
	 NwZq6nTs/bduw==
Date: Mon, 8 Jun 2026 19:02:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
 <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <20260608190249.03f4d6e7@kernel.org>
In-Reply-To: <aidvzJEXmeS6Wuz7@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
	<20260605063245.3553861-2-rkannoth@marvell.com>
	<20260608154014.1b7c8be1@kernel.org>
	<aidvzJEXmeS6Wuz7@rkannoth-OptiPlex-7090>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296851-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,gmail.com,google.com,kernel.org,resnulli.us,redhat.com,marvell.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:donald.hunter@gmail.com,m:edumazet@google.com,m:horms@kernel.org,m:jiri@resnulli.us,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B541165BCC8

On Tue, 9 Jun 2026 07:13:40 +0530 Ratheesh Kannoth wrote:
> On 2026-06-09 at 04:10:14, Jakub Kicinski (kuba@kernel.org) wrote:
> > On Fri, 5 Jun 2026 12:02:37 +0530 Ratheesh Kannoth wrote: =20
> > > There is only one admin-function PCI device per system.
> > > Reject any additional AF probe with -EBUSY so the driver model matches
> > > hardware and automated reviewers can rely on a single bound instance.=
 =20
> >
> > Could you point me to a PCI networking driver written in the last two
> > decades which would have this sort of limitation?
> >
> > At the very least you need to explain in the commit message **why**
> > correctly handling multiple devices in a system is beyond your
> > abilities. =20
>=20
> The comparison to a generic PCI networking driver isn't quite applicable
> here. The RVU AF (Administrative Function) is not a standard NIC PF =E2=
=80=94
> it is a system-level resource manager that owns a single, shared set of
> AF registers across the entire RVU subsystem. The hardware spec is
> explicit on this: "RVU has a single, common set of AF registers.
>=20
> This is fundamentally different from a multi-port NIC where each PF is
> an independent, symmetric instance. In the RVU model, there is exactly
> one AF device per SoC, and all other PFs  communicate with it
> via mailboxes rather than accessing AF registers directly. Allowing a
> second AF probe would mean two driver instances racing to manage the
> same global hardware state =E2=80=94 provisioning LFs, configuring
> NPC/NIX/NPA =E2=80=94 with no hardware arbitration between them.

I asked you before - is this a driver for a PCIe devices?
You said "yes". If so what prevents the user from plugging two such
devices into one system?

