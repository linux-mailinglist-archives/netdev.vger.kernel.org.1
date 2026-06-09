Return-Path: <netdev+bounces-296870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gYGgLXZ9J2q/yAIAu9opvQ
	(envelope-from <netdev+bounces-296870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:41:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4924565BE16
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 04:41:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=R+zWSmjB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296870-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296870-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3CAEC3081565
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 02:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D226352C2C;
	Tue,  9 Jun 2026 02:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FA2343887;
	Tue,  9 Jun 2026 02:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780972914; cv=none; b=GYi9aV+CEhpxrWnwCh/rpifpJFH8qL9YhD0HoCBHka7IswyuVd17kk/2A5GX4vVZecQLlrw0lRzurUcWFki6O5VGVjqCgBsCkSswVEnrgwUWpZTsiwrg6X8llNO8/SSV86DtjTDUO7knePblxxldhvsMCbTTVjHDqc7c/uZl0qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780972914; c=relaxed/simple;
	bh=Yinc8Z6nz7JrkNw6g5NNSBc2mJ3Wa8GzqyKhPJlBJMA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h63+7CzcOGOqD6fGraze6V3RuAaJCOBOXzD7UePUOr7tYDAgzDonkldFsS/x/6OYlpVTnrgNJAUQzT5xfUWQg0X9q+TJ9h0NbZNORO2c9ctayLwzNqGTExcZ4RztNiBUliA21q1anGlBY/fD3NHmQcjQLY+he5ZhmmZztgOFAWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R+zWSmjB; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A6A51F00893;
	Tue,  9 Jun 2026 02:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780972912;
	bh=q6nBSDH5JWF513kr1X7pmkfnR0SmWvqc0sieCQ1Li3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=R+zWSmjBbSdHZ2DFU7ZE9ZdJpw8iK021SAqTvagutHC3+QkRPcNdLEacxbaz+2grG
	 i1UScQyRHbn/BzQ0YJCqHNYlTyfep30pNT9WF3N+jFsJB7BaKelDEXFLdTJXJ1CAGe
	 VueVpbsGtb4xJpHJW3KCDL8QpX/uLATBAucu+4Y72X0QPug9gxou8YNZvl8o0+NZnT
	 mvORoFT/friRfSbxZ2RATmavuh9HNBhigCmTn2EUJknGCkWkRTO/vQ9BOCvrMUfBqJ
	 k2nADoLqvOyh5r4z+PaXKQ0vTwGXgKQH0QgbwYPAgv+e4WEmRbglgU1jZieb40TNWv
	 Esd4E5n/dUIZA==
Date: Mon, 8 Jun 2026 19:41:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
 <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <donald.hunter@gmail.com>,
 <edumazet@google.com>, <horms@kernel.org>, <jiri@resnulli.us>,
 <pabeni@redhat.com>, <sgoutham@marvell.com>
Subject: Re: [PATCH v19 net-next 1/9] octeontx2-af: Enforce single RVU AF
 probe
Message-ID: <20260608194151.7535b2f7@kernel.org>
In-Reply-To: <aid55liiG7bcuZ3f@rkannoth-OptiPlex-7090>
References: <20260605063245.3553861-1-rkannoth@marvell.com>
	<20260605063245.3553861-2-rkannoth@marvell.com>
	<20260608154014.1b7c8be1@kernel.org>
	<aidvzJEXmeS6Wuz7@rkannoth-OptiPlex-7090>
	<20260608190249.03f4d6e7@kernel.org>
	<aid55liiG7bcuZ3f@rkannoth-OptiPlex-7090>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296870-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4924565BE16

On Tue, 9 Jun 2026 07:56:46 +0530 Ratheesh Kannoth wrote:
> > > The comparison to a generic PCI networking driver isn't quite applica=
ble
> > > here. The RVU AF (Administrative Function) is not a standard NIC PF =
=E2=80=94
> > > it is a system-level resource manager that owns a single, shared set =
of
> > > AF registers across the entire RVU subsystem. The hardware spec is
> > > explicit on this: "RVU has a single, common set of AF registers.
> > >
> > > This is fundamentally different from a multi-port NIC where each PF is
> > > an independent, symmetric instance. In the RVU model, there is exactly
> > > one AF device per SoC, and all other PFs  communicate with it
> > > via mailboxes rather than accessing AF registers directly. Allowing a
> > > second AF probe would mean two driver instances racing to manage the
> > > same global hardware state =E2=80=94 provisioning LFs, configuring
> > > NPC/NIX/NPA =E2=80=94 with no hardware arbitration between them. =20
> >
> > I asked you before - is this a driver for a PCIe devices?
> > You said "yes". If so what prevents the user from plugging two such
> > devices into one system? =20
>=20
> The RVU AF (PCI device ID 0xA065) is not a pluggable add-in card. It
> is an integrated function inside the Marvell OcteonTX2/CN10K/CN20K SoC.
> On-chip firmware programs the PCI configuration space for all RVU
> functions at boot time =E2=80=94 setting device ID, class code, and BAR l=
ayout
> via RVU_PRIV_PF()_ID_CFG =E2=80=94 and the Linux PCI subsystem then disco=
vers
> what firmware has configured. There is no slot, no connector, and no
> mechanism by which a second instance of this device could appear on the
> same system. The hardware exposes exactly one AF PCI device per SoC,
> and that is the only device this driver (rvu af driver) binds to.

SMH, I asked you if it is a PCIe **card** or a SoC device.
You answered "This is PCIe." Now you're saying it's a function within
the SoC. I can see the driver is operating on struct pci_device...

Just say this is an integrated device within the SoC then in the commit
message.

