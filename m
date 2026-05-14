Return-Path: <netdev+bounces-288069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFzeAgARBmobegIAu9opvQ
	(envelope-from <netdev+bounces-288069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:14:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 53ED8545C0E
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 20:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 672CA3016ED0
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 18:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8887D391E6D;
	Thu, 14 May 2026 18:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="TDklkNMk"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E213115BD;
	Thu, 14 May 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.153.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778782460; cv=none; b=CM0hfOkvpxV21gvAA3yIOJ+NurdQMYafLdwEZ+Ksor2qeJh9qukSGVr21LCLURKbZk3I9DYeEHvOPoYYpy8GqX6v3HN3IwheKtvU+SQta5Mf2kJWoDByk8Z0vCrqMcMhPn/MkYG1QQgIU+JziCeBgs5bkxX3URfNbly5kPO5HQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778782460; c=relaxed/simple;
	bh=BQ7qpMLSNXeBFl5qOYux37jkMV7llWRcNVE9SfAA2MM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A6qF2ADjvoZbKzPLoWGodJXb3bEFM8m4gef444bWWJzNE1CGw9+vG0DCWMmgCjgGS7ETCIHEGfKgmuPhvIxnkRRKT1+NpJR1JiU7vFNlnA1CIURgwhP3GmIF5B43f0kRHhB3wxJ5z2HyE2dS7/rq2yO4EFv6NIa9c4JGLwl9s+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=TDklkNMk; arc=none smtp.client-ip=68.232.153.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1778782459; x=1810318459;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=BQ7qpMLSNXeBFl5qOYux37jkMV7llWRcNVE9SfAA2MM=;
  b=TDklkNMkHE+ntWlumtmNhhu56wBJCDMd2kME0Hm/+lfq3fh3mOD1OPgF
   1jtqjJt2vDeEca75ZyQ+22OzCObtOmppDWD7TsDw1BaDL9E5CyLpv7DYq
   xUONDl2lm+T92f12xzjLPPiFL1R9p8D+MRtIMWfRcSgt39ZH8/jdG+7h5
   X8GxvTO9bUvvRYHXWwQrxNx62lvx/tzzyPL38bTwI2zeSdgM8G9CYNMWr
   xzujF4NX97U6khlIxkXDQ3bSjO0WxBwm+8QVdyfM7ApBvzKezGRZc7yps
   37iuZI1MJvFMiDtJUPX+IX8bxz/JhLi/IjWcyiOnT+njfbG+NjdPB+xv1
   w==;
X-CSE-ConnectionGUID: l6cMKygMTVSs5+14yW2K1w==
X-CSE-MsgGUID: vnaWtqheS02Sq0tvd0rzXA==
X-IronPort-AV: E=Sophos;i="6.23,235,1770620400"; 
   d="scan'208";a="288887666"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 May 2026 11:14:18 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Thu, 14 May 2026 11:14:17 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Thu, 14 May 2026 11:14:13 -0700
Date: Thu, 14 May 2026 20:14:13 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Paolo Abeni <pabeni@redhat.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Horatiu Vultur <horatiu.vultur@microchip.com>, "Steen
 Hegelund" <steen.hegelund@microchip.com>, <UNGLinuxDriver@microchip.com>,
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, "Herve
 Codina" <herve.codina@bootlin.com>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, Mohsin Bashir
	<mohsin.bashr@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bpf@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH net-next v4 09/13] net: lan966x: add PCIe FDMA support
Message-ID: <20260514181413.n7o6jwwfoez4up6z@DEN-DL-M70577>
References: <20260508-lan966x-pci-fdma-v4-9-14e0c89d8d63@microchip.com>
 <20260509082720.503A6C2BCB2@smtp.kernel.org>
 <73a19f89-ccd7-4762-8e07-812d8d95ead2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <73a19f89-ccd7-4762-8e07-812d8d95ead2@redhat.com>
X-Rspamd-Queue-Id: 53ED8545C0E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288069-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,microchip.com,iogearbox.net,gmail.com,fomichev.me,bootlin.com,arndb.de,linuxfoundation.org,vger.kernel.org,lists.infradead.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel.machon@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,microchip.com:dkim]
X-Rspamd-Action: no action

> On 5/9/26 10:27 AM, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 10 potential issue(s) to consider:
> >> +static int lan966x_fdma_pci_napi_poll(struct napi_struct *napi, int weight)
> >> +{
> > [ ... ]
> >> +    /* Get all received skbs. */
> >> +    while (counter < weight) {
> >> +            if (!fdma_has_frames(fdma))
> >> +                    break;
> >> +            /* Order DONE read before DCB/frame reads below. */
> >> +            dma_rmb();
> >> +            counter++;
> >> +            switch (lan966x_fdma_pci_rx_check_frame(rx, &src_port)) {
> >> +            case FDMA_PASS:
> >> +                    break;
> >> +            case FDMA_ERROR:
> >> +                    fdma_dcb_advance(fdma);
> >> +                    goto allocate_new;
> >> +            }
> >> +            skb = lan966x_fdma_pci_rx_get_frame(rx, src_port);
> >> +            fdma_dcb_advance(fdma);
> >> +            if (!skb)
> >> +                    goto allocate_new;
> >
> > If napi_alloc_skb() fails due to memory pressure, does branching to
> > allocate_new prematurely break out of the processing loop? Since the hardware
> > interrupt was already cleared, and napi_complete_done() is called below,
> > will this cause the RX queue to stall permanently for the remaining
> > unprocessed frames? Should the code drop the packet and continue instead?
> 
> I went over the series and sashiko feedback, and generally speaking the
> series LGTM, but I think this one is real and should be addressed.

Thanks for reviewing. Before I respin, I'd like to sanity-check the design
expectation.

I had already looked at this and concluded it was fine — the reasoning being
that any leftover DCBs (frames) would be drained on the next IRQ when new
traffic arrives. Same pattern exists in all other Microchip FDMA drivers
(lan966x platform, sparx5/lan969x, ocelot) and has been running since their
introduction without a reported issue, AFAIK.

Is calling napi_complete_done() with DCBs still pending in the ring itself a
NAPI-contract violation — in that case this is a pattern that needs fixing
across all four drivers.

Happy to go either way — just want to make sure I understand the problem :-)

> 
> Also it would be very helpful if you could (for future series/revision)
> reply to the (wrong) sashiko comments individually explaining with a few
> words why the are off: decoding the context requires much more time for
> whoever has not wrote the code itself.

Ack.

> 
> I understand that dealing with AI feedback is a pain, but, paraphrasing
> a great aphorisms creator, I can assure you that ours (maintainers) pain
> is greater.

I can only imagine.

> 
> Thanks,
> 
> Paolo
> 

/Daniel

