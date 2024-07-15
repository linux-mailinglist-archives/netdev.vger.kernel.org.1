Return-Path: <netdev+bounces-111465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA6E931305
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 13:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87CD328323E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 11:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E6F1891D6;
	Mon, 15 Jul 2024 11:25:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F8021891B7;
	Mon, 15 Jul 2024 11:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042712; cv=none; b=lDG+f86oGwLSt8zJANefU/H+KbE+D1lE95E/8k9ad+NeWH8xFwj3XD5S4Jml490n406qHp2D7Wk1jVMSFe+nu7R/bkv82aC/p/Ie8GFpKWm9ZDskaPJM8Px8GXgr6joHwU3m62C/iWCVD9iu1r0AjvZ8GSh/Oa/eMkzM8CHdCtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042712; c=relaxed/simple;
	bh=ty+USuCasgyD0q5WV6y+xqpiIL59dUuUhJrHdOnICuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LM4x19/myLF5avv/x5Hw6d4OwNJ4svedEygwIZ6K1KmNwnsUhj7rb+SJxn6edqeSK5OB2xyRzzQsG0P6mO4yXNqdURimcP4pIXYc9NVAZVzYUiR1FuRNqY6Ehv7tDGC6m0od4AZWwfU3AjKAZpVNBsku+RdiOmbiRwijL/YPD+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2eecd2c6432so57432761fa.3;
        Mon, 15 Jul 2024 04:25:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042709; x=1721647509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nIjlZKoODIvZ5ta3ient2GVc/jl/vGg+wUu4XZXyR/w=;
        b=WVjtXsBESy0UEByyNgjK1qOlaEcvzaBP1YlHvA5aq7wiRLSYGDe7cTJiWUWob+6rJV
         Ylrilhdy9zz8pUeeL7gR+doPO8R0eFId8zX18p8uawgUw8Tf2lIEgoUYYlVbrRQM5pB9
         PqpuBeLEqqVBhlNheu19a/4GyzHp/BcmKc0BGrrIMZK3umIwfZQB6Med6pNAeDp+LtsZ
         os4fPl4dJjc57PakK7a7XJpVrq5FYLGczkOaLvahHi2eMxGgZTGtMv/rvSbCi617iKDV
         Hzdw4t/utcspr88Azu1KsZ42k4PFlOOakxWItID38ycN4wWQGPuoW6p6dHSIPY74u9cs
         J0ow==
X-Forwarded-Encrypted: i=1; AJvYcCVezM+NC3Qp+U008rQDOvt8awahf01jYx6g2EEuYoMx2y0pezkf0PLSuP4Is31d2AoWXBgNjySawpwet0rZQF+qa5Ur688RhjOfI2S9WtYfQCZLRJELK9JSspPlp85+qL+E/aEE
X-Gm-Message-State: AOJu0YyL0sHbB6Og6AZkpU5XAMZPZpG/+RfJtx69VffZe0QGarLFHHW4
	TzY66IUffVCOD9QXK8Jchnb2v5GIXxsJ1ZjEZ5iAd3b2KPliyzHNgQ44Jg==
X-Google-Smtp-Source: AGHT+IG78sUAzx9I4a7vE8/3T/SQW4az1utlpNNwNzPZzbTFoS9BD8x4sD9BV4nV2NExq/Pw+CcMGQ==
X-Received: by 2002:a05:6512:36d3:b0:52c:daa4:2f6a with SMTP id 2adb3069b0e04-52eb99d670dmr12258120e87.64.1721042709246;
        Mon, 15 Jul 2024 04:25:09 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-004.fbsv.net. [2a03:2880:30ff:4::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc820fb5sm204451066b.212.2024.07.15.04.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 04:25:08 -0700 (PDT)
Date: Mon, 15 Jul 2024 04:25:06 -0700
From: Breno Leitao <leitao@debian.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <ZpUHEszCj16rNoGy@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org>
 <20240714033803-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240714033803-mutt-send-email-mst@kernel.org>

Hello Michael,

On Sun, Jul 14, 2024 at 03:38:42AM -0400, Michael S. Tsirkin wrote:
> On Fri, Jul 12, 2024 at 04:53:25AM -0700, Breno Leitao wrote:
> > After the commit bdacf3e34945 ("net: Use nested-BH locking for
> > napi_alloc_cache.") was merged, the following warning began to appear:
> > 
> > 	 WARNING: CPU: 5 PID: 1 at net/core/skbuff.c:1451 napi_skb_cache_put+0x82/0x4b0
> > 
> > 	  __warn+0x12f/0x340
> > 	  napi_skb_cache_put+0x82/0x4b0
> > 	  napi_skb_cache_put+0x82/0x4b0
> > 	  report_bug+0x165/0x370
> > 	  handle_bug+0x3d/0x80
> > 	  exc_invalid_op+0x1a/0x50
> > 	  asm_exc_invalid_op+0x1a/0x20
> > 	  __free_old_xmit+0x1c8/0x510
> > 	  napi_skb_cache_put+0x82/0x4b0
> > 	  __free_old_xmit+0x1c8/0x510
> > 	  __free_old_xmit+0x1c8/0x510
> > 	  __pfx___free_old_xmit+0x10/0x10
> > 
> > The issue arises because virtio is assuming it's running in NAPI context
> > even when it's not, such as in the netpoll case.
> > 
> > To resolve this, modify virtnet_poll_tx() to only set NAPI when budget
> > is available. Same for virtnet_poll_cleantx(), which always assumed that
> > it was in a NAPI context.
> > 
> > Fixes: df133f3f9625 ("virtio_net: bulk free tx skbs")
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> though I'm not sure I understand the connection with bdacf3e34945.

The warning above appeared after bdacf3e34945 landed.

