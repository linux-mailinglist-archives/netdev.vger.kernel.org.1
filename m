Return-Path: <netdev+bounces-253068-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAxVOaSjdGkH8QAAu9opvQ
	(envelope-from <netdev+bounces-253068-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:49:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 625897D4D6
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 11:49:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 06C043010B8E
	for <lists+netdev@lfdr.de>; Sat, 24 Jan 2026 10:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132E213C8E8;
	Sat, 24 Jan 2026 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FO9W6wBq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB026271A94
	for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769251746; cv=none; b=D5OHUOtRVrftdIXm+t2LTl55bUlGwF+mzVnnl+/wT003xTn+DI3Lk455Bhj/DT+m3v6OvyGgdBB2QoRtS2Q9N0mU/h+w+VjMq2Ng/uVmVAaeQwPY+2vq27QtS3Gkfovt3f7/tLYirnpjOeHyt20IQjsfqB77PfxyaBNzgi7BH08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769251746; c=relaxed/simple;
	bh=5by/krL4LkgSMMT5g0Z2p396tLopyd3gucFBw6XyILI=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PWw/XDVb1sk/YRjuLvZqgAZTa4b1/2iwyHDcUe1xvz+VYO3QQCtIDWCuVjKvCW36jVM/eRXLWsbLoNYMEqr4SxIzruTAnbsvqzxGcIgFeP1ZrpFuqo9j1cZd1ihjYF6OQ2rvLTBIsNozdC6m1RpyPGvkVqDgU/Lf8q/U9gAWs2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FO9W6wBq; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-38320cd563aso33657691fa.0
        for <netdev@vger.kernel.org>; Sat, 24 Jan 2026 02:49:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769251742; x=1769856542; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PcVibjw4mjDgQQhM+5ORM6LTnO2Adlw+9ruZjnxFQfI=;
        b=FO9W6wBqZnSzLyHl8bLgqcXLeB2FBCw24iZhkVp5h+SIGMt89cbwlFtHNkhArvBFiF
         XK/fhtxdAdaO3glXzpLZvG3n++FXitqL6vu0xkEj2YjmiIV01pYVXDjvNuN644Rzr1o4
         5E9LuVu+IOdip/IUdYD896GXIrqvZylYfLsehs6oibk0Z3CeadfJF17LrAMv8seFIVvT
         qBGFuw5oihSouhAzTCAa98kN9Ea6PCLdSr/hCo2jvZcIxs7dLgJZu/NtEpuhB7Li/Oq7
         WMC46BcuKsZCeWvbu0DxqfVdWnCmZEi4KlRTtk8zVHbcRUmNSMTyA/jmgW3XjhxV2CVI
         sQ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769251742; x=1769856542;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PcVibjw4mjDgQQhM+5ORM6LTnO2Adlw+9ruZjnxFQfI=;
        b=EJxqXeEznogj/TAk39+6MvPLCpMid2jGtmjQ77Cl9inhHb/hdKKomyHDHD5DdCeNCD
         adoRjv++7LusWZqNEs8FaVVSS2YcChKvWoemNdFJGmBs8CTz2bnqHyoasKEq+GnHCJR+
         9srtJn4F+a3CJFxvKqWkz1PrxhicNLDEHyrwVteQj1XmNecggBISaHv9EB6h97J5X9+u
         7S2EiRqoa8kuUhnzwnZt49O5zmxzdmcXeI6WG3tMFuTOWhiN9IeZyPTOl4nzc6zOfIU+
         EGoLiK8fexFIFDU2OkOEJqRHzuqMkOU/cg2j9a6Z5AhJhWVvqWT0xpWApBd2tknNma3b
         yZbg==
X-Forwarded-Encrypted: i=1; AJvYcCWP/Wa6uszd9bOvw0eT7kuC4P7oCXKfK9CbnNB7hInDRknTJY3M5V7JAr5z+Yk3OMYtUxy6Wl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YweTrvcP0lC2SjT3vZrV+lrBAKEZ658W2amBg7Vyzh9LJtGnT53
	MMU8zLMm71Q90jdGKkU+aukZ0wxay2INT9LMfyw+a+TJFuOnUJzFhAp4
X-Gm-Gg: AZuq6aInzaeNGt0BxEvsKWylHuo2bnFzbH0cYe9LJKzKKRzeQxB4CfJBmoxEUSm7pj+
	iexgb3jSr06ztrob/WTbJ5oPp03+9uza99DS3k4ucaBw2/K58c8eoYT5p7VwdKO8WDgERIxXDl1
	Py5D4zkST4fZVzRXKi1zhuL9cKtQA/Z9+jup9vf1cHM2/iaEU/I1ZUSyvrgBDmnu1nqmUxRkO5h
	2CIaSvQcQVfrUwB6f6G0mXBIHcHfMozg8N+R+esNx65g4DdTfs2Y9tBlLQ7KxNC5yxufuOl9hRP
	yVwhAq7TAIqByIHQSfPSU/6GkP+Kte/PwnQFArk+5yCsXhERgg9sE350ilrVy4xkXB44zN9P7SW
	uMbLy2TuJAumyLJsGCF4JV/14uvgMm3sVxZtdjYc5hQhAHS4ggMA=
X-Received: by 2002:a05:651c:1a0c:b0:385:c21f:37e3 with SMTP id 38308e7fff4ca-385e1b715dcmr15798421fa.19.1769251741385;
        Sat, 24 Jan 2026 02:49:01 -0800 (PST)
Received: from pc636 ([2001:9b1:d5a0:a500::800])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-385da1ab6acsm11193501fa.40.2026.01.24.02.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jan 2026 02:49:00 -0800 (PST)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@pc636>
Date: Sat, 24 Jan 2026 11:48:59 +0100
To: "D. Wythe" <alibuda@linux.alibaba.com>
Cc: Uladzislau Rezki <urezki@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dust Li <dust.li@linux.alibaba.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Simon Horman <horms@kernel.org>, Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	oliver.yang@linux.alibaba.com
Subject: Re: [PATCH net-next 2/3] mm: vmalloc: export find_vm_area()
Message-ID: <aXSjm1DXm6yP62tD@pc636>
References: <20260123082349.42663-1-alibuda@linux.alibaba.com>
 <20260123082349.42663-3-alibuda@linux.alibaba.com>
 <aXPEFdEdtSmd6AzF@milan>
 <20260124093505.GA98529@j66a10360.sqa.eu95>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260124093505.GA98529@j66a10360.sqa.eu95>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253068-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,linux-foundation.org,linux.alibaba.com,google.com,kernel.org,redhat.com,linux.ibm.com,vger.kernel.org,kvack.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,alibaba.com:email]
