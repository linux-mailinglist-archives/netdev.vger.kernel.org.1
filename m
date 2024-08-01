Return-Path: <netdev+bounces-115081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B04CF94508D
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:29:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B71B1F238B0
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3890F1B3F0A;
	Thu,  1 Aug 2024 16:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B3A3A1DA;
	Thu,  1 Aug 2024 16:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529750; cv=none; b=OZJ4Lc9RNW8EoImOwGgGsPiH7xR//LGbqXC9aPqx3DwbfEgw002zk0F9yL+7103D4OIuw3uF8blpsoBby4brMtXjnvCLA4Xb4uNRgZkq7xAClTf+Qn4ox4RKiahaHP6s60fV9tZ7KtFxaTv166GuS60Py7fJBvH/ziyIzv1RAbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529750; c=relaxed/simple;
	bh=vAc6sR4RvUyOWXazrzfJmhWS9zb5OgwqFdWUsZbNs7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WzslVEP5uAXhrl8kpj9deItpt1cRSBSHJF3SZZbkGgJXY/GxoPi6J8uy16JqM8V64O7PgYEy58BvFTIUC6s3oq2f55klnYR01prulTu65x84xdX9PXrmnhgVxuaOvwRamLmBRJOkoBCpvzv8dtqiapSUTQKHBcSMWFc/VQcB2lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5a309d1a788so9417631a12.3;
        Thu, 01 Aug 2024 09:29:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722529746; x=1723134546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxBNcUyWPwUsaC1CdkFZzuO6Qgw2Nc+LKVt0U5+1vFs=;
        b=lGk0pa0r0EA9f7/eonb0jnsZOk38X+djml21hHDSNwXZ8OjX5JFDkPrHr2Vrpgpl48
         h3rgCMDiswE2rRkvDr1UodpCKd/81i1wpprSfO+vbuNw/Z91uCKynTH2yMtN3YNh//LT
         tYtsl/mKYGHrcY5XUY01egVNoYAl+U3AuVDZUxCZuPxngRaRyHhRYob6WP9Ya0JUUg4J
         QNJxuD5deebxgfN5jottb1eU0kFeasF8etlEZAbpBeNkHKQhNg/+cIMGEAuzOIjGtuis
         6NkXXimzT4V0A1UIsqgItJaEUhp62srBOZIJ8fKoGes38bKAUDdk9pmVOAUQRx55NSh1
         ++yw==
X-Forwarded-Encrypted: i=1; AJvYcCVQBQIXXJiaEnfVeHjDu4ReohoMR7Jr1hpmMbVJChdjVl4M6kk34YjaBlnafrt+ygzop+TDUVYya5CL/j/XYtdO1l02JNapH4bBgMDR5UZaZF4TW/xgt2hyMfltNwocytwLS1SR
X-Gm-Message-State: AOJu0YyqKQ3fL7I2G5/6tLJ9frfvUBHow8hns7F9zblv4BMYN7S+KWYJ
	8HnC5ME2ZQxL/QMBdpbtzHGLEwPU5ANPoDweagmS4QZvTLaMMeSpTZAzEg==
X-Google-Smtp-Source: AGHT+IGOgRSel2XYFaAwKx4ZoURyc/82n7DKzFgPUwOBjyhxXiZvOUdVk51dv6P6McnzR5nO0YGvug==
X-Received: by 2002:aa7:df97:0:b0:5ab:324c:d77d with SMTP id 4fb4d7f45d1cf-5b7f36f3feemr711392a12.1.1722529746034;
        Thu, 01 Aug 2024 09:29:06 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac6358fa5esm10360841a12.32.2024.08.01.09.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 09:29:05 -0700 (PDT)
Date: Thu, 1 Aug 2024 09:29:03 -0700
From: Breno Leitao <leitao@debian.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thevlad@fb.com, thepacketgeek@gmail.com,
	riel@surriel.com, horms@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: Re: [PATCH net-next 6/6] net: netconsole: Defer netpoll cleanup to
 avoid lock release during list traversal
Message-ID: <Zqu3z0YyhCgL+VFi@gmail.com>
References: <20240801161213.2707132-1-leitao@debian.org>
 <20240801161213.2707132-7-leitao@debian.org>
 <20240801092156.2bb27a27@hermes.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801092156.2bb27a27@hermes.local>

Hello Stephen,

On Thu, Aug 01, 2024 at 09:21:56AM -0700, Stephen Hemminger wrote:
> On Thu,  1 Aug 2024 09:12:03 -0700
> Breno Leitao <leitao@debian.org> wrote:
> 
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index eb9799edb95b..dd984ee4a564 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -37,6 +37,7 @@
> >  #include <linux/configfs.h>
> >  #include <linux/etherdevice.h>
> >  #include <linux/utsname.h>
> > +#include <linux/rtnetlink.h>
> >  
> >  MODULE_AUTHOR("Maintainer: Matt Mackall <mpm@selenic.com>");
> 
> Should the Maintainer part be removed from the AUTHOR string by now?

Yes, I think this is a good idea. I will send a patch soon.

--breno

