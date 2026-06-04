Return-Path: <netdev+bounces-295395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UWrEOKrLIWpWNwEAu9opvQ
	(envelope-from <netdev+bounces-295395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:02:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3A4642C68
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 21:02:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L5ulBtpu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295395-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295395-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC356305021C
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941633BD647;
	Thu,  4 Jun 2026 18:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE35332EC5;
	Thu,  4 Jun 2026 18:54:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780599300; cv=none; b=qjK3gJgpzasAw7Xf/drt57QbdT07unTdUrB6x4NRX1lvBrG3GWcGV1GLQSeKKfPmuofgkiqfTEjpoh1dutAdQqQ7p6zOiIA128eSgzGms54X6L6Ri7ik2+5AECuFp3HPO20cUeLdVNrpThT5hiyjOB/JB2BYSigdaaI0pV7/ywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780599300; c=relaxed/simple;
	bh=OnIdO/S5MUDNbhXrvmFJjahMuHXXb1OQdpDPo42Gz+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NOUuDIU6cjJq132BCxOTiV8Oh3MWC3C1wMSqBUM2mC3RGePsn2VlFz1ei9L3QUiITGZ/eJ5MTgOX93zG/EcjVgrOwPmFdFxu3lOZkEhstDftCS/a9QBptd4n1zsf5qb4IXSKk5ytD8FkwWzhojZjTs2WjgqKIhiGT2PaRV5L6tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5ulBtpu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D05681F00893;
	Thu,  4 Jun 2026 18:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780599299;
	bh=7bTuUjdVGLoLObAYXF1J0wLPd01j3ZAaqDiguO4CjQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L5ulBtpuV1jFXLfS7gGjYV+AA/wdlN0DE3k6Vwm4FunKBey1SFZWmUdNrlYo+Uvpp
	 +ppY4GDfmMIYVV3wJ0a+W8Kzok/o+ntB/mSPRkkTIZZ7LN57MRdXKPug8cRD28ru/y
	 UVC9FIBI+9BGp99YOGY2vwbqSiYG5jXDwdqgm13rZ7xz/GqZdRrmSph6V3Y9RqqkRZ
	 ywtrK+IGovrEMpSYBGD5jdv2g23znAa++W83mcS52voT9ch2y2mKmC9ySxOLG6ttdV
	 qbeuV3tVMBaFJWhkTIxxpWxh7V1AIvtUUQqBDXyET+I6Vni4Os/xTp0yRS/vNqEgxc
	 hp/Cx0rjavrsw==
Date: Thu, 4 Jun 2026 19:54:53 +0100
From: Simon Horman <horms@kernel.org>
To: nb@tipi-net.de
Cc: netdev@vger.kernel.org, justin.chen@broadcom.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, opendmb@gmail.com, florian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com, vikas.gupta@broadcom.com,
	rajashekar.hudumula@broadcom.com, bhargava.marreddy@broadcom.com,
	fmancera@suse.de, markus@blochl.de, arnd@arndb.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: bcmgenet: convert RX path to page_pool
Message-ID: <20260604185453.GF3920875@horms.kernel.org>
References: <20260602094248.4130712-1-nb@tipi-net.de>
 <20260604173205.3989025-3-horms@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604173205.3989025-3-horms@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-295395-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,suse.de,blochl.de,arndb.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:nb@tipi-net.de,m:netdev@vger.kernel.org,m:justin.chen@broadcom.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:opendmb@gmail.com,m:florian.fainelli@broadcom.com,m:bcm-kernel-feedback-list@broadcom.com,m:vikas.gupta@broadcom.com,m:rajashekar.hudumula@broadcom.com,m:bhargava.marreddy@broadcom.com,m:fmancera@suse.de,m:markus@blochl.de,m:arnd@arndb.de,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_SENDER_FORWARDING(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,linux.dev:url,tipi-net.de:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4A3A4642C68

On Thu, Jun 04, 2026 at 06:32:06PM +0100, Simon Horman wrote:
> From: 'Simon Horman' <horms@kernel.org>
> 
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://netdev-ai.bots.linux.dev/sashiko/
> ---
> Now I have the exact diff. Let me produce the report.
> 
> commit ff8ce4b2334ded9490897cdd2cff5a25a4a0a438
> Author: Nicolai Buchwitz <nb@tipi-net.de>
> 
> net: bcmgenet: convert RX path to page_pool
> 
> This patch converts the bcmgenet RX path from per-packet
> __netdev_alloc_skb() + dma_map_single() to page_pool, builds SKBs from
> pool pages via napi_build_skb() with skb_mark_for_recycle(), and removes
> the now-unused priv->rx_buf_len field and rx_dma_failed soft MIB
> counter.
> 
> > diff --git a/drivers/net/ethernet/broadcom/genet/bcmgenet.c b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > index 7c11cf916762..80dbfba9fa88 100644
> > --- a/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> > +++ b/drivers/net/ethernet/broadcom/genet/bcmgenet.c
> 
> [ ... ]
> 
> > @@ -1153,7 +1159,6 @@ static const struct bcmgenet_stats bcmgenet_gstrings_stats[] = {
> >  			UMAC_RBUF_ERR_CNT_V1),
> >  	STAT_GENET_MISC("mdf_err_cnt", mib.mdf_err_cnt, UMAC_MDF_ERR_CNT),
> >  	STAT_GENET_SOFT_MIB("alloc_rx_buff_failed", mib.alloc_rx_buff_failed),
> > -	STAT_GENET_SOFT_MIB("rx_dma_failed", mib.rx_dma_failed),
> >  	STAT_GENET_SOFT_MIB("tx_dma_failed", mib.tx_dma_failed),
> 
> [Medium]
> The string "rx_dma_failed" exposed via ethtool -S is user-visible: monitoring
> agents (collectd, telegraf, Prometheus exporters, ad-hoc scripts) may key off
> that name, and the strings list is ordered, so removing one shifts the index
> of every counter that follows for tools that index by offset rather than name.
> 
> Should the changelog mention this user-visible change explicitly, or could
> the entry be retained reporting 0 to preserve the existing string set?
> 
> Worth noting that the sibling driver drivers/net/ethernet/broadcom/bcmsysport.c
> still exposes rx_dma_failed, so the two drivers in the same Broadcom directory
> will diverge after this patch.

FWIIW, I feel that mentioning the change in the patch description
would be sufficient. And I don't buy the index argument, in my view these
are key value pairs.

...

