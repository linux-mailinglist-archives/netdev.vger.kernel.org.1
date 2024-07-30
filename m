Return-Path: <netdev+bounces-114102-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B525F940EF4
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E726C1C2241A
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4373A195B28;
	Tue, 30 Jul 2024 10:24:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDC0196DA1;
	Tue, 30 Jul 2024 10:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722335054; cv=none; b=a7YIlClUjbJqUMQl2Dhp1Wa/8KAoig9QWDmqukRrmV3ZThGpV8wu6/uhw5UyqsRf0YIo5hrp26MW2cJ5Z4TnJiVk61n5cKZb5btkTbf3x/51Ca5NmdwUFy0WRBFM2IfsDmL3m8nSJjOx9ZXfPCB1LMGx3owE8MI5aAD5K3yFqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722335054; c=relaxed/simple;
	bh=01+ZIHMMRxtvZeJgKqLcbttvt1/2M9rdui/cBlDT4fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwwgafEOns6LZCOE2R90ZvfwvR1sX9hVAJzZaFmbssHB1tA+Xdhr58pnmjGN7D8STC0R3VS2rvz1mM8IMQrQsZgK4UwEBw2jKwO5RpmFOC+Z3zQ0fxCRuykZ2KEUMlzyq0Mq3mMVS7AtBSpDb7ta10F+6ZTT0IwJ9cw3C+vt77w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a9185e1c0so416557366b.1;
        Tue, 30 Jul 2024 03:24:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722335051; x=1722939851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi88lXchJSc4G46YbZ5TzeeR41rMBBTQGzJDjHyoh/M=;
        b=PRUSEEfCXMdNYI+bxQtbmc+CNBBFYzfEjxN4hDROfuz6hgqwcD7ChvlYfkqp6kpXKr
         QOfrELry+ZsuKRw4tXk7gkNEpeCvgR4s3fNXzGcI1PyU0zX1U3AFPk/cxPathBhLeqgD
         Rz9iadMiMz2vqavQu+RBb5Dv0vwFD+vUffMXVejGCR9dlrrPlfMzvW/mPz6zxcGuJ13J
         SdWt1+t8fmIWVFcDSmdGTiu3IXeu9EbLElGgvVQogDyyHgtFvFzAYQiE2x1ixgu72HV8
         X6g9STD30/ZG6UpSywRYB6RmigiAUWa68CY6oUN6y/AaywPCCJ4O8+q6mDDduTPC3Ank
         zEjw==
X-Forwarded-Encrypted: i=1; AJvYcCXmXFLtnuQ9VCGF/p1UyNq1TPx0O6n0pA48CO8pEqhIee8dk59WvVL1TZ6rEIyM6g66gnidAgHo9eQV/sXCb+kscGxHx171VN3JswJohXyJs9U0nIZdyF+DU/9Sqtu1ivu3H4QL
X-Gm-Message-State: AOJu0YyzkMOkUIdVrQqnqQQSzjE3IdeLilkyf76FT64c9GxTzs1yBTEv
	c0kqkthLXpd86Oq5RIFvH1gC1VtpjZowV2E24ulbidHReYzmRIOl
X-Google-Smtp-Source: AGHT+IEFyRuo7CXOwDK1c0OaUIC0ZtIYN4M6PIvvPtfyaqJOBmjajz+6luwF95swsst5NbTFu+uG2A==
X-Received: by 2002:a17:907:3e1a:b0:a77:b052:877e with SMTP id a640c23a62f3a-a7d3fffeae5mr805941266b.19.1722335050546;
        Tue, 30 Jul 2024 03:24:10 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7acab535d9sm621889766b.75.2024.07.30.03.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 03:24:10 -0700 (PDT)
Date: Tue, 30 Jul 2024 03:24:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, leit@meta.com,
	Chris Mason <clm@fb.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] net: skbuff: Skip early return in skb_unref
 when debugging
Message-ID: <Zqi/SL/icYA9IwjH@gmail.com>
References: <20240729104741.370327-1-leitao@debian.org>
 <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e6b1f967-aaf4-47f4-be33-c981a7abc120@redhat.com>

Hello Paolo,

On Tue, Jul 30, 2024 at 11:38:38AM +0200, Paolo Abeni wrote:
> On 7/29/24 12:47, Breno Leitao wrote:

> > --- a/include/linux/skbuff.h
> > +++ b/include/linux/skbuff.h
> > @@ -1225,7 +1225,7 @@ static inline bool skb_unref(struct sk_buff *skb)
> >   {
> >   	if (unlikely(!skb))
> >   		return false;
> > -	if (likely(refcount_read(&skb->users) == 1))
> > +	if (!IS_ENABLED(CONFIG_DEBUG_NET) && likely(refcount_read(&skb->users) == 1))
> >   		smp_rmb();
> >   	else if (likely(!refcount_dec_and_test(&skb->users)))
> >   		return false;
 
> I think one assumption behind CONFIG_DEBUG_NET is that enabling such config
> should not have any measurable impact on performances.
> 
> I suspect the above could indeed cause some measurable impact, e.g. under
> UDP flood, when the user-space receiver and the BH runs on different cores,
> as this will increase pressure on the CPU cache. Could you please benchmark
> such scenario before and after this patch?

Sure, I am more than happy to do so. I will be back with it soon.

Assuming there is some performance overhead, isn't it a worthwhile
trade-off for those who are debugging the network? In other words,
wouldn't it be better to prioritize correctness over optimization in
this the CONFIG_DEBUG_NET case, even if it means sacrificing some
performance?

Thanks for reviewing,
--breno

