Return-Path: <netdev+bounces-110421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B773C92C462
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 22:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B46F1F235D9
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9460214AD03;
	Tue,  9 Jul 2024 20:19:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C061B86E2;
	Tue,  9 Jul 2024 20:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556394; cv=none; b=IzB39szuMJr4Vy9Bzp/OHPZKOQpZQMqNchUY7dhnfGibOIUwEmJqn7DzhdxlTOQR8cuUYAGIss7HAuc+ZRlgiGEavqLmyU1SyVOCCv0ZXMKO8Kb4LCGN6zhVSPiBmbjZySBGmqtlmDM/+DdJWrd0JnRL8VhARDCTq5CrSwpSb9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556394; c=relaxed/simple;
	bh=xEnkJp0gArq0WuiIGLrWX7kpveK7Rf68JlO+T6b+QWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PYth/0N561HhcaH05Sn/mRtIVQAznPBNo7IJnCmWUWWsQQbsyRT38teYXFVkuRjAv8shocGp518iHx7JB+z0x4bGO9f8k5aX9iAXfN+Cllx2Xn3BVk/OS80Pig3/i7zs1rUKvezqcOXuVb0EB/xwWkqGWesR30aTR8MLlj7Ym5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a77e7420697so449393266b.1;
        Tue, 09 Jul 2024 13:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720556391; x=1721161191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0QdwLBn0J0GvcOGX8RCaus4UscnHhqmUU5ndiMC5O8g=;
        b=eoNWSzVEtdlcsVSp5dilNzqBS39mFvrnTJKNe8JfaLPv8kIWPgecKNubfgwSUqgNCk
         x4q4gdI+r8DuZNFu/KKHN7AMGFXggRfdDicKdfkFSIbG6h+IfW0Eu+DzfA9MmWfFWlsf
         +Do1xqeJhA+dT+bF6ENoZAfA+dpMSr65Sg+kT6CThFCPJGRnnSvnr8ojzfJ1pw/yfEZw
         0g8y2uJRS1oJLUan7yA6W/ELdy675hQN9zfsaKDZhrlP4Jm88LUvZz9xceYkI53Y2Rae
         61nkzfTQo3G82xOszhSDcDjT3oTRvjsOHpmpxIEVIQJd/vDbOj9uGd1HSdXfbXCKUPuB
         JsKg==
X-Forwarded-Encrypted: i=1; AJvYcCXFahAfbDtiSliKqzi8Vlz0LSK4PPe6LTu1COO5WUQF+1+U2bay7OaWQudl5B2/cAf2pYxQ/vGGQAs65g2yg/Fm82VpoNhJtOMK8wzn+4Z+E4NIUUV1oLHwt6f11Cuf4+9p/VqcWy5GGkyBoTk4Fx7aXbcFLdmP/qW2uoTJiJNILxSQF2SV
X-Gm-Message-State: AOJu0YxXRJFcs6aCT8yBqyT+aL7eytWpUGlbqUf6wWqiF1t6qvFFzmH8
	hKq48Yg6qLQXTVhxPJebAOaSG9j0u62YsU5Tb4A38bPR7NCZ6A62
X-Google-Smtp-Source: AGHT+IFTuzuG2o8aRh8UmWLGLFL1aRSNIl6PJfXxcZm/FrqMW/4oTQzx4CkvKw7vlTSzm0wmrSLi2w==
X-Received: by 2002:a17:906:4a54:b0:a77:f2c5:84bf with SMTP id a640c23a62f3a-a780b6881ecmr186015466b.2.1720556387362;
        Tue, 09 Jul 2024 13:19:47 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a8720f9sm103530966b.220.2024.07.09.13.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:19:47 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:19:44 -0700
From: Breno Leitao <leitao@debian.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keescook@chromium.org, nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] netdevice: define and allocate &net_device
 _properly_
Message-ID: <Zo2bYCAVQaViN6z8@gmail.com>
References: <20240709125433.4026177-1-leitao@debian.org>
 <20240709181128.GO346094@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709181128.GO346094@kernel.org>

On Tue, Jul 09, 2024 at 07:11:28PM +0100, Simon Horman wrote:
> On Tue, Jul 09, 2024 at 05:54:25AM -0700, Breno Leitao wrote:
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > In fact, this structure contains a flexible array at the end, but
> > historically its size, alignment etc., is calculated manually.
> > There are several instances of the structure embedded into other
> > structures, but also there's ongoing effort to remove them and we
> > could in the meantime declare &net_device properly.
> > Declare the array explicitly, use struct_size() and store the array
> > size inside the structure, so that __counted_by() can be applied.
> > Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> > allocated buffer is aligned to what the user expects.
> > Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> > as per several suggestions on the netdev ML.
> > 
> > bloat-o-meter for vmlinux:
> > 
> > free_netdev                                  445     440      -5
> > netdev_freemem                                24       -     -24
> > alloc_netdev_mqs                            1481    1450     -31
> > 
> > On x86_64 with several NICs of different vendors, I was never able to
> > get a &net_device pointer not aligned to the cacheline size after the
> > change.
> > 
> > Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> 
> Hi Breno,
> 
> Some kernel doc warnings from my side.

Thanks. I will send a v3 with the fixes.

> Flagged by: kernel-doc -none

How do you run this test exactly? I would like to add to my workflow.

Thanks!

