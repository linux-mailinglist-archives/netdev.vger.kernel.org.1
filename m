Return-Path: <netdev+bounces-295547-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hM5gL7opImpoTQEAu9opvQ
	(envelope-from <netdev+bounces-295547-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:43:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F2EA46447C1
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 03:43:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295547-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295547-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0BB1E30D434C
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 01:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1248F37B023;
	Fri,  5 Jun 2026 01:28:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A20F436215A;
	Fri,  5 Jun 2026 01:28:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780622929; cv=none; b=ohG+GLIJ+cBiF2qli/94Gtq/b4Gxy/zXdS8QsNRr1/TPGdlAzrygbz7phfjYqOkYX8PpyyKy/QRt6RocA/C7av8pEc/WLcgeL9zXZGhHETJWJfb9Hq/oVvc2GUyyhWfLpH+WA2fZzI9HXfUhA5tpTbnmpNZqiiEJbbAfHfN5WaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780622929; c=relaxed/simple;
	bh=YIFK7ThZKvxcD6wuXBCW/xr5YF5zs8VrzZiNkhe3zvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IzD2flKaLfuJXrXit4HPSNNUwPFdi+OtbyVE5C8IhaLJxa2J9ye5ZaN6cA95ozt8jXc2g7J50MLBiuykWO3NHeatOBp1T/tysBAZgrbwUCEgmeVDtewuf9yQLE9zduLjQHYM/eOgHyMjeEfV32K+D7NSXtRCARGEroZ77ZQAeCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=18.132.163.193
X-QQ-mid: esmtpsz20t1780622911t751b3deb
X-QQ-Originating-IP: bIJVzi1eACFz8E/TmWoHi956L0iTmPj8njNpk0+moEM=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 05 Jun 2026 09:28:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17100364510394675939
EX-QQ-RecipientCnt: 13
Date: Fri, 5 Jun 2026 09:28:29 +0800
From: Yibo Dong <dong100@mucse.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com,
	vadim.fedorenko@linux.dev, horms@kernel.org,
	u.kleine-koenig@baylibre.com, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v6 4/4] net: rnpgbe: Add link status handling
 support
Message-ID: <8373BDD7E788A344+20260605012829.GA793611@nic-Precision-5820-Tower>
References: <20260604112750.769215-1-dong100@mucse.com>
 <20260604112750.769215-5-dong100@mucse.com>
 <7d31ec15-07cc-479d-adce-c7d504eff284@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d31ec15-07cc-479d-adce-c7d504eff284@lunn.ch>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: NiFdmnmiW14nvJX06TwupE9+3y99TSj2NrtjP85uGHU8e+en1htTlCl/
	RahnuuG0zfufpFAub5nEXiCYMBp3+P/MbNDqI3lqHNIo+U7/FqLWCwiPrjVM0Zxz7Z+ndbw
	Zf5eG+vWaXk7rCArT9OG6SLG4//xbay2Kub6uY925qCfRhRpb52uLuLzFsUYDu1CD5RS6vO
	RUnmDaNVGAdUG+PeSE6mSiOu/3vWIaSNKnyj0bKS69bAEy2utyh8rdmq1xU9RHseVud0VBj
	JuHXThYomA/fBg/cFDSrj4gTo8ZFH6I8Tms4oEP8bpNidBrM7NXekHasMZ5sG8mQaEm4qfH
	9CwveS4bgV2u/HvUjp/1RZA2pdPrU9eK4ITABxPjMsO0OVHtjL9OPudqcN1NTwJ6FwIWuUG
	w1/1Ibj9JXfLmrmbw1YmNJrEEghzkZ2wQ1alUEo6zvZATnttKLLFy1VK79KOq3rid3Z2SbA
	S1A14mT1JLAaEYcSRmNkoszfuMveEW/ptVXlG86W18ZXoQXxuJVoPrAPGkaQXhDyoONeMCY
	G6L/Yrt3kbDHgQjGgKd1+yKG7RFePxSMv4fDz7cnUPPdLCfPCeZN8pNMW+eiwHZwCOt6JL6
	EhNIO3/5C6TfIlNBkOJsd51459iuol+fw0yZrATz80OsULl0DkqhjQkGRAsbuH9bmyKUfjp
	nv7bPk+H1vVKcVpkc8b3xsSoX8+kcb9ceNnfGPgwCj8qJzhMPXfCJA0iS33NQ5sT+Spl/Mi
	g+MpwD94cqmyYcfGqrQ+T5x5ed6UTxKdcwHksEz1lMC7W16KlwMUoAIQOn1rp1O8bKZvn3/
	vOPMYoP0XBOxh9/cJFlRIG28gALZPnt/GWk6dyNjrvwohSh24e2ZB9ZEH1iyVcuU2q4YP9/
	0jlwjV8qp16lmj2oN0X/WymNHfIaqVEsyORaSmr9SiQpwx+2opDvoJef7DkJQPKfFby/qAY
	Yud5gFS+ejtix15PCdwQ96deXPHUgXsiJpmU8y/0WCt1lQhrSo/0ARLzzjTiNl4NvzzCUvu
	+n3wG8XtEI5rAG0Vb+6jj0yWXoi0o=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:danishanwar@ti.com,m:vadim.fedorenko@linux.dev,m:horms@kernel.org,m:u.kleine-koenig@baylibre.com,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:yaojun@mucse.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	DMARC_NA(0.00)[mucse.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dong100@mucse.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295547-lists,netdev=lfdr.de];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mucse.com:from_mime,nic-Precision-5820-Tower:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F2EA46447C1

