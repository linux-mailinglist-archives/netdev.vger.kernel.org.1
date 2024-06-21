Return-Path: <netdev+bounces-105713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFDD391266A
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 15:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9971828943F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3E3154C17;
	Fri, 21 Jun 2024 13:11:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5701E491;
	Fri, 21 Jun 2024 13:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975478; cv=none; b=rFYXJ+W2RpabGO33AVclzrmV5w4mQLN8bFjaX+Dpo4fyL6enSTa4glJ2edLPvMAAGBett8BBdh/cEdrmYstwunHbqpfG9XryjPky4oMzAt9HyYEd5GWywW/CkK8W3gh5UIwoF9q5aCWmmFeftYZypNVVt0luP9Zykt4dITffRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975478; c=relaxed/simple;
	bh=bCX5FA1mPXa8/Yzf+pWQ5GaZmjrSlKFEQf1PbK0U1fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxEwggD6aYGOPW7HStC/DU2RIGhIS3khaCGsvaXZl+5ebe93gVwe0H0LAcgqNKIjQzj1wxynUeEU6otHdoM54LzWXRysk4lw3DJGqk/WReiChfxexAr+vYl3062wnSvMsIx+5dtmznZWGxZ7M6kvJDwbelmBY4XJWHYvjZBtjlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-57d1679ee6eso4013513a12.1;
        Fri, 21 Jun 2024 06:11:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975475; x=1719580275;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=17q6bj6JqpWDK7xKaClWKJXRzHgsaQIs8Jjq3F0zneQ=;
        b=Y5/smHdKBDUgZm2u54o0Lok0RDgQr80gTbWfi8u1akB/o7V5Hp6kjluf/GYYVqesXy
         d39ouTaunVs6evYw6vTJGcL0Htvz7xR1bYU5BMjz8SdNiQSaELhHJvKL4QiwvAtkw8I8
         +FyN8pH1so3yP8A/tWyjiDlEmvrh0x2qUUsc0kLw8jxZZzMAIKPiy3eL5dCE4CYW3fBG
         HXzCzCOsKvCKauTIXmPhWIy3nzUnZzQmUVAoAstTGVN1CcK9RGK9/eQncqoIrTWF8kAt
         1UQ2Xw9m7dyCIhMyET9rXOQgyScfl3Kht2RG5mqJlF+4Ghx1Mi60YUvBVipAjPJ75Uuw
         AI+g==
X-Forwarded-Encrypted: i=1; AJvYcCXEMUCrZjOH7Xv5HJ3jVR1zCdrKtlWgTtox2Ohq0fKn06DbZ3jhcOcUEKktwryqIVrtLmdYse7iQwKV11dogpJIW1vHZI4/VgPYQNM6GL4DC2VmihWIZjzszPNZWniv9P2XQ3dAzEfvbM2j/Idd17pQTHaurJmwzDXqa/prgvN1GQkjOeJ1
X-Gm-Message-State: AOJu0YwZnEZ0hNj/nsowXi3G3ZGt1JVrRNsDHed8RPg6Ib8hOkaCM/q3
	t+pk1T6Gm8b8Adno9iQsT7Pyu1pzRSpHd6xGp8bSMhhFXZMeMyvB
X-Google-Smtp-Source: AGHT+IFBp42jeltqYdj2uOi4QCPJwDRLcY5GTJQ5xqBEL7/2bnNlJnZDbN7TrKvFm6D/xLcFf6FFJw==
X-Received: by 2002:a17:906:1348:b0:a6f:b352:a74b with SMTP id a640c23a62f3a-a6fb352a781mr487658566b.38.1718975474028;
        Fri, 21 Jun 2024 06:11:14 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6fd5f7b80csm40486666b.29.2024.06.21.06.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 06:11:13 -0700 (PDT)
Date: Fri, 21 Jun 2024 06:11:08 -0700
From: Breno Leitao <leitao@debian.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, kuba@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Simon Horman <horms@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	linux-hardening@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device
 _properly_
Message-ID: <ZnV77C66v+uS9AhR@gmail.com>
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
 <20240507111035.5fa9b1eb@kernel.org>
 <3b08e1d0-62be-4fae-9dbb-9161992ee067@intel.com>
 <Zmww9tS2eWt3mnj3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zmww9tS2eWt3mnj3@gmail.com>

On Fri, Jun 14, 2024 at 05:00:54AM -0700, Breno Leitao wrote:
> On Wed, May 08, 2024 at 11:13:21AM +0200, Alexander Lobakin wrote:
> > From: Jakub Kicinski <kuba@kernel.org>
> > Date: Tue, 7 May 2024 11:10:35 -0700
> > 
> > > On Tue,  7 May 2024 14:39:37 +0200 Alexander Lobakin wrote:
> > >> There are several instances of the structure embedded into other
> > >> structures, but also there's ongoing effort to remove them and we
> > >> could in the meantime declare &net_device properly.
> > > 
> > > Is there a reason you're reposting this before that effort is completed?
> > 
> > To speed up the conversion probably :D
> > 
> > > The warnings this adds come from sparse and you think they should be
> > > ignored?
> > 
> > For now...
> > 
> > > 
> > > TBH since Breno is doing the heavy lifting of changing the embedders 
> > > it'd seem more fair to me if he got to send this at the end. Or at
> > > least, you know, got a mention or a CC.
> > 
> > I was lazy enough to add tags, sorry. The idea of him sending this at
> > the end sounds reasonable.
> 
> I think we are almost at the time to get rid of the last user of
> embedded netdev.
> 
> 	https://lore.kernel.org/all/20240614115317.657700-1-leitao@debian.org/
> 
> Once that patch lands, I will submit this patch on top of that final
> fix.

In fact, I jumped the gun, and reviewing the embedded users of
netdevice, I found there are three more devices, that will need some
care before we proceed

drivers/crypto/caam/caamalg_qi2.h:

  struct dpaa2_caam_priv_per_cpu {
	...
	struct net_device net_dev;


drivers/crypto/caam/qi.c:

  struct caam_qi_pcpu_priv {
	...
        struct net_device net_dev;

drivers/net/ethernet/cavium/thunder/thunder_bgx.c:

  struct lmac {
	...
        struct net_device       netdev;

