Return-Path: <netdev+bounces-141662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E89A9BBEE3
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 21:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E81A528354C
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 20:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D5E1F5852;
	Mon,  4 Nov 2024 20:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BFB1E630C;
	Mon,  4 Nov 2024 20:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730752808; cv=none; b=QMTG47/QM5Alrz01YE1qiaY/VBH/VOKGeopxPlqY4kC1TfqmBtcgH3XyLCUWvfcllqJLHwZ4Kpv3UD4ZIq/NMlJg9W2l/GzyEP2y8t/w5jx7XLlnGUkZdaD8HAHgVjkq4Ki3SAu9EuZVR8t8X3dVR5wrynq6Ag+DPNkcPRjR4f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730752808; c=relaxed/simple;
	bh=3jPAgjCmc5xZFnFTlICOCmOgjU542J0fdZykbEcCH/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIZ0m4h6srL61BqClo0KaM08nc436RQua+CgklZtIFxcN6Bq6doAChoopXWzdgt4aXN0TuxOUFBt5SMkMHaqT/HUwc1yvYeJQof5wifwOx7I7Rt2BSh/PKyoRuAjsVHD7NWdf04gEy4EP9I9OPqJELDmUMcIDd/GLMZvwmFCmgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539f2b95775so5263824e87.1;
        Mon, 04 Nov 2024 12:40:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730752804; x=1731357604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W8o3axdgTYHI1ELDzRVuADA51JcMZl0PXk13YMEAtqI=;
        b=ruvVnjue6uyrE9QgzneuywDSvEJKSSmpsjemyGJFL2uWKKMPFfAWGm9HwgcxqWvlQU
         tPUJwplpJRVAFs1CYt+nnmYWdrdaRlJOaalqNzAdUPtzP/+nojgUBW2F1BK+pm10t652
         KmmMda7T02ENgNcQjOPBLHr1ksCxVuA2/6KQGqxKneSgpah+VzetFUmGWW6h0jcHFxvc
         bmYnZ8N5oZUD4WnpwuqlB2JLc6MLunDNRLT6aQ/0XztUX/4obmQRgbq766Zv+bFDjzCf
         7jyfA3AVqMK+ijWWe9trHNuOzJsDEVpbrIZTzfBSy01N0N5U3/8Kiouy0MDl+5notRS+
         dvIw==
X-Forwarded-Encrypted: i=1; AJvYcCUBeJColJt9JsYEhH0eXc1FSX76xYUWLsRlRDExv9TU+NCJxVntLy5K+Ysf51VkgsKXFBytuCTQ@vger.kernel.org, AJvYcCW3Rs3OzvTosmIOnVOr27e2EXN7S1lAAPDOkq3jaML37TGnw0+QybUZQCucPkmvf3f8oJADMpc0hBTdd2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynl4zgh3o81lYl4Z6cfrJq9P/BaWRJq45et03T9kzi33wGazfl
	Y8ZqBM6AJ8/d41pRcFKPmQn2VLAr/YSaXpKXqlBD78gh10ACe9du
X-Google-Smtp-Source: AGHT+IHgM6ZoN8gjRebFk2yb7UYmNVHSqArDicecN4n+Jms4jQjQU6O9XURNoBUCRF+SgpSWiP67/g==
X-Received: by 2002:a05:6512:1590:b0:539:8fbd:5218 with SMTP id 2adb3069b0e04-53d65e168f6mr8509539e87.56.1730752803860;
        Mon, 04 Nov 2024 12:40:03 -0800 (PST)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9eb16a1440sm28245466b.31.2024.11.04.12.40.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 12:40:03 -0800 (PST)
Date: Mon, 4 Nov 2024 12:40:00 -0800
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: horms@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	vlad.wing@gmail.com, max@kutsevol.com, kernel-team@meta.com,
	jiri@resnulli.us, jv@jvosburgh.net, andy@greyhouse.net,
	aehkn@xenhub.one, Rik van Riel <riel@surriel.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH net-next 1/3] net: netpoll: Defer skb_pool population
 until setup success
Message-ID: <20241104-nimble-scallop-of-justice-4ab82f@leitao>
References: <20241025142025.3558051-1-leitao@debian.org>
 <20241025142025.3558051-2-leitao@debian.org>
 <20241031182647.3fbb2ac4@kernel.org>
 <20241101-cheerful-pretty-wapiti-d5f69e@leitao>
 <20241101-prompt-carrot-hare-ff2aaa@leitao>
 <20241101190101.4a2b765f@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101190101.4a2b765f@kernel.org>

On Fri, Nov 01, 2024 at 07:01:01PM -0700, Jakub Kicinski wrote:
> On Fri, 1 Nov 2024 11:18:29 -0700 Breno Leitao wrote:
> > > I think that a best mechanism might be something like:
> > > 
> > >  * If find_skb() needs to consume from the pool (which is rare, only
> > > when alloc_skb() fails), raise workthread that tries to repopulate the
> > > pool in the background. 
> > > 
> > >  * Eventually avoid alloc_skb() first, and getting directly from the
> > >    pool first, if the pool is depleted, try to alloc_skb(GPF_ATOMIC).
> > >    This might make the code faster, but, I don't have data yet.  
> > 
> > I've hacked this case (getting the skb from the pool first and refilling
> > it on a workqueue) today, and the performance is expressive.
> > 
> > I've tested sending 2k messages, and meassured the time it takes to
> > run `netpoll_send_udp`, which is the critical function in netpoll.
> 
> The purpose of the pool is to have a reserve in case of OOM, AFAIU.
> We may speed things up by taking the allocations out of line but
> we risk the pool being empty when we really need it.

Correct, but, in a case of OOM, I am not sure if this is going to
change the chances at all.

Let's assume the pool is full and we start getting OOMs. It doesn't
matter if alloc_skb() will fail in the critical path or in the work
thread, netpoll will have MAX_SKBS skbs buffered to use, and none will
be allocated, thus, just 32 SKBs will be used until a -ENOMEM returns.

On the other side, let's suppose there is a bunch of OOM pressure for a
while (10 SKBs are consumed for instance), and then some free memory
show up, causing the pool to be replenished. It is better
to do it in the workthread other than in the hot path.

In both cases, the chance of not having SKBs to send the packet seems to
be the same, unless I am not modeling the problem correctly.

On top of that, a few other points that this new model could help more,
in a OOM case.

1) Now with Maksysm patches, we can monitor the OOMing rate

2) With the pool per target, we can easily increase the pool size if we
want. (patchset not pushed yet)

This will also fix another corner case we have in netconsole. When
printk() holds the console/target_list locked, the upcoming code cannot
printk() anymore, otherwise it will deadlcok system. That is because a
printk() will call netconsole again (nested), and it will try to get the
console_lock/target_lock again, but that is already held. Having the
alloc_skb() out of that thot path will reduce the probability of this
happening. This is something I am planning to fix later, by just
dropping the upcoming message. Having this patch might make less packets
being dropped.

