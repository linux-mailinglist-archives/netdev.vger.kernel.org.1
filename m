Return-Path: <netdev+bounces-291573-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UISiBiNRFWqmUQcAu9opvQ
	(envelope-from <netdev+bounces-291573-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:52:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B34675D1F16
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 09:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 095D2300B479
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 07:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B2437B00E;
	Tue, 26 May 2026 07:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="xlqVx6yw"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7879F28640C;
	Tue, 26 May 2026 07:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781921; cv=none; b=pVi8uhHsdQ3mOKPIStVfOVGrL/+oX07DjcNQ3piUsgDg1u8Mj7vC5w7csgNbY9T9WSjwElZBXsfhXkRQ/XbeRNlTTtGIhjtfwXf62e4rkoo7MNV74poi4cSBoR9HY6K94ctuyIwcF6Av+kth8niWIVnL6JYIIBONbsh26v5FxCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781921; c=relaxed/simple;
	bh=rMhf/zUonhAEYYTpCYnH6q3vSoble+pXITZAW+f7XXg=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9P+GeIlDrJ03vXNe8gxvrO/8rC52fm3uhcLCins7TBuNzaIBs4ztvEGbK9LyRN+McJdmHlQoxqcVmgwkfKeNEYOUCDiq2Qe+LM5oZWqOm2Xt544Zocl8y+GSXLDEIUkZf4ZCYBUS0TvJsxWQrGwpfaKEl6NK3B8ZT0/H8ySQcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=xlqVx6yw; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 83126206B1;
	Tue, 26 May 2026 09:51:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u74baoRSexB7; Tue, 26 May 2026 09:51:55 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 8DB6720547;
	Tue, 26 May 2026 09:51:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 8DB6720547
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1779781915;
	bh=6VskjYF2w3O6Jdr8FVLMx++k+ZlN6Ix0/mxefYXXo3k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=xlqVx6ywuMVlFEPxEka3win0WhFA+fjn3mWXTrWWGOE3BOey8gL8N39Vu20wHrOcO
	 ZP5+DDeYaQU7b6KaTCW1ETIBn0vkBhGjfYQiLgF09fTdproHan6B77HaNfMNtgYFFk
	 a+Dytx1Mf16q/+OChtilCmjyxVBzReLOZonAhT1Urc2If7B2IizMtxROSY3TBGRLfZ
	 MNthzLNjRm3r0ByKZBWNldDygXuWSwQwBLFACXTZBsQkWMjHzaMinqYBMEW2OAyxKe
	 2+16/P5PwA1L6e6jBXOgIurLW2Xm+DXjoOquC69Uhc7LSkf/pvVdVVVWYiQerRfHbx
	 FaJIUL6y3bQ/Q==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Tue, 26 May
 2026 09:51:54 +0200
Received: (nullmailer pid 85463 invoked by uid 1000);
	Tue, 26 May 2026 07:51:53 -0000
Date: Tue, 26 May 2026 09:51:53 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sabrina Dubroca <sd@queasysnail.net>
CC: tanjingguo <tanjingguo@huawei.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Chenzhe <chenzhe@huawei.com>, "malin (R)"
	<malin89@huawei.com>, michenyuan <michenyuan@huawei.com>, cenxianlong
	<cenxianlong@huawei.com>, "herbert@gondor.apana.org.au"
	<herbert@gondor.apana.org.au>, "davem@davemloft.net" <davem@davemloft.net>,
	"dsahern@kernel.org" <dsahern@kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>
Subject: Re: [PATCH ipsec v2] xfrm: esp: restore combined single-frag length
 gate
Message-ID: <ahVRGe_XgpXpsJ46@secunet.com>
References: <ab4c5808478d48978292c318d85c4484@huawei.com>
 <ag8FVjyh2ZoYuSbR@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ag8FVjyh2ZoYuSbR@krikkit>
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291573-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,secunet.com:mid,secunet.com:dkim,queasysnail.net:email];
	DKIM_TRACE(0.00)[secunet.com:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B34675D1F16
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 03:15:02PM +0200, Sabrina Dubroca wrote:
> Note that you must respect a 24-hour delay between reposts of the same
> patch:
> https://docs.kernel.org/process/maintainer-netdev.html#tl-dr
> 
> 2026-05-21, 12:00:55 +0000, tanjingguo wrote:
> > Changes in v2:
> >   - Use the ipsec tree subject prefix.
> >   - Clarify that esp_output_tail() allocates after esp_output_head() appends
> >     tailen.
> 
> Thanks for the clarification.
> 
> >   - Avoid shadowing the existing allocsize variable.
> >   - v1: https://lore.kernel.org/netdev/ag7kxJ39XQaVY1Mb@krikkit/T/#t
> > 
> >  net/ipv4/esp4.c | 4 ++--
> >  net/ipv6/esp6.c | 4 ++--
> >  2 files changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> > index 6a5febbdbee49..c62dfe049ee7 100644
> > --- a/net/ipv4/esp4.c
> > +++ b/net/ipv4/esp4.c
> > @@ -419,8 +419,8 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
> >  			return err;
> >  	}
> >  
> > -	if (ALIGN(tailen, L1_CACHE_BYTES) > PAGE_SIZE ||
> > -	    ALIGN(skb->data_len, L1_CACHE_BYTES) > PAGE_SIZE)
> > +	if (ALIGN(skb->data_len + tailen, L1_CACHE_BYTES) >
> > +	    PAGE_SIZE)
> >  		goto cow;
> 
> nit: you didn't need to wrap here, the total length of this line is
> under 80 columns.
> 
> But other than that, the fix looks correct to me:
> Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
> 
> I don't know if Steffen will require a repost or apply this directly,
> so please wait at least the standard 24 hours.

I've applied it directly, thanks everyone!