X-Rspamd-Queue-Id: 625897D4D6
X-Rspamd-Action: no action

Hello, D. Wythe!

> On Fri, Jan 23, 2026 at 07:55:17PM +0100, Uladzislau Rezki wrote:
> > On Fri, Jan 23, 2026 at 04:23:48PM +0800, D. Wythe wrote:
> > > find_vm_area() provides a way to find the vm_struct associated with a
> > > virtual address. Export this symbol to modules so that modularized
> > > subsystems can perform lookups on vmalloc addresses.
> > > 
> > > Signed-off-by: D. Wythe <alibuda@linux.alibaba.com>
> > > ---
> > >  mm/vmalloc.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> > > index ecbac900c35f..3eb9fe761c34 100644
> > > --- a/mm/vmalloc.c
> > > +++ b/mm/vmalloc.c
> > > @@ -3292,6 +3292,7 @@ struct vm_struct *find_vm_area(const void *addr)
> > >  
> > >  	return va->vm;
> > >  }
> > > +EXPORT_SYMBOL_GPL(find_vm_area);
> > >  
> > This is internal. We can not just export it.
> > 
> > --
> > Uladzislau Rezki
> 
> Hi Uladzislau,
> 
> Thank you for the feedback. I agree that we should avoid exposing
> internal implementation details like struct vm_struct to external
> subsystems.
> 
> Following Christoph's suggestion, I'm planning to encapsulate the page
> order lookup into a minimal helper instead:
> 
> unsigned int vmalloc_page_order(const void *addr){
> 	struct vm_struct *vm;
>  	vm = find_vm_area(addr);
> 	return vm ? vm->page_order : 0;
> }
> EXPORT_SYMBOL_GPL(vmalloc_page_order);
> 
> Does this approach look reasonable to you? It would keep the vm_struct
> layout private while satisfying the optimization needs of SMC.
> 
Could you please clarify why you need info about page_order? I have not
looked at your second patch.

Thanks!

--
Uladzislau Rezki

