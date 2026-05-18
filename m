Return-Path: <netdev+bounces-289022-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GE/vAzYDC2qj/QQAu9opvQ
	(envelope-from <netdev+bounces-289022-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:16:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB6256C702
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 14:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 97AE2308E77E
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 12:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8F3FD144;
	Mon, 18 May 2026 12:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4b9VaJ/R"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C719C3FCB3C;
	Mon, 18 May 2026 12:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105669; cv=none; b=Xtr9VTq9uEGPWxhn2Rjc7x++O/x7A2JxfbyAaFt5urJHtgl+8Fg8jRu6o8afxIxFAw8oJFaANxuWL1+NRpUrlN4dyTSAzb+M89dMGfpi+9kPWvM2DD1AQV3yiJQedAfY02fww7DcUlXD621KQda7hGkyrCI64L9lzF6kHtc0XMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105669; c=relaxed/simple;
	bh=ZfdSCvmJheoZqbSwPXtauVF4UyINGQSXbG9sWcASG0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ut6M34zK610rFZ4ikLvRbmShWRj7wIWSUA6rLPr/1cWHOXvz8lAdMEZdYiPYWx6XA5VJ8NSwp1EiJ2LuHGQ7CNIh7ATVAbFBFC09p+EBzrjmlKzfOj1H/uCDRdvsUDQTSr5mdOZm08ggrD3lc2CUfsjRQeuG3HAtBmzIh3gPjmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4b9VaJ/R; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=b2/B+UK9SKjleTI91bdumxJx4pLws3/L2OWSi73KWpo=; b=4b9VaJ/Rj7jWHjVeoleSI82alV
	i/fa0OYq2cR/HFqI84ON2qqx6lg+Z52dquD2DheuQgWIk08FqHqbdCeaqMKPwR4URL7aB/wZ06Mco
	kpXNj5eRS3bab8aGgot0zmNMWt86ifUTQ8cJpFYUILnsOb2unkg/AmbyFxHb31hgVnAQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wOweP-003U3q-Kf; Mon, 18 May 2026 14:00:49 +0200
Date: Mon, 18 May 2026 14:00:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Cc: Piergiorgio Beruto <Pier.Beruto@onsemi.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 8/9] onsemi: s2500: Add driver support for
 TS2500 MAC-PHY
Message-ID: <660d68f2-2e4a-4dad-a33b-9cbd1847c04e@lunn.ch>
References: <CY8PR02MB924948C0BB8611D5A2618D3283382@CY8PR02MB9249.namprd02.prod.outlook.com>
 <c9b1b559-f72e-46e0-8d71-57ea26f70bb0@lunn.ch>
 <CY8PR02MB9249BE304350D2FA7C196A6C83032@CY8PR02MB9249.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY8PR02MB9249BE304350D2FA7C196A6C83032@CY8PR02MB9249.namprd02.prod.outlook.com>
X-Rspamd-Queue-Id: 8AB6256C702
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-289022-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Action: no action

On Mon, May 18, 2026 at 04:03:38AM +0000, Selvamani Rajagopal wrote:
> 
> 
> 
> > > +static int s2500_hwtstamp_get(struct net_device *ndev,
> > > + struct kernel_hwtstamp_config *cfg)
> > > +{
> > > + struct s2500_info *priv = netdev_priv(ndev);
> > > +
> > > + if (!priv->ptp_clock) {
> > > + cfg->tx_type = 0;
> > > + cfg->rx_filter = 0;
> > > + } else {
> > > + oa_tc6_hwtstamp_get(priv->tc6, cfg);
> > > + }
> > > + return 0;
> > 
> > What is actually specific to the s2500 here? Your aim should be to put
> > everything you can into the core.
> 
> I agree on this and the next comment as well. Nothing really vendor specific. 
> 
> Question is, 
> 1) Should we add the PTP code in oa_tc6.c? This PTP code add 200+ lines. My preference is to add a new file oa_tc6_ptp.c under the directory where oa_tc6.c resides.

oa_tc6_ptp.c is good. Maybe create a directory oa_tc6 and move the
code into there. Especially if you need to add a local header which is
shared by oa_tc6.c and oa_tc6_ptp.c, but is not needed by the drivers.

> 2) If we are adding a new file, should it be under same CONFIG_OA_TC6 or add a new CONFIG_OA_TC6_HW_TIMESTAMP or something similar?

I would not bother with a new symbol. It adds build testing complexity
having to build with and without it, to test the stubs are correct
etc.

	Andrew

