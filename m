Return-Path: <netdev+bounces-256508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wZd9BielgmlaXQMAu9opvQ
	(envelope-from <netdev+bounces-256508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:47:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B027E0881
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 02:47:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E840B30053D5
	for <lists+netdev@lfdr.de>; Wed,  4 Feb 2026 01:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDF92566F7;
	Wed,  4 Feb 2026 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FupUAjoY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DEC5C613;
	Wed,  4 Feb 2026 01:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770169636; cv=none; b=XktQwURWEJ6dPRueLcDbRei6JcYMEoE7kWO54WgxdcxOWyskClrLswfNbI5Iq35WLaEH3mgBRaPFnhApo97MwtTQDd+VFtKazKVaI2e3hSYHwJg2POFOC5vIZ7tc3JclcMXb/zxWYOz7anJw6rAfDwTTCJ+fKch/iNeUk/OvcAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770169636; c=relaxed/simple;
	bh=EtMmNO0INyqsoTPYTVYPBU1hfHnKquGk52ClsNNa3xA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGjflMo0WHXfUyORd9BuWa44AldxIIbTBqaV17Zeu/pzibef6Du9mrWTBtyxyx0PWQtXhK3ffOBZXIYTJP1o++EhnnoBY1QcysfZjQ0gWURweXyJ9P+K3XVVM9X3n5B7htMe/DesVTbw5o2tOBA7tGrxM0gd427Hd8IVxqDZtro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FupUAjoY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2907C116D0;
	Wed,  4 Feb 2026 01:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770169635;
	bh=EtMmNO0INyqsoTPYTVYPBU1hfHnKquGk52ClsNNa3xA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FupUAjoYyJSFprj0Sql3B8gqvRQF6RVKpaWm99ti+8tf64Kq4mtfH6anuNPVkDymQ
	 fGlEdN7QWSRUACrO77juDSxaqKr5zNTf7UGpYQLcg2QnS1hLISuMqjdA4+3ZHLgY77
	 CrDlVJqw0lJD5aRLJHOBYmWbBBDJ7NHkxRLNc08IKF65tAxGMmJvOVoRSUWIiWBHxA
	 6w0sEzP1pHKVb2zVpC0Abe8/gaVAj8kAX21srQol/NeFVAoIXDugUDwPR5AVMjIfuN
	 TsikZ+OnwcKCw4oq0jNGFu7OtULbQ7mfTfpSKCwxldgkOHKtNvFH+PJs6Bw2Uyv5ES
	 bq3cCzlFuaXwA==
Date: Tue, 3 Feb 2026 17:47:14 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
Cc: andrew@lunn.ch, shawnguo@kernel.org, krzk+dt@kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 conor+dt@kernel.org, horms@kernel.org, richardcochran@gmail.com,
 robh@kernel.org, imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, wahrenst@gmx.net, s.hauer@pengutronix.de,
 kernel@pengutronix.de, festevam@gmail.com
Subject: Re: [net-next,v22,2/7] net: mtip: The L2 switch driver for imx287
Message-ID: <20260203174714.79388301@kernel.org>
In-Reply-To: <20260203211955.23ef4355@wsk>
References: <20260131233459.1625279-3-lukasz.majewski@mailbox.org>
	<20260203013909.822898-2-kuba@kernel.org>
	<20260203211955.23ef4355@wsk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256508-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,kernel.org,vger.kernel.org,google.com,redhat.com,davemloft.net,gmail.com,lists.linux.dev,lists.infradead.org,gmx.net,pengutronix.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B027E0881
X-Rspamd-Action: no action

On Tue, 3 Feb 2026 21:19:55 +0100 =C5=81ukasz Majewski wrote:
> > > +static void mtip_write_atable(struct switch_enet_private *fep, int
> > > index,
> > > +			      u32 write_lo, u32 write_hi)
> > > +{
> > > +	struct addr_table64b_entry __iomem *atable_base =3D
> > > +		fep->hwentry->mtip_table64b_entry;
> > > +
> > > +	writel(write_lo, &atable_base[index].lo);
> > > +	writel(write_hi, &atable_base[index].hi);
> > > +}   =20
> >=20
> > Can these functions race with concurrent access? Looking at the
> > callers, mtip_write_atable is called from two different paths:
> >=20
> > 1. Static entry updates: mtip_config_switch -> esw_mac_addr_static ->
> >    mtip_update_atable_static -> mtip_write_atable (no lock held)
> >=20
> > 2. Dynamic entry updates: timer callback -> mtip_mgnt_timer ->
> >    mtip_atable_dynamicms_learn_migration ->
> > mtip_update_atable_dynamic1 -> mtip_write_atable (learn_lock held)
> >=20
> > The learn_lock only protects the dynamic entry path. The static entry
> > path runs during link changes (mtip_switch_restart called from
> > mtip_adjust_link) without lock protection.
> >=20
> > Both paths can access the same hash block in the address table
> > (determined by GET_BLOCK_PTR(hash)). If the timer fires during a link
> > change callback, both can concurrently access the table, potentially
> > causing torn reads (reading .lo from one entry version and .hi from
> > another) or torn writes (the entry is in an inconsistent state
> > between the two writel calls).
> >=20
> > Would extending learn_lock to protect all address table access work,
> > or is a separate hw_lock needed for hardware register access?
> >  =20
>=20
> This is handled in another way:
>=20
> 1. Partial write is not possible as this IP block handles it in order
> (with some kind of 'latch' registers):
>=20
> "VFxxx Controller Reference Manual, Rev. 0, 10/2016"
> 11.5.4 MAC address lookup table
>=20
> "Each entry must be written or read with the low address accessed first
> followed by the high address"
>=20
> 2. The code for dynamic IP writing will not "touch" the entries for
> "static" MAC addresses - Figure 11-70 - bit 49 is "Record Type":
> 	1 - static entry
> 	0 - dynamic entry
>=20
> IMHO, we are "safe" here.

My reading of the AI's comment was that there is no lock in SW so two
SW threads can write:

   Thread A   Thread B
   write_lo
              write_lo
              write_hi
   write_hi

