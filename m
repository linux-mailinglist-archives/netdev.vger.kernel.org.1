Return-Path: <netdev+bounces-280353-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WA9sGCuK6Gk6LgIAu9opvQ
	(envelope-from <netdev+bounces-280353-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:43:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8944399E
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7562E303AF09
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 08:42:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5081734CFC7;
	Wed, 22 Apr 2026 08:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ut+6VcWq"
X-Original-To: netdev@vger.kernel.org
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B2637FF77
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847334; cv=none; b=IgFre0SkINoN6eDPC2uLtIagtUAyvlymN1OqUSXPvLLlm/QuPYIUEhNJxIU0RC7X4UF3OyI4QY05BjWJ21PBeo83l8fdeGtzhb14tnOTlZu8B99kzm4X2xb+Bhj6z0w2SZ25xNx8Gv2Dj3xWjY3/HhSnll7Fn1UC+vNXG/yZAj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847334; c=relaxed/simple;
	bh=d1YGxQHxFz8oO27XTBzMvRQkzYc2VrFWcRQaOXzn8RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=A9KgOaY7WrahXfEg9h6Oh0PjZLyanYft2+gnAZfAcuabtWxle6TwiO2X9TkYF7weeQobxx18m1CQcYUeE71ZMKNGZouoFaIAUhuHUqzcu7FX0rEMsN1jTRfiJHe/clsV+Amdq1wlKRQq9ds/kOyK15aEYKU+2zYulqeIyCAAIDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=ut+6VcWq; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260422084208euoutp022e56abe9ffb97e3d31746451d5d4ff97~ooTssH1JY0361503615euoutp02g
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 08:42:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260422084208euoutp022e56abe9ffb97e3d31746451d5d4ff97~ooTssH1JY0361503615euoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1776847328;
	bh=YrPgAfVKB+qxDc2CcSoeSAb6iAceV4edZfrbKmtZrQI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ut+6VcWqnwBTF9NoOJ1778Dtgk6DwTujz0tNMOrl+XSJhLEP753HmZgb0RiD177Af
	 3tHjIWF/a3W1ndJLEnZhsb+IOdv83NH3l7BlOD21/sJaqph4ovi7EeuzvSeAMa6pCv
	 PWNQqT3fo2/oACq2NycAnD+2AeaJCJYUyg0M0/1k=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260422084208eucas1p137123bfccf5ca996ba7f0c56ecf1c1e9~ooTsZ4yvQ0209102091eucas1p1-;
	Wed, 22 Apr 2026 08:42:08 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260422084207eusmtip283f6f1250b08ee1a384856d03b43da69~ooTr9v0DZ1239612396eusmtip2K;
	Wed, 22 Apr 2026 08:42:07 +0000 (GMT)
Date: Wed, 22 Apr 2026 10:42:07 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, andrew+netdev@lunn.ch, kernel-janitors@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH] net/stmmac: Fix typos: 'tx_undeflow_irq' ->
 'tx_underflow_irq'
Message-ID: <aeiJ3zr4WJAm1UCk@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
X-CMS-MailID: 20260422084208eucas1p137123bfccf5ca996ba7f0c56ecf1c1e9
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----LmDszmo.tbCNUa4xLp9F.eTPx2S9.ufKTU9pfAqIN0sGcyaX=_213c8_"
X-RootMTR: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
X-EPHeader: CA
X-CMS-RootMailID: 20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6
References: <CGME20260421115052eucas1p103281c5b25719a44c0875d6b0860bfa6@eucas1p1.samsung.com>
	<20260421115008.2690541-1-j.raczynski@samsung.com>
	<7eb9e4d4-909c-4203-833d-bd8b664fdfbc@lunn.ch>
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[samsung.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[samsung.com:s=mail20170921];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[samsung.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280353-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[j.raczynski@samsung.com,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,AMDC4622.eu.corp.samsungelectronics.net:mid,samsung.com:dkim]
X-Rspamd-Queue-Id: CBD8944399E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

------LmDszmo.tbCNUa4xLp9F.eTPx2S9.ufKTU9pfAqIN0sGcyaX=_213c8_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Tue, Apr 21, 2026 at 02:39:15PM +0200, Andrew Lunn wrote:
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> > @@ -78,7 +78,7 @@ static const struct stmmac_stats stmmac_gstrings_stats[] = {
> >  	STMMAC_STAT(rx_vlan),
> >  	STMMAC_STAT(rx_split_hdr_pkt_n),
> >  	/* Tx/Rx IRQ error info */
> > -	STMMAC_STAT(tx_undeflow_irq),
> > +	STMMAC_STAT(tx_underflow_irq),
> 
> Please take another look at this one and think about it.
> 
>     Andrew
> 
> ---
> pw-bot: cr
>

I don't see anything wrong with it?
- naming is correct, same as stmmac_extra_stats from common.h, as it
  wouldn't compile otherwise
- string length is ok, as max name length is ETH_GSTRING_LEN=32 and it is
  not close
- ethtool just polls data from driver and in my tests it is ok
- all instances of 'undeflow' are changed
- 'underflow' semantic is ok, 'undeflow' is just not correct

Please correct me if I am wrong, but imo no issues with this patch.

Regards
Jakub Raczynski

------LmDszmo.tbCNUa4xLp9F.eTPx2S9.ufKTU9pfAqIN0sGcyaX=_213c8_
Content-Type: text/plain; charset="utf-8"


------LmDszmo.tbCNUa4xLp9F.eTPx2S9.ufKTU9pfAqIN0sGcyaX=_213c8_--

