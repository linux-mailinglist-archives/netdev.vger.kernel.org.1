Return-Path: <netdev+bounces-254479-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gA8cDmSGemnx7AEAu9opvQ
	(envelope-from <netdev+bounces-254479-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:57:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 87673A9514
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:57:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4D24301BC3A
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDA533CE8F;
	Wed, 28 Jan 2026 21:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="TaJgEHQl"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2E2B330D50;
	Wed, 28 Jan 2026 21:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769637347; cv=none; b=BVt2EAu3iBnOgS6f1m1dYZi2e2lodOubHfvQA8ieE2RFVsEggonO9lwKLJ11+nAJuMP3ACitMoA7lC4I57SpP2nYtlfNu6uaXR066StT11Lc05otybngaxp38ycg9tOq7Y1yexN3YByd/rVCd9xC7Ntej466za230vzujOFwuKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769637347; c=relaxed/simple;
	bh=rtlc8ND3kQL0NIdSXD14iX29D2IcjakQ54Oo3TC3yMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDuaoq4Ag6LKRv8HfP1hFBrY0AabT3ajUaMCcEgywxCrOvM9ZyrlFI4Yx87E38jmUUtNn8RknbCxdep2EOaZw+HkYvXgjfVuqmwx9qVPTuBD5VBEEOlLkJgnZWaWHM6YaSYVDDdo0HhmkO/J5kjY+vyP90GYMVtuMScfkYJUkz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=TaJgEHQl; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f1bgK6bvKz9tRk;
	Wed, 28 Jan 2026 22:55:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1769637341;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eBZD4epMES0NdK+WxDlXWeM4FddXXNNOQ9YNWAox1JI=;
	b=TaJgEHQlYscWxauinYwsmlhF2sJliF0ML/RKfyh0FeGPnYJ23Pg4U8+quRx3YpICZdsvwL
	hEjlSryZJ3JHzgW5WdshCJG+41enbyqom9M5kz+x7xoEYMEbkaPCcHfFofE8oeIAuf30NT
	ghTJvCQIN0rYoB9GbTUu823V3S64+M20mUSW1lEn0lBjt6sgWc1ptI0OpxWHUHkWbR6sc+
	s85lSEUwBQ4gvRxkr+545gMeUC94wTLIuRccJdoK2XVSSYD4DGAXkEVaMSZ2EhWATCL+iV
	gj6bITMHm6BV0beA0wKJiAIe8WJUIjG/Od9CmffBDkdjp7pbRF8vE6RSHnJ3OQ==
Date: Wed, 28 Jan 2026 22:55:33 +0100
From: =?UTF-8?B?xYF1a2Fzeg==?= Majewski <lukasz.majewski@mailbox.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: festevam@gmail.com, linux-arm-kernel@lists.infradead.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, horms@kernel.org,
 shawnguo@kernel.org, imx@lists.linux.dev, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, devicetree@vger.kernel.org, wahrenst@gmx.net,
 pabeni@redhat.com, davem@davemloft.net, netdev@vger.kernel.org,
 richardcochran@gmail.com, edumazet@google.com, andrew+netdev@lunn.ch,
 robh@kernel.org, krzk+dt@kernel.org, andrew@lunn.ch
Subject: Re: [net-next,v20,4/7] net: mtip: Add net_device_ops functions to
 the L2 switch driver
Message-ID: <20260128225533.39665c74@wsk>
In-Reply-To: <20260128022558.4151582-1-kuba@kernel.org>
References: <20260126103400.1683125-5-lukasz.majewski@mailbox.org>
	<20260128022558.4151582-1-kuba@kernel.org>
Organization: mailbox.org
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MBO-RS-ID: 7d006a684c6f407a7af
X-MBO-RS-META: z11xxedxwyc1eh8qc7t7nd5s3ut5si6k
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254479-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_ORG_HEADER(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,lists.infradead.org,pengutronix.de,kernel.org,lists.linux.dev,vger.kernel.org,gmx.net,redhat.com,davemloft.net,google.com,lunn.ch];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lukasz.majewski@mailbox.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mailbox.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,mailbox.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 87673A9514
X-Rspamd-Action: no action

Hi Jakub,

> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see
> https://netdev-ai.bots.linux.dev/ai-local.html ---
> net: mtip: Add net_device_ops functions to the L2 switch driver
>=20
> This patch adds the net_device_ops callback implementations for the
> MTIP L2 switch driver including transmit, timeout handling, multicast
> setup, MAC address configuration, and port parent ID retrieval.
>=20
> > diff --git a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c index
> > 9c21a3d29c1c..a6424ee1a9d9 100644 ---
> > a/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c +++
> > b/drivers/net/ethernet/freescale/mtipsw/mtipl2sw.c =20
>=20
> [ ... ]
>=20
> > +static netdev_tx_t mtip_start_xmit_port(struct sk_buff *skb,
> > +					struct net_device *dev,
> > int port) +{ =20
>=20
> [ ... ]
>=20
> > +	/* Push the data cache so the CPM does not get stale memory
> > +	 * data.
> > +	 */
> > +	bdp->cbd_bufaddr =3D dma_map_single(&fep->pdev->dev, bufaddr,
> > +					  MTIP_SWITCH_TX_FRSIZE,
> > +					  DMA_TO_DEVICE); =20
>=20
> The dma_map_single() call here creates a DMA mapping, but
> mtip_switch_tx() at this point in the series is an empty stub that
> never calls dma_unmap_single().

Yes.

> Is the intention for this to be
> resolved by a later patch in the series? Looking ahead, a4c3fa1c66c9
> ("net: mtip: Add mtip_switch_{rx|tx} functions to the L2 switch
> driver") does add the full TX completion handler with the
> dma_unmap_single() call. However, this commit on its own could cause
> DMA resource exhaustion if used standalone (e.g., during bisection).
>=20

The MTIP Kconfig define would not be available at this point of the
series.

The split is done as part of the agreement of how that large driver
shall be added.

The mtip_switch_rx|tx is a stub at this point to ease the review.

> Would it make sense to merge these two patches together, or at minimum
> have a note in the commit message explaining the dependency?
>=20

@Jakub - If possible I would keep things as they are now.

> [ ... ]



--=20
Best regards,

=C5=81ukasz Majewski

