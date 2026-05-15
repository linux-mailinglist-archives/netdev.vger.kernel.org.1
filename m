Return-Path: <netdev+bounces-288284-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EOZmAiMHB2qNqwIAu9opvQ
	(envelope-from <netdev+bounces-288284-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:44:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 700F154EAE3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6067314A973
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 11:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5F047A0CD;
	Fri, 15 May 2026 11:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="amK3yAl8"
X-Original-To: netdev@vger.kernel.org
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7818247B413
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778843823; cv=none; b=r/WkHJ1+rPka81wQ+delG1lSZFqU91IPj1qpi7aoo8/aYy2enm6NaqRtJU168yaM1KCa1HLfsganQ2MbXegAO7LDyhhlcxip33JyNWaIhvMarnhMl63jrPyNnrqpZRt5FYWpeifopH1TJvhzeoHbkoSFSngZdO8fuveFV1acUiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778843823; c=relaxed/simple;
	bh=yGnni7IclGWEYyCHH8Jf+H5dk4nBnAHhdmU8OYlk8vg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=b8fbhgDx3bQoGxJUKZ2n0j0wFtu1XA7P7FM61RthzwOko/hHlZkYwKGawY0G7k73Z3Ute6NS8wR3JkfXs2CdS7XqW/l8pTF+z/aPjyN6hoKBmpsJXt/EoQukzhRuFclfLe4E7BNkfIg8KCh6mSy5CjP/W1EkI9bYpEjZ1o5GVgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=amK3yAl8; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260515111659euoutp01f9b60599b42023bb7ba894af0fa60392~vuQd5LWK91616516165euoutp01g
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 11:16:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260515111659euoutp01f9b60599b42023bb7ba894af0fa60392~vuQd5LWK91616516165euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1778843819;
	bh=sHEE4B8NbWRwM08/kWG17v5UoEwZxiOcCQzIwjpdrvc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=amK3yAl8AQzv8WXSgoOWTnuVbtVqASdSjy6w8Qk/9QoMQ2U/L/g/qWCmbOIabMtY+
	 QfKUKWVONrnKysiT1+Ih888wmL6006rgjv99ikXPioMInNQLljBD/dc3ybyujtypqW
	 BC0UsoRgkHnnQMux9Ltj8D+UsBtvpBEwn6OshIi0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260515111658eucas1p28563b3e7ed126926cc2ce83c7462e708~vuQcqtknB2023120231eucas1p2H;
	Fri, 15 May 2026 11:16:58 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260515111657eusmtip2a64ce6a9d01aefdb7d6fee870edaf713~vuQb5UqlQ2250122501eusmtip2S;
	Fri, 15 May 2026 11:16:57 +0000 (GMT)
Date: Fri, 15 May 2026 13:16:52 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	k.domagalski@samsung.com, k.tegowski@samsung.com, Chang-Sub Lee
	<cs0617.lee@samsung.com>
Subject: Re: [PATCH net] net/stmmac: Fix free-after-use panic when interface
 goes does with XDP
Message-ID: <agcApDxQ4rlWI28v@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <36ffcd43-ebda-44d8-9e32-4268826deb49@redhat.com>
X-CMS-MailID: 20260515111658eucas1p28563b3e7ed126926cc2ce83c7462e708
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_449ca_"
X-RootMTR: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
X-EPHeader: CA
X-CMS-RootMailID: 20260511165107eucas1p1882391435991ffc19670a60a43bbde01
References: <CGME20260511165107eucas1p1882391435991ffc19670a60a43bbde01@eucas1p1.samsung.com>
	<20260511165045.3091475-1-j.raczynski@samsung.com>
	<4ca19ae1-6606-433b-9860-0a8cce12f80f@redhat.com>
	<agbZXcsn9CAlofe4@AMDC4622.eu.corp.samsungelectronics.net>
	<36ffcd43-ebda-44d8-9e32-4268826deb49@redhat.com>
X-Rspamd-Queue-Id: 700F154EAE3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,foss.st.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288284-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid]
X-Rspamd-Action: no action

------t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_449ca_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, May 15, 2026 at 11:24:01AM +0200, Paolo Abeni wrote:
> > You put this after whole section, but I assume you are talking about
> > synchronize_rcu()? Because currently there are 0 checks and it is pure race
> > condition. synchronize_rcu() does secure it in some way, but you are correct,
> > proper ensuring that napi has finished is napi_synchronize().
> > Will fix in v2.
> >>
> >>> @@ -5267,6 +5279,9 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
> >>>  	if (unlikely(!xdpf))
> >>>  		return STMMAC_XDP_CONSUMED;
> >>>  
> >>> +	if (unlikely(test_bit(STMMAC_DOWN, &priv->state)))
> >>> +		return -ENETDOWN;
> >>
> >> Sashiko noted here you should return STMMAC_XDP_CONSUMED
> >>
> >> /P
> > Seems good, will fix in v2.
> 
> If you use napi_synchronize(), I think you can avoid setting STMMAC_DOWN
> and testing it in the fast path: the run-to-completion after irq
> disabling should ensure that no tx could happen after that
> napi_synchronize() completes.
> 
> Side note: it's not clear to me where/when irq disabling take place?!?
> 
> /P
>
STMMAC_DOWN is currently in strange place where it is only used in XDP and is
only ever set/cleared in stmmac_reset_subtask(), and is only applied in
one path. So for starters we wanted to unify it accross XDP paths.
But it could probably be replaced by detecting netlink state,
but that is talk for different patch.

But that aside, in stmmac_disable_all_queues() there is already measure for
XDP to drain which is after phylink stop but before stopping IRQ's in
stmmac_free_irq() (or rather freeing them, which should stop them,
unless shared), but it is not enough it seems, as we managed to crash in
test environment.

So there is a moment between phylink_stop() and stop_all_dma() where
packets are processed, even though there was synchronize_rcu() inbetween.
Using napi_synchronize() or synchronize_rcu() AFTER stop_all_dma() should be
sufficient, but we will need to retest as you said.

Question is whether we actually care about scraps of data when
killing interface.

But that generally still makes STMMAC_DOWN flag almost completely useless.
I mean, it should still be added to other paths, but doesn't do much, other
than during abnormal behavior.

Meanwhile stmmac_xdp_release() handles above in different order and should
be no issue there.

So we will retest.

BR
Jakub Raczynski

------t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_449ca_
Content-Type: text/plain; charset="utf-8"


------t8721TjszneWtmYFNhXAMuWM8V-cCrP4zY8DPt2nQiiiHfXr=_449ca_--

