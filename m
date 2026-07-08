Return-Path: <netdev+bounces-305977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Jhg6JVyxTmoVSgIAu9opvQ
	(envelope-from <netdev+bounces-305977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:21:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E982B72A2AC
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 22:21:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=samsung.com header.s=mail20170921 header.b=uXNcoISC;
	dmarc=pass (policy=none) header.from=samsung.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305977-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305977-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F7943066A2D
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 20:16:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB5D2374A02;
	Wed,  8 Jul 2026 20:16:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE062DAFBD
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:16:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783541816; cv=none; b=C27eQzotx7TFogWt1ubjOzrIueUkPdS1+j/MW0Qn5Tl9wvItMQnQ3DEmYVvck+uH2/dUG6aCjqX06JAn8w/YgEFXXeVmF1d5wZuY5Ejqm73vMqUZIALCOWZNht15edCas9RjluXAtnG7jf5+4k67gM4bOUbJb268UtB8UVksVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783541816; c=relaxed/simple;
	bh=HNny5WE316f2TANfsEdkhdW0sj0uB1BhkEwgUQExPDM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=aH/bZnEqZNizMYdAIKUJ6Dv7B5pNY5+j829G1ZbhepNeGGBDUGffkamEXrsuS9O+OQ2Oog1keHUztqqMisBsy3IC5IZ7Fdv/T5gjBWmPPh17jlxuegGOg6AhmyhuO3tVKf2ltmwzL25+MvI+Dsdk7T66eWNZlO530OrMH/nN9pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=uXNcoISC; arc=none smtp.client-ip=210.118.77.12
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260708201647euoutp026e89dc692b6957e76047ab19a2100c56~AadMKfaaD0511105111euoutp02Z
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 20:16:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260708201647euoutp026e89dc692b6957e76047ab19a2100c56~AadMKfaaD0511105111euoutp02Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1783541807;
	bh=RYx5u+5FGWCJdyvt6JytRXDJ/jVT6gVVxpgW5mLqOwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=uXNcoISCsD7Metr8ZkJ1mZrZ0T1+I81OIj5dF7xW5GCScFcnJuPA3pY34RFG8NXFv
	 ThYeAHT5X5Fpq4YBNTebOyA1WHeOZG+W3TGjgpTNToX4HsKgV3zFGBtIfJpcbNRJ4n
	 2MPZ0U7Vj2uPVH1h75Z9KQ1hm1h4Yj8vixQcvhos=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260708201646eucas1p1dff8fa3d9a443180852126f72f1cb3a1~AadLmuqnh2208022080eucas1p1H;
	Wed,  8 Jul 2026 20:16:46 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260708201645eusmtip15a406be522cc4e7c4578748b4c2e0a3f~AadKo4mXv0367403674eusmtip1M;
	Wed,  8 Jul 2026 20:16:45 +0000 (GMT)
Date: Wed, 8 Jul 2026 22:16:45 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: netdev@vger.kernel.org
Cc: k.tegowski@samsung.com, k.domagalski@samsung.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sashiko
	AI <sashiko-bot@kernel.org>
Subject: Re: [PATCH net 2/2] net/stmmac: Prevent dma queue NULL free on
 allocation failure
Message-ID: <ak6wLcK1xCXZf4mS@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20260707174115.1264466-3-j.raczynski@samsung.com>
X-CMS-MailID: 20260708201646eucas1p1dff8fa3d9a443180852126f72f1cb3a1
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_"
X-RootMTR: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
X-EPHeader: CA
X-CMS-RootMailID: 20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276
References: <20260707174115.1264466-1-j.raczynski@samsung.com>
	<CGME20260707174136eucas1p2dca8fd11dc7642c913eb03bcdf5aa276@eucas1p2.samsung.com>
	<20260707174115.1264466-3-j.raczynski@samsung.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[samsung.com:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-305977-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:k.tegowski@samsung.com,m:k.domagalski@samsung.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:sashiko-bot@kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[samsung.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,st-md-mailman.stormreply.com,lists.infradead.org,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,samsung.com:from_mime,samsung.com:email,samsung.com:dkim,AMDC4622.eu.corp.samsungelectronics.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E982B72A2AC

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Jul 07, 2026 at 07:41:15PM +0200, Jakub Raczynski wrote:
> During allocation of RX/TX descriptor resources and its DMA,
> there is verification of failed dma_alloc_coherent() due to lack of memory.
> In case of that failure, all allocated resources are freed instantly after,
> but there are no checks for dma_free_coherent() whether previous step has
> failed.
> This will generally result in panic due to freeing NULL address.
> 
> Fix it by adding NULL verification of memory that is to be freed.
> 
> Theoretically code should also set address of pointed memory to zero when
> freeing, but currently the only path of invalid address is non intialized zero,
> and there is no case possible of double-free of same memory.
> 
> Fixes: e73b19baa3b1c ("net: stmmac: simplify DMA descriptor allocation/init/freeing")
> Reported-by: Sashiko AI <sashiko-bot@kernel.org>
> Signed-off-by: Jakub Raczynski <j.raczynski@samsung.com>
> ---

Sashiko AI gave review that has valid point, patch needs changes.
Please drop it.

--
pw-bot: cr

------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_
Content-Type: text/plain; charset="utf-8"


------eLQjSWLrXY9-oLo2Anxe58pGrKtOPid212nTY8jU3vRtfcwP=_13ad66_--

