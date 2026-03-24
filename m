Return-Path: <netdev+bounces-270823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKB3AQjcwWmJXQQAu9opvQ
	(envelope-from <netdev+bounces-270823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:34:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2162FFBAC
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 01:34:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 39FFC30B4044
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 00:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C923242D6C;
	Tue, 24 Mar 2026 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ql+gcM9T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B231C3BEB;
	Tue, 24 Mar 2026 00:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774312124; cv=none; b=A/I9jaJ7V1fFtpv+4sOseTm9dT0Vg82Ay0AgTR73sl0o4774rM8xWfZTzl7nsA+YIycXvBsLyUo7H+kEEt1lwqyKc9EhEswQA1PFgpzpLgrqAkKfynfoUe3tmkO0XnyBN4qBW6IGaArHw6NVoyzrrKRxwUNVkZQ7PrWQ6Ej9kAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774312124; c=relaxed/simple;
	bh=9herclzyLSdDJPAvj1pF7VT6VknWU1hHfB//c6M6wX0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Fme/8VzGCR5wasqVpynFZIzfHDL8qrzDSiX98wopfmSjbpI+KM52vlcmY5pVXngZsEp2Nl6jP6dBSY7g21tDEliDbK2ccwxUs3X99KH8aslMTf8W8utw4mfCTv0Y0U6lMB/0AkaxTD4sA3uaPipCKQTaRs0Y19KiyF1MfSIGNSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ql+gcM9T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B84C4C2BC9E;
	Tue, 24 Mar 2026 00:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774312124;
	bh=9herclzyLSdDJPAvj1pF7VT6VknWU1hHfB//c6M6wX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ql+gcM9TQ7MjumZcWjxzu6dYO5NKwG4kpPAYCu7fmHZR9hMKDCHLcYWIsf9pAphJj
	 DIjL8fgtJWlfJS/emvVfgnufD+XLcPZygCtxjni6DCmnB3tsxOdbWeQvSGR9w+ODxB
	 Y+CyThvnfZ2OQfFSWbCBC1KW8MnrlifwGqqXr03rx7AfIJ6CJQ+2SJcNIvRvNFDam2
	 v0OodSHlORij7iAVfMmS9w+J1IchVXTrLlWUDvIlgAIAbQWKx1VKJE4LmMzGZMieGl
	 Dp7sHacrvam0w9UZtpQUNxpeGKesiN9Jf7GjxXPMP4UfAJXC+v9xL+FnYCptIMpQQp
	 wmn3OQXbdJ/zA==
Date: Mon, 23 Mar 2026 17:28:42 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: Buday Csaba <buday.csaba@prolan.hu>, Frank Li <frank.li@nxp.com>,
 Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard Cochran
 <richardcochran@gmail.com>, Bence =?UTF-8?B?Q3PDs2vDoXM=?=
 <bence98@sch.bme.hu>, Francesco Dolcini <francesco.dolcini@toradex.com>,
 "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 1/1] net: fec: fix the PTP periodic output sysfs
 interface
Message-ID: <20260323172842.7a62979d@kernel.org>
In-Reply-To: <PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <7012fbf90b844083d5fa7d764ed6372fe0288157.1773928309.git.buday.csaba@prolan.hu>
	<PAXPR04MB8510889775D757361CEAFA39884BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[prolan.hu,nxp.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,sch.bme.hu,toradex.com,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-270823-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nxp.com:email,prolan.hu:email]
X-Rspamd-Queue-Id: 5A2162FFBAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 12:54:46 +0000 Wei Fang wrote:
> > When the PPS channel configuration was implemented, the number of
> > supported periodic outputs (`n_per_out`) was left at 1.
> > 
> > This prohibits using channels 1..3 from the sysfs interface, since
> > period_store() rejects channel numbers greater than `n_per_out`.
> > 
> > Fix by increasing `n_per_out` to the number of channels supported
> > by the hardware.
> > 
> > Fixes: 566c2d83887f ("net: fec: make PPS channel configurable")
> > Signed-off-by: Buday Csaba <buday.csaba@prolan.hu>
> > ---
> >  drivers/net/ethernet/freescale/fec_ptp.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/net/ethernet/freescale/fec_ptp.c
> > b/drivers/net/ethernet/freescale/fec_ptp.c
> > index 4b7bad9a485d..1a7aa280e7f6 100644
> > --- a/drivers/net/ethernet/freescale/fec_ptp.c
> > +++ b/drivers/net/ethernet/freescale/fec_ptp.c
> > @@ -756,7 +756,7 @@ void fec_ptp_init(struct platform_device *pdev, int
> > irq_idx)
> >  	fep->ptp_caps.max_adj = 250000000;
> >  	fep->ptp_caps.n_alarm = 0;
> >  	fep->ptp_caps.n_ext_ts = 0;
> > -	fep->ptp_caps.n_per_out = 1;
> > +	fep->ptp_caps.n_per_out = 4;
> >  	fep->ptp_caps.n_pins = 0;
> >  	fep->ptp_caps.pps = 1;
> >  	fep->ptp_caps.adjfine = fec_ptp_adjfine;
> > 
> Reviewed-by: Wei Fang <wei.fang@nxp.com>

I don't understand why you think that we should be exposing 4 channels
to the user when they can only use one. And have the user guess which
one should be programmed. Please explain (and Buday will have to update
the commit message), to me v1 looked like a much better fix.
-- 
pw-bot: cr

