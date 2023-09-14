Return-Path: <netdev+bounces-33765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E97F479FF8A
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75420B20E3B
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9141224D2;
	Thu, 14 Sep 2023 09:00:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB02C224C5
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:00:53 +0000 (UTC)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBF335A2
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:00:52 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso5494435ad.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694682052; x=1695286852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ipw1ZHy8D/6qWHzFHT5Zd/+NLUp3YXU7TJewp47hz+4=;
        b=YbAsNYjg7czCqTDi7TrK2imzddERWA+6EZ1aNitv9COZ6tKJKvK60Nh9bzshBnsvCx
         CQfy/0RXPpcsCXgw8KJweazDtSq6KGziDJ0Q3qkFiK4FJr3vQ9WM22h3IEZSPNIyLEvg
         +pwIY5tva+nOmZD16Otgj7gy1EHQJcaLfl2vt15elGhLnTd86/P/E6TG1Hb4ZuIL7tWM
         rDw9Qd+JpBxe17toc1T21WMTgd6l3/WLmdMvxaLQFzJELt2XtbjX+UHbsPKUBTSpPVAq
         EtmN2FgRZTN7uYK6+5nBiCEzv5VbpwBOxpItm3UciXb9P7/TiUbIEuAzY3Ylejofdo8L
         5CKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682052; x=1695286852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ipw1ZHy8D/6qWHzFHT5Zd/+NLUp3YXU7TJewp47hz+4=;
        b=fhXGKNfWU3ndM8RhgaGYOPN/L2FzUU2vwpu2YDN+79dophVOe0pb8DYU1exqlAS5Lr
         mEN2zPnYzXKZPlW82kys5vlUhzaFSKk1E9q5a4K/Z5jddAmpzhFfHnOzFZJMTM0rqGmk
         Mdj68BQmf2GBHcFpkcCGdbwppCWmoOC9zdy/2vJpOIv6SVIzAS8bdN/YhKhBAFxdOrTE
         eV7ZMTS5/XuZm5oID8Azvxn5Fq8qWivdgfno9lJKAo5G4X3Tx/KMmE404sHuzwGbWjcz
         Ygjpbp269H6aJvH24aSSPYc6hz6/OH3GnKfk9RR9/mxwpHXGRkxvXrHJcn5cJFuPbzuB
         +MBw==
X-Gm-Message-State: AOJu0Yx4wMN2dwRZ3t0P+pCY4c49PTgNLZZ3RAEZDggEjQdPhs7hbZFV
	fBSuTDBIzp7ybOv32noYW84=
X-Google-Smtp-Source: AGHT+IEPq/WUmV+Mz4s6ctYw2RdmRukEMTjJqFNGSOWgryHrv95CykBLzuLFo0+Jaz6qGWHYrCCXXQ==
X-Received: by 2002:a17:903:606:b0:1c2:eac:b99 with SMTP id kg6-20020a170903060600b001c20eac0b99mr4266598plb.40.1694682052307;
        Thu, 14 Sep 2023 02:00:52 -0700 (PDT)
Received: from gondor.apana.org.au ([2404:c804:1b2a:5507:c00a:8aff:fe00:b003])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b001c0de73564dsm1040732plx.205.2023.09.14.02.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:00:51 -0700 (PDT)
Sender: Herbert Xu <herbertx@gmail.com>
Date: Thu, 14 Sep 2023 17:00:51 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, davejwatson@fb.com, kuba@kernel.org,
	vakul.garg@nxp.com, borisp@nvidia.com, john.fastabend@gmail.com
Subject: Re: [PATCH net 1/5] net: tls: handle -EBUSY on async encrypt/decrypt
 requests
Message-ID: <ZQLLwxQ4F2GG1eo0@gondor.apana.org.au>
References: <9681d1febfec295449a62300938ed2ae66983f28.1694018970.git.sd@queasysnail.net>
 <ZPq6vSOSkDuzBBDb@gondor.apana.org.au>
 <ZPtED-ZlSEQmPSlr@hog>
 <ZP/sdGHy7LVE3UEc@gondor.apana.org.au>
 <ZQCFs61yeFlYsHVX@hog>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZQCFs61yeFlYsHVX@hog>

On Tue, Sep 12, 2023 at 05:37:23PM +0200, Sabrina Dubroca wrote:
>
> We'd have to do pretty much what Jakub suggested [1] (handle ENOSPC by
> waiting for all current requests) and then resubmit the failed
> request. So I think keeping the MAY_BACKLOG flag and handling EBUSY
> this way is simpler. With this, we send one request to the backlog,
> then we wait until the queue drains.
> 
> [1] https://lore.kernel.org/netdev/20230908142602.2ced0631@kernel.org/

You need to handle something like ENOSPC anyhow because the underlying
driver may experience a real failure (e.g., someone unplugged the
hardware) which would have pretty much the same effect of ENOSPC
(i.e., an error with no retries).  So if the tls code can't cope with
that then it has to be fixed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

