Return-Path: <netdev+bounces-267907-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPGpGsi9tmn7GwEAu9opvQ
	(envelope-from <netdev+bounces-267907-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:10:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D8CDB290ED9
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 637EB300D6BF
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED4E634DB7F;
	Sun, 15 Mar 2026 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="YXZpGz/X"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F40840DFBA
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773583798; cv=none; b=l9c65OnFg7sNwnyvxaSM1zqaieEjU3FwSQNO9hDniOzuhJcegc9qO6qTcZLitiR9EgGZaPw3//dswCALXjY86dxV7kKiOPAMlLNjchuAXkVsJBY886UIzX4t7JEFGYyVJhk+EcmeHmHCd3lbAqOsn5bIKo10BUq+xoHjmAdt4Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773583798; c=relaxed/simple;
	bh=uiVd/+fGXelR1p5pfl5rk+Zt1I69vhzR86HcazMH88M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d77ZGZ6WTxHNVusSh42zGGFGjajTxL0R1LhmghDQA4VfwqnTfABtTOqm2GK6mJdyz9H2OrdZolbcV/PJx1WM7MmPFCTXhixrcHB5eX9Vn69JfnwkyIO5wN4uixDYZmy/Kf1uSRtVLzso461Jr7O6l2TXjpvBaZ+sDtiqZxvD2M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=YXZpGz/X; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (168.25.31.150.dy.iij4u.or.jp [150.31.25.168])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62FE9mRs025689
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 15 Mar 2026 23:09:50 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=RcLrErX1O4pkT2Qd0Kt1wtzixyuWXIGtCs14H59Vd08=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773583790; v=1;
        b=YXZpGz/XTHPMvGFL9MKXfc/wBYEcHYF9aPl9MKrn6PgZcv1VNLWwwjptSe9SNY9o
         e3sCICn5ZJqWeYnejX0Lm7IFi0bGoPThpSLVLmYQ0D6J9FEO88rBr7/ecwwKbYoH
         kADFsD6cMIHee9Frk7LXOv5cRwCxe9scKpAbgoUIhYhkf6fXppz/KcNz80ipF0Wx
         bIWYGCXE6DasmIRJCvLmQVwlLSM/b9C9TcOE9789BcaUrJhLN3Nan9zrmB5AmojY
         f9fq038F4iNf09EZfaFxOOM/eWkfDMGwjq38I0y+L02WelZ7MMsiclJHlZgFMmqC
         w2Z47VWjlSLstnvbulfkVQ==
Date: Sun, 15 Mar 2026 23:09:48 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: "Ruinskiy, Dima" <dima.ruinskiy@intel.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
        "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "kohei.enju@gmail.com" <kohei.enju@gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v1 1/2] igc: set RX hardware
 timestamps in igc_build_skb()
Message-ID: <aba7x6y1uuSp--tH@x1>
References: <20260307182808.155027-1-kohei@enjuk.jp>
 <20260307182808.155027-2-kohei@enjuk.jp>
 <IA3PR11MB89862987ED725ABA6AFC2199E546A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <25df2a93-07c8-477e-9717-fb4a815cff2c@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <25df2a93-07c8-477e-9717-fb4a815cff2c@intel.com>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267907-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[intel.com,lists.osuosl.org,vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,enjuk.jp:dkim]
X-Rspamd-Queue-Id: D8CDB290ED9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/15 15:56, Ruinskiy, Dima wrote:

[...]
> > > diff --git a/drivers/net/ethernet/intel/igc/igc_main.c
> > > b/drivers/net/ethernet/intel/igc/igc_main.c
> > > index ebd831a4ff53..3a4c1ebe4faa 100644
> > > --- a/drivers/net/ethernet/intel/igc/igc_main.c
> > > +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> > > @@ -1964,13 +1964,16 @@ static void igc_add_rx_frag(struct igc_ring
> > > *rx_ring,
> > > 
> > >   static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
> > >   				     struct igc_rx_buffer *rx_buffer,
> > > -				     struct xdp_buff *xdp)
> > > +				     struct igc_xdp_buff *ctx)
> > >   {
> > > -	unsigned int size = xdp->data_end - xdp->data;
> > > -	unsigned int truesize = igc_get_rx_frame_truesize(rx_ring,
> > > size);
> > > -	unsigned int metasize = xdp->data - xdp->data_meta;
> > > +	unsigned int size, truesize, metasize;
> > > +	struct xdp_buff *xdp = &ctx->xdp;
> > >   	struct sk_buff *skb;
> > > 
> > > +	size = xdp->data_end - xdp->data;
> > > +	truesize = igc_get_rx_frame_truesize(rx_ring, size);
> > > +	metasize = xdp->data - xdp->data_meta;
> > > +
> In the spirit of consistency, would it be possible to restructure the
> variable initialization to match that of igc_construct_skb()? Initialize xdp
> first, and then all the size variable inits can stay as they are. It would
> make the net change smaller.

I followed the reverse christmas tree convention used in netdev, but
your suggestion make sense as well.

I'll make that change in v2.

