Return-Path: <netdev+bounces-304455-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id qdp5HAh6R2rTYwAAu9opvQ
	(envelope-from <netdev+bounces-304455-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:59:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 643097005F4
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 10:59:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=stKtVONC;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304455-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304455-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6664630AEC33
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 08:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FFE377EB2;
	Fri,  3 Jul 2026 08:43:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECCF376A0A
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:43:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068237; cv=none; b=fRVx25OXnSrSdYkaXkyvWrrJLmWxQR9P5NuFsIxJqKd89jtjskXPqryCqJsA3ezs6M6BNrh7WPw5nS7N8HHfLsZ4YpkXcjghbQZuKPk8eSBMlBxCEsZRfHWV+nTZKYO7AttIViZX4cD8gvdbMDyoxFh7OLJlQX+TYaciME5JPEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068237; c=relaxed/simple;
	bh=/12BgTtiv7xZR9p/yt7WfQcL9zIE5qQRTcKRu+mzVRY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=DzIkZzn3RDWz5rXeTl2/hDX8wcQTLusiJ625L37TwkPSXNcG1x9T3yEZQUHMn7pGCXtAP9KACxkYGE9bxX8zLKpr7Ezr123YIhPkh93IiW4hZStdTzAhV7x3vrq6jI9/qOV7e0Fjk0UpSasg/8OtxZZIFp7EvQcvk10ICalODpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=stKtVONC; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260703084347euoutp02e5b403e6dedf77a50f1fe8ec74bd8cd9~_uxr9V51M2344623446euoutp02a
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 08:43:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260703084347euoutp02e5b403e6dedf77a50f1fe8ec74bd8cd9~_uxr9V51M2344623446euoutp02a
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783068227;
	bh=RiQXyM5UBOuetX8NJjqtcwpnCxcrmNGPLSLUfTbS9VQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=stKtVONCI0Nxd4ImziGy9HqSjHGqHRf2HTmneDR2HqtaDnQ5enNlQtBh4dyASZ603
	 ELueSaCCoeAMs2sLuFrUUs2rrK/sgraxcEWsEOsx/lvQuYpztP+O2ZZnl0WcHdzJa4
	 EoKZBGcapi00e64Mqn29BBtB+p6hH3KwGbPHOl08=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260703084346eucas1p18d92689a83b83307cd175ecf15318480~_uxrLK3tX1215412154eucas1p1v;
	Fri,  3 Jul 2026 08:43:46 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260703084345eusmtip120f9499256302ae63efa965f2a0d4081~_uxqqjAHX0708807088eusmtip1K;
	Fri,  3 Jul 2026 08:43:45 +0000 (GMT)
Date: Fri, 3 Jul 2026 10:43:42 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, mcoquelin.stm32@gmail.com,
	linux-kernel@vger.kernel.org, k.tegowski@samsung.com,
	k.domagalski@samsung.com, yashwant.v@samsung.com
Subject: Re: [PATCH net] net/stmmac: Set Rx queue page_pool to NULL when
 freeing DMA resources
Message-ID: <akd2Puke2ZRO8AC+@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260703072651.110614-1-pabeni@redhat.com>
X-CMS-MailID: 20260703084346eucas1p18d92689a83b83307cd175ecf15318480
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10a958_"
X-RootMTR: 20260703073148eucas1p142aec67bc3cfb5786c6ac04e8289d675
X-EPHeader: CA
X-CMS-RootMailID: 20260703073148eucas1p142aec67bc3cfb5786c6ac04e8289d675
References: <20260630100953.747868-1-j.raczynski@samsung.com>
	<CGME20260703073148eucas1p142aec67bc3cfb5786c6ac04e8289d675@eucas1p1.samsung.com>
	<20260703072651.110614-1-pabeni@redhat.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-304455-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,kernel.org,gmail.com,samsung.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:mcoquelin.stm32@gmail.com,m:linux-kernel@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:yashwant.v@samsung.com,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[AMDC4622.eu.corp.samsungelectronics.net:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 643097005F4

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10a958_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

For starters I would like to comment that I am sending this fix because this
actually happened in our environment, so this is not some fake AI report,
which I would credit with Reported-by if it was.
Sadly, no panic logs available since it happened long ago and this fix has
been for a while in our code. 

Comments for AI review below

On Fri, Jul 03, 2026 at 09:26:51AM +0200, Paolo Abeni wrote:
> From: AI Reviewer <ai@example.com>
> 
>   - read rx_q->buf_pool[i] in dma_free_rx_skbufs() ->
>     stmmac_free_rx_buffer() from already-freed slab memory:
> 
>         static void stmmac_free_rx_buffer(...)
>         {
>             struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
>             if (buf->page)
>                 page_pool_put_full_page(rx_q->page_pool, buf->page, false);
>             ...
>         }

Comment invalid, I love how AI ignored literally next line, a bit more code:

>> static void stmmac_free_rx_buffer(struct stmmac_priv *priv,
>>				  struct stmmac_rx_queue *rx_q,
>>				  int i)
>>{
>>	struct stmmac_rx_buffer *buf = &rx_q->buf_pool[i];
>>
>>	if (buf->page)
>>		page_pool_put_full_page(rx_q->page_pool, buf->page, false);
>>	buf->page = NULL;

> 
>   - call dma_free_coherent() a second time on the stale
>     rx_q->dma_rx/dma_erx and rx_q->dma_rx_phy?

That is completely separate issue and fix is not what AI suggets.
Because if we zero rx_q->dma_erx or rx_q->dma_rx, dma_free_coherent() will run
regardless on NULL pointer then. We probably should lock dma_free_coherent()
behind simple NULL check and zero it, but this will be separate patch if so.

> 
>   - call kfree() a second time on the stale rx_q->buf_pool?

Invalid, kfree() does have 'if (unlikely(ZERO_OR_NULL_PTR(object)))' check

> 
> Would also nulling rx_q->buf_pool, rx_q->dma_rx, rx_q->dma_erx, and
> rx_q->dma_rx_phy in __free_dma_rx_desc_resources() (or having the alloc
> path defensively reset them before any early return) be appropriate to
> cover the same failure mode the commit message describes?

"Would this be appropriate to cover same failures in same commit"
- Nah
"[...] in same patchset
- Maybe

BR
Jakub Raczynski

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10a958_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_10a958_--

