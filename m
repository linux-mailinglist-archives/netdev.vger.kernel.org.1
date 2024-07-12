Return-Path: <netdev+bounces-111087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE9DC92FD0C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 16:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684951F24338
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 14:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AD4172BBA;
	Fri, 12 Jul 2024 14:58:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38979171670;
	Fri, 12 Jul 2024 14:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796335; cv=none; b=g83bBEi3Ak6kLvyr5T276FmShfaUMpeZsJ7T2U7Ng+A++6wqZ7Vuxidr6FkmimNKZJUHyF/DoZ/HzqsDj9Q+ndMKR5hcMfhKg2iwO7HjGbpBjGm17SNuHR3jLzqS5j1LfFlhdO4R0B++JsLMOcGVkg5aq2czlR1+Xl7NafmUdxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796335; c=relaxed/simple;
	bh=M0fdYPs04XFI4MSEL3cVB60IKS2hZVnJ4hxKRPFY7Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P86eNU17omEhogWVZE2LFt9U3LktzhO4Vs3BhWxS3kCoP/6BIxLnRO8vvuh1brcoSlVOe3rT2sos9OizGMHDkvyTHaORv26MQhjHTmkBBbUkMAs7mJk4sGZG1YFNj8c883BRqoZZXpbEpmbo4jYZn4qctJXf7QP4Mxuz59Wy7N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so5640000a12.0;
        Fri, 12 Jul 2024 07:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720796333; x=1721401133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOROqOLL+ICKvSM0IWop1tHiRymkbqTwAK7mSurQUfQ=;
        b=H45/gAZJDjOJh1Nh3Q/c8uQvDNlVTViQ4teAD1vGt4p7OMjqOPwtTVJeWBreTfeo9I
         B1m+vHp5cUiWNdCGZlxoUKyjL9jT4XQnwKYZDILB/JMMLJ8OwbeHtgMarYqvPdSVJv7+
         VK0XYFfou0+9Wad2cEC/AwXpjU9TlE+g3JfC0Vg1Pn42kouqzwuw4DRny0BFxsGyck/q
         1AJ2bztrZUkTdzHi0W+OrjX8YnwNrqUxTfhwH+YJ754qcXqZF8zNRFew7+uZxqRrQo+m
         oiouGvpmVNLNeu4uF4zqCYVkMoa8NQyNwi151J9uZjL1ERZHs5hQfl+LuUHJ4S1hPp6m
         CsLw==
X-Forwarded-Encrypted: i=1; AJvYcCUzRGyabZMawHwIaJOaEjqK1LtRJLFwfGo31cSpMIIR4aCFpRYqfnWcs/o9z38XNMDBb/yjsXHDXDpa253FQsWZfXa04riNImJf8bOkyoNSxUs8+oQNTBpls0XkvBiQR+1dnTXs
X-Gm-Message-State: AOJu0YxQ1ENd30AQ0wSFbtFRcMiOfqXDWkmJsXn+jSnhZSMAT3yPz2+V
	8Fq7W+kl81fRSza0kH5Ut0c9b5VT6NhuAGny0MMGfRKksZCIbep6
X-Google-Smtp-Source: AGHT+IGdKQn3Gzt2+l/urCVxX8FiOJWgFC28dwbx3rOWY/5MmxMdbQp+jutRVTdORLMXHS7jdj6eVg==
X-Received: by 2002:a17:907:948b:b0:a72:afd9:6109 with SMTP id a640c23a62f3a-a799cc6abb2mr241330966b.16.1720796332394;
        Fri, 12 Jul 2024 07:58:52 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bc85dsm353984166b.41.2024.07.12.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 07:58:52 -0700 (PDT)
Date: Fri, 12 Jul 2024 07:58:49 -0700
From: Breno Leitao <leitao@debian.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	rbc@meta.com, horms@kernel.org,
	"open list:VIRTIO CORE AND NET DRIVERS" <virtualization@lists.linux.dev>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
Message-ID: <ZpFEqbibtxoK0Xcn@gmail.com>
References: <20240712115325.54175-1-leitao@debian.org>
 <20240712075432.7918767a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712075432.7918767a@kernel.org>

Hello Jakub,

On Fri, Jul 12, 2024 at 07:54:32AM -0700, Jakub Kicinski wrote:
> On Fri, 12 Jul 2024 04:53:25 -0700 Breno Leitao wrote:
> > Subject: [PATCH net-next] virtio_net: Fix napi_skb_cache_put warning
> 
> [PATCH net] for fixes so that the bot knows what to test against :)
> No need to repost (this time).

I didn't send to `net` since this WARNING is only "showing" in net-next,
due to commit bdacf3e34945 ("net: Use nested-BH locking for
napi_alloc_cache.") being only in net-next.

But you have a good point, this is a fix and it should go through `net`.
sorry about it.

--breno