On Fri, Jun 05, 2026 at 01:32:59AM +0200, Andrew Lunn wrote:
> > +static int rnpgbe_process_link_event(struct mucse *mucse)
> > +{
> > +	struct net_device *netdev = mucse->netdev;
> > +	struct mucse_hw *hw = &mucse->hw;
> > +	unsigned long flags;
> > +	bool link;
> > +	int speed;
> > +	u8 duplex;
> > +
> > +	/* lockless fast-path ,serv_task retry handles race */
> > +	if (!(mucse->flags & M_FLAG_NEED_LINK_UPDATE))
> > +		return hw->link;
> > +
> > +	spin_lock_irqsave(&mucse->link_lock, flags);
> > +
> > +	link = hw->link;
> > +	speed = hw->speed;
> > +	duplex = hw->duplex;
> > +
> > +	mucse->flags &= ~M_FLAG_NEED_LINK_UPDATE;
> > +	spin_unlock_irqrestore(&mucse->link_lock, flags);
> > +
> > +	if (link) {
> > +		netdev_info(netdev, "NIC Link is Up %d Mbps, %s Duplex\n",
> > +			    speed,
> > +			    duplex ? "Full" : "Half");
> > +	}
> 
> I actually think down is more useful to report than up? Up is
> generally the normal state, you don't care about that too
> much. However if the link does down, you probably want to know so you
> can figure out why.
> 
I agree down is the more actionable signal. However most in-tree drivers
(igb, e1000e, nfp, etc.) report both directions, and the link-up message
carries speed/duplex information that is useful at boot or after renegotiation.
I'd prefer to keep both but move the up print to the right place.
> > + * rnpgbe_link_is_down - Update netif_carrier status and
> > + * print link down message
> > + * @mucse: pointer to the private structure
> > + **/
> > +static void rnpgbe_link_is_down(struct mucse *mucse)
> > +{
> > +	struct net_device *netdev = mucse->netdev;
> > +	struct mucse_hw *hw = &mucse->hw;
> > +
> > +	/* Only continue if link was up previously */
> > +	if (!netif_carrier_ok(netdev))
> > +		return;
> > +	netdev_info(netdev, "NIC Link is Down\n");
> > +	rnpgbe_set_link(hw, false);
> > +	netif_carrier_off(netdev);
> 
> Why asymmetric behaviour.  Report up in one place down somewhere else?
You're right — the up message in rnpgbe_process_link_event() is misplaced.
I should move it to rnpgbe_link_is_up which is symmetrically with the down path.
> 
> 	Andrew
> 
Thanks for you feedback.

