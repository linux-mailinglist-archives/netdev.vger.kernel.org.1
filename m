Return-Path: <netdev+bounces-110422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0204A92C469
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 22:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ACD38B21E68
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 20:22:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790818003B;
	Tue,  9 Jul 2024 20:22:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FAC01B86DC;
	Tue,  9 Jul 2024 20:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720556526; cv=none; b=J9bhvDLi+y7GBuJlNK7HKWo3ccWcTvcOrT6suPnoLx58sGluzj7R//kkRhuM6w4P9PsEq7lPNykrD7mLNp8irabXHxqpaPaaNimfOplcsW6NuSc4CyGHPQcEjdvGGCdsBulLKk3FllS7kD7NSDO68OzaQYkaBPOTIL8QeSGAiek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720556526; c=relaxed/simple;
	bh=RGmSQUGbWLYnF/rlMB7F8Gre8jpeZnVMx52cnn9GY6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YbxfFvDF2LC0SLgKpgj1W+oFoy9aPve9rMjMHvCIwpdWUpdNFP3Z8aaCqN5ca+OjHF92MEYeBhDzP4hjaMC91H6/4Yc/OSzPiQEjwuRYS+dAStomsi1IAZdG4G0U1P4rwNQX71s1x1fViFjBLeDbPfYw6acTZ2MXP/P6SpdkSQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-595712c49ebso1254433a12.0;
        Tue, 09 Jul 2024 13:22:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720556524; x=1721161324;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vvRIuRA8Q0ILQxQtGh1N00X9AsqI+8Alg4FEVLSH3uQ=;
        b=Lus1Yj2k85MlCxtWTR9+HlwU3KO/AWPP2oP2NMlJzE8DSDv8RQ0YTJOh16KRgiXV7Y
         Rb7pmilR2ZAlNwrMLJyjZfpC6LbppdNbSG3aY1ewbqMX27YzgXOcnNgyXoB04bSyn/zL
         beIXC4pXDkGK1c2FKFnh58U5dTa3e5cKsJecjjmircCbplANjBQ6PdAYiYjfQgcp4RoS
         EplSKw5A2W6Dp1huMxGmBF9Ie3rWu9cWwdH15fRDuPIs64JjcFDtWMVH1ZjplLOW/vwG
         ogonjGHKxvPzrYrLSu8IcAKVX461JS//EfuR/R+4DRvO6Gfl2E2zvqISlmaqMpnVO01X
         nzLA==
X-Forwarded-Encrypted: i=1; AJvYcCXq3alDlNxDzWSfR8gF/Dy+WcMSmdUbZtVRHi7K8TKS3+5mCrWRGPbPxrX7vE2XkedSWY53nR+Lz7zeFqm7yVJFGG/l7B9TVoUp81vmZHh+qSL8EoV7n+LcHxA0n8+heLXqhepRKLRfbl3ZlYtdrGIYVQjHlD89qrYzEYQx3Gt3V/1gurej
X-Gm-Message-State: AOJu0YwY+3T/hzftJrqV3qD5hJpxypKXdgcROHM0oDos5dz0kB03GP68
	FtDhY83rpoNs/LFnxhEIwQMhGG/9PDQLcqtumU6nlAsf6+C7TupsvIv6Xw==
X-Google-Smtp-Source: AGHT+IGcKzyE8EOMfQ3OoW0Ujo4qjw7hNTfIbEERwMkINzHm41RRGPA3WbgjNLiDaSnmLTq5IifRmw==
X-Received: by 2002:a17:907:724a:b0:a72:5a8c:87c6 with SMTP id a640c23a62f3a-a780b68a9d5mr252708166b.10.1720556523516;
        Tue, 09 Jul 2024 13:22:03 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-113.fbsv.net. [2a03:2880:30ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcd09sm104633666b.19.2024.07.09.13.22.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 13:22:03 -0700 (PDT)
Date: Tue, 9 Jul 2024 13:22:00 -0700
From: Breno Leitao <leitao@debian.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	keescook@chromium.org, horms@kernel.org,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
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
Message-ID: <Zo2b6DJDMXLm/dBK@gmail.com>
References: <20240709125433.4026177-1-leitao@debian.org>
 <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89iJSUg8LJkpRrT0BWWMTiHixJVo1hSpt2-2kBw7BzB8Mqg@mail.gmail.com>

On Tue, Jul 09, 2024 at 08:27:45AM -0700, Eric Dumazet wrote:
> On Tue, Jul 9, 2024 at 5:54 AM Breno Leitao <leitao@debian.org> wrote:

> > @@ -2596,7 +2599,7 @@ void dev_net_set(struct net_device *dev, struct net *net)
> >   */
> >  static inline void *netdev_priv(const struct net_device *dev)
> >  {
> > -       return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
> > +       return (void *)dev->priv;

> Minor remark : the cast is not needed, but this is fine.

Thanks. I will fix it in a v3, which needs to be done to address some
kernel-doc warnings identified by Simon..

> It would be great to get rid of NETDEV_ALIGN eventually.

Would you mind sharing what do you have in mind? What do you use as a
replacement?

Thanks

