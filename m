Return-Path: <netdev+bounces-63241-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74EC482BF2A
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 12:23:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B0151C2201E
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45D967E72;
	Fri, 12 Jan 2024 11:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ATGsi/5R"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323564CFF
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 11:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705058631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lebhBG0NQIVEZ9dzeH5C6khVucojmjN2MHAd4rsuJ8Q=;
	b=ATGsi/5RLuHnKyF8YM4EXTcG4COPbc2dGcvxscfH9QKRmFNz6/4rCGyBwLgmtTn1tylASH
	oMoRH1YRKVpd4wYRl2P9mY+l94yL1WYfD924i5AL9fdoyO/iOhWpqa1CmXtBwGYDb8Kshz
	kk2mQl3cm+6Ue92oOZwxW8wI/5M6yrE=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-_zkKpWGyOC21g7tT1FPekA-1; Fri, 12 Jan 2024 06:23:50 -0500
X-MC-Unique: _zkKpWGyOC21g7tT1FPekA-1
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-1d542680c9cso40900575ad.2
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 03:23:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705058629; x=1705663429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lebhBG0NQIVEZ9dzeH5C6khVucojmjN2MHAd4rsuJ8Q=;
        b=BuWCkYTNm1FLocHoJxc3QcEhtnn6WgLjKU788pJaX3yR3DBODjjvSaa2qPK1OwwvKI
         Mu5I3zyefU7JwAOt5EEddMnBAp3zxiwad/vY5f/Q3aIPq7sp1QUMdkitOStjzHr4756b
         1n6/RjzOylUw0Z717CR0Tg6ZOxc+6qqxODKsyBc/2R90vW4tW15U5Mm+cHxvCYTA+3mt
         Apvkk9p7j09H1IY/WupFzpghBDkqaB1QsLOwlRP8hRzfgBcY0MVu/a/L8BBPBnTX9rBt
         eGIUhI0R9xeo7LOrdlrr1D/4edFX1y2scSwh3458ZL2JhigTvwehxjKB2hj1IDNp4A1I
         FRtQ==
X-Gm-Message-State: AOJu0YzQDVGRGnkxqr6oMu8usgOwcTAfxJM5MxsSZrZp3TPOMdWZ2FJp
	HRRudPoAiWe9qsq2+aWItFG+waDkL6y6la/rvaB3nMS4QFQrAOiUwAkNi4oUHD8vpgC+puxPn7H
	JQUAWXR6IJDacgp5X8urWtRnXLmLZJe3B
X-Received: by 2002:a17:902:c951:b0:1d5:a453:4145 with SMTP id i17-20020a170902c95100b001d5a4534145mr939747pla.66.1705058628974;
        Fri, 12 Jan 2024 03:23:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEWCXyYl/hGYD7BdDmhEbc1jAwWbrXHu2atnttng0ucw7FIcNPE89FyPHbnVwYS9U+Xvxqqug==
X-Received: by 2002:a17:902:c951:b0:1d5:a453:4145 with SMTP id i17-20020a170902c95100b001d5a4534145mr939738pla.66.1705058628722;
        Fri, 12 Jan 2024 03:23:48 -0800 (PST)
Received: from localhost ([78.209.94.35])
        by smtp.gmail.com with ESMTPSA id n17-20020a170903111100b001d3ffb7c4c7sm2895029plh.40.2024.01.12.03.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 03:23:48 -0800 (PST)
Date: Fri, 12 Jan 2024 12:23:37 +0100
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>, Jon Maloy <jmaloy@redhat.com>,
	David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2 2/2] treewide: fix typos in various comments
Message-ID: <ZaEhOak-a16AWxnd@renaissance-vector>
References: <cover.1704816744.git.aclaudi@redhat.com>
 <f384c3720a340ca5302ee0f97d5e2127e246ce01.1704816744.git.aclaudi@redhat.com>
 <20240111114035.4dc407dd@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111114035.4dc407dd@hermes.local>

On Thu, Jan 11, 2024 at 11:40:35AM -0800, Stephen Hemminger wrote:
> On Tue,  9 Jan 2024 17:32:35 +0100
> Andrea Claudi <aclaudi@redhat.com> wrote:
> 
> > diff --git a/include/libiptc/libiptc.h b/include/libiptc/libiptc.h
> > index 1bfe4e18..89dce2f9 100644
> > --- a/include/libiptc/libiptc.h
> > +++ b/include/libiptc/libiptc.h
> > @@ -80,7 +80,7 @@ int iptc_append_entry(const xt_chainlabel chain,
> >  		      const struct ipt_entry *e,
> >  		      struct xtc_handle *handle);
> >  
> > -/* Check whether a mathching rule exists */
> > +/* Check whether a matching rule exists */
> >  int iptc_check_entry(const xt_chainlabel chain,
> >  		      const struct ipt_entry *origfw,
> >  		      unsigned char *matchmask,
> 
> This is no longer in current code tree.
> Please rebase and resubmit

Woops, sorry. Will do.


